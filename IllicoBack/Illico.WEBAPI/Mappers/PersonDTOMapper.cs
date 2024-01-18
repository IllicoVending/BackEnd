using Illico.Domain.Entities;
using Illico.WEBAPI.DTOs;

namespace Illico.WEBAPI.Mappers
{
    public static class PersonDTOMapper
    {
        public static PersonDTO PersonToDTO(this Person person)
        {
            return new PersonDTO()
            {
                Id = person.Id,
                Name = person.Name,
            };
        }
    }
}
