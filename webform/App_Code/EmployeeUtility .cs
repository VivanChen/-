using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;

/// <summary>
/// EmployeeUtility 的摘要描述
/// </summary>
public class EmployeeUtility
{
    public static List<Employee> GetAllEmployee()
    //員工列表載入Employees Tables的所有資料
    {
        SqlDataAdapter da = new SqlDataAdapter(
            "Select * from Employees",
            Common.DBConnectionString);
        DataTable dt = new DataTable();
        da.Fill(dt);

        var query = from row in dt.AsEnumerable()
                    select new Employee()
                    {
                        EmployeeID=(int)row["EmployeeID"],
                        Name = row["Name"].ToString(),
                        Gender = row["Gender"].ToString(),
                        BirthDate = row["BirthDate"].ToString(),
                        DepartmentID = row["DepartmentID"].ToString(),
                        DepartmentName = row["DepartmentName"].ToString(),
                        StartDate = row["StartDate"].ToString(),
                        EndDate = row["EndDate"] is DBNull ?"" : row["EndDate"].ToString(),
                        Password = row["Password"].ToString(),
                        Phone=row["Phone"].ToString(),
                        Address=row["Address"].ToString(),
                        Email = row["Email"].ToString(),
                        Status = row["Status"].ToString(),
                        ImageFileName = row["ImageFileName"] is DBNull ? "" : row["ImageFileName"].ToString(),
                        NumberID=row["NumberID"].ToString()
                    };

        List<Employee> EmployeeList = query.ToList();
        return EmployeeList;
    }

    public static List<Employee> GetEmployeesByName(string name)
     //依照員工名稱查詢資料
    {
        SqlDataAdapter da = new SqlDataAdapter(
            "Select * from Employees Where Name like '%'+@Name+'%'",
            Common.DBConnectionString);

        da.SelectCommand.Parameters.AddWithValue("@Name",name);

        DataTable dt = new DataTable();

        da.Fill(dt);

        var query = from row in dt.AsEnumerable()
                    select new Employee()
                    {
                        EmployeeID = (int)row["EmployeeID"],
                        Name = row["Name"].ToString(),
                        Gender = row["Gender"].ToString(),
                        BirthDate =row["BirthDate"].ToString(),
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
        List<Employee> EmployeeList = query.ToList();
        return EmployeeList;

    }

    public static Employee GetEmployeesById(int EmployeeID)
    //修改員工資料時，當pageload時透過id載入其他欄位的資料
    {
        // //修改員工資料，當pageload時透過id載入其他欄位的資料
        SqlDataAdapter da = new SqlDataAdapter(
            "Select * from Employees Where EmployeeID =@EmployeeID",
            Common.DBConnectionString);

        da.SelectCommand.Parameters.AddWithValue("@EmployeeID", EmployeeID);

        DataTable dt = new DataTable();
        da.Fill(dt);
        DataRow row = dt.Rows[0];

        Employee emp= new Employee()
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
    public static void InsertEmployee(Employee emp)
    //新增員工資料
    {
        SqlConnection cn = new SqlConnection
            (Common.DBConnectionString);
        SqlCommand cmd = new SqlCommand(
            "Insert into Employees(Name,Gender,BirthDate,DepartmentID,DepartmentName," +
            "StartDate,EndDate,Password,Phone,Address,Email,Status,ImageFileName,NumberID)" +
            "values(@Name,@Gender,@BirthDate,@DepartmentID,@DepartmentName," +
            "@StartDate,@EndDate,@Password,@Phone,@Address,@Email,@Status,@ImageFileName,@NumberID)", cn
            );

        //cmd.Parameters.AddWithValue("@EmployeeID", emp.EmployeeID);
        cmd.Parameters.AddWithValue("@Name",emp.Name);
        cmd.Parameters.AddWithValue("@Gender", emp.Gender);
        cmd.Parameters.AddWithValue("@BirthDate", emp.BirthDate);
        cmd.Parameters.AddWithValue("@DepartmentID", emp.DepartmentID);
        cmd.Parameters.AddWithValue("@DepartmentName", emp.DepartmentName);
        cmd.Parameters.AddWithValue("@StartDate", emp.StartDate);
        cmd.Parameters.AddWithValue("@EndDate", emp.EndDate);
        cmd.Parameters.AddWithValue("@Password", emp.Password);
        cmd.Parameters.AddWithValue("@Phone", emp.Phone);
        cmd.Parameters.AddWithValue("@Address", emp.Address);
        cmd.Parameters.AddWithValue("@Email", emp.Email);
        cmd.Parameters.AddWithValue("@Status", emp.Status);
        cmd.Parameters.AddWithValue("@ImageFileName", emp.ImageFileName);
        cmd.Parameters.AddWithValue("@NumberID",emp.NumberID);
       
        cn.Open();
        cmd.ExecuteNonQuery();
        cn.Close();

    }

    public static void UpdateEmployee(Employee emp)
    //修改員工資料
    {
        SqlConnection cn = new SqlConnection
            (Common.DBConnectionString);
        SqlCommand cmd = new SqlCommand(
            "UPDATE Employees set " +
            "Name=@Name," +
            "Gender=@Gender," +
            "BirthDate=@BirthDate," +
            "DepartmentID=@DepartmentID," +
            "DepartmentName=@DepartmentName," +
            "StartDate=@StartDate," +
            "EndDate=@EndDate," +
            "Password=@Password," +
            "Phone=@Phone," +
            "Address=@Address," +
            "Email=@Email," +
            "Status=@Status," +
            "ImageFileName=@ImageFileName, " +
            "NumberID=@NumberID "+
            "Where EmployeeID=@EmployeeID", cn);

        cmd.Parameters.AddWithValue("@EmployeeID", emp.EmployeeID);
        cmd.Parameters.AddWithValue("@Name", emp.Name);
        cmd.Parameters.AddWithValue("@Gender", emp.Gender);
        cmd.Parameters.AddWithValue("@BirthDate", emp.BirthDate);
        cmd.Parameters.AddWithValue("@DepartmentID", emp.DepartmentID);
        cmd.Parameters.AddWithValue("@DepartmentName", emp.DepartmentName);
        cmd.Parameters.AddWithValue("@StartDate", emp.StartDate);
        cmd.Parameters.AddWithValue("@EndDate", emp.EndDate);
        cmd.Parameters.AddWithValue("@Password", emp.Password);
        cmd.Parameters.AddWithValue("@Phone", emp.Phone);
        cmd.Parameters.AddWithValue("@Address", emp.Address);
        cmd.Parameters.AddWithValue("@Email", emp.Email);
        cmd.Parameters.AddWithValue("@Status", emp.Status);
        cmd.Parameters.AddWithValue("@ImageFileName", emp.ImageFileName);
        cmd.Parameters.AddWithValue("@NumberID", emp.NumberID);
        cn.Open();
        cmd.ExecuteNonQuery();
        cn.Close();

    }
    public static void DeleteEmployee(int employeeID)
    //刪除員工資料
    {
        SqlConnection cn = new SqlConnection(Common.DBConnectionString);

        SqlCommand cmd = new SqlCommand(
            "DELETE FROM Employees where EmployeeID=@EmployeeID",
            cn);

        cmd.Parameters.AddWithValue("@EmployeeID", employeeID);

      
        cn.Open();
        cmd.ExecuteNonQuery();
        cn.Close();
    }
}