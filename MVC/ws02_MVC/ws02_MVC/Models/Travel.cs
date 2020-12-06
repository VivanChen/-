using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace ws02_MVC.Models
{
    public class Travel
    {
        [DisplayName("編號")]
        public int TravelID { get; set; }
        [DisplayName("員工編號")]
        public int EmployeeID { get; set; }
        [Required]
        [DisplayName("姓名")]
        
        public string EmployeeName { get; set; }
        [Required]
        [DisplayName ("部門")]

        public string DepartmentName { get; set; }
        [Required]
        [DisplayName("生日")]
        [DataType(DataType.Date)]
        public string BirthDate { get; set; }
        [Required (ErrorMessage ="身份證字號不可空白")]
        [DisplayName("身份證字號")]
        public string NumberID { get; set; }
        [Required]
        [DisplayName("大頭照")]
        public string ImageFileName { get; set; }

    }
}