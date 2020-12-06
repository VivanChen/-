using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for PunchcardUtility
/// </summary>
public class PunchcardsUtility
{
    public static void InsertPunchcard(Punchcard pcard)
    {
        string cnStr = ConfigurationManager.ConnectionStrings["WebsiteConnectionString1"].ConnectionString;
        SqlConnection cn = new SqlConnection(cnStr);
        SqlCommand cmd = new SqlCommand(
            "insert into Punchcards (Id, Name, DepartmentID, Date, Punchin, Punchout, hours ) values (@Id, @Name, @DepartmentID, @Date, @Punchin, @Punchout, @hours)",
            cn);

        cmd.Parameters.AddWithValue("@Id", pcard.Id);
        cmd.Parameters.AddWithValue("@Name", pcard.Name);
        cmd.Parameters.AddWithValue("@DepartmentID", pcard.DepartmentID);
        cmd.Parameters.AddWithValue("@Date", pcard.Date);
        cmd.Parameters.AddWithValue("@Punchin", pcard.Punchin);
        cmd.Parameters.AddWithValue("@Punchout", pcard.Punchout);
        cmd.Parameters.AddWithValue("@hours", pcard.Hours);

        cn.Open();
        cmd.ExecuteNonQuery();
        cn.Close();
    }
    public static Punchcard FindPunchcardById(int id)
    {
        string cnStr = ConfigurationManager.ConnectionStrings["WebsiteConnectionString1"].ConnectionString;
        SqlDataAdapter da = new SqlDataAdapter("Select * From Punchcards where Id=@Id And Date=@Date", cnStr);
        string TodayPunchcard = DateTime.Now.Date.ToShortDateString().ToString(); //判斷抓到的Id欄位 的 PunchIn欄位日期時間是不是今天的，有的話就會抓到資料
        da.SelectCommand.Parameters.AddWithValue("@Id", id);
        da.SelectCommand.Parameters.AddWithValue("@Date", TodayPunchcard);


        DataTable dt = new DataTable();
        da.Fill(dt);
        if (dt.Rows.Count == 0)
        {
            return null;
        }

        DataRow row = dt.Rows[0];
        Punchcard pp = new Punchcard()
        {
            PunchcardID=Convert.ToInt32(row["PunchcardID"]),
            Id = Convert.ToInt32(row["Id"]),
            Name = row["Name"].ToString(),
            DepartmentID = row["DepartmentID"].ToString(),
            Date = row["Date"].ToString(),
            Punchin = row["Punchin"].ToString(),
            Punchout = row["Punchout"].ToString(),
            Hours = row["Hours"].ToString(),
            //ImageFileName = row["ImageFileName"] is DBNull ? "" : row["ImageFileName"].ToString()
            //FirstDate = row["FirstDate"] is DBNull ? "" : Convert.ToDateTime(row["FirstDate"]),
            //LastDate = Convert.ToDateTime(row["LastDate"]),
        };


        return pp;
    }
    public static void UpdatePunchcard(Punchcard pcard)
    {
        string cnStr = ConfigurationManager.ConnectionStrings["WebsiteConnectionString1"].ConnectionString;
        SqlConnection cn = new SqlConnection(cnStr);
        SqlCommand cmd = new SqlCommand(
            "Update Punchcards  set Name=@Name , DepartmentID=@DepartmentID, Punchin=@Punchin, Punchout=@Punchout, Hours=@Hours where Id=@Id AND Date=@Date", cn);

        cmd.Parameters.AddWithValue("@Id", pcard.Id);
        cmd.Parameters.AddWithValue("@Name", pcard.Name);
        cmd.Parameters.AddWithValue("@DepartmentID", pcard.DepartmentID);
        cmd.Parameters.AddWithValue("@Date", pcard.Date);
        cmd.Parameters.AddWithValue("@Punchin", pcard.Punchin);
        cmd.Parameters.AddWithValue("@Punchout", pcard.Punchout);
        cmd.Parameters.AddWithValue("@Hours", pcard.Hours);

        cn.Open();
        cmd.ExecuteNonQuery();
        cn.Close();
    }
    public static List<Punchcard> FindAllPunchcardsById(int id)
    {
        string cnStr = ConfigurationManager.ConnectionStrings["WebsiteConnectionString1"].ConnectionString;
        SqlDataAdapter da = new SqlDataAdapter("Select * From Punchcards where Id=@Id", cnStr);
        da.SelectCommand.Parameters.AddWithValue("@Id", id);

        DataTable dt = new DataTable();
        da.Fill(dt);
        var query = from row in dt.AsEnumerable()
                    select new Punchcard()
                    {
                         PunchcardID=Convert.ToInt32(row["PunchcardID"]),
                        Id = Convert.ToInt32(row["id"]),
                        Name = row["Name"].ToString(),
                        DepartmentID = row["DepartmentID"].ToString(),
                        Date = row["Date"].ToString(),
                        Punchin = row["Punchin"].ToString(),
                        Punchout = row["Punchout"].ToString(),
                        Hours = row["Hours"].ToString()
                    };

        return query.ToList();
    }
    public static void DeletePunchcardById(int punchcardid)
    {
        string cnStr = ConfigurationManager.ConnectionStrings["WebsiteConnectionString1"].ConnectionString;
        SqlConnection cn = new SqlConnection(cnStr);
        SqlCommand cmd = new SqlCommand("Delete From Punchcards where PunchcardID = @PunchcardID ", cn);

        cmd.Parameters.AddWithValue("@PunchcardID", punchcardid);

        cn.Open();
        cmd.ExecuteNonQuery();
        cn.Close();
    }
    public static Punchcard FindAllPunchcardsByPunchcardID(int punchcardid)
    {
        string cnStr = ConfigurationManager.ConnectionStrings["WebsiteConnectionString1"].ConnectionString;
        SqlDataAdapter da = new SqlDataAdapter("Select * From Punchcards where PunchcardID=@PunchcardID", cnStr);
        da.SelectCommand.Parameters.AddWithValue("@PunchcardID", punchcardid);

        DataTable dt = new DataTable();
        da.Fill(dt);
        var query = from row in dt.AsEnumerable()
                    select new Punchcard()
                    {
                        PunchcardID = Convert.ToInt32(row["PunchcardID"]),
                        Id = Convert.ToInt32(row["id"]),
                        Name = row["Name"].ToString(),
                        DepartmentID = row["DepartmentID"].ToString(),
                        Date = row["Date"].ToString(),
                        Punchin = row["Punchin"].ToString(),
                        Punchout = row["Punchout"].ToString(),
                        Hours = row["Hours"].ToString()
                    };

        return query.SingleOrDefault();
    }
}