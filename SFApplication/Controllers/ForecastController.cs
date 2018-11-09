using SFApplication.Helpers;
using SFApplication.Models;
using SFApplication.ViewModels;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Script.Serialization;
using WebMatrix.WebData;

namespace SFApplication.Controllers
{
    public class ForecastController : Controller
    {
        ForecastDBEntities db = new ForecastDBEntities();

        #region // GET:

        // GET: Forecast/
        public ActionResult Index()
        {
            return View();
        }

        // GET: Forecast/Tool/2018
        public ActionResult Tool(int id = 0)
        {
            if (!WebSecurity.IsAuthenticated)
            {
                return RedirectToAction("Logout", "Account");
            }

            //WebSecurity.RequireRoles("Test");


            if (id < 1)
            {
                return RedirectToAction("Index");
            }

            return View();
        }

        // GET:/Forecast/Details/1
        /// <summary>
        /// Returns consumption reports
        /// </summary>
        /// <param name="id">Item Id</param>
        /// <param name="m">Month clicked</param>
        /// <returns>Consumption Report</returns>
        public ActionResult Details(int id, int m)
        {
            if (!WebSecurity.IsAuthenticated)
            {
                return RedirectToAction("Login", "Account");
            }
            obj_ServerResponse response = new obj_ServerResponse();

            ViewBag.ItemId = id;
            ViewBag.Month = m;
            
            return PartialView();
        }

        public ActionResult CreateForecast()
        {
            if (!WebSecurity.IsAuthenticated)
            {
                return RedirectToAction("Login", "Account");
            }

            return View();
        }

        #endregion

        #region // POST:

        // POST:/Forecast/Details
        [HttpPost]
        public JsonNetResult Details(string collection)
        {
            //server response
            obj_ServerResponse response = new obj_ServerResponse();

            JavaScriptSerializer jsonSerializer = new JavaScriptSerializer();
            mdl_ForecastRevision details = jsonSerializer.Deserialize<mdl_ForecastRevision>(collection);
            var context = new ValidationContext(details);
            var results = new List<ValidationResult>();
            if (Validator.TryValidateObject(details, context, results, true))
            {
            }
            else
            {
                response.Errors = results.Select(d => new KeyValuePair<string, string>(d.MemberNames.First().ToString(), d.ErrorMessage));
            }

            return new JsonNetResult();
        }


        // POST:/Forecast/CreateForecast
        [HttpPost]
        public ActionResult CreateForecast(mdl_Forecast model)
        {
            return View();
        }

        #endregion

        #region AJAX

        /// <summary>
        /// Get forecast items/summary
        /// </summary>
        /// <param name="id">Year</param>
        /// <returns></returns>
        public JsonNetResult GetForecastItems(int id)
        {
            obj_ServerResponse response = new obj_ServerResponse();

            tbl_Forecasts dbForecast = db.tbl_Forecasts.Find(id);
            if(dbForecast == null)
            {
                //item not found
                response.MessageType = "warning";
                response.Message = "Forecast not found!";
                response.ShowDialog = true;
            }
            mdl_Forecast model = new mdl_Forecast();
            model.ForecastId = id;
            model.Year = dbForecast.Year;


            List<mdl_ForecastItems> data = db.AAA2018_GET_FORECAST_SUMMARY_DATA(id).Select(d => new mdl_ForecastItems()
            {
                CustomItem = d.CustomItem,
                ItemDescription = d.ItemDescription,
                ItemId = d.ItemId ?? 0,
                ItemNumber = d.ItemNumber,
                ItemWeight = d.ItemWeight,
                I = null,
                M = null,
                P = null,
                VendorItemDescription = d.VendorItemDescription,
                VendorItemNumber = d.VendorItemNumber,
                Month = d.Month,
                ForecastItemId = d.ForecastItemId,
                Original = d.Original,
                Revised = d.Revised
            }).ToList<mdl_ForecastItems>();

            //populate matrix data
            model.ForecastItems = new List<mdl_ForecastItems>();

            for(int i = 0; i < data.Count(); i++)
            {
                mdl_ForecastItems item = data[i];
                item.ForecastData = new List<mdl_ForecastItemData>();

                //get data for each month
                for(int m = 1; m<= 12; m++)
                {
                    mdl_ForecastItemData mdata = new mdl_ForecastItemData();
                    mdata.Month = m;
                    if (data[i].Month == m)
                    {
                        mdata.Revised = data[i].Revised ?? 0;
                        mdata.Forecast = data[i].Original ?? 0;
                    }
                    else
                    {
                        mdata.Revised = 0;
                        mdata.Forecast = 0;
                    }

                    item.ForecastData.Add(mdata);

                }
                model.ForecastItems.Add(item);
            }
            

            return new JsonNetResult(model);
        }

        public JsonNetResult GetConsumerReport(int id, int month)
        {
            gp_InventoryItems gpItem = db.gp_InventoryItems.Find(id);

            List<mdl_ConsumerReport> consumers = db.AAA2018_CONSUMER_REPORT_DATA(gpItem.VNDITNUM, 2012, month)
                .Select(d => new mdl_ConsumerReport()
                {
                    Average = d.Average,
                    CustomerName = d.CustomerName,
                    CustomerNumber = d.CustomerNumber,
                    MonthUsage = d.MonthlyUsage,
                    Quantity = d.OverallUsage,
                    Rank = d.Rank
                })
                .ToList<mdl_ConsumerReport>();

            return new JsonNetResult(consumers);
        }

        #endregion
    }
}