<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="PurchCheck.aspx.cs" Inherits="prod_PurchCheck" %>

<asp:Content ID="Content1" ContentPlaceHolderID="myCss" runat="Server">
    <%-- 引用自己的css --%>
    <link href="../css/MyStyleSheet.css" rel="stylesheet" />
    <%--引用nice-select start--%>
    <link href="jquery-nice-select-1.1.0/css/nice-select.css" rel="stylesheet" />
    <%--引用nice-select end--%>
    <%-- 引用table css --%>
    <link href="../vendor/datatables/dataTables.bootstrap4.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="myContent" runat="Server">
    <div class="container-fluid">

        <!-- Page Heading   有問題那邊還沒做-->
        <h1 class="h3 mb-2 text-gray-800">採購審核表</h1>
        <%--<p class="mb-4">料件表功能包含查詢料件編號、修改，<a target="_blank" href="https://datatables.net">如有問題請點此連結</a>。</p>--%>

        <!-- DataTales Example -->
        <div class="card shadow mb-4">
            <div class="card-header py-3 form-inline">
                <i class="fas fa-clipboard-list fa-2x text-gray-300"></i>&nbsp;<h4 class="m-0 font-weight-bold text-primary">採購編號列表</h4>
            </div>
            <div class="card-body">
                <div class="table-responsive">
                    <div class="row">

                        <%--search part number start--%>
                        <div class="col-sm-12 col-md-8 ">
                            <div id="dataTable_filter" class="dataTables_filter">

                                <asp:Label ID="Label1" runat="server" Text="依表單編號查詢:"></asp:Label>
                                <div class="form-inline">
                                    <asp:TextBox ID="searchTextBox" class="form-control form-control-sm" type="search" runat="server" placeholder="PURCH00000" aria-controls="dataTable"></asp:TextBox>
                                    <%-- 查詢--%>
                                    <button class="btn btn-primary" id="btncheck" type="button">
                                        <i class="fas fa-search fa-sm"></i>
                                    </button>

                                </div>
                                <div class="col-sm-12 col-md-4 d-inline">
                                    <div id="dataTable_create" class="dataTables_filter ">
                                        <label>
                                            <br>
                                            <a href="Purchasing.aspx" class="btn btn-success btn-icon-split">
                                                <span class="icon text-white-50">
                                                    <i class="fas fa-check"></i>
                                                </span>
                                                <span class="text">新增採購單</span>
                                            </a>
                                        </label>
                                           <label>
                                            <br>
                                            <a href="PurchCheck.aspx" class="btn btn-secondary btn-icon-split">
                                                <span class="icon text-white-50">
                                                    <i class="fa fa-search"></i>
                                                </span>
                                                <span class="text">查詢全部</span>
                                            </a>
                                        </label>
                                    </div>
                                </div>
                                <br />

                                <%-- 查詢text欄位 --%>
                            </div>
                        </div>
                        <%--search part number end--%>
                    </div>
                    <%--table start--%>
                    <br />
                    <table class="table table-bordered " id="dataTable" width="100%" cellspacing="0">
                        <%--補table內容--%>
                    </table>
                    <%--table end--%>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="myScript" runat="Server">
    <%-- 引用function products js --%>
    <script src="../js/prodUse.js"></script>
    <%-- 引用nice-select js start--%>
    <script src="jquery-nice-select-1.1.0/js/jquery.nice-select.js"></script>
    <%-- 引用nice-select js end--%>
    <%-- 引用table js start--%>
    <script src="../vendor/datatables/jquery.dataTables.js"></script>
    <script src="../vendor/datatables/dataTables.bootstrap4.js"></script>
    <%-- 引用table js end--%>
    <script>
        $(function () {
            //nice select
            $('select').niceSelect();

            //load全部的表格

            $.ajax({
                type: 'POST',
                url: '/WebService.asmx/GetAllcheck',
                contentType: "application/json;charset=utf-8",
                success: function (data) {
                    console.log(data.d)

                    $("#dataTable").append(`<thead>
                            <tr>
                               <th>採購編號</th>
                                <th>員工編號</th>
                                <th>員工名字</th>
                                <th>所屬部門</th>
                                <th>填寫日期</th>
                                <th>審核狀態</th>
                                <th>審核時間</th>
                                <th>功能</th>
                            </tr>
                        </thead>
                            <tbody id="myTableBody">
                            </tbody>
                             <tfoot>
                                <tr>
                              <th>採購編號</th>
                                <th>員工編號</th>
                                <th>員工名字</th>
                                <th>所屬部門</th>
                                <th>填寫日期</th>
                                <th>審核狀態</th>
                                <th>審核時間</th>
                                <th>功能</th>
                            </tr>
                        </tfoot>`);
                    $(data.d).each(function (index, item) {
                        //this day用
                        var MyDate_String_Value = item.ThisDay
                        var value = new Date
                            (
                            parseInt(MyDate_String_Value.replace(/(^.*\()|([+-].*$)/g, ''))
                            );
                        var dat = value.getFullYear() + "/" +
                            (value.getMonth() +
                                1) +
                            "/" +
                            value.getDate();
                        //check day用
                        if (item.checkday != null) {
                            var MyDate_String_Value_check = item.checkday
                            var value_check = new Date
                                (
                                parseInt(MyDate_String_Value_check.replace(/(^.*\()|([+-].*$)/g, ''))
                                );
                            var dat_check = value_check.getFullYear() + "/" +
                                (value.getMonth() +
                                    1) +
                                "/" +
                                (value.getDate()+1);
                        }
                        if (item.checkday == null) {
                            var dat_check = "尚未修改時間"
                        }



                        $("#myTableBody").append(
                            ` <tr>
                                    <td>PURCH${padLeft(item.purchNO, 5)}</td>
                                    <td>A${padLeft(item.buyer, 4)}</td>
                                      <td>${item.Name}</td>
                                    <td>${item.department}</td>
                                    <td>${dat}</td> 
                                    <td>${item.checkstatus}</td>
                                   <td>${dat_check}</td>
                                    <td>
                                          <a href="/prod/PurchCheckModify.aspx?id=${item.purchNO}" class="btn btn-info btn-icon-split">
                                            <span class="icon text-white-50" >
                                              <i class="fas fa-info-circle"></i>
                                            </span>
                                            <span id="btnEdit" class="text" value="${item.purchNO}" title="${item.id}" >查閱資訊</span>
                                          </a>                           
                                    </td>
                            </tr>`
                        )
                    });
                    $('#dataTable').DataTable();
                },
                error: function (x) {
                    alert("error");

                }
            });
            //修改下拉選單查詢狀態
            $("#selectItem").change(function () {

                $.ajax({
                    type: 'POST',
                    url: '/WebService.asmx/GetAllcheck',
                    contentType: "application/json;charset=utf-8",
                    success: function (data) {
                        console.log(data.d)
                        $("#dataTable").replace(`<thead>
                            <tr>
                               <th>採購編號</th>
                                <th>員工編號</th>
                                    <th>員工名字</th>
                                <th>所屬部門</th>
                                <th>填寫日期</th>
                                <th>審核狀態</th>
                                <th>審核時間</th>
                                <th>功能</th>
                            </tr>
                        </thead>
                            <tbody id="myTableBody">
                            </tbody>
                             <tfoot>
                                <tr>
                              <th>採購編號</th>
                                <th>員工編號</th>
                                <th>員工名字</th>
                                <th>所屬部門</th>
                                <th>填寫日期</th>
                                <th>審核狀態</th>
                                <th>審核時間</th>
                                <th>功能</th>
                            </tr>
                        </tfoot>`);

                        $("#selectItem").find(":selected").$(data.d).each(function (index, item) {

                            //this day用
                            var MyDate_String_Value = item.ThisDay
                            var value = new Date
                                (
                                parseInt(MyDate_String_Value.replace(/(^.*\()|([+-].*$)/g, ''))
                                );
                            var dat = value.getFullYear() + "/" +
                                (value.getMonth() +
                                    1) +
                                "/" +
                                value.getDate();
                            //check day用
                            if (item.checkday != null) {
                                var MyDate_String_Value_check = item.checkday
                                var value_check = new Date
                                    (
                                    parseInt(MyDate_String_Value_check.replace(/(^.*\()|([+-].*$)/g, ''))
                                    );
                                var dat_check = value_check.getFullYear() + "/" +
                                    (value.getMonth() +
                                        1) +
                                    "/" +
                                    (value.getDate()+1);
                            }
                            if (item.checkday == null) {
                                var dat_check = "尚未修改時間"
                            }

                            $("#myTableBody").append(
                                ` <tr>
                                    <td>PURCH${padLeft(item.purchNO, 5)}</td>
                                    <td>A${padLeft(item.buyer, 4)}</td>
                                     <td>${item.Name}</td>
                                    <td>${item.department}</td>
                                    <td>${item.ThisDay}</td> 
                                    <td>${item.checkstatus}</td>
                                   <td>${item.checkday}</td>
                                    <td>
                                          <a href="/prod/PurchCheckModify.aspx?id=${item.purchNO}" class="btn btn-info btn-icon-split">
                                            <span class="icon text-white-50" >
                                              <i class="fas fa-info-circle"></i>
                                            </span>
                                            <span id="btnEdit" class="text" value="${item.purchNO}" title="${item.purchNO}" >查閱資訊</span>
                                          </a>                           
                                    </td>
                            </tr>`
                            )


                        });


                        $('#dataTable').DataTable();
                    },
                    error: function (x) {
                        alert("error");

                    }
                });

            });


            //按搜尋觸發 開始
            $("#btncheck").click(function () {
                //以表單編號搜尋
                var TextBoxTrim = $("#myContent_searchTextBox").val().replace(/^\s*|\s*$/g, "");
                //如果符合條件
                if (TextBoxTrim.length == 10) {
                    if (TextBoxTrim.slice(0, 5) == "PURCH") {
                        //alert(TextBoxTrim.slice(0, 5) + "2");
                        var TextboxId = parseInt(TextBoxTrim.slice(5));
                        //alert(TextboxId);
                        var mydata = { purchNO: TextboxId };
                        $.ajax({
                            type: 'POST',
                            url: '/WebService.asmx/purchAll',
                            contentType: "application/json;charset=utf-8",
                            data: JSON.stringify(mydata),
                            success: function (data) {
                                console.log(data.d)
                                //this day用
                                var MyDate_String_Value = data.d.ThisDay
                                var value = new Date
                                    (
                                    parseInt(MyDate_String_Value.replace(/(^.*\()|([+-].*$)/g, ''))
                                    );
                                var dat = value.getFullYear() + "/" +
                                    (value.getMonth() +
                                        1) +
                                    "/" +
                                    value.getDate();
                                //check day用
                                if (data.d.checkday != null) {
                                    var MyDate_String_Value_check = item.checkday
                                    var value_check = new Date
                                        (
                                        parseInt(MyDate_String_Value_check.replace(/(^.*\()|([+-].*$)/g, ''))
                                        );
                                    var dat_check = value_check.getFullYear() + "/" +
                                        (value.getMonth() +
                                            1) +
                                        "/" +
                                        (value.getDate()+1);
                                }
                                if (data.d.checkday == null) {
                                    var dat_check = "尚未修改時間"
                                }
                                //alert(mycheck);             
                                $("#dataTable").replaceWith(
                                    ` <table class="table table-bordered " id="dataTable" width="100%" cellspacing="0">
                                    <thead>
                                        <tr>
                                            <th>採購編號</th>
                                            <th>員工編號</th>
                                            <th>員工名字</th>
                                            <th>所屬部門</th>
                                            <th>填寫日期</th>
                                            <th>審核狀態</th>
                                            <th>審核時間</th>
                                            <th>功能</th>
                                        </tr>
                                    </thead>
                                        <tbody id="myTableBody">
                                        </tbody>
                                         <tfoot>
                                            <tr>
                                                 <th>採購編號</th>
                                                <th>員工編號</th>
                                                <th>員工名字</th>
                                                <th>所屬部門</th>
                                                <th>填寫日期</th>
                                                <th>審核狀態</th>
                                                <th>審核時間</th>
                                                <th>功能</th>
                                        </tr>
                                    </tfoot>
                                </table>
                                    `);
                                $("#myTableBody").replaceWith(

                                    ` <tr>
                                    <td>PURCH${padLeft(data.d.purchNO, 5)}</td>
                                    <td>A${padLeft(data.d.buyer, 4)}</td>
                                         <td>${data.d.Name}</td>
                                    <td>${data.d.department}</td>
                                    <td>${dat}</td> 
                                    <td>${data.d.checkstatus}</td>
                                   <td>${dat_check}</td>
                                    <td>
                                          <a href="/prod/PurchCheckModify.aspx?id=${data.d.purchNO}" class="btn btn-info btn-icon-split">
                                            <span class="icon text-white-50" >
                                              <i class="fas fa-info-circle"></i>
                                            </span>
                                            <span id="btnEdit" class="text" value="${data.d.purchNO}" title="${data.d.purchNO}" >查閱資訊</span>
                                          </a>                           
                                    </td>
                            </tr>`);

                            },
                            error: function (x) {
                                //alert("error");
                                $("#dataTable").replaceWith(
                                    ` <table class="table table-bordered " id="dataTable" width="100%" cellspacing="0">
                                    <thead>
                                        <tr>
                                           <th>採購編號</th>
                                            <th>員工編號</th>
                                                <th>員工名字</th>
                                            <th>所屬部門</th>
                                            <th>填寫日期</th>
                                            <th>審核狀態</th>
                                            <th>審核時間</th>
                                            <th>功能</th>
                                        </tr>
                                    </thead>
                                        <tbody id="myTableBody">
                                        </tbody>
                                         <tfoot>
                                            <tr>
                                         <th>採購編號</th>
                                            <th>員工編號</th>
                                            <th>員工名字</th>
                                            <th>所屬部門</th>
                                            <th>填寫日期</th>
                                            <th>審核狀態</th>
                                            <th>審核時間</th>
                                            <th>功能</th>
                                        </tr>
                                    </tfoot>
                                </table>
                                    `);
                                //輸入錯誤show
                                $("#myTableBody").replaceWith(
                                    `</br></br></br>查無資訊</br></br></br>`);
                            }
                        });

                    }

                    //長度符合 料號英文不符合
                    else {
                        //alert("error 料號英文不符合")
                        $("#dataTable").replaceWith(
                            ` <table class="table table-bordered " id="dataTable" width="100%" cellspacing="0">
                                    <thead>
                                        <tr>
                                            <th>採購編號</th>
                                            <th>員工編號</th>
                                            <th>所屬部門</th>
                                            <th>填寫日期</th>
                                            <th>審核狀態</th>
                                            <th>審核時間</th>
                                            <th>功能</th>
                                        </tr>
                                    </thead>
                                        <tbody id="myTableBody">
                                        </tbody>
                                         <tfoot>
                                            <tr>
                                            <th>採購編號</th>
                                            <th>員工編號</th>
                                            <th>所屬部門</th>
                                            <th>填寫日期</th>
                                            <th>審核狀態</th>
                                            <th>審核時間</th>
                                            <th>功能</th>
                                        </tr>
                                    </tfoot>
                                </table>
                                    `);
                        //輸入錯誤show
                        $("#myTableBody").replaceWith(
                            `</br></br></br>採購單英文不符合</br></br></br>`);
                    }
                }
                //輸入長度錯誤的bug
                else {
                    //alert("error 料號長度不符合")
                    $("#dataTable").replaceWith(
                        ` <table class="table table-bordered " id="dataTable" width="100%" cellspacing="0">
                                    <thead>
                                        <tr>
                                          <th>採購編號</th>
                                            <th>員工編號</th>
                                            <th>所屬部門</th>
                                            <th>填寫日期</th>
                                            <th>審核狀態</th>
                                            <th>審核時間</th>
                                            <th>功能</th>
                                        </tr>
                                    </thead>
                                        <tbody id="myTableBody">
                                        </tbody>
                                         <tfoot>
                                            <tr>
                                          <th>採購編號</th>
                                            <th>員工編號</th>
                                            <th>所屬部門</th>
                                            <th>填寫日期</th>
                                            <th>審核狀態</th>
                                            <th>審核時間</th>
                                            <th>功能</th>
                                        </tr>
                                    </tfoot>
                                </table>
                                    `);
                    //輸入錯誤show
                    $("#myTableBody").replaceWith(
                        `</br></br></br>採購單不正確</br></br></br>`);
                }
            });

        });
    </script>
</asp:Content>

