using System.Linq;
using System.Web.Mvc;
using SWDataPad.Data.Entities;
using SWDataPad.Helpers;
using SWDataPad.Models.Character;

namespace SWDataPad.Controllers
{
    [Authorize]
    public class CharacterController : BaseController
    {
        [HttpGet]
        public ActionResult Select()
        {
            User user = UserRepository.SelectSingle(u => u.Username == User.Identity.Name);
            return View(user.Characters);
        }

        [HttpGet]
        public ActionResult Create()
        {
            return View(new CreateCharacterModel());
        }

        [HttpPost]
        public ActionResult Create(CreateCharacterModel model)
        {
            if (ModelState.IsValid)
            {
                User user = UserRepository.SelectSingle(u => u.Username == User.Identity.Name);
                CharacterRepository.Create(model.ToCharacterEntity(user));
                return RedirectToAction("Select");
            }
            return View(model);
        }

        [HttpGet]
        public ActionResult Activate(int characterId)
        {
            if (UserRepository.SelectSingle(u => u.Username == User.Identity.Name).Characters.Any(c => c.Id == characterId))
            {
                SessionHelper.ActiveCharacterId = characterId;
                return new EmptyResult();
            }
            return RedirectToAction("Select");
        }

        [HttpGet]
        public ActionResult Edit(int characterId)
        {
            Character character = UserRepository.SelectSingle(u => u.Username == User.Identity.Name).Characters.Single(c => c.Id == characterId);
            return View(new EditCharacterModel(character));
        }

        [HttpPost]
        public ActionResult Edit(EditCharacterModel model)
        {
            if (ModelState.IsValid)
            {
                User user = UserRepository.SelectSingle(u => u.Username == User.Identity.Name);
                CharacterRepository.Update(model.ToCharacterEntity(user));
                return RedirectToAction("Select");
            }
            return View(model);
        }

        [HttpGet]
        public ActionResult Delete(int characterId)
        {
            CharacterRepository.DeleteById(characterId);
            return RedirectToAction("Select");
        }
    }
}