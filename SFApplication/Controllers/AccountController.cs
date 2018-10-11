using System;
using System.Globalization;
using System.Linq;
using System.Security.Claims;
using System.Threading.Tasks;
using System.Web;
using System.Web.Mvc;
using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.Owin;
using Microsoft.Owin.Security;
using SFApplication.ViewModels;
using WebMatrix.WebData;

namespace SFApplication.Controllers
{
    public class AccountController : Controller
    {
        #region // GET: 
        
        public ActionResult Login()
        {
            return View();
        }
        
        public ActionResult Register()
        {
            if (!WebSecurity.Initialized)
            {
                WebSecurity.InitializeDatabaseConnection("UserDb", "Users", "Id", "UserName", autoCreateTables: true);
            }
            return View();
        }

        public ActionResult Logout()
        {
            WebSecurity.Logout();
            return RedirectToAction("Login");
        }

        #endregion


        #region // POST: 

        [HttpPost]
        public ActionResult Login(mdl_Login model)
        {
            if (ModelState.IsValid)
            {
                bool success = WebSecurity.Login(model.Username, model.Password, false);
                if (success)
                {
                    return RedirectToAction("Index", "Forecast");
                }
                return View();
            }
            else
            {
                return View(model);
            }
        }

        [HttpPost]
        public ActionResult Register(mdl_Login model)
        {
            WebSecurity.CreateUserAndAccount(model.Username, model.Password);
            Response.Redirect("~/account/login");
            return View();
        }

        #endregion
    }
}
