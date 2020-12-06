using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for PurchMain
/// </summary>
public class PurchMain
{
    public int purchNO { get; set; }
    public int buyer { get; set; }
    public string Name { get; set; }
    public string department { get; set; }
    public DateTime ThisDay { get; set; }
    public string vendor { get; set; }
    public string vendorsales { get; set; }
    public string phone { get; set; }
    public string email { get; set; }
    public int tax { get; set; }
    public int taxrate { get; set; }
    public int freight { get; set; }
    public int totalprice { get; set; }
    public string checkstatus { get; set; }
    public DateTime? checkday { get; set; }
    public string checkreason { get; set; }


}