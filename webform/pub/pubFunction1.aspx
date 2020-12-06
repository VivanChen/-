<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" %>

<script runat="server">

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Page.IsPostBack == false)
        {
            if (HttpContext.Current.User.Identity.IsAuthenticated)
            {
                //將cookie存取的User.Identity送至資料庫抓取員工資料
                Employee emp = EmployeesUtility.FindEmployeeById(Convert.ToInt32(HttpContext.Current.User.Identity.Name));
                TextBox1.Text = emp.DepartmentID + emp.EmployeeID.ToString().PadLeft(4, '0');
                TextBox2.Text = emp.Name;
                TextBox3.Text = emp.DepartmentName;
                HiddenField1.Value = emp.EmployeeID.ToString();
                HiddenField2.Value = emp.DepartmentName;
                Button2.Visible = false;

                Repeater1.DataSource = PunchcardsUtility.FindAllPunchcardsById(Convert.ToInt32(HttpContext.Current.User.Identity.Name));
                Repeater1.DataBind();
                Punchcard pun = PunchcardsUtility.FindPunchcardById(Convert.ToInt32(HttpContext.Current.User.Identity.Name));
                if (pun != null)
                {
                    TextBox4.Text = pun.Punchin;
                    Button1.Visible = false;
                    TextBox5.Text = pun.Punchout;
                    if (TextBox5.Text != "")
                    {
                        Button2.Visible = false;
                        TextBox6.Text = pun.Hours.ToString();
                    }
                    else
                    {
                        DateTime ptimecheck = DateTime.Now;
                        DateTime Prepintime = Convert.ToDateTime(pun.Punchin).AddHours(8.0);            //上班卡時間加上8小時，即為預計的可下班時間
                        DateTime Prepouttime = Convert.ToDateTime(ptimecheck.ToString()).AddHours(8.0); //抓取現在時間，測試，所以先幫現在時間加上8小時，以此為判斷依據是否顯示下班打卡的按鈕

                        //TimeSpan PunchCount = Prepouttime.Subtract(Prepintime);
                        //double TotalHours = PunchCount.TotalHours;
                        //double CompleteProgressbar = (TotalHours / 8) * 100;
                        //TimeSpan prepcount = prepoutime.Subtract(Prepintime);
                        //double CheckHours = prepcount.TotalHours;

                        //判讀現在的時間是否等於 上班時間加上8小時 或是大於上班時間加上8小時，若為true即可顯示下班打卡的Button
                        if (Prepouttime >= Prepintime)
                        {
                            Button2.Visible = true;
                        }
                        else
                        {
                            Button2.Visible = false;
                        }
                    }
                }
                else
                {
                    TextBox4.Text = "";
                }
            }
        }
    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        //TextBox4.Text = DateTime.Now.ToString();
        DateTime pin = DateTime.Now;
        //TextBox4.Text = DateTime.Now.ToString();
        TextBox4.Text = pin.ToString();
        TextBox4.ReadOnly = true;
        Button1.Visible = false;
        Label1.Text = "上班時間已送至資料庫，如需修改請聯絡管理人員";

        Punchcard punch = new Punchcard()
        {
            Id = Convert.ToInt32(TextBox1.Text.Substring(1)),
            Name = TextBox2.Text,
            DepartmentID = HiddenField2.Value,
            Date = pin.Date.ToShortDateString().ToString(),
            Punchin = pin.ToString(),
            Punchout = "",
            Hours = "0",
        };
        PunchcardsUtility.InsertPunchcard(punch);
        Response.Redirect("pubFunction1.aspx");
    }


    protected void Button2_Click(object sender, EventArgs e)
    {

        DateTime pout = DateTime.Now;
        //TextBox5.Text = pout.ToString();                    //正式用 抓取 電腦時間
        //TextBox5.Text = "2020/06/22 下午 09:23:00";  //測試用 寫死
        TextBox5.Text = pout.AddHours(8).ToString();   //測試用 ，可調整下班時間，正式用需拿掉AddHours(8)
        TextBox5.ReadOnly = true;
        Button2.Visible = false;
        Label2.Text = "下班時間已送至資料庫，如需修改請聯絡管理人員";
        DateTime Punchin = Convert.ToDateTime(TextBox4.Text);
        DateTime Punchout = Convert.ToDateTime(TextBox5.Text);
        TimeSpan PunchCount = Punchout.Subtract(Punchin);
        double TotalHours = PunchCount.TotalHours;
        TextBox6.Text = TotalHours.ToString("#0.00");

        Punchcard punpun = new Punchcard()
        {
            Id = Convert.ToInt32(TextBox1.Text.Substring(1)),
            Name = TextBox2.Text,
            DepartmentID = HiddenField2.Value,
            Date = Convert.ToString(Convert.ToDateTime(TextBox4.Text).Date.ToShortDateString().ToString()),
            Punchin = TextBox4.Text,
            Punchout = TextBox5.Text,
            Hours = TextBox6.Text,
        };
        PunchcardsUtility.UpdatePunchcard(punpun);
        Response.Redirect("pubFunction1.aspx");
    }
