using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace ws02_MVC.Models
{
    public class TravelADO
    {
        public static void InsertTravel(Travel t)
        {
            SqlConnection cn = new SqlConnection
                (Common.DBConnectionString);
            SqlCommand cmd = new SqlCommand("Insert into Travels(EmployeeID,EmployeeName,DepartmentName,BirthDate,NumberID) " +
                "values(@EmployeeID,@EmployeeName,@DepartmentName,@BirthDate,@NumberID)", cn);

            cmd.Parameters.AddWithValue("@EmployeeID", t.EmployeeID);
            cmd.Parameters.AddWithValue("@EmployeeName", t.EmployeeName);
            cmd.Parameters.AddWithValue("@DepartmentName", t.DepartmentName);
            cmd.Parameters.AddWithValue("@BirthDate",t.BirthDate);
            cmd.Parameters.AddWithValue("@NumberID",t.NumberID);

            cn.Open();
            cmd.ExecuteNonQuery();
            cn.Close();
         }

        public static void UpdateTravel(Travel t)
        {
            SqlConnection cn = new SqlConnection(Common.DBConnectionString);
            SqlCommand cmd = new SqlCommand(
                "Update Travels  set  EmployeeID=@EmployeeID,EmployeeName=@EmployeeName," +
                "DepartmentName=@DepartmentName,BirthDate=@BirthDate,NumberID=@NumberID WHERE  TravelID=@TravelID", cn);
            cmd.Parameters.AddWithValue("@TravelID", t.TravelID);
            cmd.Parameters.AddWithValue("@EmployeeID", t.EmployeeID);
            cmd.Parameters.AddWithValue("@EmployeeName", t.EmployeeName);
            cmd.Parameters.AddWithValue("@DepartmentName", t.DepartmentName);
            cmd.Parameters.AddWithValue("@BirthDate", t.BirthDate);
            cmd.Parameters.AddWithValue("@NumberID", t.NumberID);

            cn.Open();
            cmd.ExecuteNonQuery();
            cn.Close();
        }

        public static void DeleteTravel(int travelId)
        {
            SqlConnection cn = new SqlConnection(Common.DBConnectionString);
            SqlCommand cmd = new SqlCommand("Delete from Travels where TravelID=@TravelID",cn);

            cmd.Parameters.AddWithValue("@TravelID", travelId);

            cn.Open();
            cmd.ExecuteNonQuery();
            cn.Close();
        }

        public static List<Travel> GetAllTravels()
        {
            SqlDataAdapter da = new SqlDataAdapter("Select * from Travels", Common.DBConnectionString);
            DataTable dt = new DataTable();
            da.Fill(dt);

            var query = from row in dt.AsEnumerable()
                        select new Travel()
                        {
                            TravelID = (int)row["TravelID"],
                            EmployeeID = (int)row["EmployeeID"],
                            EmployeeName = row["EmployeeName"].ToString(),
                            DepartmentName = row["DepartmentName"].ToString(),
                            BirthDate=row["BirthDate"].ToString(),
                            NumberID=row["NumberID"].ToString()
                        };
            List<Travel> travels = query.ToList();
            return travels;
        }

        public static Travel GetTravelById(int? travelId)
        {
            SqlDataAdapter da = new SqlDataAdapter(
                "Select * from Travels Where TravelID=@TravelID",
                Common.DBConnectionString);
            da.SelectCommand.Parameters.AddWithValue("@TravelID", travelId);

            DataTable dt = new DataTable();
            da.Fill(dt);
            DataRow row = dt.Rows[0];
            Travel t = new Travel()
            {
                TravelID=(int)row["TravelID"],
                EmployeeID=(int)row["EmployeeID"],
                EmployeeName=row["EmployeeName"].ToString(),
                DepartmentName=row["DepartmentName"].ToString(),
                BirthDate=row["BirthDate"].ToString(),
                NumberID=row["NumberID"].ToString()
            };
            return t;
        }
        public static Travel GetTravelByemployeeId(int employeeId)
            //當pageload時要抓employeeid載入資料
        {
            SqlDataAdapter da = new SqlDataAdapter(
                "Select * from employees Where EmployeeID=@EmployeeID",
                Common.DBConnectionString);
            da.SelectCommand.Parameters.AddWithValue("@EmployeeID", employeeId);

            DataTable dt = new DataTable();
            da.Fill(dt);
            DataRow row = dt.Rows[0];
            Travel t = new Travel()
            {
                EmployeeID = (int)row["EmployeeID"],
                EmployeeName = row["Name"].ToString(),
                DepartmentName = row["DepartmentName"].ToString(),
                BirthDate = row["BirthDate"].ToString(),
                NumberID = row["NumberID"].ToString()
            };
            return t;
        }
    }
}
