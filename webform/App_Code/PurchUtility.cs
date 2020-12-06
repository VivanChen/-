using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlTypes;

/// <summary>
/// Summary description for PurchUtility
/// </summary>
public class PurchUtility
{
    //storedProcedure傳入訂單資料得到ID
    public static int InsertPurchGetID(PurchMain P)
    {
        SqlConnection cn = new SqlConnection(Common.DBConnectionString);
        SqlCommand cmd = new SqlCommand("InserPurchSP2", cn);
        cmd.CommandType = CommandType.StoredProcedure;

        cmd.Parameters.AddWithValue("@buyer", P.buyer);
        cmd.Parameters.AddWithValue("@department", P.department);
        cmd.Parameters.AddWithValue("@ThisDay", P.ThisDay);
        cmd.Parameters.AddWithValue("@vendor", P.vendor);
        cmd.Parameters.AddWithValue("@vendorsales", P.vendorsales);
        cmd.Parameters.AddWithValue("@phone", P.phone);
        cmd.Parameters.AddWithValue("@email", P.email);
        cmd.Parameters.AddWithValue("@tax", P.tax);
        cmd.Parameters.AddWithValue("@taxrate", P.taxrate);
        cmd.Parameters.AddWithValue("@freight", P.freight);
        cmd.Parameters.AddWithValue("@totalprice", P.totalprice);

        //連線
        cn.Open();
        object PurNOObject = cmd.ExecuteScalar();//拿到只能是物件或row
        cn.Close();
        //轉成int
        int PurNO = Convert.ToInt32(PurNOObject);
        return PurNO;
    }
    //得到的purchNO存入table PurchPart
    public static void InsertPurchPartUsePurNO(PurchPartClass PurP)
    {
        SqlConnection cn = new SqlConnection(Common.DBConnectionString);
        SqlCommand cmd = new SqlCommand("InserPurchPartSP1", cn);
        cmd.CommandType = CommandType.StoredProcedure;

        cmd.Parameters.AddWithValue("@purchPart", PurP.purchPart);
        cmd.Parameters.AddWithValue("@config", PurP.config);
        cmd.Parameters.AddWithValue("@count", PurP.count);
        cmd.Parameters.AddWithValue("@price", PurP.price);
        cmd.Parameters.AddWithValue("@partTotal", PurP.partTotal);
        cmd.Parameters.AddWithValue("@purchNO", PurP.purchNO);
        cmd.Parameters.AddWithValue("@remark", PurP.remark);

        cn.Open();
        cmd.ExecuteNonQuery();
        cn.Close();

    }

    ///select detailpurch
    public static PurchMain purchMainById(int purchNO)
    {
        SqlDataAdapter da = new SqlDataAdapter("SELECT * FROM PurchMain1 where purchNO=@purchNO", Common.DBConnectionString);
        da.SelectCommand.Parameters.AddWithValue("@purchNO", purchNO);
        DataTable dt = new DataTable();
        da.Fill(dt);
        DataRow row = dt.Rows[0];
        PurchMain pu = new PurchMain()
        {
            purchNO = (int)row["purchNO"],
            buyer = (int)row["buyer"],
            department = row["department"].ToString(),
            ThisDay = (DateTime)(row["ThisDay"]),
            vendor = row["vendor"].ToString(),
            vendorsales = row["vendorsales"].ToString(),
            phone = row["phone"].ToString(),
            email = row["email"].ToString(),
            tax = row["tax"] is DBNull ? 0 : (int)row["tax"],
            taxrate = row["taxrate"] is DBNull ? 0 : (int)row["taxrate"],
            freight = row["freight"] is DBNull ? 0 : (int)row["freight"],
            totalprice = row["totalprice"] is DBNull ? 0 : (int)row["totalprice"],
            checkstatus = row["checkstatus"] is DBNull ? "尚未審核" : row["checkstatus"].ToString(),
            checkday = (row["checkday"] == DBNull.Value) ? (DateTime?)null : (DateTime)row["checkday"],
            checkreason = row["checkreason"] is DBNull ? "尚未填寫" : row["checkreason"].ToString(),
            Name = PurchUtility.UseEmployeeIDGetName((int)row["buyer"])
        };
        return pu;
    }
    public static List<PurchPartClass> purchPartByPUNO(int purchNO)
    {
        SqlDataAdapter da = new SqlDataAdapter("select * from PurchPart1 where purchNO=@purchNO", Common.DBConnectionString);
        da.SelectCommand.Parameters.AddWithValue("@purchNO", purchNO);
        DataTable dt = new DataTable();
        da.Fill(dt);
        var query = from row in dt.AsEnumerable()
                    select new PurchPartClass()
                    {
                        purchPart = row["purchPart"].ToString(),
                        config = row["config"].ToString(),
                        count = (int)row["count"],
                        price = (int)row["price"],
                        partTotal = (int)row["partTotal"],
                        purchNO = (int)row["purchNO"],
                        remark = row["remark"].ToString()
                    };
        List<PurchPartClass> purchpartlist = query.ToList();
        return purchpartlist;
    }
    //刪除purch by NO
    public static void DeletePurchMainByNO(int purchNO)
    {
        SqlConnection cn = new SqlConnection(Common.DBConnectionString);
        SqlCommand cmd = new SqlCommand("Delete from PurchMain1 where purchNO=@purchNO", cn);
        cmd.Parameters.AddWithValue("@purchNO", purchNO);
        cn.Open();
        cmd.ExecuteNonQuery();
        cn.Close();

    }
    //刪除purchpart by NO
    public static void DeletePurchPartByNO(int purchNO)
    {
        SqlConnection cn = new SqlConnection(Common.DBConnectionString);
        SqlCommand cmd = new SqlCommand("Delete from PurchPart1 where purchNO=@purchNO", cn);
        cmd.Parameters.AddWithValue("@purchNO", purchNO);
        cn.Open();
        cmd.ExecuteNonQuery();
        cn.Close();
    }

