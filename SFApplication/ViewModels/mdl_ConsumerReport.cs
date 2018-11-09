using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace SFApplication.ViewModels
{
    public class mdl_ConsumerReport
    {
        public string CustomerNumber { get; set; }
        public string CustomerName { get; set; }
        public Decimal? Quantity { get; set; }
        public Decimal? Average { get; set; }
        public Decimal? MonthUsage { get; set; }
        public int? Rank { get; set; }
    }
}