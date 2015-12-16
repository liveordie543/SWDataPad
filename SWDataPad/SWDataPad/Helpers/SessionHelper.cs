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
            return HttpContext.Current?.Session[key] != null
                ? (T) HttpContext.Current.Session[key]
                : default(T);
        }

        private static void SetSessionVariable(string key, object value)
        {
            HttpContext.Current.Session[key] = value;
        }
    }
}