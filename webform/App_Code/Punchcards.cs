using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for Employee
/// </summary>
public class Punchcard
{
        public int PunchcardID { get; set; }
        public int Id { get; set; }
        public string Name { get; set; }
        public string DepartmentID { get; set; }
        public string Date { get; set; }
        public string Punchin { get; set; }
        public string Punchout { get; set; }
        public string Hours { get; set; }
}