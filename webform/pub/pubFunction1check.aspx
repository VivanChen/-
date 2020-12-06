<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" %>

<script runat="server">

    protected void Page_Load(object sender, EventArgs e)
    {

        if (Page.IsPostBack == false)
        {

            Repeater1.DataSource = PunchcardsUtility.FindAllPunchcardsById(Convert.ToInt32(HttpContext.Current.User.Identity.Name));
            Repeater1.DataBind();
            int punchcardid = Convert.ToInt32(Request.QueryString["id"]);
            if (punchcardid==0)
            {
                TextBox1.Text = "";
                TextBox2.Text = "";
                TextBox3.Text = "";
                HiddenDate.Value = "";
                TextBox4.Text = "";
                TextBox5.Text = "";
                TextBox6.Text = "";
            }
            else
            {
                Punchcard pp = PunchcardsUtility.FindAllPunchcardsByPunchcardID(punchcardid);
                TextBox1.Text = "A" + pp.Id.ToString().PadLeft(4, '0');
                TextBox2.Text = pp.Name;
                TextBox3.Text = pp.DepartmentID;
                HiddenDate.Value = pp.Date;
                TextBox4.Text = pp.Punchin;
                TextBox5.Text = pp.Punchout;
                TextBox6.Text = pp.Hours;
            }

            //Repeater1.DataSource = CheckPunchcardsUtility.FindCheckPunchcardById(Convert.ToInt32(HttpContext.Current.User.Identity.Name));
            //Repeater1.DataBind();
        }


    }

    protected void Button1_Click(object sender, EventArgs e)
    {
        TextBox4.Visible = false;
        TextBox8.Visible = true;
        Button1.Visible = false;
        Button2.Visible = true;
        Button3.Visible = true;
        //Label1.Text = 

    }

    protected void Button2_Click(object sender, EventArgs e)
    {
        TextBox4.Text=Convert.ToDateTime(TextBox8.Text).ToString();
        TextBox4.Visible = true;
        TextBox8.Visible = false;
        Button1.Visible = true;
        Button2.Visible = false;
        Button3.Visible = false;
        DateTime Punchin = Convert.ToDateTime(TextBox4.Text);
        DateTime Punchout = Convert.ToDateTime(TextBox5.Text);
        TimeSpan PunchCount = Punchout.Subtract(Punchin);
        double TotalHours = PunchCount.TotalHours;
        TextBox6.Text = TotalHours.ToString("#0.00");
    }

    protected void Button3_Click(object sender, EventArgs e)
    {
        TextBox4.Visible = true;
        TextBox8.Visible = false;
        Button1.Visible = true;
        Button2.Visible = false;
        Button3.Visible = false;
    }

    protected void Button4_Click(object sender, EventArgs e)
    {
        TextBox5.Visible = false;
        TextBox9.Visible = true;
        Button4.Visible = false;
        Button5.Visible = true;
        Button6.Visible = true;
    }

    protected void Button5_Click(object sender, EventArgs e)
    {
        TextBox5.Text=Convert.ToDateTime(TextBox9.Text).ToString();
        TextBox5.Visible = true;
        TextBox9.Visible = false;
        Button4.Visible = true;
        Button5.Visible = false;
        Button6.Visible = false;
        DateTime Punchin = Convert.ToDateTime(TextBox4.Text);
        DateTime Punchout = Convert.ToDateTime(TextBox5.Text);
        TimeSpan PunchCount = Punchout.Subtract(Punchin);
        double TotalHours = PunchCount.TotalHours;
        TextBox6.Text = TotalHours.ToString("#0.00");
    }

    protected void Button6_Click(object sender, EventArgs e)
    {
        TextBox5.Visible = true;
        TextBox9.Visible = false;
        Button4.Visible = true;
        Button5.Visible = false;
        Button6.Visible = false;
    }

    protected void SendtoCheck_btn_Click(object sender, EventArgs e)
    {

        CheckPunchcards cp = new CheckPunchcards()
        {
            EmployeeID = Convert.ToInt32(TextBox1.Text.Substring(1)),
            Name = TextBox2.Text,
            DepartmentID = TextBox3.Text,
            Date = HiddenDate.Value,
            Punchin = TextBox4.Text,
            Punchout = TextBox5.Text,
            Hours = TextBox6.Text,
            Reason = TextBox7.Text,
            CheckPunchcard="審核中"
        };
        CheckPunchcardsUtility.InsertCheckPunchcard(cp);
        Response.Redirect("pubFunction1checking.aspx");


    }

    protected void BacktopubFunction1_Click(object sender, EventArgs e)
    {
        Response.Redirect("pubFunction1.aspx");
    }

    //protected void Button7_Click(object sender, EventArgs e)
    //{
    //    Employee emp = EmployeeUtility.GetEmployeesById(Convert.ToInt32(HttpContext.Current.User.Identity.Name));
    //    TextBox1.Text =  "A" + emp.EmployeeID.ToString().PadLeft(4, '0');
    //    TextBox2.Text = emp.Name;
    //    TextBox3.Text = emp.DepartmentName;

    //}
</script>
<asp:Content ID="Content2" ContentPlaceHolderID="myCss" runat="Server">
</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="myContent" runat="Server">
    <!-- Begin Page Content -->
    <div class="container-fluid">

        <!-- Page Heading -->
        <h1 class="h3 mb-4 text-gray-800">送審系統</h1>

        <div class="row">
            
            <!--start-->
            <div class="col-lg-6">

                <div class="card shadow mb-4">
                    <div class="card-header py-3">
                        <h6 class="m-0 font-weight-bold text-primary">本月份打卡資訊</h6>
                    </div>
                    <div class="card-body">
                        <div class="table-responsive">
                            <asp:Repeater ID="Repeater1" runat="server">
                                <HeaderTemplate>
                                    <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                                        <thead>
                                            <tr>
