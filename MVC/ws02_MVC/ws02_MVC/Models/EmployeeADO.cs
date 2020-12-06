using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;

namespace ws02_MVC.Models
{
    public class EmployeeADO
    {
        public static List<Employee> GetEmployees(string employeename)
        {
            SqlDataAdapter da = new SqlDataAdapter("Select* From Employees where Name like '%'+@Name+'%'", Common.DBConnectionString);
            da.SelectCommand.Parameters.AddWithValue("@Name", employeename);
            DataTable dt = new DataTable();
            da.Fill(dt);
            var query = from row in dt.AsEnumerable()
                        select new Employee()
                        {
                            EmployeeID = (int)row["EmployeeID"],
                            Name = row["Name"].ToString(),
                            DepartmentName=row["DepartmentName"].ToString(),
                            Phone = row["Phone"].ToString(),
                            Email = row["Email"].ToString()
                        };

            List<Employee> EmployeeList = query.ToList();
            return EmployeeList;
        }
    }
}