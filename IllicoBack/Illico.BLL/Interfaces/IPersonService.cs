using Illico.BLL.Forms;
using Illico.Domain.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Illico.BLL.Interfaces
{
    public interface IPersonService
    {
        public Person? Register(RegisterForm form);
        public Person? Login(string email,string password);
        public Person  GetByEmail(string email);
    }
}
