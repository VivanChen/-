using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;

/// <summary>
/// LeaveUtility 的摘要描述
/// </summary>
public class LeaveUtility
{
    public static List<Leave> GetAllLeave()
    //請假列表載入Leaves Tables的所有資料
    {
        SqlDataAdapter da = new SqlDataAdapter(
            "Select * from Leaves",
            Common.DBConnectionString);
        DataTable dt = new DataTable();
        da.Fill(dt);

        var query = from row in dt.AsEnumerable()
                    select new Leave()
                    {
                        LeaveID=(int)row["LeaveID"],
                        EmployeeID = (int)row["EmployeeID"],
                        Name = row["Name"].ToString(),
                        DepartmentID = row["DepartmentID"].ToString(),
                        DepartmentName = row["DepartmentName"].ToString(),
                        StartTime = (row["StartTime"]).ToString(),
                        EndTime = (row["EndTime"]).ToString(),
                        Category = row["Category"].ToString(),
                        Hours = (int)row["Hours"],
                        Reason = row["Reason"] is DBNull ? "" : row["Reason"].ToString(),
                        Status = row["Status"] is DBNull ? "" : row["Status"].ToString()
                    };

        List<Leave> leaveList = query.ToList();
        return leaveList;

    }

    public static List<Leave> GetLeavesByEmployeeName(string employeename)
    {
        //假單list搜尋名字
        SqlDataAdapter da = new SqlDataAdapter(
            "Select * from Leaves Where Name like '%'+@Name+'%'",
             Common.DBConnectionString);

        da.SelectCommand.Parameters.AddWithValue("@Name", employeename);

        DataTable dt = new DataTable();

        da.Fill(dt);
        var query = from row in dt.AsEnumerable()
                    select new Leave()
                    {
                        LeaveID = (int)row["LeaveID"],
                        EmployeeID = (int)row["EmployeeID"],
                        Name = row["Name"].ToString(),
                        DepartmentName = row["DepartmentName"].ToString(),
                        Category = row["Category"].ToString(),
                        StartTime = row["StartTime"].ToString(),
                        EndTime = row["EndTime"].ToString(),
                        Hours = (int)row["Hours"],
                        Status = row["Status"].ToString(),
                        Reason = row["Reason"].ToString(),
                    };
        List<Leave> LeaveList = query.ToList();
        return LeaveList;

    }
    public static List<Leave> GetLeavesByDepartmentName(string departername)
        //假單list搜尋部門名稱
    {
        SqlDataAdapter da = new SqlDataAdapter(
            "Select * from Leaves Where DepartmentName like '%'+@DepartmentName+'%'",
             Common.DBConnectionString);

        da.SelectCommand.Parameters.AddWithValue("@DepartmentName", departername);

        DataTable dt = new DataTable();

        da.Fill(dt);
        var query = from row in dt.AsEnumerable()
                    select new Leave()
                    {
                        LeaveID = (int)row["LeaveID"],
                        EmployeeID = (int)row["EmployeeID"],
                        Name = row["Name"].ToString(),
                        DepartmentName = row["DepartmentName"].ToString(),
                        Category = row["Category"].ToString(),
                        StartTime = row["StartTime"].ToString(),
                        EndTime = row["EndTime"].ToString(),
                        Hours = (int)row["Hours"],
                        Status = row["Status"].ToString(),
                        Reason = row["Reason"].ToString(),
                    };
        List<Leave> LeaveList = query.ToList();
        return LeaveList;

    }

    public static List<Leave> GetLeavesByStatus(string status)
        //假單list搜尋狀態
    {
        SqlDataAdapter da = new SqlDataAdapter(
            "Select * from Leaves Where Status like '%'+@Status+'%'",
             Common.DBConnectionString);

        da.SelectCommand.Parameters.AddWithValue("@Status", status);

        DataTable dt = new DataTable();

        da.Fill(dt);
        var query = from row in dt.AsEnumerable()
                    select new Leave()
                    {
                        LeaveID = (int)row["LeaveID"],
                        EmployeeID = (int)row["EmployeeID"],
                        Name = row["Name"].ToString(),
                        DepartmentName = row["DepartmentName"].ToString(),
                        Category = row["Category"].ToString(),
                        StartTime = row["StartTime"].ToString(),
                        EndTime = row["EndTime"].ToString(),
                        Hours = (int)row["Hours"],
                        Status = row["Status"].ToString(),
                        Reason = row["Reason"].ToString(),
                    };
        List<Leave> LeaveList = query.ToList();
        return LeaveList;

    }

