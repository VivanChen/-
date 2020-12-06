using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for CheckPunchcardsUtility
/// </summary>
public class CheckPunchcardsUtility
{
    public static void InsertCheckPunchcard(CheckPunchcards cpcard)
    {
        string cnStr = ConfigurationManager.ConnectionStrings["WebsiteConnectionString1"].ConnectionString;
        SqlConnection cn = new SqlConnection(cnStr);
        SqlCommand cmd = new SqlCommand(
            "insert into CheckPunchcards (EmployeeID, Name, DepartmentID, Date, Punchin, Punchout, Hours, Reason, CheckPunchcard ) values (@EmployeeID, @Name, @DepartmentID, @Date, @Punchin, @Punchout, @Hours, @Reason, @CheckPunchcard)",
            cn);

        cmd.Parameters.AddWithValue("@EmployeeID", cpcard.EmployeeID);
        cmd.Parameters.AddWithValue("@Name", cpcard.Name);
        cmd.Parameters.AddWithValue("@DepartmentID", cpcard.DepartmentID);
        cmd.Parameters.AddWithValue("@Date", cpcard.Date);
        cmd.Parameters.AddWithValue("@Punchin", cpcard.Punchin);
        cmd.Parameters.AddWithValue("@Punchout", cpcard.Punchout);
        cmd.Parameters.AddWithValue("@Hours", cpcard.Hours);
        cmd.Parameters.AddWithValue("@Reason", cpcard.Reason);
        cmd.Parameters.AddWithValue("@CheckPunchcard", cpcard.CheckPunchcard);

        cn.Open();
        cmd.ExecuteNonQuery();
        cn.Close();
    }
    public static List<CheckPunchcards> FindCheckPunchcardById(int empid)
    {
        string cnStr = ConfigurationManager.ConnectionStrings["WebsiteConnectionString1"].ConnectionString;
        SqlDataAdapter da = new SqlDataAdapter("Select * From CheckPunchcards where EmployeeID=@EmployeeID ", cnStr);
        da.SelectCommand.Parameters.AddWithValue("@EmployeeID", empid);



        DataTable dt = new DataTable();
        da.Fill(dt);

        var query = from row in dt.AsEnumerable()
                    select new CheckPunchcards()
                    {
                        CheckPunchcardID = Convert.ToInt32(row["CheckPunchcardID"]),
                        EmployeeID = Convert.ToInt32(row["EmployeeID"]),
                        Name = row["Name"].ToString(),
                        DepartmentID = row["DepartmentID"].ToString(),
                        Date = row["Date"].ToString(),
                        Punchin = row["Punchin"].ToString(),
                        Punchout = row["Punchout"].ToString(),
                        Hours = row["Hours"].ToString(),
                        Reason=row["Reason"].ToString(),
                        CheckPunchcard=row["CheckPunchcard"].ToString()

                    };




        return query.ToList();
    }
    public static List<CheckPunchcards> FindAllCheckPunchcards()
    {
        string cnStr = ConfigurationManager.ConnectionStrings["WebsiteConnectionString1"].ConnectionString;
        SqlDataAdapter da = new SqlDataAdapter("Select * From CheckPunchcards", cnStr);



        DataTable dt = new DataTable();
        da.Fill(dt);

        var query = from row in dt.AsEnumerable()
                    select new CheckPunchcards()
                    {
                        CheckPunchcardID = Convert.ToInt32(row["CheckPunchcardID"]),
                        EmployeeID = Convert.ToInt32(row["EmployeeID"]),
                        Name = row["Name"].ToString(),
                        DepartmentID = row["DepartmentID"].ToString(),
                        Date = row["Date"].ToString(),
                        Punchin = row["Punchin"].ToString(),
                        Punchout = row["Punchout"].ToString(),
                        Hours = row["Hours"].ToString(),
                        Reason = row["Reason"].ToString(),
                        CheckPunchcard = row["CheckPunchcard"].ToString()

                    };




        return query.ToList();
    }
    public static void UpdateCheckPunchcard(CheckPunchcards cpcard)
    {
        string cnStr = ConfigurationManager.ConnectionStrings["WebsiteConnectionString1"].ConnectionString;
        SqlConnection cn = new SqlConnection(cnStr);
        SqlCommand cmd = new SqlCommand(
            "Update CheckPunchcards  set Name=@Name , DepartmentID=@DepartmentID, Punchin=@Punchin, Punchout=@Punchout, Hours=@Hours, Reason=@Reason, CheckPunchcard=@CheckPunchcard where EmployeeID=@EmployeeID AND Date=@Date", cn);

        cmd.Parameters.AddWithValue("@EmployeeID", cpcard.EmployeeID);
        cmd.Parameters.AddWithValue("@Name", cpcard.Name);
        cmd.Parameters.AddWithValue("@DepartmentID", cpcard.DepartmentID);
        cmd.Parameters.AddWithValue("@Date", cpcard.Date);
        cmd.Parameters.AddWithValue("@Punchin", cpcard.Punchin);
        cmd.Parameters.AddWithValue("@Punchout", cpcard.Punchout);
        cmd.Parameters.AddWithValue("@Hours", cpcard.Hours);
        cmd.Parameters.AddWithValue("@Reason", cpcard.Reason);
        cmd.Parameters.AddWithValue("@CheckPunchcard", cpcard.CheckPunchcard);

        cn.Open();
        cmd.ExecuteNonQuery();
        cn.Close();
    }
    //public static List<Punchcard> FindAllPunchcardsById(int id)
    //{
    //    string cnStr = ConfigurationManager.ConnectionStrings["WebsiteConnectionString1"].ConnectionString;
    //    SqlDataAdapter da = new SqlDataAdapter("Select * From Punchcards where Id=@Id", cnStr);
    //    da.SelectCommand.Parameters.AddWithValue("@Id", id);

