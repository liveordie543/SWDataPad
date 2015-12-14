using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Web.Mvc;
using SWDataPad.Data.Repositories;

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
    }
}