    public static List<Leave> GetLeavesByName(string name)
     //透過名稱搜尋資料
    {
        SqlDataAdapter da = new SqlDataAdapter(
            "Select * from Leaves Where Name like '%'+@Name+'%'",
            Common.DBConnectionString);

        da.SelectCommand.Parameters.AddWithValue("@Name",name);

        DataTable dt = new DataTable();

        da.Fill(dt);

        var query = from row in dt.AsEnumerable()
                    select new Leave()
                    {
                        LeaveID = (int)row["LeaveID"],
                        EmployeeID = (int)row["EmployeeID"],
                        Name = row["Name"].ToString(),
                        DepartmentID = row["DepartmentID"].ToString(),
                        DepartmentName = row["DepartmentName"].ToString(),
                        StartTime = (row["StartTime"]).ToString(),
                        EndTime = (row["EndTime"]).ToString(),
                        Category = row["Category"].ToString(),
                        Hours = (int)row["Hours"],
                        Reason = row["Reason"] is DBNull ? "" : row["Reason"].ToString(),
                        Status = row["Status"] is DBNull ? "" : row["Status"].ToString()
                    };
        List<Leave> leaveList = query.ToList();
        return leaveList;

    }

   

    public static Leave GetLeavesById(int leaveID)
    //修改假單，當pageload時透過leaveID載入資料
    {
        SqlDataAdapter da = new SqlDataAdapter(
            "Select * from leaves Where LeaveID =@LeaveID",
            Common.DBConnectionString);

        da.SelectCommand.Parameters.AddWithValue("@LeaveID", leaveID);

        DataTable dt = new DataTable();
        da.Fill(dt);
        DataRow row = dt.Rows[0];

        Leave l = new Leave()
        {
            LeaveID=(int)row["LeaveID"],
            EmployeeID = (int)row["EmployeeID"],
            Name = row["Name"].ToString(),
            DepartmentID = row["DepartmentID"].ToString(),
            DepartmentName = row["DepartmentName"].ToString(),
            StartTime = (row["StartTime"]).ToString(),
            EndTime = (row["EndTime"]).ToString(),
            Category = row["Category"].ToString(),
            Hours = (int)row["Hours"],
            Reason = row["Reason"] is DBNull ? "" : row["Reason"].ToString(),
            Status = row["Status"] is DBNull ? "" : row["Status"].ToString()
        };
        return l;

    }
    public static Leave GetLeavesByLeaveId(int leaveID)
    //修改假單，當pageload時透過leaveID載入資料
    {
        SqlDataAdapter da = new SqlDataAdapter(
            "Select * from leaves Where LeaveID =@LeaveID",
            Common.DBConnectionString);

        da.SelectCommand.Parameters.AddWithValue("@LeaveID", leaveID);

        DataTable dt = new DataTable();
        da.Fill(dt);
        DataRow row = dt.Rows[0];

        Leave l = new Leave()
        {
            LeaveID = (int)row["LeaveID"],
            EmployeeID = (int)row["EmployeeID"],
            Name = row["Name"].ToString(),
            DepartmentID = row["DepartmentID"].ToString(),
            DepartmentName = row["DepartmentName"].ToString(),
            StartTime = (row["StartTime"]).ToString(),
            EndTime = (row["EndTime"]).ToString(),
            Category = row["Category"].ToString(),
            Hours = (int)row["Hours"],
            Reason = row["Reason"] is DBNull ? "" : row["Reason"].ToString(),
            Status = row["Status"] is DBNull ? "" : row["Status"].ToString()
        };
        return l;

    }