    //    DataTable dt = new DataTable();
    //    da.Fill(dt);
    //    var query = from row in dt.AsEnumerable()
    //                select new Punchcard()
    //                {
    //                     PunchcardID=Convert.ToInt32(row["PunchcardID"]),
    //                    Id = Convert.ToInt32(row["id"]),
    //                    Name = row["Name"].ToString(),
    //                    DepartmentID = row["DepartmentID"].ToString(),
    //                    Date = row["Date"].ToString(),
    //                    Punchin = row["Punchin"].ToString(),
    //                    Punchout = row["Punchout"].ToString(),
    //                    Hours = row["Hours"].ToString()
    //                };

    //    return query.ToList();
    //}
    public static void DeleteCheckPunchcardBycpId(int cpid)
    {
        string cnStr = ConfigurationManager.ConnectionStrings["WebsiteConnectionString1"].ConnectionString;
        SqlConnection cn = new SqlConnection(cnStr);
        SqlCommand cmd = new SqlCommand("Delete From CheckPunchcards where CheckPunchcardID = @CheckPunchcardID ", cn);

        cmd.Parameters.AddWithValue("@CheckPunchcardID", cpid);

        cn.Open();
        cmd.ExecuteNonQuery();
        cn.Close();
    }
    //public static Punchcard FindAllPunchcardsByPunchcardID(int punchcardid)
    //{
    //    string cnStr = ConfigurationManager.ConnectionStrings["WebsiteConnectionString1"].ConnectionString;
    //    SqlDataAdapter da = new SqlDataAdapter("Select * From Punchcards where PunchcardID=@PunchcardID", cnStr);
    //    da.SelectCommand.Parameters.AddWithValue("@PunchcardID", punchcardid);

    //    DataTable dt = new DataTable();
    //    da.Fill(dt);
    //    var query = from row in dt.AsEnumerable()
    //                select new Punchcard()
    //                {
    //                    PunchcardID = Convert.ToInt32(row["PunchcardID"]),
    //                    Id = Convert.ToInt32(row["id"]),
    //                    Name = row["Name"].ToString(),
    //                    DepartmentID = row["DepartmentID"].ToString(),
    //                    Date = row["Date"].ToString(),
    //                    Punchin = row["Punchin"].ToString(),
    //                    Punchout = row["Punchout"].ToString(),
    //                    Hours = row["Hours"].ToString()
    //                };

    //    return query.SingleOrDefault();
    //}
}