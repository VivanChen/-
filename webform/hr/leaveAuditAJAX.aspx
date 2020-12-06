<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" %>

<script runat="server">

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!User.IsInRole("hr"))
        {
            Response.Redirect("~/AuthorityInfo.aspx");
        }
    }

</script>

<asp:Content ID="Content1" ContentPlaceHolderID="myCss" runat="Server">
    <%--<link href="Scripts/sweetalert2.min.css" rel="stylesheet" />--%>
    <link href="/css/MyStyle.css" rel="stylesheet" />

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="myContent" runat="Server">

    <style>
        body {
            font-family: Microsoft JhengHei;
        }
    </style>
    <div class="container-fluid">
        <h1 class="h3 mb-2 text-gray-800">審核假單</h1>
        <br />

        <div class="card shadow mb-4">
            <div class="card-header py-3">
                <h6 class="m-0 font-weight-bold text-primary">請假清單</h6>
            </div>
            <div class="card-body">
                <div class="table-responsive">
                </div>


                <%--表頭,標籤的上半段--%>
                <table id="dataTable" class="table table-bordered" width="100%" cellspacing="0">

                    <asp:HyperLink ID="HyperLink1" CssClass="btn btn-success btn-icon-split" runat="server"
                        NavigateUrl='<%# Eval("LeaveID" , "leaveList.aspx?leaveID={0}") %>'>
                                    <span class="icon text-white-50">
                                    <i class="fas fa-check"></i>
                                    </span>
                                    <span class="text text-white">通過</span>
                    </asp:HyperLink> &nbsp;
                     <asp:HyperLink ID="HyperLink2" CssClass="btn btn-warning btn-icon-split" runat="server"
                        NavigateUrl='<%# Eval("LeaveID" , "leaveList.aspx?leaveID={0}") %>'>
                                    <span class="icon text-white-50">
                                    <i class="fas fa-check"></i>
                                    </span>
                                    <span class="text text-white">未通過</span>
                    </asp:HyperLink>
                    <br />
                    <br />
                    <div class="form-inline">
                        <%--查詢start--%>
                        <asp:Label ID="Label1" runat="server" Text="查詢:"></asp:Label>
                        &nbsp;  &nbsp;                                
                                    <%-- 選擇查詢方式 --%>
                        <asp:DropDownList ID="DropDownList1" runat="server" CssClass="form-control bg-light border-0 small">
                            <asp:ListItem Value="employeename">姓名</asp:ListItem>
                            <asp:ListItem Value="departmentname">部門名稱</asp:ListItem>
                            <asp:ListItem Value="status">狀態</asp:ListItem>
                        </asp:DropDownList>
                        &nbsp;
                                    <%-- 查詢text欄位 --%>
                        <asp:TextBox ID="searchTextBox" class="form-control bg-light border-0 small" type="search" runat="server" placeholder="" aria-controls="dataTable"></asp:TextBox>
                        <%-- 查詢--%>
                        <button class="btn btn-primary" id="btncheck" type="button" onclick="return false">
                            <i class="fas fa-search fa-sm"></i>
                        </button>
                        &nbsp;
                        <input type="button" id="auditdemo1" value="DEMO姓名" class="btn btn-info"/>&nbsp;
                        <input type="button" id="auditdemo2" value="DEMO部門名稱" class="btn btn-info"/>&nbsp;
                        <input type="button" id="auditdemo3" value="DEMO狀態" class="btn btn-info"/>

                    </div>
            </div>
        </div>
        <%--search part number end--%>
        <br />
        <thead class="thead-light">
            <tr>
                <th>
                    <div>
                        <input id="CheckBox2" value="全選" type="checkbox" /><label>全選</label>
                    </div>

                    <%--<asp:CheckBox ID="CheckBox2" runat="server" Text="全選" />--%>

                    
                </th>
                <%--<th>審核編號</th>--%>
                <th>申請單編號</th>
                <th>員工編號</th>
                <th>姓名</th>
                <th>部門名稱</th>
                <th>假別</th>
                <th>事由</th>
                <th>說明</th>
                <th>狀態</th>

            </tr>
        </thead>

        <tbody id="myTableBody">
            <%--資料新增在這裡--%>
        </tbody>
        </table>                    
    </div>
    </div>
    </div>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="myScript" runat="Server">
    <%-- <script src="Scripts/sweetalert2.min.js"></script>
    <script src="Scripts/jquery-3.5.1.min.js"></script>--%>
    <%--補0的js--%>
