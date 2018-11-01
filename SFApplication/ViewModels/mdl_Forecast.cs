using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace SFApplication.ViewModels
{
    public class mdl_Forecast
    {
        public int ForecastId { get; set; }
        public int? Year { get; set; }

        public List<mdl_ForecastItems> ForecastItems { get; set; }
    }
}