using System;
using System.Security.Cryptography;
using SWDataPad.Data.Entities;
using SWDataPad.Data.Repositories;

namespace SWDataPad.Data.Authentication
{
    public class Authenticator
    {
        public static string ComputeHash(string password)
        {
            RNGCryptoServiceProvider provider = new RNGCryptoServiceProvider();
            byte[] salt = new byte[16];
            provider.GetBytes(salt);

            byte[] hashBytes = new byte[36];
            Array.Copy(salt, 0, hashBytes, 0, 16);
            Array.Copy(GetDeriveBytes(password, salt), 0, hashBytes, 16, 20);

            return Convert.ToBase64String(hashBytes);
        }

        public static bool IsValidLogin(string username, string password)
        {
            bool isValid = true;

            UserRepository userRepository = new UserRepository();
            User user = userRepository.SelectSingleOrDefault(u => u.Username == username);
            if (user == null)
            {
                isValid = false;
            }

            const string stubPassword = "L/PFDxjaZuUeDSPh9JN0ZR09CU0EYg8UOPOdAqacTbZnPeI6";
            byte[] hashBytes = Convert.FromBase64String(user != null ? user.Password : stubPassword);
            byte[] salt = new byte[16];
            Array.Copy(hashBytes, 0, salt, 0, 16);

            byte[] hash = GetDeriveBytes(password, salt);
            for (int i = 0; i < 20; i++)
            {
                if (hashBytes[i + 16] != hash[i])
                {
                    isValid = false;
                }
            }

            return isValid;
        }

        private static byte[] GetDeriveBytes(string password, byte[] salt)
        {
            Rfc2898DeriveBytes deriveBytes = new Rfc2898DeriveBytes(password, salt, 1000);
            return deriveBytes.GetBytes(20);
        }
    }
}