<%--                                                <th>編號</th>
                                                <th>姓名</th>
                                                <th>部門代號</th>
                                                <th>日期</th>--%>
                                                <th>上班時間</th>
                                                <th>下班時間</th>
                                                <th>時數</th>
                                                <th>功能</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                </HeaderTemplate>
                                <ItemTemplate>
                                        <tr>
<%--                                            <td><%# Eval("Id") %></td>
                                            <td><%# Eval("Name") %></td>
                                            <td><%# Eval("DepartmentID") %></td>
                                            <td><%# Eval("Date") %></td>--%>
                                            <td><%# Eval("Punchin") %></td>
                                            <td><%# Eval("Punchout") %></td>
                                            <td><%# Eval("Hours") %></td>
                                            <td>
                                                <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl='<%# Eval("PunchcardID", "pubFunction1check.aspx?Id={0}") %>'><i class="fa fa-arrow-right"></i></asp:HyperLink>
                                            </td>
                                        </tr>
                                </ItemTemplate>
                                <FooterTemplate>                                   
                                    </tbody>
                                    </table>
                                </FooterTemplate>
                            </asp:Repeater>
                        </div>
                    </div>
                </div>

            </div>
            <!--/end-->
            <div class="col-lg-6">

                <!-- Circle Buttons -->
                <div class="card shadow mb-4">
                    <div class="card-header py-3">
                        <h6 class="m-0 font-weight-bold text-primary">送審資訊</h6>
                    </div>
                    <div class="card-body">
                        <p>
                            打卡修改審核流程說明:<br/>
                               代入打卡資訊 > 修改上下班時間 > 可附上說明或相關證明文件 > 並由主管審核後修改。
                        </p>
<%--                        <div style="text-align:right;"><asp:Button ID="Button7" runat="server" Text="預先打卡" CssClass="btn btn-warning " OnClick="Button7_Click" /></div>--%>
<%--                        <br/>--%>
                        <!-- Circle Buttons (Default) -->
                        工號:
                        <asp:TextBox ID="TextBox1" runat="server" CssClass="form-control" ReadOnly="True"></asp:TextBox>
                        <asp:HiddenField ID="HiddenField1" runat="server" />
                        姓名:
                        <asp:TextBox ID="TextBox2" runat="server" CssClass="form-control " ReadOnly="True"></asp:TextBox>
                        部門:
                        <asp:TextBox ID="TextBox3" runat="server" CssClass="form-control " ReadOnly="True"></asp:TextBox>
                        <asp:HiddenField ID="HiddenDate" runat="server" />
                        上班時間:
                        <asp:TextBox ID="TextBox4" runat="server" CssClass="form-control "  ReadOnly="True"></asp:TextBox>
                        <asp:TextBox ID="TextBox8" runat="server" CssClass="form-control " TextMode="DateTimeLocal" Visible="false"></asp:TextBox>
                        <asp:Button ID="Button1" runat="server" Text="修改" onclick="Button1_Click" CssClass="btn btn-primary"/>
                        <asp:Button ID="Button2" runat="server" Text="完成" onclick="Button2_Click" CssClass="btn btn-info" Visible="false"/>
                        <asp:Button ID="Button3" runat="server" Text="取消" onclick="Button3_Click" CssClass="btn btn-danger" Visible="false"/>
                        <br/>
                        下班時間:
                        <asp:TextBox ID="TextBox5" runat="server" CssClass="form-control "  ReadOnly="True"></asp:TextBox>                     
                        <asp:TextBox ID="TextBox9" runat="server" CssClass="form-control " TextMode="DateTimeLocal" Visible="false"></asp:TextBox>
                        <asp:Button ID="Button4" runat="server" Text="修改" onclick="Button4_Click" CssClass="btn btn-primary"/>
                        <asp:Button ID="Button5" runat="server" Text="完成" onclick="Button5_Click" CssClass="btn btn-info" Visible="false"/>
                        <asp:Button ID="Button6" runat="server" Text="取消" onclick="Button6_Click"  CssClass="btn btn-danger" Visible="false"/>
                        <br/>
                        時數:
                        <asp:TextBox ID="TextBox6" runat="server" CssClass="form-control form-control-user" ReadOnly="True"></asp:TextBox>
                        說明:
                        <asp:TextBox ID="TextBox7" runat="server" CssClass="form-control form-control-user" TextMode="MultiLine" ></asp:TextBox>
                        <input type="button" id="punchcarddemo_btn" value="DEMO" class="btn btn-sm btn-info"/>
                        <hr/>
                        <asp:Button ID="SendtoCheck_btn" runat="server" Text="送審" OnClick="SendtoCheck_btn_Click" CssClass="btn btn-success"/>
                        <asp:Button ID="BacktopubFunction1" runat="server" Text="返回" OnClick="BacktopubFunction1_Click" CssClass="btn btn-danger"/>
                    </div>
                </div>



            </div>



        </div>

    </div>
    <!-- /.container-fluid -->
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="myScript" runat="Server">
    <script>
        $(function () {
            $("#punchcarddemo_btn").click(function () {
                $("#myContent_TextBox7").val("忘記打卡");
            });
        });
    </script>
</asp:Content>

