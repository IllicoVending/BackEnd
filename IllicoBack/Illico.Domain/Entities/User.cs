﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Illico.Domain.Entities
{
    public class User
    {
        public int Id { get; set; }
        public int RoleId { get; set; }
        public Guid PersonId { get; set; }


    }
}
