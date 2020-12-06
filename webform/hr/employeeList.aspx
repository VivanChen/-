<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" %>

<script runat="server">

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!User.IsInRole("hr"))
        {
            Response.Redirect("~/AuthorityInfo.aspx");
        }
        Repeater1.DataSource = EmployeeUtility.GetAllEmployee();
        Repeater1.DataBind();
    }
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="myCss" runat="Server">
    <%--自已加--%>
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
        <h1 class="h3 mb-2 text-gray-800">員工資料</h1>
        <div class="card shadow mb-4">
            <div class="card-header py-3">
                <h6 class="m-0 font-weight-bold text-primary">員工資料清單</h6>
            </div>
            <asp:Repeater ID="Repeater1" runat="server">
                <HeaderTemplate>
                    <div class="card-body">
                        <div class="table-responsive">
                            <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                                <thead class="thead-light">
                                    <tr>
                                        <th>大頭照</th>
                                        <th>員工編號</th>
                                        <th>姓名</th>
                                        <th>生日</th>
                                        <th>部門名稱</th>
                                        <th>到職日</th>
                                        <th>離職日</th>
                                        <th>電話</th>
                                        <th>電子信箱</th>
                                        <th>狀態</th>
                                        <th>功能</th>
                                    </tr>
                                </thead>
                                <tbody>
                </HeaderTemplate>
                <ItemTemplate>

                    <tr>
                        <td>
                            <asp:Image ID="Image1" Width="35px" runat="server" ImageUrl='<%#"/Upload/"+Eval("ImageFileName") %>' /></td>
                        <td>A<%# Eval("EmployeeID").ToString().PadLeft(4,'0')%></td>
                        <td><%#Eval("Name") %></td>
                        <td><%#Eval("BirthDate") %></td>
                        <td><%#Eval("DepartmentName") %></td>
                        <td><%#Eval("StartDate") %></td>
                        <td><%#Eval("EndDate") %></td>
                        <td><%#Eval("Phone") %></td>
                        <td><%#Eval("Email") %></td>
                        <td><%#Eval("Status") %></td>
                        <td>
                            <asp:HyperLink ID="HyperLink1" CssClass="btn btn-info btn-icon-split " runat="server"
                                NavigateUrl='<%# Eval("EmployeeID" , "employeeEdit.aspx?employeeID={0}") %>'>
                    <span class="icon text-white-50">
                      <i class="fas fa-info-circle"></i>
                    </span>
                    <span class="text">修改</span>
                            </asp:HyperLink>
                        </td>
                    </tr>
                </ItemTemplate>
                <FooterTemplate>
                    </tbody>
                    </table> 
                    </div>
                    </div>
                </FooterTemplate>
            </asp:Repeater>
        </div>
    </div>

</asp:Content>


<asp:Content ID="Content3" ContentPlaceHolderID="myScript" runat="Server">
    <script src="/vendor/datatables/jquery.dataTables.min.js"></script>
    <script src="/vendor/datatables/dataTables.bootstrap4.min.js"></script>
    <script>
        $(function () {
            $('#dataTable').DataTable();
        });
       
    </script>
</asp:Content>

