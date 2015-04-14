using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Optimization;
using System.Web.Routing;
using System.Web.Security;
using System.Web.SessionState;

namespace YuQ11
{
    public class Global : HttpApplication
    {
        void Application_Start(object sender, EventArgs e)
        {
            // 在应用程序启动时运行的代码
            RouteConfig.RegisterRoutes(RouteTable.Routes);
            BundleConfig.RegisterBundles(BundleTable.Bundles);

            //Create the role
            //Logic.logicRole _role = new Logic.logicRole();
            //_role.AddRoleAndAdminstration();

            // Add Routes.
            //RegisterCustomRoutes(RouteTable.Routes);
        }

        //void RegisterCustomRoutes(RouteCollection routes)
        //{
        //    routes.MapPageRoute("NewsByIDRoute", "News/{newsID}", "~/News.aspx");
        //}
    }
}