<%--    <script src="../js/MyJavaScript.js"></script>--%>
    <script src="../js/prodUse.js"></script>
    <script>

        $(function () {
            $("#auditdemo1").click(function () {
                $("#myContent_searchTextBox").val("賴彥廷");
            });
            $("#auditdemo2").click(function () {
                $("#myContent_searchTextBox").val("人資部");
            });
            $("#auditdemo3").click(function () {
                $("#myContent_searchTextBox").val("審核中");
            });
            $("#CheckBox2").click(function () {
                console.log("aa");
                $("#dataTable input").each(function () {
                    //找#dataTable input標籤用each跑迴圈
                    console.log("bb");
                    if ($("#CheckBox2").prop("checked")) {
                        $(this).attr("checked", true)
                    }
                    else {
                        $(this).attr("checked", false)
                    }
                });
            });

            //checkall結束
            var i = 0;
            $.ajax({
                type: 'POST',
                url: '/WebService.asmx/GetAllLeave',
                contentType: "application/json;charset=utf-8",
                //data: JSON.stringify(myData),
                success: function (data) {
                    console.log(data);
                    $(data.d).each(function (index, item) {
                        i++;
                        $("#myTableBody").append(
                            `<tr>                                
                                <td>  <input type="checkbox"  ID="CheckBox${i}" name="CheckBox1" onclick="checkAll();" value="${item.LeaveID}" /></td>                      
                                <td>NO${padLeft((item.LeaveID), 5)}</td>                                   
                                <td>A${padLeft((item.EmployeeID), 4)}</td>                            
                                <td>${item.Name}</td>                             
                                <td>${item.DepartmentName}</td>                                                 
                                <td>${item.Category}</td>                             
                                <td>${item.Reason}</td>                              
                                <td>從${item.StartTime}到${item.EndTime}共${item.Hours}小時</td>                               
                                <td>${item.Status}</td>
                           </tr>`
                        )

                    });
                    //$('#dataTable').DataTable();
                },
                error: function (x) {
                    alert("error");
                }
            });
            //按搜尋觸發 開始
            $("#btncheck").click(function () {
                //以姓名搜尋
                $("#myTableBody").empty();
                if ($("#myContent_DropDownList1").val() == "employeename") {
                    var myData = {
                        employeeName: $("#myContent_searchTextBox").val(),
                    };
                    $.ajax({
                        type: 'POST',
                        url: '/WebService.asmx/GetLeavesByEmployeeName',
                        contentType: "application/json;charset=utf-8",
                        data: JSON.stringify(myData),
                        success: function (data) {
                            console.log(data.d);
                            console.log(data.d[0].EmployeeName);

                            $(data.d).each(function (index, item) {

                                $("#myTableBody").append(
                                    `<tr>                                
                                <td>  <input type="checkbox"  ID="CheckBox1"  value="${item.LeaveID}" /></td>                      
                               <td>NO${padLeft((item.LeaveID), 5)}</td>                                   
                                <td>A${padLeft((item.EmployeeID), 4)}</td>                               
                                <td>${item.Name}</td>                             
                                <td>${item.DepartmentName}</td>                                                 
                                <td>${item.Category}</td>                             
                                <td>${item.Reason}</td>                              
                                <td>從${item.StartTime}到${item.EndTime}共${item.Hours}小時</td>                               
                                <td>${item.Status}</td>
                           </tr>`
                                )
                            });
                        },
                        error: function (x) {
                            alert("error");
                        }
                    });
                }//以姓名搜尋END
                //搜尋部門名稱
                if ($("#myContent_DropDownList1").val() == "departmentname") {
                    var myData = {
                        departermentName: $("#myContent_searchTextBox").val(),
                    };
                    $.ajax({
                        type: 'POST',
                        url: '/WebService.asmx/GetLeavesByDepartmentName',
                        contentType: "application/json;charset=utf-8",
                        data: JSON.stringify(myData),
                        success: function (data) {
                            console.log(data.d);
                            console.log(data.d[0].departermentName);

                            $(data.d).each(function (index, item) {

                                $("#myTableBody").append(
                                    `<tr>                                
                                <td>  <input type="checkbox"  ID="CheckBox1" value="${item.LeaveID}" /></td>                      
                               <td>NO${padLeft((item.LeaveID), 5)}</td>                                   
                                <td>A${padLeft((item.EmployeeID), 4)}</td>                      
                                <td>${item.Name}</td>                             
                                <td>${item.DepartmentName}</td>                                                 
                                <td>${item.Category}</td>                             
                                <td>${item.Reason}</td>                              
                                <td>從${item.StartTime}到${item.EndTime}共${item.Hours}小時</td>                               
                                <td>${item.Status}</td>
                           </tr>`
                                )
                            });
                            //$('#dataTable').DataTable();
                        },
                        error: function (x) {
                            alert("error");
                        }
                    });
                } //搜尋部門名稱END
                //搜尋狀態
                if ($("#myContent_DropDownList1").val() == "status") {
                    var myData = {
                        status: $("#myContent_searchTextBox").val(),
                    };
                    $.ajax({
                        type: 'POST',
                        url: '/WebService.asmx/GetLeavesByStatus',
                        contentType: "application/json;charset=utf-8",
                        data: JSON.stringify(myData),
                        success: function (data) {
                            console.log(data.d);
                            console.log(data.d[0].status);

                            $(data.d).each(function (index, item) {

                                $("#myTableBody").append(
                                    `<tr>                                
                                <td>  <input type="checkbox"  ID="CheckBox1"  value="${item.LeaveID}"/></td>                      
                               <td>NO${padLeft((item.LeaveID), 5)}</td>                                   
                                <td>A${padLeft((item.EmployeeID), 4)}</td>                            
                                <td>${item.Name}</td>                             
                                <td>${item.DepartmentName}</td>                                                 
                                <td>${item.Category}</td>                             
                                <td>${item.Reason}</td>                              
                                <td>從${item.StartTime}到${item.EndTime}共${item.Hours}小時</td>                               
                                <td>${item.Status}</td>
                           </tr>`
                                )
                            });
                            //$('#dataTable').DataTable();
                        },
                        error: function (x) {
                            alert("error");
                        }
                    });
                } //搜尋狀態END          
            });
            //審核開始
            $("#myContent_HyperLink1").click(function () {
                if (confirm("確認審核?") == false) {
                    event.preventDefault();
                    return  location.href = "leaveAuditAJAX.aspx";                   
                }
                // alert(1);
                //if ($("CheckBox2").prop("checked", true)) {
                var idStr = "";
                var idArr = [];
                $("input[id^='CheckBox']").each(function () {
                    if ($(this).is(':Checked')) {
                        idArr.push($(this).attr("value"));
                        console.log(idArr)
                    }
                });
                //idStr = idArr.join(",");

                var myData = { idArr2: idArr };
                $.ajax({
                    type: 'POST',
                    url: '/WebService.asmx/UpdateLeaveStatus',
                    contentType: "application/json;charset=utf-8",
                    data: JSON.stringify(myData),
                    success: function (data) {
                        console.log(data.d);

                        location.href = "leaveAuditAJAX.aspx";
                    },
                    error: function (x) {
                        alert("error");
                    }
                });

            });
             $("#myContent_HyperLink2").click(function () {
                if (confirm("確認審核?") == false) {
                    event.preventDefault();
                    return  location.href = "leaveAuditAJAX.aspx";                   
                }
                // alert(1);
                //if ($("CheckBox2").prop("checked", true)) {
                var idStr = "";
                var idArr = [];
                $("input[id^='CheckBox']").each(function () {
                    if ($(this).is(':Checked')) {
                        idArr.push($(this).attr("value"));
                        console.log(idArr)
                    }
                });
                //idStr = idArr.join(",");

                var myData = { idArr2: idArr };
                $.ajax({
                    type: 'POST',
                    url: '/WebService.asmx/UpdateLeaveStatusNotPass',
                    contentType: "application/json;charset=utf-8",
                    data: JSON.stringify(myData),
                    success: function (data) {
                        console.log(data.d);

                        location.href = "leaveAuditAJAX.aspx";
                    },
                    error: function (x) {
                        alert("error");
                    }
                });

            });
        });


    </script>
    <%-- <script>
       

        function checkAll() {
            $("#dataTable input").each(function () {
                //找#dataTable input標籤用each跑迴圈

                if ($(this).attr("name").indexOf("CheckBox1") > 0) {
                    this.checked = event.srcElement.checked;
                }
            });
        }
    </script>--%>
</asp:Content>

