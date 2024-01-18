using Illico.Domain.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Illico.DAL.Interfaces
{
    public interface IPersonRepository : ICrudRepository<Guid,Person>
    {
        Person GetByEmail(string email);


    }
}
