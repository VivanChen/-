using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using System.Web.Security;
using ws02_MVC.Models;

namespace ws02_MVC.Controllers
{
    public class AnnouncementController : Controller
    {
        // GET: Announcement
        public ActionResult Index()
        {

            return View(Models.AnnouncementADO.GetAllAnnouncement());

        }

        // GET: Announcement/Details/5
        public ActionResult Details(int? id)
        {
            return View(AnnouncementADO.GetAnnouncementById(id));
        }

        // GET: Announcement/Create
        public ActionResult Create()
        {
            int userid = Convert.ToInt32(Session["useremployeeid"].ToString().Substring(1));
            Employees emp = CompanyADO.GetEmployeesById(userid);
            ViewBag.Anntaddemp = emp.Name;
            return View();
        }

        // POST: Announcement/Create
        [HttpPost]
        public ActionResult Create(Announcement annt)
        {

            AnnouncementADO.InsertAnnouncement(annt);
            return RedirectToAction("Index");

        }

        // GET: Announcement/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id==null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            //AnnouncementADO.GetAnnouncementById(id);
            return View(AnnouncementADO.GetAnnouncementById(id));
        }

        // POST: Announcement/Edit/5
        [HttpPost]
        public ActionResult Edit(int id, Announcement annt)
        {
            try
            {
                // TODO: Add update logic here
                AnnouncementADO.UpdateAnnouncement(id, annt);
                return RedirectToAction("Index");
            }
            catch
            {
                return View();
            }
        }

        // GET: Announcement/Delete/5
        public ActionResult Delete(int id)
        {
            AnnouncementADO.DeleteAnnouncementByAnnouncementId(id);

            return RedirectToAction("Index");
        }

        // POST: Announcement/Delete/5
        [HttpPost]
        public ActionResult Delete(int id, FormCollection collection)
        {
            try
            {
                // TODO: Add delete logic here

                return RedirectToAction("Index");
            }
            catch
            {
                return View();
            }
        }
    }
}
