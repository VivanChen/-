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
    public class TheProjectController : Controller
    {
        // GET: TheProject
        public ActionResult Index()
        {
            var c = Request.Cookies[".ASPXAUTH"];
            var uncodecookie = FormsAuthentication.Decrypt(c.Value);
            var employeerole = uncodecookie.UserData.Split(char.Parse(","));
            if (!employeerole.Contains("prod"))
            {
                return RedirectToAction("AuthorityInfo", "Company");
            }
            //Context.User = new GenericPrincipal(User.Identity, employeerole.Split(char.Parse(",")));
            
            var All = ProjectADO.GetAllsupplier();

            //supplierAll.supplier  c= new supplierAll.supplier();
            //supplierAll.supComponent d = new supplierAll.supComponent();


            return View("Index", All);
            //return View("Index",new Tuple<supplierAll.supplier,supplierAll.supComponent>(c,d));
        }


        // GET: TheProject/Create
        //insert觀看頁
        public ActionResult Create()
        {
            return View("Create");
        }
        //insert收資料頁
        [HttpPost]
        public ActionResult InsertRecord(FormCollection frm)
        {
            foreach (var item in ProjectADO.GetAllsupplier())
            {
                if (frm["CompanyName"].ToString() == item.CompanyName)
                {
                    ViewBag.Message = "輸入公司名稱重複";
                    return View("Create");
                }
            }

            supplierAll.supplier sup = new supplierAll.supplier()
            {
                CompanyName = frm["CompanyName"].ToString(),
                Address = frm["Address"].ToString(),
                Contact = frm["Contact"].ToString(),
                DirectTelephone = frm["DirectTelephone"].ToString(),
                Email = frm["Email"].ToString(),
                ThisDay = DateTime.Now
            };
            int thesupid = ProjectADO.Insertsupplier(sup);

            supplierAll.supComponent supcom = new supplierAll.supComponent();
            //切除最後一個","
            string strComponentHid = frm["ComponentHid"].ToString();
            strComponentHid = strComponentHid.Remove(strComponentHid.LastIndexOf(','), 1);
            string[] arrsup = strComponentHid.Split(',');
            foreach (var item in arrsup)
            {
                supcom.supplierID = thesupid;
                supcom.Component = item.ToString();
                ProjectADO.InsertSupplierAndComponent(supcom);
            }
            var All = ProjectADO.GetAllsupplier();
            return View("Index", All);

        }
        //GET:TheProject/Details/5
        public ActionResult Details(int id)
        {

            var SupByID = ProjectADO.GetSupplierByID(id);
            if (SupByID == null)
            {
                return HttpNotFound();
            }
            return View("Details", SupByID);

        }


        //GET: TheProject/Edit/5

        public ActionResult Edit(int id)
        {
            var SupByID = ProjectADO.GetSupplierByID(id);
            if (SupByID == null)
            {
                return HttpNotFound();
            }
            return View("Edit", SupByID);

        }


        // POST: TheProject/Edit/5
        [HttpPost]
        public ActionResult UpdateEdit(FormCollection frm)
        {
            //update sup
            supplierAll.supplier sup = new supplierAll.supplier()
            {
                supplierID = Convert.ToInt32(frm["supplierID"]),
                CompanyName = frm["CompanyName"].ToString(),
                Address = frm["Address"].ToString(),
                Contact = frm["Contact"].ToString(),
                DirectTelephone = frm["DirectTelephone"].ToString(),
                Email = frm["Email"].ToString(),
                ThisDay = DateTime.Now
            };
            ProjectADO.UpdateSupplierComp(sup);
            //delete supcom
            ProjectADO.DeletesupComponent(sup.supplierID);

            //insert supcom
            supplierAll.supComponent supcom = new supplierAll.supComponent();
            //切除最後一個","
            string strComponentHid = frm["ComponentHid"].ToString();
            strComponentHid = strComponentHid.Remove(strComponentHid.LastIndexOf(','), 1);
            string[] arrsup = strComponentHid.Split(',');
            foreach (var item in arrsup)
            {
                supcom.supplierID = sup.supplierID;
                supcom.Component = item.ToString();
                ProjectADO.InsertSupplierAndComponent(supcom);
            }
            //return
            var All = ProjectADO.GetAllsupplier();
            return View("Index", All);
        }

        // GET: TheProject/Delete/5
        public ActionResult Delete(int id)
        {
            ProjectADO.Deletesupplier(id);
            ProjectADO.DeletesupComponent(id);
            var All = ProjectADO.GetAllsupplier();
            return View("Index", All);
        }

        // POST: TheProject/Delete/5
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

        //判斷年分 
        public static int thisyear = DateTime.Now.Year;
        List<SelectListItem> _list1 = new List<SelectListItem>
            {
               new SelectListItem{Value=thisyear.ToString(),Text=thisyear.ToString()},
                new SelectListItem{Value=(thisyear-1).ToString(),Text=(thisyear-1).ToString()},
                new SelectListItem{Value=(thisyear-2).ToString(),Text=(thisyear-2).ToString()},



            };
        //判斷月分
        List<SelectListItem> _list2 = new List<SelectListItem>
            {
                new SelectListItem{Value="1",Text="1月"},
                new SelectListItem{Value="2",Text="2月"},
                new SelectListItem{Value="3",Text="3月"},
                new SelectListItem{Value="4",Text="4月"},
                new SelectListItem{Value="5",Text="5月"},
                new SelectListItem{Value="6",Text="6月"},
                new SelectListItem{Value="7",Text="7月"},
                new SelectListItem{Value="8",Text="8月"},
                new SelectListItem{Value="9",Text="9月"},
                new SelectListItem{Value="10",Text="10月"},
                new SelectListItem{Value="11",Text="11月"},
                new SelectListItem{Value="12",Text="12月"}
            };
        //年度各公司及採購價格表
        public ActionResult Histogram()
        {
            var c = Request.Cookies[".ASPXAUTH"];
            var uncodecookie = FormsAuthentication.Decrypt(c.Value);
            var employeerole = uncodecookie.UserData.Split(char.Parse(","));
            if (!employeerole.Contains("prod"))
            {
                return RedirectToAction("AuthorityInfo", "Company");
            }
            ViewBag.droplist1 = _list1;
            ViewBag.droplist2 = _list2;

            //現在時間 自動帶入
            DateTime thistime = DateTime.Now;
            List<supplierAll.supplier> purches = ProjectADO.SelectSupplierColumn();
            var q = from a in purches
                    where a.checkstatus == "已通過" && a.checkday.GetValueOrDefault(DateTime.Now).Year == thistime.Year
                    group a by a.vendor into g
                    select new { g.Key, Total = g.Sum(a => a.totalprice) };
            var result = q.ToList();
            //加成arry
            string[] compAry = result.Select(s => s.Key).ToArray();
            int[] TotalAry = result.Select(s => s.Total).ToArray();
            //加成字串viewbag帶入前方javascript
            ViewData["vendor"] = string.Join(",", compAry);
            ViewData["Total"] = string.Join(", ", TotalAry);
            //對下拉是選單做事bind
            _list1.Where(y => y.Value == thistime.Year.ToString()).First().Selected = true;
            ViewBag.yearList1 = _list1;

            ViewData["titletotal"] = "該年廠商及採購總價圖";
            return View("Histogram");

        }
        //年度各公司及採購價格表 查詢Post
        [HttpPost]
        public ActionResult Histogram(string dropYear,string dropMonth, string action)
        {
            if (action == "submityear")
            {
                int TheYear = Convert.ToInt32(dropYear);

                List<supplierAll.supplier> purches = ProjectADO.SelectSupplierColumn();
                var q = from a in purches
                        where a.checkstatus == "已通過" && a.checkday.GetValueOrDefault(DateTime.Now).Year == TheYear
                        group a by a.vendor into g
                        select new { g.Key, Total = g.Sum(a => a.totalprice) };
                var result = q.ToList();
                //加成arry
                string[] compAry = result.Select(s => s.Key).ToArray();
                int[] TotalAry = result.Select(s => s.Total).ToArray();
                //加成字串viewbag帶入前方javascript
                ViewData["vendor"] = string.Join(",", compAry);
                ViewData["Total"] = string.Join(", ", TotalAry);
                //對下拉是選單做事bind
                _list1.Where(y => y.Value == dropYear.ToString()).First().Selected = true;
                ViewBag.yearList1 = _list1;

                ViewData["titletotal"] = "今年廠商及採購總價圖";
                return View("Histogram");
            }
            if (action == "submitmonth")
            {
                var TheMonth = Convert.ToInt32(dropMonth);
                int TheYear = Convert.ToInt32(dropYear);
                List<supplierAll.supplier> purches = ProjectADO.SelectSupplierColumn();
                var q = from a in purches
                        where a.checkstatus == "已通過" && a.checkday.GetValueOrDefault(DateTime.Now).Year == TheYear && a.checkday.GetValueOrDefault(DateTime.Now).Month== TheMonth
                        group a by a.vendor into g
                        select new { g.Key, Total = g.Sum(a => a.totalprice) };
                var result = q.ToList();
                //加成arry
                string[] compAry = result.Select(s => s.Key).ToArray();
                int[] TotalAry = result.Select(s => s.Total).ToArray();
                //加成字串viewbag帶入前方javascript
                ViewData["vendor"] = string.Join(",", compAry);
                ViewData["Total"] = string.Join(", ", TotalAry);
                //對下拉是選單做事bind
                _list1.Where(y => y.Value == dropYear.ToString()).First().Selected = true;
                ViewBag.yearList1 = _list1;

                ViewData["titletotal"] = "該年廠商及採購總價圖";
                return View("Histogram");
            }



            ViewBag.droplist1 = _list1;
            ViewBag.droplist2 = _list2;


            return View("Histogram");

        }
    }
}
