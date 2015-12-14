using System.Data.Entity;
using System.Data.Entity.SqlServer;

namespace SWDataPad.Data
{
    public class DataConnector
    {
        public static void Initialize()
        {
            Database.SetInitializer(new CreateDatabaseIfNotExists<DataContext>());
            using(DataContext context = new DataContext())
            {
                context.Database.CreateIfNotExists();
                context.ExecuteMigrations();
            }
        }

        public void FixEfProviderServicesProblem()
        {
            //The Entity Framework provider type 'System.Data.Entity.SqlServer.SqlProviderServices, EntityFramework.SqlServer'
            //for the 'System.Data.SqlClient' ADO.NET provider could not be loaded. 
            //Make sure the provider assembly is available to the running application. 
            //See http://go.microsoft.com/fwlink/?LinkId=260882 for more information.

            SqlProviderServices instance = SqlProviderServices.Instance;
        }
    }
}