    //得到CHECK PURCHMAIN所有檔案
    public static List<PurchMain> GetAllPurchMainCheck()
    {
        SqlDataAdapter da = new SqlDataAdapter("SELECT * FROM PurchMain1", Common.DBConnectionString);
        DataTable dt = new DataTable();
        da.Fill(dt);
        var query = from row in dt.AsEnumerable()
                    select new PurchMain()
                    {

                        //原本上面欄位
                        purchNO = (int)row["purchNO"],
                        buyer = (int)row["buyer"],
                        department = row["department"].ToString(),
                        ThisDay = (DateTime)row["ThisDay"],
                        vendor = row["vendor"].ToString(),
                        vendorsales = row["vendorsales"].ToString(),
                        phone = row["phone"].ToString(),
                        email = row["email"].ToString(),
                        tax = row["tax"] is DBNull ? 0 : (int)row["tax"],
                        taxrate = row["taxrate"] is DBNull ? 0 : (int)row["taxrate"],
                        freight = row["freight"] is DBNull ? 0 : (int)row["freight"],
                        totalprice = row["totalprice"] is DBNull ? 0 : (int)row["totalprice"],
                        //check 欄位
                        checkstatus = row["checkstatus"] is DBNull ? "尚未審核" : row["checkstatus"].ToString(),
                        checkday = (row["checkday"]==DBNull.Value) ? (DateTime?)null : (DateTime)row["checkday"],
                        checkreason = row["checkreason"] is DBNull ? "尚未填寫" : row["checkreason"].ToString(),
                        Name=PurchUtility.UseEmployeeIDGetName((int)row["buyer"])

                    };
        List<PurchMain> purchMainslist = query.ToList();
        return purchMainslist;
    }
    //存入修改審核的檔案
    public static void UpdateCheckStatus(PurchMain p)
    {
        SqlConnection cn = new SqlConnection(Common.DBConnectionString);
        SqlCommand cmd = new SqlCommand("UPDATE PurchMain1 SET checkstatus=@checkstatus,checkday=@checkday,checkreason=@checkreason WHERE purchNO=@purchNO", cn);
        cmd.Parameters.AddWithValue("@purchNO", p.purchNO);
        cmd.Parameters.AddWithValue("@checkstatus", p.checkstatus);
        cmd.Parameters.AddWithValue("@checkday", p.checkday);
        cmd.Parameters.AddWithValue("@checkreason", p.checkreason);

        cn.Open();
        cmd.ExecuteNonQuery();
        cn.Close();
    }
    public static string UseEmployeeIDGetName(int EmployeeID)
    {
        SqlConnection cn = new SqlConnection(Common.DBConnectionString);
        SqlCommand cmd = new SqlCommand("SELECT Name FROM Employees WHERE EmployeeID=@EmployeeID", cn);
        cmd.Parameters.AddWithValue("@EmployeeID", EmployeeID);

        cn.Open();
        string Name = (string)cmd.ExecuteScalar();
        cn.Close();

        return Name;
    }
}