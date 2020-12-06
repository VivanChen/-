<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" %>

<script runat="server">

    protected void Button1_Click(object sender, EventArgs e)
    {
        if (FileUpload1.HasFile)  //如果使用者有上傳檔案,才去另存新檔
        {
            string filePath = Server.MapPath("~/Upload/" + FileUpload1.FileName);
            FileUpload1.SaveAs(filePath);
        }
        Employee emp = new Employee()
        {
            EmployeeID = int.Parse(TextBox1.Text),
            Name = TextBox2.Text,
            Gender = DropDownList1.SelectedItem.Text,
            BirthDate = TextBox3.Text,
            DepartmentID = TextBox4.Text,
            NumberID = TextBox5.Text,
            DepartmentName = DropDownList3.SelectedItem.Text,
            StartDate = TextBox6.Text,
            Password = TextBox7.Text,
            Phone = TextBox8.Text,
            Address = TextBox9.Text,
            Email = TextBox10.Text,
            Status = DropDownList2.SelectedItem.Text,
            EndDate = TextBox11.Text,
            ImageFileName = FileUpload1.HasFile ? FileUpload1.FileName : HiddenField1.Value

        };
        EmployeeUtility.UpdateEmployee(emp);
        Response.Redirect("employeeList.aspx");
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Page.IsPostBack == false)
        {
            if (!User.IsInRole("hr"))
            {
                Response.Redirect("~/AuthorityInfo.aspx");
            }
            int id = int.Parse(Request.QueryString["EmployeeID"]);
            Employee emp = EmployeeUtility.GetEmployeesById(id);

            TextBox1.Text = emp.EmployeeID.ToString();
            TextBox2.Text = emp.Name;
            DropDownList1.SelectedItem.Text = emp.Gender;
            TextBox3.Text = emp.BirthDate;
            TextBox4.Text = emp.DepartmentID;
            TextBox5.Text = emp.NumberID;
            DropDownList3.SelectedItem.Text = emp.DepartmentName;
            TextBox6.Text = emp.StartDate;
            TextBox7.Text = emp.Password;
            TextBox8.Text = emp.Phone;
            TextBox9.Text = emp.Address;
            TextBox10.Text = emp.Email;
            TextBox11.Text = emp.EndDate;
            DropDownList2.SelectedItem.Text = emp.Status;
            Image1.ImageUrl = $"/Upload/{emp.ImageFileName}";
            HiddenField1.Value = emp.ImageFileName;
        }
    }
    //protected void DropDownList3_SelectedIndexChanged(object sender, EventArgs e)
    //   {
    //       TextBox5.Text = DropDownList3.SelectedValue;
    //   }

    protected void TextBox5_TextChanged(object sender, EventArgs e)
    {
        string password = TextBox5.Text;
        TextBox7.Text = password.Substring(6, 4);
    }
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="myCss" runat="Server">
    <%--<link href="../prod/jQuery-Plugin-To-Beautify-File-Inputs-with-Custom-Styles-Dropify/dist/css/demo.css" rel="stylesheet" />--%>
    <link href="../prod/jQuery-Plugin-To-Beautify-File-Inputs-with-Custom-Styles-Dropify/dist/css/dropify.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="myContent" runat="Server">
    <style>
        body {
            font-family: Microsoft JhengHei;
        }
    </style>

    <div class="container">
        <div class="p-5">
            <div class="text-center">
                <div class="btn btn-success btn-circle  ">
                    <i class="fas fa-check"></i>
                </div>
                <h1 class="h4 text-gray-900 mb-4" >修改員工資料</h1>
                <br />             
                <asp:Image ID="Image1" Width="20%" runat="server" />
            </div>         
        </div>
        <div class="form-group row">
            <div class="col-sm-3 mb-3 mb-sm-0">
                <asp:Label ID="Label1" CssClass="col-form-label text-right col-1" runat="server" Text="員工ID"></asp:Label>
                <asp:TextBox ID="TextBox1" ReadOnly="True" CssClass="form-control form-control-user" runat="server" placeholder="自動新增"></asp:TextBox>
            </div>
            <div class="col-sm-3">
                <asp:Label ID="Label2" CssClass="col-form-label text-right col-1" runat="server" Text="姓名"></asp:Label>
                <asp:TextBox ID="TextBox2" CssClass="form-control form-control-user" runat="server" placeholder="填入姓名"></asp:TextBox>
            </div>
            <div class="col-sm-3">
                <asp:Label ID="Label3" CssClass="col-form-label text-right col-1" runat="server" Text="性別"></asp:Label>
                <asp:DropDownList ID="DropDownList1" CssClass="form-control form-control-user" runat="server">
                    <asp:ListItem Value="0">---</asp:ListItem>
                    <asp:ListItem Value="male">男</asp:ListItem>
                    <asp:ListItem Value="female">女</asp:ListItem>
                </asp:DropDownList>
            </div>
            <div class="col-sm-3">
                <asp:Label ID="Label4" CssClass="col-form-label text-right col-1" runat="server" Text="生日"></asp:Label>
                <asp:TextBox ID="TextBox3" CssClass="form-control form-control-user" runat="server" TextMode="Date"></asp:TextBox>
            </div>
        </div>
        <br />

        <div class="form-group row">
            <div class="col-sm-3 mb-3 mb-sm-0">
                <asp:Label ID="Label5" CssClass="col-form-label text-right col-1" runat="server" Text="部門編號"></asp:Label>
                <asp:TextBox ID="TextBox4" CssClass="form-control form-control-user" runat="server" ReadOnly="true"></asp:TextBox>
            </div>
            <div class="col-sm-3">
                <asp:Label ID="Label6" CssClass="col-form-label text-right col-1" runat="server" Text="部門名稱"></asp:Label>
                <asp:DropDownList ID="DropDownList3" CssClass="form-control form-control-user" runat="server">
                    <%--AutoPostBack="True" OnSelectedIndexChanged="DropDownList3_SelectedIndexChanged"--%>
                    <asp:ListItem Value="0">---</asp:ListItem>
                    <asp:ListItem Value="管理部">管理部</asp:ListItem>
                    <asp:ListItem Value="人資部">人資部</asp:ListItem>
                    <asp:ListItem Value="產品部">產品部</asp:ListItem>
                </asp:DropDownList>
            </div>
            <div class="col-sm-3">
                <asp:Label ID="Label7" CssClass="col-form-label text-right col-1" runat="server" Text="身份證字號"></asp:Label>
                <asp:TextBox ID="TextBox5" CssClass="form-control form-control-user" runat="server" MaxLength="10"  AutoPostBack="True" OnTextChanged="TextBox5_TextChanged"></asp:TextBox>
            </div>
            <div class="col-sm-3">
                <asp:Label ID="Label8" CssClass="col-form-label text-right col-1" runat="server" Text="到職日"></asp:Label>
                <asp:TextBox ID="TextBox6" CssClass="form-control form-control-user" runat="server" TextMode="Date"></asp:TextBox>
            </div>
        </div>
        <br />
        <div class="form-group row">
            <div class="col-sm-3 mb-3 mb-sm-0">
                <asp:Label ID="Label9" CssClass="col-form-label text-right col-1" runat="server" Text="密碼"></asp:Label>
                <asp:TextBox ID="TextBox7" CssClass="form-control form-control-user" runat="server" placeholder="預設為id"></asp:TextBox>
            </div>
            <div class="col-sm-3">
                <asp:Label ID="Label10" CssClass="col-form-label text-right col-1" runat="server" Text="電話"></asp:Label>
                <asp:TextBox ID="TextBox8" CssClass="form-control form-control-user" runat="server" placeholder="電話格式"></asp:TextBox>
            </div>
            <div class="col-sm-6">
                <asp:Label ID="Label11" CssClass="col-form-label text-right col-1" runat="server" Text="地址"></asp:Label>
                <asp:TextBox ID="TextBox9" CssClass="form-control form-control-user" runat="server" placeholder="地址"></asp:TextBox>
            </div>
        </div>
        <br />
        <div class="form-group row">
            <div class="col-sm-6 mb-3 mb-sm-0">
                <asp:Label ID="Label12" CssClass="col-form-label text-right col-1" runat="server" Text="電子信箱"></asp:Label>
                <asp:TextBox ID="TextBox10" CssClass="form-control form-control-user" runat="server" placeholder="電子信箱"></asp:TextBox>
            </div>
            <div class="col-sm-3">
                <asp:Label ID="Label13" CssClass="col-form-label text-right col-1" runat="server" Text="狀態"></asp:Label>
                <asp:DropDownList ID="DropDownList2" CssClass="form-control form-control-user" runat="server">
                    <asp:ListItem Value="0">---</asp:ListItem>
                    <asp:ListItem Value="service">在職</asp:ListItem>
                    <asp:ListItem Value="resignation">離職</asp:ListItem>
                </asp:DropDownList>
            </div>
            <div class="col-sm-3">
                <asp:Label ID="Label14" CssClass="col-form-label text-right col-1" runat="server" Text="離職日"></asp:Label>
                <asp:TextBox ID="TextBox11" CssClass="form-control form-control-user" runat="server" TextMode="Date"></asp:TextBox>
            </div>
        </div>
        <br />
        <br />
        <asp:Label ID="Label15" CssClass="col-form-label text-right col-1" runat="server" Text="上傳大頭照"></asp:Label>
        <asp:FileUpload ID="FileUpload1"  class="dropify" data-default-file="" runat="server" />
        <%-- <asp:Image ID="Image1" Width="30%" runat="server" />--%>
        <br />
        <br />
        <asp:HiddenField ID="HiddenField1" runat="server" />

        <%--  <a href="login.html" class="btn btn-primary btn-user btn-block">
                 新增
                </a>--%>
        <asp:Button ID="Button1" CssClass="btn btn-primary btn-user btn-block" runat="server" Text="修改" OnClick="Button1_Click" />
   </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="myScript" runat="Server">
    <script src="../prod/jQuery-Plugin-To-Beautify-File-Inputs-with-Custom-Styles-Dropify/dist/js/dropify.js"></script>
<script >
        $(function () {
            $('.dropify').dropify()
        })

    </script>
</asp:Content>

