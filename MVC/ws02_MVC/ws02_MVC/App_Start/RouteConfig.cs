using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Routing;

namespace ws02_MVC
{
    public class RouteConfig
    {
        public static void RegisterRoutes(RouteCollection routes)
        {
            routes.IgnoreRoute("{resource}.axd/{*pathInfo}");

            routes.MapRoute(
                name: "Company",
                url: "{controller}/{action}/{id}",
                defaults: new { controller = "Company", action = "Login", id = UrlParameter.Optional }
            );
            routes.IgnoreRoute("{resource}.axd/{*pathInfo}");

            routes.MapRoute(
                name: "Announcement",
                url: "{controller}/{action}/{id}",
                defaults: new { controller = "Announcement", action = "Index", id = UrlParameter.Optional }
            );
            routes.IgnoreRoute("{resource}.axd/{*pathInfo}");

            routes.MapRoute(
                name: "TheProject",
                url: "{controller}/{action}/{id}",
                defaults: new { controller = "TheProject", action = "Index", id = UrlParameter.Optional }
            );
        }
    }
}
