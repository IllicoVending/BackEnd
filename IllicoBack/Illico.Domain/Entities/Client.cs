using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Illico.Domain.Entities
{
    public class Client
    {
        public int Id { get; set; }
        public string? Address { get; set; }
        public Guid PersonId { get; set; }
    }
}
