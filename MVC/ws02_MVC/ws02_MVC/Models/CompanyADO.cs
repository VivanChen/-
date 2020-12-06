using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

namespace ws02_MVC.Models
{
    public class CompanyADO
    {
        //public static List<Announcement> GetAccountbyidandpassword()
        //{
        //    SqlDataAdapter da = new SqlDataAdapter("SELECT * FROM Accounts", Common.DBConnectionString);
        //    DataTable dt = new DataTable();
        //    da.Fill(dt);
        //    var query = from row in dt.AsEnumerable()
        //                select new Announcement()
        //                {
        //                     AnnouncementID=Convert.ToInt32(row["AnnouncementID"]),
        //                      AnntTitle=row["AnntTitle"].ToString(),
        //                        AnntName=row["AnntName"].ToString(),
        //                         AnntContent=row["AnntContent"].ToString(),
        //                          AnntDay=row["AnntDay"].ToString()
        //                };
        //    List<Announcement> AnnouncementList = query.ToList();
        //    return AnnouncementList;

        //}

        //internal static void FindAccount(Account act)
        //{
        //    throw new NotImplementedException();
        //}

        //public static void InsertAnnouncement(Announcement annt)
        //{
        //    string cnStr = ConfigurationManager.ConnectionStrings["WebsiteConnectionString1"].ConnectionString;
        //    SqlConnection cn = new SqlConnection(cnStr);
        //    SqlCommand cmd = new SqlCommand(
        //        "insert into Announcements ( AnntTitle, AnntContent, AnntName, AnntDay) values ( @AnntTitle, @AnntContent, @AnntName, @AnntDay )", cn);


        //    cmd.Parameters.AddWithValue("@AnntTitle", annt.AnntTitle);
        //    cmd.Parameters.AddWithValue("@AnntContent", annt.AnntContent);
        //    cmd.Parameters.AddWithValue("@AnntName", annt.AnntName);
        //    cmd.Parameters.AddWithValue("@AnntDay", annt.AnntDay);



        //    cn.Open();
        //    cmd.ExecuteNonQuery();
        //    cn.Close();
        //}
        //public static void UpdateAnnouncement(int id, Announcement annt)
        //{
        //    string cnStr = ConfigurationManager.ConnectionStrings["WebsiteConnectionString1"].ConnectionString;
        //    SqlConnection cn = new SqlConnection(cnStr);
        //    SqlCommand cmd = new SqlCommand(
        //        "Update Announcements  set AnntTitle=@AnntTitle , AnntContent=@AnntContent, AnntName=@AnntName, AnntDay=@AnntDay where AnnouncementID=@AnnouncementID", cn);

        //    cmd.Parameters.AddWithValue("@AnnouncementID", id);
        //    cmd.Parameters.AddWithValue("@AnntTitle", annt.AnntTitle);
        //    cmd.Parameters.AddWithValue("@AnntContent", annt.AnntContent);
        //    cmd.Parameters.AddWithValue("@AnntName", annt.AnntName);
        //    cmd.Parameters.AddWithValue("@AnntDay", annt.AnntDay);


        //    cn.Open();
        //    cmd.ExecuteNonQuery();
        //    cn.Close();
        //}
        //public static Announcement GetAnnouncementById(int? id)
        //{
        //    SqlDataAdapter da = new SqlDataAdapter("SELECT * FROM Announcements where AnnouncementID=@AnnouncementID", Common.DBConnectionString);
        //    da.SelectCommand.Parameters.AddWithValue("@AnnouncementID", id);
        //    DataTable dt = new DataTable();
        //    da.Fill(dt);
        //    if (dt.Rows.Count == 0)
        //    {
        //        return null;
        //    }
        //    var query = from row in dt.AsEnumerable()
        //                    select new Announcement()
        //                    {
        //                        AnnouncementID = Convert.ToInt32(row["AnnouncementID"]),
        //                        AnntTitle = row["AnntTitle"].ToString(),
        //                        AnntName = row["AnntName"].ToString(),
        //                        AnntContent = row["AnntContent"].ToString(),
        //                        AnntDay = row["AnntDay"].ToString()
        //                    };
        //    //List<Announcement> AnnouncementList = query.ToList();
        //    return query.SingleOrDefault();

        //}
        //public static void DeleteAnnouncementByAnnouncementId(int annt)
        //{
        //    string cnStr = ConfigurationManager.ConnectionStrings["WebsiteConnectionString1"].ConnectionString;
        //    SqlConnection cn = new SqlConnection(cnStr);
        //    SqlCommand cmd = new SqlCommand("Delete From Announcements where AnnouncementID = @AnnouncementID ", cn);

        //    cmd.Parameters.AddWithValue("@AnnouncementID", annt);

        //    cn.Open();
        //    cmd.ExecuteNonQuery();
        //    cn.Close();
        //}
        public static Account FindAccount(string id, string password)
        {
            string cnStr = ConfigurationManager.ConnectionStrings["WebsiteConnectionString1"].ConnectionString;
            SqlDataAdapter da = new SqlDataAdapter("Select * From Accounts where id=@id And Password=@Password", cnStr);
            da.SelectCommand.Parameters.AddWithValue("@id", id);
            da.SelectCommand.Parameters.AddWithValue("@Password", password);

            DataTable dt = new DataTable();
            da.Fill(dt);
            if (dt.Rows.Count == 0)
            {
                return null;
            }
            DataRow row = dt.Rows[0];
            Account m = new Account()
            {
                Id = Convert.ToInt32(row["Id"]),
                //UserName = row["UserName"].ToString(),
                Password = row["Password"].ToString(),
                Roles = row["Roles"].ToString(),
                DepartmentID = row["DepartmentID"].ToString(),
                ImageFileName = row["ImageFileName"] is DBNull ? "" : row["ImageFileName"].ToString()
            };


            return m;
        }
        public static Employees GetEmployeesById(int EmployeeID)
        {

            SqlDataAdapter da = new SqlDataAdapter(
                "Select * from Employees Where EmployeeID =@EmployeeID",
                Common.DBConnectionString);

            da.SelectCommand.Parameters.AddWithValue("@EmployeeID", EmployeeID);

            DataTable dt = new DataTable();
            da.Fill(dt);
            DataRow row = dt.Rows[0];

            Employees emp = new Employees()
            {
                EmployeeID = (int)row["EmployeeID"],
                Name = row["Name"].ToString(),
                Gender = row["Gender"].ToString(),
                BirthDate = row["BirthDate"].ToString(),
                DepartmentID = row["DepartmentID"].ToString(),
                DepartmentName = row["DepartmentName"].ToString(),
                StartDate = row["StartDate"].ToString(),
                EndDate = row["EndDate"] is DBNull ? "" : row["EndDate"].ToString(),
                Password = row["Password"].ToString(),
                Phone = row["Phone"].ToString(),
                Address = row["Address"].ToString(),
                Email = row["Email"].ToString(),
                Status = row["Status"].ToString(),
                ImageFileName = row["ImageFileName"] is DBNull ? "" : row["ImageFileName"].ToString(),
                NumberID = row["NumberID"].ToString()

            };
            return emp;

        }
    }
}