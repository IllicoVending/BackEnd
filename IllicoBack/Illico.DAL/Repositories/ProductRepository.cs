using Illico.DAL.Interfaces;
using Illico.Domain.Entities;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Illico.DAL.Repositories
{
    public class ProductRepository : RepositoryBase<int, Product>, IProductRepository
    {
        public ProductRepository(SqlConnection dbConnection) : base(dbConnection)
        {
        }

        public override int Create(Product entity)
        {
            throw new NotImplementedException();
        }

        public override bool Delete(int id)
        {
            throw new NotImplementedException();
        }

        public override IEnumerable<Product>? GetAll()
        {
            List<Product> products = new List<Product>();
            connection.Open();

            using (SqlCommand cmd = new SqlCommand("SELECT * FROM Product", connection))
            {
                using (SqlDataReader reader = cmd.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        Product product = new Product()
                        {
                            Id = (int)reader["ProductId"],
                            Name = (string)reader["Name"],
                            Price = (double)reader["Price"],
                            Image = (string)reader["Image"],
                            CategoryId = (int)reader["CategoryId"]
                        };
                        products.Add(product);
                    }
                }
            }
            connection.Close();
            return products;
        }

        public override Product? GetById(int id)
        {
            throw new NotImplementedException();
        }

        public override bool Update(int id, Product entity)
        {
            throw new NotImplementedException();
        }
    }
}
