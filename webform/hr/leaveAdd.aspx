<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" %>

<script runat="server">


    protected void Button1_Click(object sender, EventArgs e)
    {
        //送Leave和Audit資料庫
        Leave l = new Leave()
        {
            //LeaveID = int.Parse(TextBox1.Text),
            EmployeeID = int.Parse(TextBox2.Text.Substring(1)),
            Name = TextBox3.Text,
            DepartmentID = HiddenField1.Value,
            DepartmentName = TextBox4.Text,
            Category = DropDownList1.SelectedItem.Text,
            StartTime = TextBox5.Text,
            EndTime = TextBox6.Text,
            Hours = int.Parse(TextBox7.Text),
            Reason = TextBox8.Text,
            Status="審核中"
        };

        LeaveUtility.InsertLeave(l);

        Response.Redirect("leaveList.aspx");
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        //連資料庫 依照登入的EmployeeID 自動帶入
        //EmployeeID' Name' DepartmantID' DepatmantName
        if (Page.IsPostBack == false)
        {
            if (HttpContext.Current.User.Identity.IsAuthenticated)
            {
                int id = Convert.ToInt32(HttpContext.Current.User.Identity.Name);
                Leave l = LeaveUtility.GetLeavesByEmployeeId(id);
                TextBox2.Text = "A" + l.EmployeeID.ToString().PadLeft(4, '0');
                //TextBox2.Text = l.EmployeeID.ToString();
                TextBox3.Text = l.Name;
                HiddenField1.Value = l.DepartmentID;
                TextBox4.Text = l.DepartmentName;

            }
        }
    }
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="myCss" runat="Server">
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
              <h1 class="h4 text-gray-900 mb-4">新增請假單</h1>
            </div>
        </div>
   
        <div class="form-group row"> 
            <div class="form-group col-md-3">
                <asp:Label ID="Label1" CssClass="col-form-label text-left col-1" runat="server" Text="請假單號"></asp:Label>
                <asp:TextBox ID="TextBox1" CssClass="form-control col-10 " placeholder="自動帶入" runat="server" ReadOnly="True"></asp:TextBox>&nbsp;
                </div>
                  <div class="form-group col-md-3">
                <asp:Label ID="Label2" CssClass="col-form-label text-right col-1" runat="server" Text="員工編號"></asp:Label>
                <asp:TextBox ID="TextBox2" CssClass="form-control col-10" placeholder="自動帶入" runat="server" ReadOnly="True"></asp:TextBox>&nbsp;
                <%-- ReadOnly="True"--%>
                <br />
                <br />
            </div>
            <div class="form-group col-md-3">
                <asp:Label ID="Label3" CssClass="col-form-label text-right col-1" runat="server" Text="姓名"></asp:Label>
                <asp:TextBox ID="TextBox3" CssClass="form-control col-10" placeholder="自動帶入" runat="server" ReadOnly="True"></asp:TextBox>&nbsp;
                <%-- ReadOnly="True"--%>
                <br />
                <br />
            </div>
          <%--  <div class="form-group col-md-3">
                <asp:Label ID="Label10" CssClass="col-form-label text-right col-1" runat="server" Text="部門ID"></asp:Label>
                <asp:TextBox ID="TextBox9" CssClass="form-control col-10" placeholder="自動帶入" runat="server" ReadOnly="True"></asp:TextBox>
                </div>--%>
                 
    
            <div class="form-group col-md-3">
                <asp:Label ID="Label4" CssClass="col-form-label text-right col-1" runat="server" Text="部門"></asp:Label>
                <asp:TextBox ID="TextBox4" CssClass="form-control col-10 " placeholder="自動帶入" runat="server" ReadOnly="True"></asp:TextBox>&nbsp;
                <%-- ReadOnly="True"--%>
                <asp:HiddenField ID="HiddenField1" runat="server" />
            </div>
    </div>
    <asp:Label ID="Label9"  runat="server" Text="假別"></asp:Label>
            <asp:DropDownList ID="DropDownList1" CssClass="form-control" runat="server">
           
                <asp:ListItem>----</asp:ListItem>
                <asp:ListItem Value="sick">病假</asp:ListItem>
                <asp:ListItem Value="personal">事假</asp:ListItem>
                <asp:ListItem Value="special">年假</asp:ListItem>
                <asp:ListItem Value="funeral">喪假</asp:ListItem>
                <asp:ListItem Value="prematernity">產假</asp:ListItem>
                <asp:ListItem Value="other">其他</asp:ListItem>
            </asp:DropDownList>
        <asp:RequiredFieldValidator
            CssClass="ErrorMessage" 
            ErrorMessage="假別必須選擇" 
            InitialValue="未選擇" 
            ControlToValidate="DropDownList1"
            runat="server" 
            ForeColor="Red">*</asp:RequiredFieldValidator>

        <br />
        <br />
        <asp:Label ID="Label5" runat="server" Text="開始時間"></asp:Label>
        <asp:TextBox ID="TextBox5" CssClass="form-control" runat="server" TextMode="Date"></asp:TextBox>
        <br />
        <br />
        <asp:Label ID="Label6" runat="server" Text="結束時間"></asp:Label>
        <asp:TextBox ID="TextBox6" CssClass="form-control" runat="server" TextMode="Date"></asp:TextBox>
        <br />

        <br />
        <asp:Label ID="Label7" runat="server" Text="時數"></asp:Label>
        <asp:TextBox ID="TextBox7" CssClass="form-control" runat="server" TextMode="Number"></asp:TextBox>
        <br />
        <br />
        <asp:Label ID="Label8" runat="server" Text="事由"></asp:Label>
        <asp:TextBox ID="TextBox8" CssClass="form-control" runat="server" TextMode="MultiLine"></asp:TextBox>
        <br />
        <br />
        <div class="form-group">
<%--            <asp:Button ID="Button2"  CssClass="btn btn-danger " runat="server" Text="DEMO" OnClientClick="Button2_Click" />--%>
            <input type="button" id="Button2" class="btn btn-danger" value="DEMO"/>
        </div>
        <br />
        <div class="form-group">
            <asp:Button ID="Button1" CssClass="form-control btn btn-primary" runat="server" Text="送出" OnClick="Button1_Click" />
        </div>
        <br />
    </div> 
     
    
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="myScript" runat="Server">
     <script>
         $(function () {
             $("#Button2").click(function () {
                 $("#myContent_DropDownList1").val("sick");
                 $("#myContent_TextBox5").val("2020-07-29");
                 $("#myContent_TextBox6").val("2020-07-29");
                 $("#myContent_TextBox7").val("8");
                 $("#myContent_TextBox8").val("感冒");
             })
         })
          </script>
</asp:Content>

