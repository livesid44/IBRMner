using System;
using System.Web;
using System.Web.Routing;

namespace IBRMnerWeb
{
    public class Global : HttpApplication
    {
        void Application_Start(object sender, EventArgs e)
        {
            RegisterRoutes(RouteTable.Routes);
        }

        void Application_End(object sender, EventArgs e)
        {
        }

        void Application_Error(object sender, EventArgs e)
        {
            Exception exc = Server.GetLastError();
            if (exc != null)
            {
                // Log or handle the exception as needed.
            }
        }

        private static void RegisterRoutes(RouteCollection routes)
        {
            routes.MapPageRoute("Default", "", "~/Default.aspx");
        }
    }
}
