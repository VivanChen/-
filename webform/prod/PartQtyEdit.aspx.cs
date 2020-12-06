using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class prod_PartQtyEdit : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Page.IsPostBack == false)
        {
            int reqid = Convert.ToInt32(Request.QueryString["id"]);
            PartNumber pid = PartNumberUtility.PartNumberById(reqid);
            //Labelerror.Text = reqid.ToString();
            PartNOTextBox.Text = "PARTN" + pid.id.ToString().PadLeft(5, '0');
            ComponentTextBox.Text = pid.component;
            VendorTextBox.Text = pid.vendor;
            ConfigTextbox.Text = pid.config;
            Qtyresume.InnerText = pid.qtydescription;
            textboxnumber.Text = pid.qty.ToString();
            HiddenField1.Value = $"/prod/prodPhoto/{pid.drawing}";
        }
        //if (Page.IsPostBack)
        //{
        //    int reqid = Convert.ToInt32(Request.QueryString["id"]);
        //    PartNumber pid = PartNumberUtility.PartNumberById(reqid);
        //    //Labelerror.Text = reqid.ToString();
        //    PartNOTextBox.Text = "PARTN" + pid.id.ToString().PadLeft(5, '0');
        //    ComponentTextBox.Text = pid.component;
        //    VendorTextBox.Text = pid.vendor;
        //    ConfigTextbox.Text = pid.config;
        //    Qtyresume.InnerText = pid.qtydescription;
        //    textboxnumber.Text = pid.qty.ToString();
        //    HiddenField1.Value = $"/prod/prodPhoto/{pid.drawing}";
        //}
    }

    protected void sumitbutton_Click(object sender, EventArgs e)
    {
        try
        {
            //拉舊的資料
            int reqid = Convert.ToInt32(Request.QueryString["id"]);
            PartNumber pid = PartNumberUtility.PartNumberById(reqid);

            //如果fileUpload1有檔案
            
                PartNumber pn = new PartNumber()
                {
                    id = Convert.ToInt32(Request.QueryString["id"]),
                    component = ComponentTextBox.Text,
                    vendor = VendorTextBox.Text,
                    config = ConfigTextbox.Text,
                    qty = Convert.ToInt32(textboxnumber.Text),
                    qtydescription = Qtyresume.InnerText,
                    qtyDateStr = DateTime.Now.ToString("yyyy-MM-dd hh:mm:ss")
                };
                //update物件
                PartNumberUtility.UpdatePartNumberQty(pn);
            
            PartNOLabel1.Text = "*已修改成功";
        }
        catch (Exception ex)
        {
            //Labelerror.Text = ex.Message;
        }
    }

    protected void topartnolist_Click(object sender, EventArgs e)
    {
        Response.Redirect("/prod/PartQty.aspx");
    }
}