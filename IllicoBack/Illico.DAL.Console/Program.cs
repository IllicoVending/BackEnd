
using Illico.DAL.Repositories;
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
        }
    }
}