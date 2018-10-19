using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Http.Results;
using System.Web.Mvc;

namespace SFApplication.Helpers
{
    public class JsonNetResult : JsonResult
    {
        new public object Data { get; set; }

        public JsonNetResult()
        {
        }

        public JsonNetResult(object data)
        {
            this.Data = data;
        }

        public override void ExecuteResult(ControllerContext context)
        {
            HttpResponseBase response = context.HttpContext.Response;
            response.ContentType = "application/json";
            if (ContentEncoding != null)
                response.ContentEncoding = ContentEncoding;
            if (Data != null)
            {
                JsonTextWriter writer = new JsonTextWriter(response.Output) { Formatting = Formatting.Indented };
                JsonSerializer serializer = JsonSerializer.Create(new JsonSerializerSettings()
                {
                    DateTimeZoneHandling = DateTimeZoneHandling.Local
                });
                serializer.Serialize(writer, Data);
                writer.Flush();
            }
        }
    }
}