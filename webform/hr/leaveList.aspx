<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" %>

<script runat="server">

    protected void Page_Load(object sender, EventArgs e)
    {
        int LOGinID = Convert.ToInt32(HttpContext.Current.User.Identity.Name);
        List<Leave> listLeaves = LeaveUtility.GetAllLeave();
        var query = listLeaves.Where(s => s.EmployeeID == LOGinID/* && s.Status != "已通過"*/).ToList();
        //Repeater1.DataSource = LeaveUtility.GetAllLeave();
        Repeater1.DataSource = query;
        Repeater1.DataBind();
        //Repeater2.DataSource = query;
        //Repeater2.DataBind();
        string[] arr = { "Label1" };

        int count = 0;
        foreach (var s in arr)
        {

            foreach (RepeaterItem items1 in Repeater1.Items)
            {
                Label link = Common.FindControl<Label>(items1, "Label1");

                if (link.Text == "已通過" || link.Text == "未通過")
                {



                    HyperLink link2 = Common.FindControl<HyperLink>(items1, "HyperLink1");
                    link2.Visible = false;

                    HyperLink link3 = Common.FindControl<HyperLink>(items1, "HyperLink2");
                    link3.Visible = false;








                }



            }


        }
    }
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="myCss" runat="Server">
    <link href="../vendor/datatables/dataTables.bootstrap4.css" rel="stylesheet" />
    <link href="../css/MyStyle.css" rel="stylesheet" />

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="myContent" runat="Server">

    <style>
        body {
            font-family: Microsoft JhengHei;
        }
    </style>
    <div class="container-fluid">
        <h1 class="h3 mb-2 text-gray-800">假單</h1>

        <div class="card shadow mb-4">
            <div class="card-header py-3">
                <h6 class="m-0 font-weight-bold text-primary">請假清單</h6>
            </div>
            <div class="card-body">
                <div class="table-responsive">
                </div>
                <asp:Repeater ID="Repeater1" runat="server">
                    <HeaderTemplate>
                        <%--表頭,標籤的上半段--%>
                        <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                            <%--表頭資料--%>
                            <thead class="thead-light">
                                <tr>
                                    <th>請假單號</th>
                                    <th>員工編號</th>
                                    <th>姓名</th>                                    
                                    <th>部門</th>
                                    <th>開始日期</th>
                                    <th>結束日期</th>
                                    <th>假別</th>
                                    <th>時數</th>
                                    <th>事由</th>
                                    <th>狀態</th>
                                    <th>功能</th>
                                </tr>
                            </thead>
                            <tbody>
                    </HeaderTemplate>
                    <ItemTemplate>
                        <tr>
                            <td>NO<%#Eval("LeaveID").ToString().PadLeft(4,'0') %></td>
                            <td>A<%#Eval("EmployeeID").ToString().PadLeft(4,'0') %></td>
                            <td><%#Eval("Name") %></td>                           
                            <td><%#Eval("DepartmentName") %></td>
                            <td><%#Eval("StartTime","{0:D}") %></td>
                            <td><%#Eval("EndTime","{0:D}") %></td>
                            <td><%#Eval("Category") %></td>
                            <td><%#Eval("Hours") %></td>
                            <td><%#Eval("Reason") %></td>

                            <td>
                                <asp:Label ID="Label1" runat="server" Text='<%#Eval("Status") %>'></asp:Label></td>
                            <td>
                                <asp:HyperLink ID="HyperLink1" CssClass="btn btn-info btn-icon-split " runat="server"
                                    NavigateUrl='<%# Eval("LeaveID" , "leaveEdit.aspx?leaveID={0}") %>'>
                    <span class="icon text-white-50">
                      <i class="fas fa-info-circle"></i>
                    </span>
                    <span class="text">修改</span>
                                </asp:HyperLink>
                                <asp:HyperLink ID="HyperLink2" CssClass="btn btn-danger btn-icon-split" runat="server"
                                    NavigateUrl='<%#Eval("LeaveID","leaveDelete.aspx?leaveID={0}") %>' onclick="check()">
                    <span class="icon text-white-50">
                      <i class="fas fa-trash"></i>
                    </span>
                    <span class="text">刪除</span>
                                </asp:HyperLink>
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
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="myScript" runat="Server">
    <script src="/vendor/datatables/jquery.dataTables.min.js"></script>
    <script src="/vendor/datatables/dataTables.bootstrap4.min.js"></script>


    <script>
        $(function () {
            //$('#dataTable').DataTable();
        });
        function check() {
            //alert("check");

            if (confirm("Delete?") == false) {
                event.preventDefault();  //停止導向
            }


        }
    </script>
</asp:Content>

