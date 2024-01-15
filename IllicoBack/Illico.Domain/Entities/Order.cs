using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Illico.Domain
{
    public class Order
    {
        public int Id { get; set; }
        public DateTime Date { get; set; }
        public Decimal TotalPrice { get; set; }
        public bool IsCommandHandled { get; set; }
        public int UserId { get; set; }
        public int ClientId { get; set; } 

    }
}
