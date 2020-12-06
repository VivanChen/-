<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" %>

<script runat="server">

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!User.IsInRole("hr"))
        {
            Response.Redirect("~/AuthorityInfo.aspx");
        }
        Repeater1.DataSource = LeaveUtility.GetAllLeave();
        Repeater1.DataBind();
    }
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="myCss" runat="Server">
    <link href="/css/MyStyle.css" rel="stylesheet" />

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="myContent" runat="Server">

    <style>
        body {
            font-family: Microsoft JhengHei;
        }
    </style>
    <div class="container-fluid">
        <h1 class="h3 mb-2 text-gray-800">批次審核</h1>
        <br />      
        
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
                          <table id="dataTable" class="table table-bordered" width="100%" cellspacing="0">                   
                           
                            <asp:HyperLink ID="HyperLink1" CssClass="btn btn-warning btn-icon-split" runat="server"
                                        NavigateUrl='<%# Eval("LeaveID" , "leaveList.aspx?leaveID={0}") %>'>
                                    <span class="icon text-white-50">
                                    <i class="fas fa-check"></i>
                                    </span>
                                    <span class="text text-white">審核</span>
                                    </asp:HyperLink>
                           <br />
                            <br />
                                 <div class="form-inline">
                        <%--查詢start--%>
                        <asp:Label ID="Label1" runat="server" Text="查詢:"></asp:Label>
                        &nbsp;  &nbsp;                                
                                    <%-- 選擇查詢方式 --%>
                        <asp:DropDownList ID="DropDownList1" runat="server" CssClass="form-control bg-light border-0 small">                          
                            <asp:ListItem Value="component">姓名</asp:ListItem>
                            <asp:ListItem Value="vendor">部門名稱</asp:ListItem>
                        </asp:DropDownList>
                        &nbsp;
                                    <%-- 查詢text欄位 --%>
                        <asp:TextBox ID="searchTextBox" class="form-control bg-light border-0 small" type="search" runat="server" placeholder="" aria-controls="dataTable"></asp:TextBox>
                        <%-- 查詢--%>
                        <button class="btn btn-primary" id="btncheck" type="button" onclientclick="return false">
                            <i class="fas fa-search fa-sm"></i>
                        </button>
                    </div>
            </div>
        </div>
        <%--search part number end--%>

        <br />

                            <thead class="thead-light">
                                <tr>
                                    <th>
                                     <asp:CheckBox ID="CheckBox2" onclick="checkAll()" runat="server"  Text="全選" /></th>
                                    <%--<th>審核編號</th>--%>
                                    <th>假單編號</th>
                                    <th>員工編號</th>
                                    <th>姓名</th>
                                    <th>部門名稱</th>
                                    <th>假別</th>                                    
                                    <th>事由</th>
                                    <th>說明</th>
                                    <th>狀態</th>
                              </tr>
                            </thead>
                    </HeaderTemplate>
                    <ItemTemplate>
                        <tbody>
                            <tr>                                
                                <td><asp:CheckBox ID="CheckBox1" runat="server" /></td>
                                <td>NO.000<%#Eval("CheckID") %></td>
                                <td><%#Eval("EmployeeID") %></td>
                                <td><%#Eval("EmployeeName") %></td>                               
                                <td><%#Eval("DepartmentName") %></td>
                                <td><%#Eval("AuditName") %></td>                              
                                <td><%#Eval("Reason") %></td>
                                <td>從<%#Eval("StartTime","{0:D}") %>到<%#Eval("EndTime","{0:D}") %>共<%#Eval("Hours") %>小時</td>
                                <td><%#Eval("Status") %></td> 
                           </tr>
                        </tbody>
                    </ItemTemplate>
                    <FooterTemplate>
                        </table>   
                    </FooterTemplate>
                </asp:Repeater>
            </div>
        </div>
    </div>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="myScript" runat="Server">
  
    <script>
        function check() {
            //alert("check");

            if (confirm("Delete?") == false) {
                event.preventDefault();  //停止導向
            }
        }

        function checkAll() {
            $("#dataTable input").each(function () {
                //找#dataTable input標籤用each跑迴圈

                if ($(this).attr("name").indexOf("CheckBox1") > 0) {
                    this.checked = event.srcElement.checked;
                }
            });
        }
    </script>
</asp:Content>

