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
        public PersonRepository(SqlConnection dbConnection) : base(dbConnection) { }

        public override Person Create(Person entity)
        {
            connection.Open();
            using (SqlCommand cmd = new SqlCommand(
                "INSERT INTO [Person](" +
                "[Name]," +
                "[Email]," +
                "[Phone]," +
                "[Password])" +
                " OUTPUT INSERTED.[PersonId]" +
                " VALUES(" +
                "@Name," +
                "@Email," +
                "@Phone," +
                "@Password)"
                , connection))
            {
                cmd.Parameters.AddWithValue("@Name", entity.Name);
                cmd.Parameters.AddWithValue("@Email", entity.Email);
                cmd.Parameters.AddWithValue("@Phone", entity.Phone);
                cmd.Parameters.AddWithValue("@Password", entity.Password);

                entity.Id = new Guid(cmd.ExecuteScalar().ToString());

                connection.Close();
                return entity;
            }
        }

        public override bool Delete(Guid id)
        {
            throw new NotImplementedException();
        }

        public override IEnumerable<Person>? GetAll()
        {
            List<Person> persons = new List<Person>();
            connection.Open();

            using (SqlCommand cmd = new SqlCommand("SELECT * FROM Person", connection))
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

        public Person? GetByEmail(string email)
        {
            Person? person = null;

            using (SqlCommand command = new SqlCommand(
              "SELECT * FROM [Person] WHERE [Email] = @Email", connection))
            {
                command.Parameters.AddWithValue("@Email", email);
                connection.Open();

                using (SqlDataReader reader = command.ExecuteReader())
                {
                    if (reader.Read())
                    {
                        person = new Person()
                        {
                            Id = new Guid(reader["PersonId"].ToString()),
                            Name = reader["Name"].ToString(),
                            Email = reader["Email"].ToString(),
                            Phone = reader["Phone"].ToString(),
                            Password = reader["Password"].ToString()
                        };
                    }
                }
                connection.Close();
            }
            return person;
        }
    }
}
