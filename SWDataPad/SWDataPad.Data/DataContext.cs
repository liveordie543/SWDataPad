using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Data.Entity.Core.Metadata.Edm;
using System.Data.Entity.Core.Objects;
using System.Data.Entity.Infrastructure;
using System.IO;
using System.Linq;
using SWDataPad.Data.Entities;

namespace SWDataPad.Data
{
    public class DataContext : DbContext
    {
        public DbSet<User> Users { get; set; }

        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            Database.SetInitializer<DataContext>(null);
            base.OnModelCreating(modelBuilder);
        }

        public void ExecuteMigrations()
        {
            IEnumerable<string> migrationFiles = GetMigrationsFiles();
            int index = 0;
            foreach (string file in migrationFiles.OrderBy(mf => int.Parse(Path.GetFileNameWithoutExtension(mf))))
            {
                if (index == 0 && IsInitialMigrationPresent())
                {
                    index++;
                    continue;
                }
                Database.ExecuteSqlCommand(File.ReadAllText(file));
                index++;
            }
        }

        public override int SaveChanges()
        {
            ObjectStateManager manager = ((IObjectContextAdapter)this).ObjectContext.ObjectStateManager;
            foreach(ObjectStateEntry entry in manager.GetObjectStateEntries(EntityState.Added))
            {
                if(entry.Entity != null && entry.EntitySet != null && entry.EntitySet.ElementType.KeyProperties.Count <= 1)
                {
                    EdmProperty keyProp = entry.EntitySet.ElementType.KeyProperties[0];
                    object key = entry.CurrentValues[keyProp.Name];
                    if(key != null && (keyProp.TypeName == typeof(int).Name && (int)key != 0 || keyProp.TypeName == typeof(string).Name && (string)key != string.Empty))
                    {
                        manager.ChangeObjectState(entry.Entity, EntityState.Unchanged);
                    }
                }
            }
            return base.SaveChanges();
        }

        private static IEnumerable<string> GetMigrationsFiles()
        {
            string migrationPath = Directory.GetParent(AppDomain.CurrentDomain.BaseDirectory).Parent.FullName + "\\SWDataPad\\Migrations";
            return Directory.GetFiles(migrationPath, "*.sql");
        }

        private bool IsInitialMigrationPresent()
        {
            return Database.SqlQuery<int?>(@"SELECT 1 FROM sys.tables AS T WHERE T.Name = 'Versions'").SingleOrDefault() != null;
        }
    }
}