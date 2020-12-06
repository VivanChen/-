using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
public partial class prod_PartEdit : System.Web.UI.Page
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
            resume.InnerText = pid.description;
            //FileUpload1.FileName = pid.drawing;
            HiddenField1.Value = $"/prod/prodPhoto/{pid.drawing}";
        }
        if (Page.IsPostBack)
        {
            //重load圖
            int reqid = Convert.ToInt32(Request.QueryString["id"]);
            PartNumber pid = PartNumberUtility.PartNumberById(reqid);
            //Labelerror.Text = reqid.ToString();
            PartNOTextBox.Text = "PARTN" + pid.id.ToString().PadLeft(5, '0');
            ComponentTextBox.Text = pid.component;
            VendorTextBox.Text = pid.vendor;
            //ConfigTextbox.Text = pid.config;
            //resume.InnerText = pid.description;
            if (pid.drawing != "")
            {
                HiddenField1.Value = $"/prod/prodPhoto/{pid.drawing}";
            }
            else
            {
                HiddenField1.Value = "";
            }
        }
    }

    protected void sumitbutton_Click(object sender, EventArgs e)
    {
        try
        {
            //拉舊的資料
            int reqid = Convert.ToInt32(Request.QueryString["id"]);
            PartNumber pid = PartNumberUtility.PartNumberById(reqid);

            //如果fileUpload1有檔案
            if (FileUpload1.HasFile)
            {
                PartNumber pn = new PartNumber()
                {
                    id = Convert.ToInt32(Request.QueryString["id"]),
                    component = ComponentTextBox.Text,
                    vendor = VendorTextBox.Text,
                    config = ConfigTextbox.Text,
                    description = resume.InnerText,
                    drawing = FileUpload1.FileName,
                    theDate = DateTime.Now
                };

                //如果新上傳的檔案不等於原本的檔案
                if (pn.drawing != pid.drawing)
                {
                    if (pid.drawing != "")
                    {
                        //複製檔案到別的資料夾
                        string OldDrawingFile = pid.drawing;
                        //舊的資料夾與新的資料夾
                        string sourcePath = Server.MapPath("~/prod/prodPhoto/");
                        string targetPath = Server.MapPath("~/prod/deletePhoto/");
                        string sourceFile = Path.Combine(sourcePath, OldDrawingFile);
                        string destFile = Path.Combine(targetPath, OldDrawingFile);
                        //複製單一檔案
                        File.Copy(sourceFile, destFile, true);

                    }
                    //新增新檔案到資料夾
                    string FilePath = Server.MapPath("/prod/prodPhoto/" + pn.drawing);
                    FileUpload1.SaveAs(FilePath);
                }

                //update物件
                PartNumberUtility.UpdatePartNumber(pn);
            }
            //如果沒有新檔案舊檔案不為null
            if (FileUpload1.HasFile==false)
            {
                PartNumber pn = new PartNumber()
                {
                    id = Convert.ToInt32(Request.QueryString["id"]),
                    component = ComponentTextBox.Text,
                    vendor = VendorTextBox.Text,
                    config = ConfigTextbox.Text,
                    description = resume.InnerText,
                    drawing = pid.drawing,
                    theDate = DateTime.Now
                };

                //update物件
                PartNumberUtility.UpdatePartNumber(pn);
            }


            PartNOLabel1.Text = "*已修改成功";
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