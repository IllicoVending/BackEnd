using Illico.BLL.Forms;
using Illico.BLL.Interfaces;
using Illico.BLL.Services;
using Illico.Domain.Entities;
using Illico.WEBAPI.DTOs;
using Illico.WEBAPI.Mappers;
using Illico.WEBAPI.Services;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace Illico.WEBAPI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class AuthController : ControllerBase
    {
        IPersonService _personService;
        TokenService _tokenService;

        public AuthController(IPersonService personService, TokenService tokenService)
        {
            _personService = personService;
            _tokenService = tokenService;
        }

        #region Login
        [HttpPost]
        [Route("login")]
        public IActionResult Login(LoginForm form)
        {
            Person person = _personService.Login(form.Email, form.Password);

            if (person is not null)
            {
                PersonTokenDTO tokenDTO = new PersonTokenDTO()
                {
                    Member = person.PersonToDTO(),
                    Token = _tokenService.GenerateJwt(person)
                };

                return Ok(tokenDTO);
            }
            return BadRequest();
        }
        #endregion
        #region Register
        [HttpPost]
        [Route("register")]

        public IActionResult Register(RegisterForm form)
        {
            Person person = _personService.Register(form);
            if(person is not null)
            {
                return Ok(person);
            }
            return BadRequest();
        }
        #endregion
    }
}
