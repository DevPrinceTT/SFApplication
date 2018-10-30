using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace SFApplication.ViewModels
{
    public class mdl_Item
    {
        public int ItemId { get; set; }
        public string ItemNumber { get; set; }
        public string ItemDescription { get; set; }
        public Nullable<decimal> ItemWeight { get; set; }
        public string VendorId { get; set; }
        [Required(ErrorMessage = "Supplier code is required")]
        public string VendorItemNumber { get; set; }
        [Required(ErrorMessage="Vendor Item description is required")]
        public string VendorItemDescription { get; set; }
        public Nullable<System.DateTime> DateCreated { get; set; }
        public Nullable<System.DateTime> SyncDate { get; set; }
        public Nullable<bool> CustomItem { get; set; }
        public Nullable<bool> Synced { get; set; }
        public string Status { get; set; }
    }
}