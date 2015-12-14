using SWDataPad.Data.Entities;

namespace SWDataPad.Models.Character
{
    public class CreateCharacterModel : BaseCharacterModel
    {
        public override Data.Entities.Character ToCharacterEntity(User user)
        {
            return new Data.Entities.Character
            {
                Id = 0,
                Name = Name,
                Class = Class,
                Species = Species,
                Level = Level,
                Age = Age,
                Gender = Gender,
                Height = Height,
                Weight = Weight,
                Background = Background,
                Destiny = Destiny,
                Credits = Credits,
                MaxHp = MaxHp,
                CurrentHp = MaxHp,
                Experience = Experience,
                CharacterSheet = new CharacterSheet(),
                Users_Id = user.Id
            };
        }
    }
}