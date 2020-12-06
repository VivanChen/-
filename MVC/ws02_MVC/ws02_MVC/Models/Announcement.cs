using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace ws02_MVC.Models
{
    public class Announcement
    {
        [DisplayName("公告編號")]
        public int AnnouncementID { get; set; }

        [Required(ErrorMessage = "公告主旨不可空白")]
        [DisplayName("公告主旨")]
        public string AnntTitle { get; set; }

        [Required(ErrorMessage = "公告內容不可為空白")]
        [DisplayName("公告內容")]
        public string AnntContent { get; set; }
        //[Required(ErrorMessage = "公告性質不可為空白")]
        //[DisplayName("公告性質")]
        //public string AnntStatus { get; set; }

        [Required(ErrorMessage = "填表人不可為空白")]
        [DisplayName("填表人")]
        public string AnntName { get; set; }

        [DisplayName("公告日期")]
        public string AnntDay { get; set; }
    }
}