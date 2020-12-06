<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" %>

<script runat="server">

    protected void Button1_Click(object sender, EventArgs e)
    {
        //TextBox8.Text = TextBox4.Text+TextBox1.Text.PadLeft(4, '0');
        Employee emp = new Employee()
        {
            //EmployeeID = int.Parse(TextBox1.Text),
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
            EndDate = TextBox11.Text,
            Status = DropDownList2.SelectedItem.Text,
            ImageFileName = FileUpload1.FileName,
        };
        EmployeeUtility.InsertEmployee(emp);
        Response.Redirect("employeeList.aspx");
    }

    protected void DropDownList3_SelectedIndexChanged(object sender, EventArgs e)
    {
        //TextBox5.Text = DropDownList3.SelectedValue;
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!User.IsInRole("hr"))
        {
            Response.Redirect("~/AuthorityInfo.aspx");
        }
    }

    protected void Button2_Click(object sender, EventArgs e)
    {
        //TextBox2.Text = "周小豪";
        //DropDownList1.SelectedItem.Text = "男";
        //TextBox3.Text = "2003-09-01";
        //TextBox4.Text = "A";
        //TextBox5.Text = "A133443567";
        //DropDownList3.SelectedItem.Text = "人資部";
        //TextBox6.Text = "2016-12-30";
        //TextBox7.Text = "3567";
        //TextBox8.Text = "0916-168-168";
        //TextBox9.Text = "台北市信義區基隆路一段155-1號";
        //TextBox10.Text = "nick@protek.com.tw";
        //TextBox11.Text = "";
        //DropDownList2.SelectedItem.Text = "在職";

    }

    protected void TextBox5_TextChanged(object sender, EventArgs e)
    {
        string passwoed = TextBox5.Text;
        TextBox7.Text = passwoed.Substring(6, 4);
    }

    //protected void Button3_Click(object sender, EventArgs e)
    //{
    //    Label16.Text = "HELLO~~";
    //}
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="myCss" runat="Server">
  <%--  <link href="../prod/jQuery-Plugin-To-Beautify-File-Inputs-with-Custom-Styles-Dropify/dist/css/demo.css" rel="stylesheet" />--%>
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
                <h1 class="h4 text-gray-900 mb-4 ">新增員工資料</h1>
            </div>
        </div>
        <div class="form-group row">
            <div class="col-sm-3 mb-3 mb-sm-0">
                <%-- <asp:Label ID="Label16" runat="server" Text="Label"></asp:Label>--%>
                <asp:Label ID="Label1" CssClass="col-form-label text-right col-1" runat="server" Text="員工ID"></asp:Label>
                <asp:TextBox ID="TextBox1" CssClass="form-control form-control-user" ReadOnly="True" runat="server" placeholder="自動新增"></asp:TextBox>
            </div>
            <div class="col-sm-3">
                <asp:Label ID="Label2" CssClass="col-form-label text-right col-1" runat="server" Text="姓名"></asp:Label>
                <asp:TextBox ID="TextBox2" CssClass="form-control form-control-user" runat="server" placeholder="填入姓名"></asp:TextBox>
                <asp:RequiredFieldValidator CssClass="ErrorMessage" ErrorMessage="*姓名不可空白" ControlToValidate="TextBox2" runat="server" ForeColor="Red" SetFocusOnError="True" Display="Static" />
            </div>
            <div class="col-sm-3">
                <asp:Label ID="Label3" CssClass="col-form-label text-right col-1" runat="server" Text="性別"></asp:Label>
                <asp:DropDownList ID="DropDownList1" CssClass="form-control form-control-user" runat="server">
                    <asp:ListItem Value="0">---</asp:ListItem>
                    <asp:ListItem Value="male">男</asp:ListItem>
                    <asp:ListItem Value="female">女</asp:ListItem>
                </asp:DropDownList>
                <asp:RequiredFieldValidator CssClass="ErrorMessage" ErrorMessage="*請選擇性別" ControlToValidate="DropDownList1" runat="server" ForeColor="Red" SetFocusOnError="True" Display="Static" InitialValue="0" />
            </div>
            <div class="col-sm-3">
                <asp:Label ID="Label4" CssClass="col-form-label text-right col-1" runat="server" Text="生日"></asp:Label>
                <asp:TextBox ID="TextBox3" CssClass="form-control form-control-user" runat="server" TextMode="Date"></asp:TextBox>
                <asp:RequiredFieldValidator CssClass="ErrorMessage" ErrorMessage="*生日不可空白" ControlToValidate="TextBox3" runat="server" ForeColor="Red" Type="Date" operator="datetypecheck" />
            </div>
        </div>
        <br />

        <div class="form-group row">
            <div class="col-sm-3 mb-3 mb-sm-0">
                <asp:Label ID="Label5" CssClass="col-form-label text-right col-1" runat="server" Text="ID編號"></asp:Label>
                <%-- <asp:TextBox ID="TextBox4" CssClass="form-control form-control-user" runat="server" placeholder="選單"></asp:TextBox>--%>
                <asp:TextBox ID="TextBox4" CssClass="form-control form-control-user" runat="server" Text="A" ReadOnly="true"></asp:TextBox>

            </div>
            <div class="col-sm-3">
                <asp:Label ID="Label6" CssClass="col-form-label text-right col-1" runat="server" Text="部門名稱"></asp:Label>
                <asp:DropDownList ID="DropDownList3" CssClass="form-control form-control-user" runat="server" AutoPostBack="True" OnSelectedIndexChanged="DropDownList3_SelectedIndexChanged">
                    <asp:ListItem Value="0">---</asp:ListItem>
                    <asp:ListItem Value="管理部">管理部</asp:ListItem>
                    <asp:ListItem Value="人資部">人資部</asp:ListItem>
                    <asp:ListItem Value="產品部">產品部</asp:ListItem>
                </asp:DropDownList>
                <asp:RequiredFieldValidator ErrorMessage="*部門不可空白" ControlToValidate="DropDownList3" runat="server" ForeColor="Red" SetFocusOnError="True" Display="Static" InitialValue="0" />
            </div>
            <div class="col-sm-3">
                <asp:Label ID="Label15" CssClass="col-form-label text-right col-1" runat="server" Text="身份證字號"></asp:Label>
                <asp:TextBox ID="TextBox5" CssClass="form-control form-control-user" runat="server" placeholder="身份證字號" MaxLength="10" AutoPostBack="True" OnTextChanged="TextBox5_TextChanged"></asp:TextBox>
                <%----%>
                <asp:RequiredFieldValidator CssClass="ErrorMessage" ErrorMessage="*必填欄位" ControlToValidate="TextBox5" runat="server" ForeColor="Red" SetFocusOnError="True" Display="Static" />
            </div>
            <div class="col-sm-3">
                <asp:Label ID="Label7" CssClass="col-form-label text-right col-1" runat="server" Text="到職日"></asp:Label>
                <asp:TextBox ID="TextBox6" CssClass="form-control form-control-user" runat="server" TextMode="Date"></asp:TextBox>
                <asp:RequiredFieldValidator ErrorMessage="*到職日不可空白" ControlToValidate="TextBox6" runat="server" ForeColor="Red" Type="Date" operator="datetypecheck" />
            </div>
        </div>
        <br />
        <div class="form-group row">
            <div class="col-sm-3 mb-3 mb-sm-0">
                <asp:Label ID="Label9" CssClass="col-form-label text-right col-1" runat="server" Text="密碼"></asp:Label>
                <asp:TextBox ID="TextBox7" CssClass="form-control form-control-user" runat="server" placeholder="預設身份證字號後4碼" TextMode="SingleLine"></asp:TextBox>
                <asp:RequiredFieldValidator ErrorMessage="*必填欄位" ControlToValidate="TextBox7" runat="server" ForeColor="Red" />
            </div>
            <div class="col-sm-3">
                <asp:Label ID="Label10" CssClass="col-form-label text-right col-1" runat="server" Text="電話"></asp:Label>
                <asp:TextBox ID="TextBox8" CssClass="form-control form-control-user" runat="server" placeholder="電話格式" TextMode="Phone"></asp:TextBox>
                <asp:RequiredFieldValidator ErrorMessage="*電話不可空白" ControlToValidate="TextBox8" runat="server" ForeColor="Red" SetFocusOnError="True" Display="Static" />
            </div>
            <div class="col-sm-6">
                <asp:Label ID="Label11" CssClass="col-form-label text-right col-1" runat="server" Text="地址"></asp:Label>
                <asp:TextBox ID="TextBox9" CssClass="form-control form-control-user" runat="server" placeholder="地址"></asp:TextBox>
                <asp:RequiredFieldValidator ErrorMessage="*地址不可空白" ControlToValidate="TextBox9" runat="server" ForeColor="Red" SetFocusOnError="True" Display="Static" />
            </div>
        </div>
        <br />
        <div class="form-group row">
            <div class="col-sm-6 mb-3 mb-sm-0">
                <asp:Label ID="Label12" CssClass="col-form-label text-right col-1" runat="server" Text="電子信箱"></asp:Label>
                <asp:TextBox ID="TextBox10" CssClass="form-control form-control-user" runat="server" placeholder="電子信箱" TextMode="Email"></asp:TextBox>
                <asp:RequiredFieldValidator ErrorMessage="*電子信箱不可空白" ControlToValidate="TextBox10" runat="server" ForeColor="Red" SetFocusOnError="True" Display="Static" />
            </div>
            <div class="col-sm-3">
                <asp:Label ID="Label13" CssClass="col-form-label text-right col-1" runat="server" Text="狀態"></asp:Label>
                <asp:DropDownList ID="DropDownList2" CssClass="form-control form-control-user" runat="server">
                    <asp:ListItem Value="0">---</asp:ListItem>
                    <asp:ListItem Value="service">在職</asp:ListItem>
                    <asp:ListItem Value="resignation">離職</asp:ListItem>
                </asp:DropDownList>
                <asp:RequiredFieldValidator ErrorMessage="*狀態不可空白" ControlToValidate="DropDownList2" runat="server" ForeColor="Red" SetFocusOnError="True" Display="Static" InitialValue="0" />
            </div>
            <div class="col-sm-3">
                <asp:Label ID="Label8" CssClass="col-form-label text-right col-1" runat="server" Text="離職日"></asp:Label>
                <asp:TextBox ID="TextBox11" CssClass="form-control form-control-user" runat="server" TextMode="Date"></asp:TextBox>
            </div>
        </div>
        <br />
        <asp:Label ID="Label14" CssClass="col-form-label text-right col-1" runat="server" Text="上傳大頭照"></asp:Label>
        <asp:FileUpload ID="FileUpload1" class="dropify" data-default-file="" runat="server" />
        <%-- <asp:FileUpload ID="FileUpload2"  CssClass="form-control form-control-user"  runat="server" />--%>
        <br />
        <div>
            <asp:Button ID="Button2" CssClass="btn btn-danger " runat="server" Text="DEMO" OnClientClick="Button2_Click" />
        </div>
        <%-- btn-icon-split--%>
        <br />
        <asp:Button ID="Button1" CssClass="btn btn-primary btn-user btn-block" runat="server" Text="新增" OnClick="Button1_Click" />
    </div>
    <%-- <asp:Button ID="Button3" runat="server" Text="Button" OnClick="Button3_Click" />--%>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="myScript" runat="Server">
    <%--引用uploadfile start--%>
    <script src="../prod/jQuery-Plugin-To-Beautify-File-Inputs-with-Custom-Styles-Dropify/dist/js/dropify.js"></script>
    <script type="text/javascript">
        $(function () {
            $("#myContent_Button2").click(function () {
                $("#myContent_TextBox2").val("周小豪");
                $("#myContent_DropDownList1").val("male");
                $("#myContent_TextBox3").val("2003-09-01");
                $("#myContent_DropDownList3").val("人資部");
                $("#myContent_TextBox5").val("A133443567");
                $("#myContent_TextBox6").val("2016-12-30");
                $("#myContent_TextBox8").val("0916-168-168");
                $("#myContent_TextBox9").val("台北市信義區基隆路一段155-1號");
                $("#myContent_TextBox10").val("nick@protek.com.tw");
                $("#myContent_DropDownList2").val("service");
            })

            $('.dropify').dropify()
        })

    </script>
</asp:Content>

