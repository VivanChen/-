using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for apiCLass
/// </summary>
public class apiCLass1
{
  public int buyer { get; set; }
  public String department { get; set; }
  public String ThisDay { get; set; }
  public String vendor { get; set; }
  public String vendorsales { get; set; }
  public String phone { get; set; }
  public String email { get; set; }
  public int taxrate { get; set; }
  public int tax { get; set; }
  public int freight { get; set; }
  public int totalprice { get; set; }
    public List<apiClass2> detail { get; set; }

}
public class apiClass2
{
    public string purchPart { get; set; }
    public string config { get; set; }
    public int count { get; set; }
    public int price { get; set; }
    public int partTotal { get; set; }
    public string remark { get; set; }
    public int purchNO { get; set; }
}