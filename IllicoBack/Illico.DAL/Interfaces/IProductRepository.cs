using Illico.Domain.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Illico.DAL.Interfaces
{
    public interface IProductRepository : ICrudRepository<int,Product>
    {
    }
}
