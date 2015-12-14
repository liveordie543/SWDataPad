using System.Web;

namespace SWDataPad.Helpers
{
    public class SessionHelper
    {
        public static int ActiveCharacterId
        {
            get { return GetSessionVariable<int>("ActiveCharacterId"); }
            set { SetSessionVariable("ActiveCharacterId", value); }
        }

        private static T GetSessionVariable<T>(string key)
        {
            HttpContext context = HttpContext.Current;
            if (context != null && context.Session[key] != null)
            {
                return (T)context.Session[key];
            }
            return default(T);
        }

        private static void SetSessionVariable(string key, object value)
        {
            HttpContext.Current.Session[key] = value;
        }
    }
}