    public static Leave GetLeavesByEmployeeId(int employeeID)
    //新增假單，當pageload時透過EmployeeID載入資料
    {
        SqlDataAdapter da = new SqlDataAdapter(
            "Select * from Employees Where EmployeeID =@EmployeeID",
            Common.DBConnectionString);

        da.SelectCommand.Parameters.AddWithValue("@EmployeeID", employeeID);

        DataTable dt = new DataTable();
        da.Fill(dt);
        DataRow row = dt.Rows[0];

        Leave I = new Leave()
        {
            EmployeeID = (int)row["EmployeeID"],
            Name = row["Name"].ToString(),
            DepartmentID = row["DepartmentID"].ToString(),
            DepartmentName = row["DepartmentName"].ToString(),
           
        };
        return I;

    }
    public static void InsertLeave(Leave l)
    //新增假單
    {
        SqlConnection cn = new SqlConnection
            (Common.DBConnectionString);
        SqlCommand cmd = new SqlCommand(
            "Insert into Leaves(EmployeeID,Name,DepartmentName,StartTime,EndTime,Category,Hours,Reason,Status)" +
            "values(@EmployeeID,@Name,@DepartmentName,@StartTime,@EndTime,@Category,@Hours,@Reason,@Status)", cn
            );

        //cmd.Parameters.AddWithValue("@LeaveID", l.LeaveID);
        cmd.Parameters.AddWithValue("@EmployeeID", l.EmployeeID);
        cmd.Parameters.AddWithValue("@Name", l.Name);
        //cmd.Parameters.AddWithValue("@DepartmentID", l.DepartmentID);
        cmd.Parameters.AddWithValue("@DepartmentName", l.DepartmentName);
        cmd.Parameters.AddWithValue("@StartTime", l.StartTime);
        cmd.Parameters.AddWithValue("@EndTime", l.EndTime);
        cmd.Parameters.AddWithValue("@Category", l.Category);
        cmd.Parameters.AddWithValue("@Hours", l.Hours);
        cmd.Parameters.AddWithValue("@Reason", l.Reason);
        cmd.Parameters.AddWithValue("@Status", l.Status);
        cn.Open();
        cmd.ExecuteNonQuery();
        cn.Close();
        
    }
   
    public static void UpdateLeave(Leave l)
    //修改假單
    {
        SqlConnection cn = new SqlConnection
            (Common.DBConnectionString);
        SqlCommand cmd = new SqlCommand(
            "UPDATE Leaves set EmployeeID=@EmployeeID,Name=@Name,DepartmentID=@DepartmentID,DepartmentName=@DepartmentName," +
            "StartTime=@StartTime,EndTime=@EndTime,Category=@Category,Hours=@Hours,Reason=@Reason Where LeaveID=@LeaveID ", cn);

        cmd.Parameters.AddWithValue("@LeaveID", l.LeaveID);
        cmd.Parameters.AddWithValue("@EmployeeID", l.EmployeeID);
        cmd.Parameters.AddWithValue("@Name", l.Name);
        cmd.Parameters.AddWithValue("@DepartmentID", l.DepartmentID);
        cmd.Parameters.AddWithValue("@DepartmentName", l.DepartmentName);
        cmd.Parameters.AddWithValue("@StartTime", l.StartTime);
        cmd.Parameters.AddWithValue("@EndTime", l.EndTime);
        cmd.Parameters.AddWithValue("@Category", l.Category);
        cmd.Parameters.AddWithValue("@Hours", l.Hours);
        cmd.Parameters.AddWithValue("@Reason", l.Reason);
        //cmd.Parameters.AddWithValue("@Status", l.Status);
        cn.Open();
        cmd.ExecuteNonQuery();
        cn.Close();

    }
    public static void UpdateLeaveStatus(int LeaveID )
    //審核假單後更改假單狀態
    {
        SqlConnection cn = new SqlConnection
              (Common.DBConnectionString);
        SqlCommand cmd = new SqlCommand(
            "UPDATE Leaves set Status=@Status Where LeaveID=@LeaveID ", cn);
       
        cmd.Parameters.AddWithValue("@LeaveID", LeaveID);      
        cmd.Parameters.AddWithValue("@Status", "已通過");
        cn.Open();
        cmd.ExecuteNonQuery();
        cn.Close();
    }

    public static void UpdateLeaveStatusNotPass(int LeaveID)
    //審核假單後更改假單狀態
    {
        SqlConnection cn = new SqlConnection
              (Common.DBConnectionString);
        SqlCommand cmd = new SqlCommand(
            "UPDATE Leaves set Status=@Status Where LeaveID=@LeaveID ", cn);

        cmd.Parameters.AddWithValue("@LeaveID", LeaveID);
        cmd.Parameters.AddWithValue("@Status", "未通過");
        cn.Open();
        cmd.ExecuteNonQuery();
        cn.Close();
    }
    public static void DeleteLeave(int leaveID)
    //刪除假單
    {

        SqlConnection cn = new SqlConnection(Common.DBConnectionString);

        SqlCommand cmd = new SqlCommand(
            "DELETE FROM Leaves where LeaveID=@LeaveID",
            cn);

        cmd.Parameters.AddWithValue("@LeaveID", leaveID);

        cn.Open();
        cmd.ExecuteNonQuery();
        cn.Close();
    }
}