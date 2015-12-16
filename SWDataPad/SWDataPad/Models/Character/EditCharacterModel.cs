using System.ComponentModel.DataAnnotations;
using SWDataPad.Data.Entities;

namespace SWDataPad.Models.Character
{
    public class EditCharacterModel : BaseCharacterModel
    {
        public EditCharacterModel() { }

        public EditCharacterModel(Data.Entities.Character character)
        {
            Id = character.Id;
            Name = character.Name;
            Class = character.Class;
            Species = character.Species;
            Level = character.Level;
            Age = character.Age;
            Gender = character.Gender;
            Height = character.Height;
            Weight = character.Weight;
            Background = character.Background;
            Destiny = character.Destiny;
            Credits = character.Credits;
            MaxHp = character.MaxHp;
            CurrentHp = character.CurrentHp;
            Experience = character.Experience;
            CharacterSheetId = character.CharacterSheet_Id;
        }

        [Range(0, int.MaxValue, ErrorMessage = "Value must be greater than 0.")]
        public int Id { get; set; }

        [Range(0, int.MaxValue, ErrorMessage = "Value must be greater than 0.")]
        public int CharacterSheetId { get; set; }

        [Display(Name = "Current HP")]
        [Range(0, int.MaxValue, ErrorMessage = "Value must be greater than 0.")]
        public int CurrentHp { get; set; }

        public override Data.Entities.Character ToCharacterEntity(User user)
        {
            return new Data.Entities.Character
            {
                Id = Id,
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
                CurrentHp = CurrentHp,
                Experience = Experience,
                CharacterSheet_Id = CharacterSheetId,
                Users_Id = user.Id
            };
        }
    }
}