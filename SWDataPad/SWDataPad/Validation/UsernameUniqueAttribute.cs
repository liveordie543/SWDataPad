using System;
using System.ComponentModel.DataAnnotations;
using SWDataPad.Data.Entities;
using SWDataPad.Data.Repositories;

namespace SWDataPad.Validation
{
    [AttributeUsage(AttributeTargets.Field | AttributeTargets.Property)]
    public class UsernameUniqueAttribute : ValidationAttribute
    {
        private readonly string _errorMessage;

        public UsernameUniqueAttribute(string errorMessage)
        {
            _errorMessage = errorMessage;
        }

        protected override ValidationResult IsValid(object value, ValidationContext validationContext)
        {
            if (value == null)
            {
                return new ValidationResult("");
            }
            User user = new UserRepository().SelectSingleOrDefault(u => u.Username == (string)value);
            return user == null ? ValidationResult.Success : new ValidationResult(_errorMessage);
        }
    }
}
