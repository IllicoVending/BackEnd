using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Illico.DAL.Interfaces;
using Illico.Domain.Entities;

namespace Illico.DAL.Repositories
{
    public class PersonRepository : RepositoryBase<Guid, Person>, IPersonRepository
    {
        public PersonRepository(IDbConnection dbConnection) : base(dbConnection) { }

        public override Guid Create(Person entity)
        {
            throw new NotImplementedException();
        }

        public override bool Delete(Guid id)
        {
            throw new NotImplementedException();
        }

        public override IEnumerable<Person>? GetAll()
        {
            List<Person> persons = new List<Person>();
            connection.Open();

            using (SqlCommand cmd = new SqlCommand("SELECT * FROM USER", connection))
            //execute une commande sql et permet d'obtenir un objet sqlDataReader en en appelant la méthode ExecuteReader() sur l'objet sqlCommand 
            {
                using (SqlDataReader reader = cmd.ExecuteReader())
                {
                    while(reader.Read())
                    {
                        Person person = new Person()
                        {
                            Id = (Guid)reader["PersonId"],
                            Name = (string)reader["Name"],
                            Email = (string)reader["Email"],
                            Phone = (string)reader["PhoneNumber"],
                            Password = (string)reader["Password"]
                        };
                        persons.Add(person);
                    }
                }
            }
            connection.Close();
            return persons;

        }

        public override Person? GetById(Guid id)
        {
            throw new NotImplementedException();
        }

        public override bool Update(Guid id, Person entity)
        {
            throw new NotImplementedException();
        }
    }
}
