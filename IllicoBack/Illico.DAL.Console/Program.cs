
using Illico.DAL.Repositories;
using Isopoh.Cryptography.Argon2;
using System.Data.SqlClient;

namespace Illico.DAL.Console
{
    internal class Program
    {
        static void Main(string[] args)
        {
            SqlConnection connection = new SqlConnection("Server=5346\\SQLSERVER;DataBase=IllicoDB;User ID=sa;Password=formation;Encrypt=False");

            ProductRepository repository = new ProductRepository(connection);

            foreach (var r in repository.GetAll())
            {
                System.Console.WriteLine(r.Name);
            }
            System.Console.WriteLine("-----------");

            string hash1 = Argon2.Hash("Mimi123");
            string hash2 = Argon2.Hash("Toto123");
            string hash3 = Argon2.Hash("Harry123");
            System.Console.WriteLine("mdp1 = " +hash1 +" mdp2 = " + hash2 + " mdp3 = " + hash3);
        }
    }
}