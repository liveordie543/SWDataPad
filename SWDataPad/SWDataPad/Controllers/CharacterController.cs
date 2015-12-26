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
            return View(CurrentUser.Characters);
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
                CharacterRepository.Create(model.ToCharacterEntity(CurrentUser));
                return RedirectToAction("Select");
            }
            return View(model);
        }

        [HttpGet]
        public ActionResult Activate(int characterId)
        {
            if (CurrentUser.Characters.Any(c => c.Id == characterId))
            {
                SessionHelper.ActiveCharacterId = characterId;
                return RedirectToAction("Dashboard");
            }
            return RedirectToAction("Select");
        }

        [HttpGet]
        public ActionResult Edit(int characterId)
        {
            Character character = CurrentUser.Characters.Single(c => c.Id == characterId);
            return View(new EditCharacterModel(character));
        }

        [HttpPost]
        public ActionResult Edit(EditCharacterModel model)
        {
            if (ModelState.IsValid && CurrentUser.Characters.Any(c => c.Id == model.Id))
            {
                CharacterRepository.Update(model.ToCharacterEntity(CurrentUser));
                return RedirectToAction("Select");
            }
            return View(model);
        }

        [HttpGet]
        public ActionResult Delete(int characterId)
        {
            if (CurrentUser.Characters.Any(c => c.Id == characterId))
            {
                CharacterRepository.DeleteById(characterId);
            }     
            return RedirectToAction("Select");
        }

        [HttpGet]
        public ActionResult Dashboard()
        {
            return View();
        }

        [HttpPost]
        public ActionResult SetActiveDashboardPage(string page)
        {
            SessionHelper.ActiveDashboardPage = page;
            return Json(true);
        }
    }
}