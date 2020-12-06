using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Security;
using ws02_MVC.Models;

namespace ws02_MVC.Controllers
{
    public class CompanyController : Controller
    {
        // GET: Default 首頁Index
        public ActionResult Index()
        {
            var c = Request.Cookies[".ASPXAUTH"];
            var uncodecookie = FormsAuthentication.Decrypt(c.Value);
            var employeeid = uncodecookie.Name;
            //if (uncodecookie.UserData=="admin")  
            //{

            //}

            //ViewBag.useremployeeid = $"A{employeeid.PadLeft(4,'0')}";
            Session["useremployeeid"]= $"A{employeeid.PadLeft(4, '0')}"; //存使用者id到session 組字串給View那邊秀出員工A0001
            Employees emphead = CompanyADO.GetEmployeesById(Convert.ToInt32(employeeid));
            Session["userhead"] = emphead.ImageFileName;
            Session["userroles"] = uncodecookie.UserData; // 存使用者role
            ViewBag.Todaytime1 = DateTime.Now.ToShortDateString(); 
            ViewBag.Todaytime2 = DateTime.Now.ToShortTimeString();
            JArray jsondata = WeatherApiUtility.getJson("https://opendata.cwb.gov.tw/api/v1/rest/datastore/F-C0032-001?Authorization=CWB-75869465-3002-41DD-98D3-E4B21F33F790&locationName=%E8%87%BA%E5%8C%97%E5%B8%82");

            foreach (JObject data in jsondata)
            {
                string loactionname = (string)data["locationName"]; //地名
                string weathdescrible = (string)data["weatherElement"][0]["time"][0]["parameter"]["parameterName"]; //天氣狀況
                string pop = (string)data["weatherElement"][1]["time"][0]["parameter"]["parameterName"];  //降雨機率
                string mintemperature = (string)data["weatherElement"][2]["time"][0]["parameter"]["parameterName"]; //最低溫度
                string maxtemperature = (string)data["weatherElement"][4]["time"][0]["parameter"]["parameterName"]; //最高溫度

                ViewBag.city = loactionname;
                ViewBag.weather = weathdescrible + " " + mintemperature + "°c" + "-" + maxtemperature + "°c" + " " + pop + "%";

            }

            return View();
        }

        //Project專案管理頁
        public ActionResult Project()
        {
            return View();
        }

        // GET: Default/Details/5
        public ActionResult AuthorityInfo()
        {
            return View();
        }

        // GET: Default/Create      
        //[Authorize]
        public ActionResult Login()
        {
            return View();
        }

        // POST: Default/Login
 
        [HttpPost]
        public ActionResult Login(Account2 act)
        {
            // TODO: Add insert logic here
            if (act.Id.Length==5)
            {
                Account m2 = CompanyADO.FindAccount(act.Id.Substring(1), act.Password);
                if (m2!=null)
                {
                    //FormsAuthentication.SetAuthCookie(m2.Id.ToString(), false);
                    Session.RemoveAll();
                    FormsAuthenticationTicket ticket = new FormsAuthenticationTicket(
                        1,
                        m2.Id.ToString(),
                        DateTime.Now,
                        //DateTime.Now.AddMinutes(30),
                        DateTime.Now.AddDays(1),
                        false,
                        m2.Roles.ToString(),
                        FormsAuthentication.FormsCookiePath
                        );

                        string encTicket = FormsAuthentication.Encrypt(ticket);

                        Response.Cookies.Add(new HttpCookie(FormsAuthentication.FormsCookieName, encTicket));
                    return RedirectToAction("Index");
                }
                else
                {
                    ViewBag.errormessage = "登入失敗，帳號或密碼錯誤";
                }
            }
            else
            {
                ViewBag.errormessage = "登入失敗，帳號或密碼錯誤";
            }

            return View();

        }
        public ActionResult Logout()
        {
            FormsAuthentication.SignOut();
            return RedirectToAction("Login");
        }
        // GET: Default/Edit/5
        public ActionResult Edit(int id)
        {
            return View();
        }

        // POST: Default/Edit/5
        [HttpPost]
        public ActionResult Edit(int id, FormCollection collection)
        {
            try
            {
                // TODO: Add update logic here

                return RedirectToAction("Index");
            }
            catch
            {
                return View();
            }
        }

        // GET: Default/Delete/5
        public ActionResult Delete(int id)
        {
            return View();
        }

        // POST: Default/Delete/5
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
