using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace SFApplication.ViewModels
{
    public class mdl_ForecastRevision
    {
        public int RevisionId { get; set; }
        public Nullable<int> ForecastItemId { get; set; }
        public Nullable<bool> InitialRevision { get; set; }
        public Nullable<int> RevisedBy { get; set; }
        public Nullable<DateTime> RevisionDate { get; set; }
        public List<mdl_ForecastDetails> ForecastDetails { get; set; }
    }
}