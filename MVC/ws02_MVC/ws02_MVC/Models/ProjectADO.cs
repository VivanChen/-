using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;

namespace ws02_MVC.Models
{
    public class ProjectADO
    {

        //專案首頁查詢全部
        public static List<supplierAll.supplier> GetAllsupplier()
        {
            SqlDataAdapter da = new SqlDataAdapter("SELECT * FROM supplier", Common.DBConnectionString);
            DataTable dt = new DataTable();
            da.Fill(dt);
            var query = from row in dt.AsEnumerable()
                        select new supplierAll.supplier()
                        {
                            supplierID = (int)row["supplierID"],
                            CompanyName = row["CompanyName"].ToString(),
                            Address = row["Address"].ToString(),
                            Contact = row["Contact"].ToString(),
                            DirectTelephone = row["DirectTelephone"].ToString(),
                            Email = row["Email"].ToString(),
                            ThisDay = (DateTime)row["ThisDay"]
                        };
            List<supplierAll.supplier> supplierList = query.ToList();
            return supplierList;

        }
        //新增專案建立主內容 sup
        public static int Insertsupplier(supplierAll.supplier p)
        {
            SqlConnection cn = new SqlConnection(Common.DBConnectionString);
            SqlCommand cmd = new SqlCommand("InsertSupplierGetID2", cn);
            cmd.CommandType = CommandType.StoredProcedure;

            cmd.Parameters.AddWithValue("@CompanyName", p.CompanyName);
            cmd.Parameters.AddWithValue("@Address", p.Address);
            cmd.Parameters.AddWithValue("@Contact", p.Contact);
            cmd.Parameters.AddWithValue("@DirectTelephone", p.DirectTelephone);
            cmd.Parameters.AddWithValue("@Email", p.Email);
            cmd.Parameters.AddWithValue("@ThisDay", p.ThisDay);

            cn.Open();
            object supid = cmd.ExecuteScalar();
            cn.Close();

            int thesupid = Convert.ToInt32(supid);
            return thesupid;
        }
        //資料存進db supcom
        public static void InsertSupplierAndComponent(supplierAll.supComponent p)
        {
            SqlConnection cn = new SqlConnection(Common.DBConnectionString);
            SqlCommand cmd = new SqlCommand("InsertSupplierAndComponent", cn);
            cmd.CommandType = CommandType.StoredProcedure;

            cmd.Parameters.AddWithValue("@supplierID", p.supplierID);
            cmd.Parameters.AddWithValue("@Component", p.Component);

            cn.Open();
            cmd.ExecuteNonQuery();
            cn.Close();

        }
        //拿資料supplier BY ID
        public static supplierAll.supplier GetSupplierByID(int supplierID)
        {
            SqlDataAdapter da = new SqlDataAdapter("SELECT * FROM supplier WHERE supplierID=@supplierID", Common.DBConnectionString);
            da.SelectCommand.Parameters.AddWithValue("@supplierID", supplierID);
            DataTable dt = new DataTable();
            da.Fill(dt);
            DataRow row = dt.Rows[0];
            supplierAll.supplier sup = new supplierAll.supplier()
            {
                supplierID = (int)row["supplierID"],
                CompanyName = row["CompanyName"].ToString(),
                Address = row["Address"].ToString(),
                Contact = row["Contact"].ToString(),
                DirectTelephone = row["DirectTelephone"].ToString(),
                Email = row["Email"].ToString(),
                ThisDay = (DateTime)row["ThisDay"],
                strSupcom = ProjectADO.GetsupComponentByID(supplierID)
            };
            return sup;
        }
        //拿資料supComponent BY ID
        public static string GetsupComponentByID(int supplierID)
        {
            SqlDataAdapter da = new SqlDataAdapter("SELECT * FROM supComponent WHERE supplierID=@supplierID", Common.DBConnectionString);
            da.SelectCommand.Parameters.AddWithValue("@supplierID", supplierID);
            DataTable dt = new DataTable();
            da.Fill(dt);
            var query = from row in dt.AsEnumerable()
                        select new supplierAll.supComponent()
                        {
                            Component = row["Component"].ToString(),
                        };
            List<supplierAll.supComponent> supcom = query.ToList();
            var strSupcom = "";
            foreach (var item in supcom)
            {
                strSupcom += item.Component.ToString() + ',';
            }
            var strcom = strSupcom.Substring(0, strSupcom.Length - 1);
            return strcom;
        }


        //DELETE supplier BY supplierID
        public static void Deletesupplier(int supplierID)
        {
            SqlConnection cn = new SqlConnection(Common.DBConnectionString);
            SqlCommand cmd = new SqlCommand("DELETE FROM supplier WHERE supplierID=@supplierID", cn);
            cmd.Parameters.AddWithValue("@supplierID", supplierID);
            cn.Open();
            cmd.ExecuteNonQuery();
            cn.Close();
        }
        //DELETE supComponent BY supplierID
        public static void DeletesupComponent(int supplierID)
        {
            SqlConnection cn = new SqlConnection(Common.DBConnectionString);
            SqlCommand cmd = new SqlCommand("DELETE FROM supComponent WHERE supplierID=@supplierID", cn);
            cmd.Parameters.AddWithValue("@supplierID", supplierID);
            cn.Open();
            cmd.ExecuteNonQuery();
            cn.Close();
        }
        //UPDATE ALL by ID 
        //table1 update table2 delete+insert(foreach)
        public static void UpdateSupplierComp(supplierAll.supplier p)
        {
            SqlConnection cn = new SqlConnection(Common.DBConnectionString);
            SqlCommand cmd = new SqlCommand("UPDATE supplier SET " +
                "CompanyName=@CompanyName,Address=@Address,Contact=@Contact," +
                "DirectTelephone=@DirectTelephone,Email=@Email,ThisDay=@ThisDay WHERE supplierID=@supplierID", cn);

            cmd.Parameters.AddWithValue("@supplierID", p.supplierID);
            cmd.Parameters.AddWithValue("@CompanyName", p.CompanyName);
            cmd.Parameters.AddWithValue("@Address", p.Address);
            cmd.Parameters.AddWithValue("@Contact", p.Contact);
            cmd.Parameters.AddWithValue("@DirectTelephone", p.DirectTelephone);
            cmd.Parameters.AddWithValue("@Email", p.Email);
            cmd.Parameters.AddWithValue("@ThisDay", p.ThisDay);

            cn.Open();
            cmd.ExecuteNonQuery();
            cn.Close();
        }
        //select採購單全部資料 vendor+totalprice+checkday+checkstatus="已通過"
        public static List<supplierAll.supplier> SelectSupplierColumn()
        {
            SqlDataAdapter da = new SqlDataAdapter("SELECT vendor,totalprice,checkstatus,checkday FROM PurchMain1", Common.DBConnectionString);
            DataTable dt = new DataTable();
            da.Fill(dt);
            var query = from row in dt.AsEnumerable()
                        select new supplierAll.supplier()
                        {
                            vendor = row["vendor"].ToString(),
                            totalprice = (int)row["totalprice"],
                            checkstatus = row["checkstatus"] is DBNull ? "尚未審核" : row["checkstatus"].ToString(),
                            checkday = (row["checkday"] == DBNull.Value) ? (DateTime?)null : (DateTime)row["checkday"],
                        };
            List<supplierAll.supplier> supplierColumnList = query.ToList();
            return supplierColumnList;
        }

    }
}