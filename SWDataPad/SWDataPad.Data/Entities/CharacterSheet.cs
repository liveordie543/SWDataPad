using System.ComponentModel.DataAnnotations.Schema;

namespace SWDataPad.Data.Entities
{
    public class CharacterSheet
    {
        public CharacterSheet()
        {
            Stats = new Stats();
            Skills = new Skills();
        }

        public int Id { get; set; }

        public int Stats_Id { get; set; }

        [ForeignKey("Stats_Id")]
        public Stats Stats { get; set; }

        public int Skills_Id { get; set; }

        [ForeignKey("Skills_Id")]
        public Skills Skills { get; set; }
    }
}
