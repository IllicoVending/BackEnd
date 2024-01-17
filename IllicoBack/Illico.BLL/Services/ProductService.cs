using Illico.BLL.Interfaces;
using Illico.Domain.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Illico.DAL.Interfaces;

namespace Illico.BLL.Services
{
    public class ProductService : IProductService
    {
        private readonly IProductRepository _productRepository;
        public ProductService(IProductRepository productRepository)
        {
            _productRepository = productRepository;
        } 
        public IEnumerable<Product>? GetAll()
        {
            return _productRepository.GetAll();
        }
    }
}
