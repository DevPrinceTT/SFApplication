using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace SFApplication.ViewModels
{
    public class mdl_ForecastItemData
    {
        public int Month { get; set; }
        public decimal Forecast { get; set; }
        public decimal Revised { get; set; }
    }
}