using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace SFApplication.Helpers
{
    public class UserRoles
    {
        #region ADMIN

        public static string Admin = "Admin";

        public static string CreateUser = "CreateUser";
        public static string EditUser = "EditUser";
        public static string DeleteUser = "DeleteUser";
        public static string ResetUser = "ResetUser";

        public static string CreateForecast = "CreateForecast";
        public static string EditForecast = "EditForecast";
        public static string DeleteForecast = "DeleteForecast";
        public static string DeleteRevision = "DeleteRevision";


        #endregion

        #region GENERAL

        public static string ForecastList = "ForecastList";

        #endregion

        #region FORECAST TOOL

        public static string ViewForecasts = "ViewForecasts";
        public static string EditForecasts = "EditForecasts";
        public static string ReviseForecasts = "ReviseForecasts";

        public static string UploadForecast = "UploadForecast";

        #endregion

        #region TEMP ITEMS

        public static string CreateTempItem = "CreateTempItem";
        public static string EditTempItem = "EditTempItem";
        public static string DeleteTempItem = "DeleteTempItem";

        #endregion
    }
}