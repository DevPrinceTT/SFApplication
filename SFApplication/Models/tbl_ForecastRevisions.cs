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
    
    public partial class tbl_ForecastRevisions
    {
        public int RevisionId { get; set; }
        public Nullable<int> ForecastItemId { get; set; }
        public Nullable<bool> InitialRevision { get; set; }
        public Nullable<int> RevisedBy { get; set; }
        public Nullable<System.DateTime> RevisionDate { get; set; }
    }
}