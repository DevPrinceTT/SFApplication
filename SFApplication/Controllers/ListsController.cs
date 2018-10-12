using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using System.Web.Mvc;

namespace SFApplication.Controllers
{
    public class ListsController : Controller
    {
        // GET/Lists
        public JsonResult Index()
        {
            var response = new { };

            return Json(response, JsonRequestBehavior.AllowGet);
        }
    }
}

