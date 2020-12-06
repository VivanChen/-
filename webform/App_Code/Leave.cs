using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Leave 的摘要描述
/// </summary>
public class Leave
{
    public int LeaveID { get; set; }
    public int EmployeeID { get; set; }
    public string Name { get; set; }
    public string DepartmentID { get; set; }
    public string DepartmentName { get; set; }
    public string StartTime { get; set; }
    public string EndTime { get; set; }
    public string Category { get; set; }
    public int Hours { get; set; }
    public string Reason { get; set; }
    public string Status { get; set; }
    
}