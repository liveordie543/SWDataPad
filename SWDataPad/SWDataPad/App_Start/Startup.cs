using Microsoft.AspNet.Identity;
using Microsoft.Owin;
using Microsoft.Owin.Security.Cookies;
using Owin;
using SWDataPad;

[assembly: OwinStartup(typeof(Startup))]

namespace SWDataPad
{
    public class Startup
    {
        public void Configuration(IAppBuilder appBuilder)
        {
            CookieAuthenticationOptions options = new CookieAuthenticationOptions
            {
                AuthenticationType = DefaultAuthenticationTypes.ApplicationCookie,
                LoginPath = new PathString("/Login"),
                ReturnUrlParameter = "returnUrl",
            };
            appBuilder.UseCookieAuthentication(options);
        }
    }
}
