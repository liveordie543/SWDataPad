using System.Web;
using System.Web.Mvc;
using SWDataPad.Data.Repositories;
using Microsoft.Owin.Security;
using SWDataPad.Data.Entities;

namespace SWDataPad.Controllers
{
    public class BaseController : Controller
    {
        private UserRepository _userRepository;

        public UserRepository UserRepository
        {
            get { return _userRepository ?? (_userRepository = new UserRepository()); }
        }

        private CharacterRepository _characterRepository;

        public CharacterRepository CharacterRepository
        {
            get { return _characterRepository ?? (_characterRepository = new CharacterRepository()); }
        }

        public IAuthenticationManager OwinAuthManager
        {
            get { return HttpContext.GetOwinContext().Authentication; }
        }

        public User CurrentUser
        {
            get
            {
                return string.IsNullOrEmpty(User.Identity.Name)
                    ? null
                    : UserRepository.SelectSingle(u => u.Username == User.Identity.Name);
            }
        }
    }
}
