//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace SFApplication.Models
{
    using System;
    using System.Collections.Generic;
    
    public partial class tbl_ForecastItems
    {
        public int ForecastItemId { get; set; }
        public Nullable<int> ForecastId { get; set; }
        public Nullable<int> ItemId { get; set; }
        public Nullable<decimal> ConsumedAvg { get; set; }
        public Nullable<decimal> ForecastValue { get; set; }
        public Nullable<int> RevisedForecastValueId { get; set; }
        public Nullable<int> Month { get; set; }
    }
}