</script>
<asp:Content ID="Content2" ContentPlaceHolderID="myCss" runat="Server">
</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="myContent" runat="Server">
    <!-- Begin Page Content -->
    <div class="container-fluid">

        <!-- Page Heading -->
        <h1 class="h3 mb-4 text-gray-800">打卡系統</h1>

        <div class="row">

            <div class="col-lg-6">

                <!-- Circle Buttons -->
                <div class="card shadow mb-4">
                    <div class="card-header py-3">
                        <h6 class="m-0 font-weight-bold text-primary">打卡資訊</h6>
                    </div>
                    <div class="card-body">
                        <p>
                            親愛的同仁，您好：
                               為維護您的權益，上下班請記得準時打卡，謝謝您的配合。
                        </p>
                        <!-- Circle Buttons (Default) -->
                        工號:
                        <asp:TextBox ID="TextBox1" runat="server" CssClass="form-control form-control-user" ReadOnly="True"></asp:TextBox>
                        <asp:HiddenField ID="HiddenField1" runat="server" />
                        姓名:
                        <asp:TextBox ID="TextBox2" runat="server" CssClass="form-control form-control-user" ReadOnly="True"></asp:TextBox>
                        部門:
                        <asp:TextBox ID="TextBox3" runat="server" CssClass="form-control form-control-user" ReadOnly="True"></asp:TextBox>
                        <asp:HiddenField ID="HiddenField2" runat="server" />
                        上班時間:
                        <asp:TextBox ID="TextBox4" runat="server" CssClass="form-control form-control-user" ReadOnly="True"></asp:TextBox>
                        <asp:Label ID="Label1" runat="server" ForeColor="#3399FF"></asp:Label>
                        <asp:Button ID="Button1" runat="server" Text="上班" CssClass="btn btn-success" OnClick="Button1_Click" />
                        <br />
                        下班時間:
                        <asp:TextBox ID="TextBox5" runat="server" CssClass="form-control form-control-user" ReadOnly="True"></asp:TextBox>
                        <asp:Label ID="Label2" runat="server" ForeColor="#3399FF"></asp:Label>
                        <asp:Button ID="Button2" runat="server" Text="下班" CssClass="btn btn-info" OnClick="Button2_Click" />
                        <br />
                        時數:
                        <asp:TextBox ID="TextBox6" runat="server" CssClass="form-control form-control-user" ReadOnly="True"></asp:TextBox>
                    </div>
                </div>

            </div>

            <div class="col-lg-6">

                <div class="card shadow mb-4">
                    <div class="card-header py-3">
                        <h6 class="m-0 font-weight-bold text-primary">本月份打卡資訊</h6>
                    </div>
                    <div class="card-body">
                        <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="pubFunction1check.aspx" CssClass="btn btn-primary">修改</asp:HyperLink>
                        <hr/>
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
<%--                                            <td></td>--%>
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

        </div>

    </div>
    <!-- /.container-fluid -->
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="myScript" runat="Server">
</asp:Content>

