using System.Security.Claims;
using System.Web;
using SWDataPad.Models.Login;
using System.Web.Mvc;
using Microsoft.AspNet.Identity;
using Microsoft.Owin.Security;
using SWDataPad.Data.Authentication;

namespace SWDataPad.Controllers
{
    public class LoginController : BaseController
    {
        [HttpGet]
        public ActionResult Login()
        {
            return View(new LoginModel());
        }

        [HttpPost]
        public ActionResult Login(LoginModel model)
        {
            if (ModelState.IsValid && Authenticator.IsLoginCorrect(model.Username, model.Password))
            {
                AuthenticateUser(model.Username);
                return RedirectToAction("Select", "Character");
            }
            return View(model);
        }

        public ActionResult LogOut()
        {
            HttpContext.GetOwinContext().Authentication.SignOut(DefaultAuthenticationTypes.ApplicationCookie, DefaultAuthenticationTypes.ExternalCookie);
            return RedirectToAction("Login");
        }

        [HttpGet]
        public ActionResult Register()
        {
            return View(new RegisterModel());
        }

        [HttpPost]
        public ActionResult Register(RegisterModel model)
        {
            if (ModelState.IsValid)
            {
                UserRepository.Create(model.ToUserEntity());
                return RedirectToAction("Login");
            }
            return View(model);
        }

        private void AuthenticateUser(string username)
        {
            Claim[] claims = {new Claim(ClaimTypes.Name, username) };
            ClaimsIdentity identity = new ClaimsIdentity(claims, DefaultAuthenticationTypes.ApplicationCookie);
            AuthenticationProperties properties = new AuthenticationProperties {IsPersistent = false};
            HttpContext.GetOwinContext().Authentication.SignIn(properties, identity);
        }
    }
}