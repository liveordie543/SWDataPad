using System.ComponentModel.DataAnnotations;
using SWDataPad.Data.Authentication;
using SWDataPad.Data.Entities;
using SWDataPad.Validation;

namespace SWDataPad.Models.Login
{
    public class RegisterModel
    {
        [Required]
        [UsernameUnique("Username must be unique.")]
        public string Username { get; set; }

        [Required]
        [Compare("ConfirmPassword", ErrorMessage = "Passwords must match.")]
        public string Password { get; set; }

        [Required]
        [Display(Name = "Confirm Password")]
        public string ConfirmPassword { get; set; }

        [Required]
        [Display(Name = "First Name")]
        public string FirstName { get; set; }

        [Required]
        [Display(Name = "Last Name")]
        public string LastName { get; set; }

        public User ToUserEntity()
        {
            return new User
            {
                Id = 0,
                FirstName = FirstName,
                LastName = LastName,
                Username = Username,
                Password = Authenticator.ComputeHash(Password),
                IsDm = false,
            };
        }
    }
}