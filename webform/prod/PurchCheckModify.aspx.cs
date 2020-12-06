
using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class prod_PurchCheckModify : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        int reqid = Convert.ToInt32(Request.QueryString["id"]);
        HiddenField.Value = reqid.ToString();

        Account m = AccountsUtility.FindAccountById(Convert.ToInt32(HttpContext.Current.User.Identity.Name));
        //HiddenField1.Value = ;
        if (!User.IsInRole("admin"))
        {
            HiddenField1.Value = "a";
        }

    }

    protected void Button1_Click(object sender, EventArgs e)
    {


    }
}