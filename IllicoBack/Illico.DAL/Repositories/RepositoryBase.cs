using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Illico.DAL.Repositories
{
    public abstract class RepositoryBase<TId, TEntity> : ICrudRepository<TId, TEntity> where TEntity : class
    {
        protected SqlConnection connection;

        public RepositoryBase(SqlConnection dbConnection)
        {
            connection = dbConnection;
        }

        public abstract IEnumerable<TEntity>? GetAll();
        public abstract TEntity? GetById(TId id);
        public abstract TId Create(TEntity entity);
        public abstract bool Update(TId id, TEntity entity);
        public abstract bool Delete(TId id);
    }
}

