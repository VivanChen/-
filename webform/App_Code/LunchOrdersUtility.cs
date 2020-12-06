using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for LunchOrdersUtility
/// </summary>
public class LunchOrdersUtility
{
    public static void InsertLunchOrder(LunchOrders lunchorder)
    {
        string cnStr = ConfigurationManager.ConnectionStrings["WebsiteConnectionString1"].ConnectionString;
        SqlConnection cn = new SqlConnection(cnStr);
        SqlCommand cmd = new SqlCommand(
            "insert into LunchOrders ( EmployeeID, OrderDate, OrderName, OrderInfo, OrderCount, OrderPrice) values ( @EmployeeID, @OrderDate, @OrderName, @OrderInfo, @OrderCount, @OrderPrice )", cn);

        cmd.Parameters.AddWithValue("@EmployeeID", lunchorder.EmployeeID);
        cmd.Parameters.AddWithValue("@OrderDate", lunchorder.OrderDate);
        cmd.Parameters.AddWithValue("@OrderName", lunchorder.OrderName);
        cmd.Parameters.AddWithValue("@OrderInfo", lunchorder.OrderInfo);
        cmd.Parameters.AddWithValue("@OrderCount", lunchorder.OrderCount);
        cmd.Parameters.AddWithValue("@OrderPrice", lunchorder.OrderPrice);


        cn.Open();
        cmd.ExecuteNonQuery();
        cn.Close();
    }
    public static List<LunchOrders> FindLunchOrderById(int id)
    {
        string cnStr = ConfigurationManager.ConnectionStrings["WebsiteConnectionString1"].ConnectionString;
        SqlDataAdapter da = new SqlDataAdapter("Select * From LunchOrders where EmployeeID=@EmployeeID And OrderDate=@OrderDate", cnStr);
        string TodayLunchOrder = DateTime.Now.ToShortDateString(); //判斷抓到的Id欄位 的 Pun欄位日期時間是不是今天的，有的話就會抓到資料
        da.SelectCommand.Parameters.AddWithValue("@EmployeeID", id);
        da.SelectCommand.Parameters.AddWithValue("@OrderDate", TodayLunchOrder);


        DataTable dt = new DataTable();
        da.Fill(dt);
        if (dt.Rows.Count == 0)
        {
            return null;
        }

        var query = from row in dt.AsEnumerable()
                    select new LunchOrders()
                    {
                        LunchOrderID = Convert.ToInt32(row["LunchOrderID"]),
                        EmployeeID = Convert.ToInt32(row["EmployeeID"]),
                        OrderDate = row["OrderDate"].ToString(),
                        OrderName = row["OrderName"].ToString(),
                        OrderInfo = row["OrderInfo"].ToString(),
                        OrderCount = Convert.ToInt32(row["OrderCount"]),
                        OrderPrice = Convert.ToInt32(row["OrderPrice"])
                    };



        return query.ToList();
    }
    //public static void UpdatePunchcard(Punchcard pcard)
    //{
    //    string cnStr = ConfigurationManager.ConnectionStrings["WebsiteConnectionString1"].ConnectionString;
    //    SqlConnection cn = new SqlConnection(cnStr);
    //    SqlCommand cmd = new SqlCommand(
    //        "Update Punchcards  set Name=@Name , DepartmentID=@DepartmentID, Punchin=@Punchin, Punchout=@Punchout, Hours=@Hours where Id=@Id AND Date=@Date", cn);

    //    cmd.Parameters.AddWithValue("@Id", pcard.Id);
    //    cmd.Parameters.AddWithValue("@Name", pcard.Name);
    //    cmd.Parameters.AddWithValue("@DepartmentID", pcard.DepartmentID);
    //    cmd.Parameters.AddWithValue("@Date", pcard.Date);
    //    cmd.Parameters.AddWithValue("@Punchin", pcard.Punchin);
    //    cmd.Parameters.AddWithValue("@Punchout", pcard.Punchout);
    //    cmd.Parameters.AddWithValue("@Hours", pcard.Hours);

