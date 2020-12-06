using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for CheckPunchcards
/// </summary>
public class CheckPunchcards
{
    public int CheckPunchcardID { get; set; }
    public int EmployeeID { get; set; }
    public string Name { get; set; }
    public string DepartmentID { get; set; }
    public string Date { get; set; }
    public string Punchin { get; set; }
    public string Punchout { get; set; }
    public string Hours { get; set; }
    public string Reason { get; set; }
    public string CheckPunchcard { get; set; }
}