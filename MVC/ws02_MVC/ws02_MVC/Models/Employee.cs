using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace ws02_MVC.Models
{
    public class Employee
    {
        [DisplayName("分機")]
        public int EmployeeID { get; set; }
        [DisplayName("員工姓名")]
        public string Name { get; set; }
        [DisplayName("部門名稱")]
        public string DepartmentName { get; set; }
        [DisplayName("電話")]
        public string Phone { get; set; }
        [DisplayName("信箱")]
        public string Email{ get; set; }
    }
}