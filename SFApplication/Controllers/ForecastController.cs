using SFApplication.Helpers;
using SFApplication.ViewModels;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Script.Serialization;
using WebMatrix.WebData;

namespace SFApplication.Controllers
{
    public class ForecastController : Controller
    {

        #region // GET:

        // GET: Forecast/
        public ActionResult Index()
        {
            return View();
        }

        // GET: Forecast/Tool/2018
        public ActionResult Tool(int id = 0)
        {
            //if (!WebSecurity.IsAuthenticated)
            //{
            //    return RedirectToAction("Logout", "Account");
            //}

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
            ViewBag.ItemId = id;
            ViewBag.Month = m;

            return View();
        }

        public ActionResult CreateForecast()
        {
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
    }
}