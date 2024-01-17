using Illico.BLL.Interfaces;
using Illico.BLL.Services;
using Illico.Domain.Entities;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using System.Collections.Generic;

namespace Illico.WEBAPI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class ProductController : ControllerBase
    {
        IProductService _productService;

        public ProductController(IProductService productService)
        {
            _productService = productService;
        }

        [HttpGet]
        [Route ("GetAllProduct")]

        public IActionResult GetAll()
        {
            IEnumerable<Product> products = _productService.GetAll();

            return Ok(products);
        }
    }
}
