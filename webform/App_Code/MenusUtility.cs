using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for MenusUtility
/// </summary>
public class MenusUtility
{
    public static void InsertMenu(Menus lunchMenu)
    {
        string cnStr = ConfigurationManager.ConnectionStrings["WebsiteConnectionString1"].ConnectionString;
        SqlConnection cn = new SqlConnection(cnStr);
        SqlCommand cmd = new SqlCommand(
            "insert into Menus (LunchCompanyID, LunchName, LunchType, Price) values (@LunchCompanyID, @LunchName, @LunchType, @Price)", cn);

        cmd.Parameters.AddWithValue("@LunchCompanyID", lunchMenu.LunchCompanyID);
        cmd.Parameters.AddWithValue("@LunchName", lunchMenu.LunchName);
        cmd.Parameters.AddWithValue("@LunchType", lunchMenu.LunchType);
        cmd.Parameters.AddWithValue("@Price", lunchMenu.Price);


        cn.Open();
        cmd.ExecuteNonQuery();
        cn.Close();
    }
    public static List<Menus> FindAllMenusById(int id)
    {
        string cnStr = ConfigurationManager.ConnectionStrings["WebsiteConnectionString1"].ConnectionString;
        SqlDataAdapter da = new SqlDataAdapter("Select * From Menus where LunchCompanyID=@Id", cnStr);
        da.SelectCommand.Parameters.AddWithValue("@Id", id);


        DataTable dt = new DataTable();
        da.Fill(dt);
        if (dt.Rows.Count == 0)
        {
            return null;
        }
        var query = from row in dt.AsEnumerable()
                    select new Menus()
                    {
                        LunchCompanyID = Convert.ToInt32(row["LunchCompanyID"]),
                        LunchName = row["LunchName"].ToString(),
                        LunchType = row["LunchType"].ToString(),
                        Price = row["Price"].ToString()
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
    public static List<Menus> FindAllMenus()
    {
        string cnStr = ConfigurationManager.ConnectionStrings["WebsiteConnectionString1"].ConnectionString;
        SqlDataAdapter da = new SqlDataAdapter("Select * From Menus", cnStr);

        DataTable dt = new DataTable();
        da.Fill(dt);
        if (dt.Rows.Count == 0)
        {
            return null;
        }
        var query = from row in dt.AsEnumerable()
                    select new Menus()
                    {
                        LunchCompanyID = Convert.ToInt32(row["LunchCompanyID"]),
                         LunchName =row["LunchName"].ToString(),
                          LunchType=row["LunchType"].ToString(),
                           Price=row["Price"].ToString()
                    };

        return query.ToList();
    }
    public static void DeleteLunchMenusById(int id)
    {
        string cnStr = ConfigurationManager.ConnectionStrings["WebsiteConnectionString1"].ConnectionString;
        SqlConnection cn = new SqlConnection(cnStr);
        SqlCommand cmd = new SqlCommand("Delete From Menus where LunchCompanyID = @LunchCompanyID", cn);

        cmd.Parameters.AddWithValue("@LunchCompanyID", id);

        cn.Open();
        cmd.ExecuteNonQuery();
        cn.Close();
    }
    public static void DeleteLunchMenuByName(int id, string name)
    {
        string cnStr = ConfigurationManager.ConnectionStrings["WebsiteConnectionString1"].ConnectionString;
        SqlConnection cn = new SqlConnection(cnStr);
        SqlCommand cmd = new SqlCommand("Delete From Menus where LunchCompanyID = @LunchCompanyID AND LunchName=@LunchName", cn);

        cmd.Parameters.AddWithValue("@LunchCompanyID", id);
        cmd.Parameters.AddWithValue("@LunchName", name);

        cn.Open();
        cmd.ExecuteNonQuery();
        cn.Close();
    }

}