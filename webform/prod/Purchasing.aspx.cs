using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class prod_Purchasing : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        //TodayTextBox.Text = DateTime.Now.ToString("yyyy/MM/dd");
        Account m = AccountsUtility.FindAccountById(Convert.ToInt32(HttpContext.Current.User.Identity.Name));
        HiddenField1.Value = m.Id.ToString();
        HiddenField2.Value = m.DepartmentID;
        HiddenField4.Value = PurchUtility.UseEmployeeIDGetName(m.Id);
        //HiddenField4.Value = m.Roles;

        //////做session傳到detail頁purchNO hidden接值
        //Session["aa"]=HiddenField3.Value;
    }
}