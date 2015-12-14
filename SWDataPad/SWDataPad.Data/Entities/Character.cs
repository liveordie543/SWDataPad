using System.ComponentModel.DataAnnotations.Schema;

namespace SWDataPad.Data.Entities
{
    public class Character
    {
        public int Id { get; set; }

        public string Name { get; set; }

        public string Class { get; set; }

        public string Species { get; set; }

        public int Level { get; set; }

        public int Age { get; set; }

        public string Gender { get; set; }

        public int Height { get; set; }

        public int Weight { get; set; }

        public string Background { get; set; }

        public string Destiny { get; set; }

        public decimal Credits { get; set; }

        public int MaxHp { get; set; }

        public int CurrentHp { get; set; }

        public long Experience { get; set; }

        public string PortraitPath { get; set; }

        public bool IsActive { get; set; }

        public int CharacterSheet_Id { get; set; }

        [ForeignKey("CharacterSheet_Id")]
        public CharacterSheet CharacterSheet { get; set; }

        public int Users_Id { get; set; }

        [ForeignKey("Users_Id")]
        public User User { get; set; }
    }
}