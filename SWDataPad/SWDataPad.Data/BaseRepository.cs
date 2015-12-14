using System;
using System.Collections.Generic;
using System.Linq;
using System.Data.Entity;
using System.Linq.Expressions;

namespace SWDataPad.Data
{
    public abstract class BaseRepository<T> where T : class
    {
        public void Create(T entity)
        {
            using(DataContext context = new DataContext())
            {
                AddEntity(context, entity);
                context.SaveChanges();
            }
        }

        public void Update(T entity)
        {
            using (DataContext context = new DataContext())
            {
                UpdateEntity(context, entity);
                context.SaveChanges();
            }
        }

        public void Delete(T entity)
        {
            using (DataContext context = new DataContext())
            {
                DeleteEntity(context, entity);
                context.SaveChanges();
            }
        }

        public T SelectSingle(Expression<Func<T, bool>> criteria)
        {
            using (DataContext context = new DataContext())
            {
                IQueryable<T> query = BuildSingleEntityQuery(context.Set<T>());
                return query.Single(criteria);
            }
        }

        public T SelectSingleOrDefault(Expression<Func<T, bool>> criteria)
        {
            using (DataContext context = new DataContext())
            {
                IQueryable<T> query = BuildSingleEntityQuery(context.Set<T>());
                return query.SingleOrDefault(criteria);
            }
        }

        public IList<T> Select(Expression<Func<T, bool>> criteria)
        {
            using (DataContext context = new DataContext())
            {
                IQueryable<T> query = BuildMultiEntityQuery(context.Set<T>());
                return query.Where(criteria).ToList();
            }
        }

        protected virtual void AddEntity(DataContext context, T entity)
        {
            context.Set<T>().Add(entity);
        }

        protected virtual void UpdateEntity(DataContext context, T entity)
        {
            context.Set<T>().Attach(entity);
            context.Entry(entity).State = EntityState.Modified;
        }

        protected virtual void DeleteEntity(DataContext context, T entity)
        {
            DbSet<T> set = context.Set<T>();
            set.Attach(entity);
            set.Remove(entity);
        }

        protected virtual IQueryable<T> BuildSingleEntityQuery(IQueryable<T> query)
        {
            return query;
        }

        protected virtual IQueryable<T> BuildMultiEntityQuery(IQueryable<T> query)
        {
            return query;
        }
    }
}