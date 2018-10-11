using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace SFApplication.ViewModels
{
    public class mdl_Login
    {
        [Required(ErrorMessage ="Please provide username")]
        public string Username { get; set; }
        [Required(ErrorMessage = "Please provide password")]
        public string Password { get; set; }
    }
}