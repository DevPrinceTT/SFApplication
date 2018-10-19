using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace SFApplication.ViewModels
{
    public class obj_ServerResponse
    {
        public string Message { get; set; }
        public string MessageType { get; set; }
        public bool ShowDialog { get; set; }
        public object Errors { get; set; }
        public object Data { get; set; }
    }
}