    //    cn.Open();
    //    cmd.ExecuteNonQuery();
    //    cn.Close();
    //}
    public static List<LunchOrders> FindAllLunchOrders()
    {
        string cnStr = ConfigurationManager.ConnectionStrings["WebsiteConnectionString1"].ConnectionString;
        SqlDataAdapter da = new SqlDataAdapter("Select * From LunchOrders", cnStr);

        DataTable dt = new DataTable();
        da.Fill(dt);
        if (dt.Rows.Count == 0)
        {
            return null;
        }
        var query = from row in dt.AsEnumerable()
                    select new LunchOrders()
                    {
                        LunchOrderID = Convert.ToInt32(row["LunchOrderID"]),
                        EmployeeID = Convert.ToInt32(row["EmployeeID"]),
                        OrderDate = row["OrderDate"].ToString(),
                        OrderName = row["OrderName"].ToString(),
                        OrderInfo = row["OrderInfo"].ToString(),
                        OrderCount = Convert.ToInt32(row["OrderCount"]),
                        OrderPrice = Convert.ToInt32(row["OrderPrice"])
                    };

        return query.ToList();
    }
    //public static void DeleteLunchMenusById(int id)
    //{
    //    string cnStr = ConfigurationManager.ConnectionStrings["WebsiteConnectionString1"].ConnectionString;
    //    SqlConnection cn = new SqlConnection(cnStr);
    //    SqlCommand cmd = new SqlCommand("Delete From Menus where LunchCompanyID = @LunchCompanyID", cn);

    //    cmd.Parameters.AddWithValue("@LunchCompanyID", id);

    //    cn.Open();
    //    cmd.ExecuteNonQuery();
    //    cn.Close();
    //}
    public static void DeleteLunchOrderByOrderId(int orderid)
    {
        string cnStr = ConfigurationManager.ConnectionStrings["WebsiteConnectionString1"].ConnectionString;
        SqlConnection cn = new SqlConnection(cnStr);
        SqlCommand cmd = new SqlCommand("Delete From LunchOrders where LunchOrderID = @LunchOrderID ", cn);

        cmd.Parameters.AddWithValue("@LunchOrderID", orderid);

        cn.Open();
        cmd.ExecuteNonQuery();
        cn.Close();
    }
    public static List<LunchTotalOrders> FindAllLunchOrdersFinal()
    {
        string cnStr = ConfigurationManager.ConnectionStrings["WebsiteConnectionString1"].ConnectionString;
        SqlDataAdapter da = new SqlDataAdapter("SELECT OrderInfo, SUM(OrderCount)as OrderCount, SUM(OrderPrice)as OrderPrice FROM LunchOrders Group by OrderInfo", cnStr);

        DataTable dt = new DataTable();
        da.Fill(dt);
        if (dt.Rows.Count == 0)
        {
            return null;
        }
        var query = from row in dt.AsEnumerable()
                    select new LunchTotalOrders()
                    {
                        OrderInfo = row["OrderInfo"].ToString(),
                        OrderCount = Convert.ToInt32(row["OrderCount"]),
                        OrderPrice = Convert.ToInt32(row["OrderPrice"])
                    };

        return query.ToList();
    }
    public static List<LunchTotalOrders> FindAllLunchOrdersFinalByDate(string date)
    {
        string cnStr = ConfigurationManager.ConnectionStrings["WebsiteConnectionString1"].ConnectionString;
        SqlDataAdapter da = new SqlDataAdapter("SELECT OrderInfo, SUM(OrderCount)as OrderCount, SUM(OrderPrice)as OrderPrice FROM LunchOrders Where OrderDate=@OrderDate Group by OrderInfo", cnStr);

        da.SelectCommand.Parameters.AddWithValue("OrderDate",date);

        DataTable dt = new DataTable();
        da.Fill(dt);
        if (dt.Rows.Count == 0)
        {
            return null;
        }
        var query = from row in dt.AsEnumerable()
                    select new LunchTotalOrders()
                    {
                        OrderInfo = row["OrderInfo"].ToString(),
                        OrderCount = Convert.ToInt32(row["OrderCount"]),
                        OrderPrice = Convert.ToInt32(row["OrderPrice"])
                    };

        return query.ToList();
    }
    //}
    public static List<LunchOrders> FindAllLunchOrdersByDate(string date)
    {
        string cnStr = ConfigurationManager.ConnectionStrings["WebsiteConnectionString1"].ConnectionString;
        SqlDataAdapter da = new SqlDataAdapter("Select * From LunchOrders where OrderDate=@OrderDate", cnStr);

        da.SelectCommand.Parameters.AddWithValue("@OrderDate", date);
        DataTable dt = new DataTable();
        da.Fill(dt);
        if (dt.Rows.Count == 0)
        {
            return null;
        }
        var query = from row in dt.AsEnumerable()
                    select new LunchOrders()
                    {
                        LunchOrderID = Convert.ToInt32(row["LunchOrderID"]),
                        EmployeeID = Convert.ToInt32(row["EmployeeID"]),
                        OrderDate = row["OrderDate"].ToString(),
                        OrderName = row["OrderName"].ToString(),
                        OrderInfo = row["OrderInfo"].ToString(),
                        OrderCount = Convert.ToInt32(row["OrderCount"]),
                        OrderPrice = Convert.ToInt32(row["OrderPrice"])
                    };

        return query.ToList();
    }
}