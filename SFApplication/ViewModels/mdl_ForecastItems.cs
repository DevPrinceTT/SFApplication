using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace SFApplication.ViewModels
{
    public class mdl_ForecastItems
    {
        public int ItemId { get; set; }
        /// <summary>
        /// FDL Item Number
        /// </summary>
        public string ItemNumber { get; set; }
        /// <summary>
        /// Item Weight
        /// </summary>
        public Nullable<decimal> ItemWeight { get; set; }
        /// <summary>
        /// Vendor Item Number
        /// </summary>
        public string VendorItemNumber { get; set; }
        /// <summary>
        /// FDL Item Description
        /// </summary>
        public string ItemDescription { get; set; }
        /// <summary>
        /// Vendor Item Description
        /// </summary>
        public string VendorItemDescription { get; set; }
        public int? ForecastItemId { get; set; }
        public int? Month { get; set; }
        public decimal? Original { get; set; }
        public decimal? Revised { get; set; }
        public string M { get; set; }
        public string I { get; set; }
        public string P { get; set; }
        public Nullable<bool> CustomItem { get; set; }
        public string Status { get; set; }

        /// <summary>
        /// Forecast Data (months)
        /// </summary>
        public List<mdl_ForecastItemData> ForecastData { get; set; }
    }
}