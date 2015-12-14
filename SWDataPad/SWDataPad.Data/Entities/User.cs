using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;

namespace SWDataPad.Data.Entities
{
    public class User
    {
        public User()
        {
            Characters = new List<Character>();
        }

        public int Id { get; set; }

        public string Username { get; set; }

        public string Password { get; set; }

        public string FirstName { get; set; }

        public string LastName { get; set; }

        public bool IsDm { get; set; }

        public List<Character> Characters { get; set; }

        [NotMapped]
        public string PlayerName
        {
            get
            {
                return string.Format("{0} {1}", FirstName, LastName[0]);
            }
        }
    }
}