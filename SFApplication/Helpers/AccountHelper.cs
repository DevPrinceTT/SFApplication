using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using WebMatrix.WebData;

namespace SFApplication.Helpers
{
    public static class AccountHelper
    {
        /// <summary>
        /// Authentication only
        /// </summary>
        /// <returns>Is user authenticated</returns>
        public static bool SecurityCheck()
        {
            if (WebSecurity.IsAuthenticated)
            {
                return true;
            }
            return false;
        }

        /// <summary>
        /// Authentication and Authorization(role list)
        /// </summary>
        /// <param name="Roles">List of roles required</param>
        /// <returns>Is user authenticated and authorized</returns>
        public static bool SecurityCheck(params string[] Roles)
        {
            if (WebSecurity.IsAuthenticated)
            {
                WebSecurity.RequireRoles(Roles);
                return true;
            }
            return false;
        }
    }
}