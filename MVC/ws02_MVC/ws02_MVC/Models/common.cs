using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace ws02_MVC.Models
{
    public class Common
    {
        public static string DBConnectionString
        {
            get
            {
                return System.Web.Configuration.WebConfigurationManager.ConnectionStrings["WebsiteConnectionString1"].ConnectionString;
            }
        }

    }


}