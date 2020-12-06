using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace ws02_MVC.Models
{
    public class Project
    {
        [DisplayName("專案編號")]
        public int projectID { get; set; }

        [Required(ErrorMessage = "專案名稱不可以為空白")]
        [DisplayName("專案名稱")]
        public string projName { get; set; }
        [Required(ErrorMessage = "客戶名稱不可以為空白")]
        [DisplayName("客戶名稱")]
        public string client { get; set; }
        [Required(ErrorMessage = "專案描述不可以為空白")]
        [DisplayName("專案描述")]
        public string projDescrip { get; set; }
        [DisplayName("專案新增或修改日期")]
        public string projDay { get; set; }

    }
}