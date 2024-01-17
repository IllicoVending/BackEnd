using Illico.Domain.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Illico.BLL.Interfaces
{
    public interface IProductService
    {
        public IEnumerable<Product>? GetAll();
    }
}
