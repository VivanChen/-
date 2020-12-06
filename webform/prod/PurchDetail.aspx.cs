using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class prod_PurchDetail : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        ////接request在HIDDEN
        int reqid = Convert.ToInt32(Request.QueryString["id"]);
        HiddenField.Value = reqid.ToString();

    }
}