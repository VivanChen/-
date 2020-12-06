using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for PartNumber
/// </summary>
public class PartNumber
{
    public int id { get; set; }
    public string component { get; set; }
    public string vendor { get; set; }
    public string config { get; set; }
    public string description { get; set; }
    public string drawing { get; set; }
    public int qty { get; set; }
    public string qtydescription { get; set; }
    public DateTime theDate { get; set; }
    public string qtyDateStr { get; set; }
    public int price { get; set; }

    public string theDateString
    {
        get
        {
            return this.theDate.ToString("yyyy-MM-dd hh:mm:ss");
        }
    }
   
}