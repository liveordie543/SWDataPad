using System.Web.Mvc;
using System.Web.Routing;
using SWDataPad.Data;

namespace SWDataPad
{
    public class MvcApplication : System.Web.HttpApplication
    {
        protected void Application_Start()
        {
            AreaRegistration.RegisterAllAreas();
            RouteConfig.RegisterRoutes(RouteTable.Routes);
            DataConnector.Initialize();
        }
    }
}
