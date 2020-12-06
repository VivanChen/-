using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using ws02_MVC.Models;

namespace ws02_MVC.Controllers
{
    public class TravelController : Controller
    {
        // GET: Travel
        public ActionResult Index()
        {
            return View();
        }

        public ActionResult Create()
            //新增時抓session的id，去資料庫找要的資料
        {
            int userid = Convert.ToInt32(Session["useremployeeid"].ToString().Substring(1));
            Travel emp= TravelADO.GetTravelByemployeeId(userid);
            ViewBag.employeeid = emp.EmployeeID;
            ViewBag.employeename = emp.EmployeeName;
            ViewBag.departmentname = emp.DepartmentName;
            ViewBag.birthdate = emp.BirthDate;
            ViewBag.numberid = emp.NumberID;
            return View();
        }
        
        [HttpPost]
        public ActionResult Create(Travel t)
        {          
            TravelADO.InsertTravel(t);
            var travelList = TravelADO.GetAllTravels();
            return View("List", travelList);
        }

        public ActionResult Delete(int id)
        {
            TravelADO.DeleteTravel(id);
            var travelList = TravelADO.GetAllTravels();
            return View("List",travelList);
        }

        public ActionResult Edit(int? id)
        {
            //當pageLoad時抓id顯示的資料
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            //int travelId = int.Parse(Request.QueryString["TravelID"]);
            Travel travel = TravelADO.GetTravelById(id);

            return View(travel);
        }
        [HttpPost]
        public ActionResult Edit(Travel t)
        {

            TravelADO.UpdateTravel(t);
            var travelList = TravelADO.GetAllTravels();
            return View("List", travelList);
        }
        public ActionResult List()
        {
            var travelList = TravelADO.GetAllTravels();
            return View("List", travelList);
        }

        //public ActionResult Excel()
        //{
        //    TravelViewModel model = new TravelViewModel();
        //    return View(model);
        //}

        //public FileContentResult ExportToExcel()
        //{
        //    List<Travel> travelList = TravelADO.GetAllTravels();   
        //    string[] columns = { "序號", "員工編號", "姓名","部門名稱","生日","身份證字號" };
        //    byte[] filecontent = ExcelExportHelper.ExportExcel(travelList, "", false, columns);
        //    return File(filecontent, ExcelExportHelper.ExcelContentType, "MyTravel.xlsx");
        //}
    }
}
