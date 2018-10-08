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