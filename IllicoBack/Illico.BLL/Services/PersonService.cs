using Illico.BLL.Forms;
using Illico.BLL.Interfaces;
using Illico.DAL.Interfaces;
using Illico.Domain.Entities;
using Isopoh.Cryptography.Argon2;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Illico.BLL.Services
{
    public class PersonService : IPersonService
    {

        private readonly IPersonRepository _personRepository;

        public PersonService(IPersonRepository personRepository)
        {
            _personRepository = personRepository;
        }

        public Person GetByEmail(string email)
        {
            return _personRepository.GetByEmail(email);
        }

        public Person? Login(string email, string password)
        {

            // grace à getByEmail , je récupère tout l'user qui lui correspond
           Person person = _personRepository.GetByEmail(email);
            if (person == null)
            {
                return null;
            }
            string hashPwd = person.Password;

            if (Argon2.Verify(hashPwd, password)) {
                return person;
            }

            return null;
        }

        public Person? Register(RegisterForm form)
        {
            Person person = new Person() {
                Id = Guid.NewGuid(),
                Name = form.Name,
                Email = form.Email,
                Phone = form.Phone,
                Password = form.Password
            };
            person.Password = Argon2.Hash(person.Password);

            return _personRepository.Create(person);
        }

    }
}
