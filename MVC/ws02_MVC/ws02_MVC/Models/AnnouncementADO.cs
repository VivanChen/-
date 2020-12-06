using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

namespace ws02_MVC.Models
{
    public class AnnouncementADO
    {
        public static List<Announcement> GetAllAnnouncement()
        {
            SqlDataAdapter da = new SqlDataAdapter("SELECT * FROM Announcements", Common.DBConnectionString);
            DataTable dt = new DataTable();
            da.Fill(dt);
            var query = from row in dt.AsEnumerable()
                        select new Announcement()
                        {
                             AnnouncementID=Convert.ToInt32(row["AnnouncementID"]),
                              AnntTitle=row["AnntTitle"].ToString(),
                                AnntName=row["AnntName"].ToString(),
                                 AnntContent=row["AnntContent"].ToString(),
                                  AnntDay=row["AnntDay"].ToString()
                        };
            List<Announcement> AnnouncementList = query.ToList();
            return AnnouncementList;

        }

        public static void InsertAnnouncement(Announcement annt)
        {
            string cnStr = ConfigurationManager.ConnectionStrings["WebsiteConnectionString1"].ConnectionString;
            SqlConnection cn = new SqlConnection(cnStr);
            SqlCommand cmd = new SqlCommand(
                "insert into Announcements ( AnntTitle, AnntContent, AnntName, AnntDay) values ( @AnntTitle, @AnntContent, @AnntName, @AnntDay )", cn);


            cmd.Parameters.AddWithValue("@AnntTitle", annt.AnntTitle);
            cmd.Parameters.AddWithValue("@AnntContent", annt.AnntContent);
            cmd.Parameters.AddWithValue("@AnntName", annt.AnntName);
            cmd.Parameters.AddWithValue("@AnntDay", annt.AnntDay);



            cn.Open();
            cmd.ExecuteNonQuery();
            cn.Close();
        }
        public static void UpdateAnnouncement(int id, Announcement annt)
        {
            string cnStr = ConfigurationManager.ConnectionStrings["WebsiteConnectionString1"].ConnectionString;
            SqlConnection cn = new SqlConnection(cnStr);
            SqlCommand cmd = new SqlCommand(
                "Update Announcements  set AnntTitle=@AnntTitle , AnntContent=@AnntContent, AnntName=@AnntName, AnntDay=@AnntDay where AnnouncementID=@AnnouncementID", cn);

            cmd.Parameters.AddWithValue("@AnnouncementID", id);
            cmd.Parameters.AddWithValue("@AnntTitle", annt.AnntTitle);
            cmd.Parameters.AddWithValue("@AnntContent", annt.AnntContent);
            cmd.Parameters.AddWithValue("@AnntName", annt.AnntName);
            cmd.Parameters.AddWithValue("@AnntDay", annt.AnntDay);


            cn.Open();
            cmd.ExecuteNonQuery();
            cn.Close();
        }
        public static Announcement GetAnnouncementById(int? id)
        {
            SqlDataAdapter da = new SqlDataAdapter("SELECT * FROM Announcements where AnnouncementID=@AnnouncementID", Common.DBConnectionString);
            da.SelectCommand.Parameters.AddWithValue("@AnnouncementID", id);
            DataTable dt = new DataTable();
            da.Fill(dt);
            if (dt.Rows.Count == 0)
            {
                return null;
            }
            var query = from row in dt.AsEnumerable()
                            select new Announcement()
                            {
                                AnnouncementID = Convert.ToInt32(row["AnnouncementID"]),
                                AnntTitle = row["AnntTitle"].ToString(),
                                AnntName = row["AnntName"].ToString(),
                                AnntContent = row["AnntContent"].ToString(),
                                AnntDay = row["AnntDay"].ToString()
                            };
            //List<Announcement> AnnouncementList = query.ToList();
            return query.SingleOrDefault();

        }
        public static void DeleteAnnouncementByAnnouncementId(int annt)
        {
            string cnStr = ConfigurationManager.ConnectionStrings["WebsiteConnectionString1"].ConnectionString;
            SqlConnection cn = new SqlConnection(cnStr);
            SqlCommand cmd = new SqlCommand("Delete From Announcements where AnnouncementID = @AnnouncementID ", cn);

            cmd.Parameters.AddWithValue("@AnnouncementID", annt);

            cn.Open();
            cmd.ExecuteNonQuery();
            cn.Close();
        }
    }
}