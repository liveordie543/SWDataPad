using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SWDataPad.Data.Entities;

namespace SWDataPad.Models.Character
{
    public class BaseCharacterModel
    {
        [Required]
        public string Name { get; set; }

        [Required]
        public string Class { get; set; }

        [Required]
        public string Species { get; set; }

        [Range(0, int.MaxValue, ErrorMessage = "Value must be greater than 0.")]
        public int Level { get; set; }

        [Range(0, int.MaxValue, ErrorMessage = "Value must be greater than 0.")]
        public int Age { get; set; }

        [Required]
        public string Gender { get; set; }

        [Range(0, int.MaxValue, ErrorMessage = "Value must be greater than 0.")]
        public int Height { get; set; }

        [Range(0, int.MaxValue, ErrorMessage = "Value must be greater than 0.")]
        public int Weight { get; set; }

        public string Background { get; set; }

        public string Destiny { get; set; }

        [Range(0, double.MaxValue, ErrorMessage = "Value must be greater than 0.")]
        public decimal Credits { get; set; }

        [Display(Name = "Max HP")]
        [Range(0, int.MaxValue, ErrorMessage = "Value must be greater than 0.")]
        public int MaxHp { get; set; }

        [Range(0, long.MaxValue, ErrorMessage = "Value must be greater than 0.")]
        public long Experience { get; set; }

        public virtual Data.Entities.Character ToCharacterEntity(User user)
        {
            return new Data.Entities.Character();
        }
    }
}
