using Illico.DAL.Interfaces;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Illico.DAL.Repositories
{
    public abstract class RepositoryBase<TId, TEntity> : ICrudRepository<TId, TEntity> where TEntity : class
    {
        protected readonly SqlConnection connection;
        private IDbConnection _dbConnection;

        public RepositoryBase(SqlConnection dbConnection)
        {
            connection = dbConnection;
        }

        protected RepositoryBase(IDbConnection dbConnection)
        {
            _dbConnection = dbConnection;
        }

        public abstract TEntity Create(TEntity entity);
        public abstract bool Update(TId id, TEntity entity);
        public abstract bool Delete(TId id);
        public abstract TEntity? GetById(TId id);
        public abstract IEnumerable<TEntity>? GetAll();
    }
}

