using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace ws02_MVC.Models
{
    public class supplierAll
    {
        //public supplier a { get; set; }

        public class supplier
        {
            [DisplayName("編號")]
            public int supplierID { get; set; }
            [DisplayName("名稱")]
            [Required(ErrorMessage = "公司名稱不可為空白")]
            public string CompanyName { get; set; }
            [DisplayName("地址")]
            [Required(ErrorMessage = "地址不可為空白")]
            public string Address { get; set; }
            [DisplayName("負責人")]
            [Required(ErrorMessage = "負責人不可為空白")]
            public string Contact { get; set; }
            [DisplayName("電話")]
            [Required(ErrorMessage = "電話不可為空白")]
            public string DirectTelephone { get; set; }
            [DisplayName("E-mail")]
           
            [DataType(DataType.EmailAddress)]
            [Required(ErrorMessage = "E-mail不可為空白")]
            public string Email { get; set; }
            [DisplayName("修改日期")]
            [DataType(DataType.Date)]
            public DateTime ThisDay { get; set; }
            public string strSupcom { get; set; }

            //下拉選單一 年分
            [DisplayName("採購年份")]
            //下拉選單二 月份
            public int? dropYear { get; set; }
            [DisplayName("採購月份")]
            public int? dropMonth { get; set; }
            //採購
            public string vendor { get; set; }
            public int totalprice { get; set; }
            public DateTime? checkday { get; set; }
            public string checkstatus { get; set; }

        }
        public class supComponent
        {

            public int supplierID { get; set;}
            public string Component { get; set;}

        }
      
    }
   
}