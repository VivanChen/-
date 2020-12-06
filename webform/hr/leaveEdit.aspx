<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" %>

<script runat="server">

    protected void Button1_Click(object sender, EventArgs e)
    {
        Leave l = new Leave()
        {
            LeaveID=int.Parse(TextBox1.Text),
            EmployeeID = int.Parse(TextBox2.Text.Substring(1)),
            Name = TextBox3.Text,
            DepartmentID = HiddenField2.Value,
            DepartmentName = TextBox9.Text,
            Category = DropDownList1.Text,
            StartTime = TextBox5.Text,
            EndTime = TextBox6.Text,
            Hours = int.Parse(TextBox7.Text),
            Reason = TextBox8.Text
        };
        LeaveUtility.UpdateLeave(l);
        //視窗會跳出 "Name"請假單送出。
        Response.Redirect("~/hr/leaveList.aspx");
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Page.IsPostBack == false)
        {
            int id = int.Parse(Request.QueryString["leaveID"]);
            Leave l = LeaveUtility.GetLeavesById(id);

            TextBox1.Text = l.LeaveID.ToString();
            TextBox2.Text ="A"+ l.EmployeeID.ToString().PadLeft(4,'0');
            //視窗會跳出 "Name"請假單送出。
            TextBox3.Text = l.Name;
            DropDownList1.Text = l.Category;
            TextBox9.Text = l.DepartmentName;
            TextBox5.Text = l.StartTime;
            TextBox6.Text = l.EndTime;
            TextBox7.Text = l.Hours.ToString();
            TextBox8.Text = l.Reason;
            HiddenField2.Value = l.DepartmentID;

            //Response.Redirect();檢視視窗
            HiddenField1.Value = l.LeaveID.ToString();
        }
    }
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="myCss" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="myContent" Runat="Server">
    <style>
        body {
        font-family: Microsoft JhengHei ;
        
        }
    </style>

 <div class="container">
         <div class="p-5">
              <div class="text-center">
                  <div class="btn btn-warning btn-circle">
                 <i class="fas fa-info-circle"></i>
                 </div>
                  <h1 class="h4 text-gray-900 mb-4">修改請假單</h1>
              </div>      
          
                <%-- ReadOnly="True"--%>
        <div class="form-group row"> 
            <div class="form-group col-md-3">
                <asp:Label ID="Label2" CssClass="col-form-label text-left col-1" runat="server" Text="請假單號"></asp:Label>
                <asp:TextBox ID="TextBox1" CssClass="form-control col-10 " placeholder="自動帶入" runat="server" ReadOnly="True"></asp:TextBox>&nbsp;
                </div>
                  <div class="form-group col-md-3">
                <asp:Label ID="Label3" CssClass="col-form-label text-right col-1" runat="server" Text="員工編號"></asp:Label>
                <asp:TextBox ID="TextBox2" CssClass="form-control col-10" placeholder="自動帶入" runat="server" ReadOnly="True"></asp:TextBox>&nbsp;
                <%-- ReadOnly="True"--%>
                <br />
                <br />
            </div>
            <div class="form-group col-md-3">
                <asp:Label ID="Label4" CssClass="col-form-label text-right col-1" runat="server" Text="姓名"></asp:Label>
                <asp:TextBox ID="TextBox3" CssClass="form-control col-10" placeholder="自動帶入" runat="server" ReadOnly="True"></asp:TextBox>&nbsp;
                <%-- ReadOnly="True"--%>
                <br />
                <br />
            </div>
          <%--  <div class="form-group col-md-3">
                <asp:Label ID="Label10" CssClass="col-form-label text-right col-1" runat="server" Text="部門ID"></asp:Label>
                <asp:TextBox ID="TextBox9" CssClass="form-control col-10" placeholder="自動帶入" runat="server" ReadOnly="True"></asp:TextBox>
                </div>--%>
            <asp:HiddenField ID="HiddenField2" runat="server" />
            <div class="form-group col-md-3">
                <asp:Label ID="Label10" CssClass="col-form-label text-right col-1" runat="server" Text="部門"></asp:Label>
                <asp:TextBox ID="TextBox9" CssClass="form-control col-10 " placeholder="自動帶入" runat="server" ReadOnly="True"></asp:TextBox>&nbsp;
                <%-- ReadOnly="True"--%>
              
            </div>
    </div>
            <asp:Label ID="Label9"  runat="server" Text="假別:"></asp:Label>
            <asp:DropDownList ID="DropDownList1" CssClass="form-control" runat="server">
                <asp:ListItem>----</asp:ListItem>
                <asp:ListItem Value="病假">病假</asp:ListItem>
                <asp:ListItem Value="事假">事假</asp:ListItem>
                <asp:ListItem Value="年假">年假</asp:ListItem>
                <asp:ListItem Value="喪假">喪假</asp:ListItem>
                <asp:ListItem Value="產假">產假</asp:ListItem>
                <asp:ListItem Value="其他">其他</asp:ListItem>
            </asp:DropDownList>
        <br />
        <br />
            <asp:Label ID="Label5" runat="server" Text="開始時間:"></asp:Label>
          
            <asp:TextBox ID="TextBox5" CssClass="form-control" runat="server" TextMode="Date"></asp:TextBox>
            <br />
            <br />
            <asp:Label ID="Label6" runat="server" Text="結束時間:"></asp:Label>
            
            <asp:TextBox ID="TextBox6" CssClass="form-control" runat="server" TextMode="Date"></asp:TextBox>
            <br />

            <br />
            <asp:Label ID="Label7" runat="server" Text="時數"></asp:Label>
            <asp:TextBox ID="TextBox7" CssClass="form-control" runat="server" TextMode="Number"></asp:TextBox>
            <br />
            <br />
            <asp:Label ID="Label8" runat="server" Text="事由"></asp:Label>
            <asp:TextBox ID="TextBox8" CssClass="form-control" runat="server" TextMode="MultiLine"></asp:TextBox>
            <input type="button" id="Button2" class="btn btn-danger" value="DEMO"/>
            <br />
            <br />
            <div class="form-group">
                <asp:Button ID="Button1" CssClass="form-control btn btn-primary" runat="server" Text="送出" OnClick="Button1_Click" />
            </div>
            <br />
            
     </div>
            <asp:HiddenField ID="HiddenField1" runat="server" />

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="myScript" Runat="Server">
     <script>
         $(function () {
             $("#Button2").click(function () {
                 $("#myContent_TextBox8").val("頭痛");
             })
         })
          </script>
</asp:Content>

