using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Illico.DAL.Interfaces
{
    public interface ICrudRepository<TId, TEntity> where TEntity : class
    {
        //Plan des méthodes
        TId Create(TEntity entity);
        bool Update(TId id, TEntity entity);
        bool Delete(TId id);
        TEntity? GetById(TId id);
        IEnumerable<TEntity>? GetAll();
    }
}
