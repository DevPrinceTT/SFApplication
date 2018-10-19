using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace SFApplication.ViewModels
{
    public class mdl_ForecastDetails
    {
        public int ForecastId { get; set; }
        public int CustomerId { get; set; }
        public int RevisionId { get; set; }
        public string CustomerName { get; set; }
        public decimal? ForcastValue { get; set; }
        public decimal? ConsumedAvg { get; set; }
    }
}