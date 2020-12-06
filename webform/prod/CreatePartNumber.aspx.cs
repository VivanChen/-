using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
public partial class prod_CrestPartNumber : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void sumitbutton_Click(object sender, EventArgs e)
    {
       
            try
            {

                ////test用
                //ComponentLabel1.Text = ComponentDropDown.SelectedValue;
                //VendorLabel1.Text = VendorDropDown.SelectedValue;


                if (HiddenField1.Value == "==請選擇==")
                {
                    ComponentLabel1.Text = "*請選單加入廠商";
                }
                if (HiddenField2.Value == "==請選擇==")
                {
                    VendorLabel1.Text = "*請選單加入元件類型";
                }
                if (HiddenField1.Value != "==請選擇==" & HiddenField2.Value != "==請選擇==")
                {
                    //Labelerror.Text = FileUpload1.FileName;
                    PartNumber pn = new PartNumber()
                    {
                        component = HiddenField2.Value,
                        vendor = HiddenField1.Value,
                        config = ConfigTextbox.Text,
                        //description = TextArea1.InnerText,
                        description = resume.InnerText,
                        drawing = FileUpload1.FileName,
                        theDate = DateTime.Now
                    };
                    ////寫相對位置
                    string FilePath = Server.MapPath("/prod/prodPhoto/" + FileUpload1.FileName);
                    FileUpload1.SaveAs(FilePath);

                    ////Insert進資料庫
                    PartNumberUtility.InserPartNumber(pn);
                    ////從資料庫找全部符合的
                    PartNumber FindthisPartNO = PartNumberUtility.PartNumberByAllFindPartNO(pn);
                    string partid = FindthisPartNO.id.ToString();
                    PartNOTextBox.Text = "PARTN" + partid.PadLeft(5, '0');
                Response.Redirect("PartNumber5.aspx");
                }

            }
            catch (Exception ex)
            {

                //Labelerror.Text = ex.Message;
            }
        







    }

    protected void topartnolist_Click(object sender, EventArgs e)
    {
        Response.Redirect("/prod/PartNumber5.aspx");
    }
}
