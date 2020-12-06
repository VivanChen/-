using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace ws02_MVC.Models
{
    public class Account2
    {
        public string Id { get; set; }
        public string Password { get; set; }

    }
    public class Account
    {
        public int Id { get; set; }
        public string Password { get; set; }
        public string Roles { get; set; }
        public string DepartmentID { get; set; }
        public string ImageFileName { get; set; }
    }
}