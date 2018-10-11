using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace SFApplication.Controllers
{
    public class ForecastController : Controller
    {
        // GET: Forecast/
        public ActionResult Index()
        {
            return View();
        }

        // GET: Forecast/
        public ActionResult Tool2()
        {
            return View();
        }

        // GET:/Forecast/Consumed/1
        /// <summary>
        /// Retuerns consumption reports
        /// </summary>
        /// <param name="id">Item Id</param>
        /// <param name="m">Month clicked</param>
        /// <returns>Consumption Report</returns>
        public ActionResult Consumed(int id, int m)
        {
            ViewBag.ItemId = id;
            ViewBag.Month = m;

            return PartialView();
        }

        // GET: Forecast/Tool/2018
        public ActionResult Tool(int id = 0)
        {
            if (id < 1)
            {
                return RedirectToAction("Index");
            }

            return View();
        }
    }
}