namespace Illico.WEBAPI.DTOs
{
    public class PersonDTO
    {
        public Guid Id { get; set; }
        public string Name { get; set; }

    }
    public class PersonTokenDTO
    {
        public PersonDTO Member { get; set; }
        public string Token { get; set; } = string.Empty;
    }
}
