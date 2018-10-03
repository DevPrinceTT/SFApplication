using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace SFApplication.Controllers
{
    public class SalesController : Controller
    {
        // GET: Sales
        public ActionResult Index()
        {
            return View();
        }

        // POST: Sales
        [HttpPost]
        public ActionResult Index(int id)
        {
            return View();
        }
    }
}