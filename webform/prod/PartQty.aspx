<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="PartQty.aspx.cs" Inherits="prod_PartQty" %>

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
        <h1 class="h3 mb-2 text-gray-800">庫存表單</h1>
        <p class="mb-4">料件表功能包含查詢料件編號、修改，<a target="_blank" href="https://datatables.net">如有問題請點此連結</a>。</p>

        <!-- DataTales Example -->
        <div class="card shadow mb-4">
            <div class="card-header py-3 form-inline">
                <i class="fas fa-clipboard-list fa-2x text-gray-300"></i>&nbsp;<h4 class="m-0 font-weight-bold text-primary">料件編號庫存列表</h4>
            </div>
            <div class="card-body">
                <div class="table-responsive">
                    <div class="row">
                        <%--單頁數量 start--%>
                        <%--<div class="col-sm-12 col-md-6">
                            <div class="dataTables_length" id="dataTable_length">
                                <label>
                                    Show
                                        <select name="dataTable_length" aria-controls="dataTable" class="custom-select custom-select-sm form-control form-control-sm">
                                            <option value="10">10</option>
                                            <option value="25">25</option>
                                            <option value="50">50</option>
                                            <option value="100">100</option>
                                        </select>
                                    entries</label>
                            </div>
                        </div>--%>
                        <%--單頁數量 end--%>
                        <%--search part number start--%>
                        <div class="col-sm-12 col-md-8 ">
                            <div id="dataTable_filter" class="dataTables_filter">

                                <asp:Label ID="Label1" runat="server" Text="查詢料件編號:"></asp:Label>
                                <div class="form-inline">


                                    <%-- 選擇查詢方式 --%>
                                    <asp:DropDownList ID="DropDownList1" runat="server" CssClass="select">
                                        <asp:ListItem Value="PARTN">料件編號</asp:ListItem>
                                        <asp:ListItem Value="component">元件類型</asp:ListItem>
                                        <asp:ListItem Value="vendor">供應商</asp:ListItem>
                                    </asp:DropDownList>
                                    &nbsp;
                                    <%-- 查詢text欄位 --%>
                                    <asp:TextBox ID="searchTextBox" class="form-control form-control-sm" type="search" runat="server" placeholder="" aria-controls="dataTable"></asp:TextBox>
                                    <%-- 查詢--%>
                                    <button class="btn btn-primary" id="btncheck" type="button">
                                        <i class="fas fa-search fa-sm"></i>
                                    </button>

                                </div>

                            </div>
                        </div>
                        <%--search part number end--%>
                        <div class="col-sm-12 col-md-4">
                            <div id="dataTable_create" class="dataTables_filter">

                                <label>
                                    <br>
                                    <a href="PartQty.aspx" class="btn btn-secondary btn-icon-split">
                                        <span class="icon text-white-50">
                                            <i class="fa fa-search"></i>
                                        </span>
                                        <span class="text">查詢全部資訊</span>
                                    </a>
                                </label>
                            </div>
                        </div>
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
                url: '/WebService.asmx/PartNumberList',
                contentType: "application/json;charset=utf-8",
                success: function (data) {
                    $("#dataTable").append(`<thead>
                            <tr>
                               <th>料件編號</th>
                                <th>元件</th>
                                <th>供應商</th>
                                <th>規格</th>
                                <th>庫存數量</th>
                                <th>數量最後修改時間</th>
                                <th>功能</th>
                            </tr>
                        </thead>
                            <tbody id="myTableBody">
                            </tbody>
                             <tfoot>
                                <tr>
                               <th>料件編號</th>
                                <th>元件</th>
                                <th>供應商</th>
                                <th>規格</th>
                                <th>庫存數量</th>
                                <th>數量最後修改時間</th>
                                <th>功能</th>
                            </tr>
                        </tfoot>`);
                    $(data.d).each(function (index, item) {
                        $("#myTableBody").append(
                            ` <tr>
                                    <td>PARTN${padLeft(item.id, 5)}</td>
                                    <td>${item.component}</td>
                                    <td>${item.vendor}</td>
                                    <td>${item.config}</td> 
                                    <td>${item.qty}</td>
                                   <td>${item.qtyDateStr}</td>
                                    <td>
                                          <a href="/prod/PartQtyEdit.aspx?id=${item.id}" class="btn btn-info btn-icon-split">
                                            <span class="icon text-white-50" >
                                              <i class="fas fa-info-circle"></i>
                                            </span>
                                            <span id="btnEdit" class="text" value="${item.id}" title="${item.id}" >修改</span>
                                          </a>                           
                                    </td>
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



                //以PARTN搜尋
                if ($("#myContent_DropDownList1").val() == "PARTN") {
                    var TextBoxTrim = $("#myContent_searchTextBox").val().replace(/^\s*|\s*$/g, "");
                    //如果符合條件
                    if (TextBoxTrim.length == 10) {
                        if (TextBoxTrim.slice(0, 5) == "PARTN") {
                            //alert(TextBoxTrim.slice(0, 5) + "2");
                            var TextboxId = parseInt(TextBoxTrim.slice(5));
                            //alert(TextboxId);
                            var mycheck = { id: TextboxId };
                            $.ajax({
                                type: 'POST',
                                url: '/WebService.asmx/PartNumberById',
                                contentType: "application/json;charset=utf-8",
                                data: JSON.stringify(mycheck),
                                success: function (data) {
                                    //alert(mycheck);             
                                    $("#dataTable").replaceWith(
                                        ` <table class="table table-bordered " id="dataTable" width="100%" cellspacing="0">
                                    <thead>
                                        <tr>
                                            <th>料件編號</th>
                                            <th>元件</th>
                                            <th>供應商</th>
                                            <th>規格</th>
                                            <th>庫存數量</th>
                                            <th>數量最後修改時間</th>
                                            <th>功能</th>
                                        </tr>
                                    </thead>
                                        <tbody id="myTableBody">
                                        </tbody>
                                         <tfoot>
                                            <tr>
                                                <th>料件編號</th>
                                                <th>元件</th>
                                                <th>供應商</th>
                                                <th>規格</th>
                                                <th>庫存數量</th>
                                                <th>數量最後修改時間</th>
                                                <th>功能</th>
                                        </tr>
                                    </tfoot>
                                </table>
                                    `);
                                    $("#myTableBody").replaceWith(
                                        ` <tr>
                                    <td>PARTN${padLeft(data.d.id, 5)}</td>
                                    <td>${data.d.component}</td>
                                    <td>${data.d.vendor}</td>
                                    <td>${data.d.config}</td>
                                    <td>${data.d.qty}</td>
                                   <td>${data.d.qtyDateStr}</td>
                                    
                                    <td>
                                          <a href="/prod/PartQtyEdit.aspx?id=${data.d.id}" class="btn btn-info btn-icon-split">
                                            <span class="icon text-white-50" >
                                              <i class="fas fa-info-circle"></i>
                                            </span>
                                            <span id="btnEdit" class="text" value="${data.d.id}" title="${data.d.id}">修改</span>
                                          </a>
                                                    </td>
                                            </tr>`);
                                    ////按delete觸發 開始
                                    //$("span[id^='DeleteItem']").click(function () {
                                    //    if (confirm("Delete?")) {
                                    //        var myDelete = { id: $(this).attr("title") };

                                    //        $.ajax({
                                    //            type: 'POST',
                                    //            url: '/WebService.asmx/DeletePartNumberById',
                                    //            contentType: "application/json;charset=utf-8",
                                    //            data: JSON.stringify(myDelete),
                                    //            success: function (data) {
                                    //                console.log("success");
                                    //                //reload頁面
                                    //                window.location.reload();

                                    //            },
                                    //            error: function (x) { console.log("error"); }


                                    //        });
                                    //    }
                                    //});
                                    ////按delete觸發 結束
                                },
                                error: function (x) {
                                    //alert("error");
                                    $("#dataTable").replaceWith(
                                        ` <table class="table table-bordered " id="dataTable" width="100%" cellspacing="0">
                                    <thead>
                                        <tr>
                                          <th>料件編號</th>
                                        <th>元件</th>
                                        <th>供應商</th>
                                        <th>規格</th>
                                        <th>庫存數量</th>
                                        <th>數量最後修改時間</th>
                                        <th>功能</th>
                                        </tr>
                                    </thead>
                                        <tbody id="myTableBody">
                                        </tbody>
                                         <tfoot>
                                            <tr>
                                          <th>料件編號</th>
                                        <th>元件</th>
                                        <th>供應商</th>
                                        <th>規格</th>
                                        <th>庫存數量</th>
                                        <th>數量最後修改時間</th>
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
                                          <th>料件編號</th>
                                        <th>元件</th>
                                        <th>供應商</th>
                                        <th>規格</th>
                                        <th>數量最後修改時間</th>
                                        <th>功能</th>
                                        </tr>
                                    </thead>
                                        <tbody id="myTableBody">
                                        </tbody>
                                         <tfoot>
                                            <tr>
                                            <th>料件編號</th>
                                        <th>元件</th>
                                        <th>供應商</th>
                                        <th>規格</th>
                                        <th>數量最後修改時間</th>
                                        <th>功能</th>
                                        </tr>
                                    </tfoot>
                                </table>
                                    `);
                            //輸入錯誤show
                            $("#myTableBody").replaceWith(
                                `</br></br></br>PartNumber料號英文不符合</br></br></br>`);
                        }
                    }
                    //輸入長度錯誤的bug
                    else {
                        //alert("error 料號長度不符合")
                        $("#dataTable").replaceWith(
                            ` <table class="table table-bordered " id="dataTable" width="100%" cellspacing="0">
                                    <thead>
                                        <tr>
                                        <th>料件編號</th>
                                        <th>元件</th>
                                        <th>供應商</th>
                                        <th>規格</th>
                                        <th>數量最後修改時間</th>
                                        <th>功能</th>
                                        </tr>
                                    </thead>
                                        <tbody id="myTableBody">
                                        </tbody>
                                         <tfoot>
                                            <tr>
                                        <th>料件編號</th>
                                        <th>元件</th>
                                        <th>供應商</th>
                                        <th>規格</th>
                                        <th>數量最後修改時間</th>
                                        <th>功能</th>
                                        </tr>
                                    </tfoot>
                                </table>
                                    `);
                        //輸入錯誤show
                        $("#myTableBody").replaceWith(
                            `</br></br></br>查無資訊</br></br></br>`);
                    }

                }

                //以component搜尋
                if ($("#myContent_DropDownList1").val() == "component") {
                    var mycheck = { component: $("#myContent_searchTextBox").val().replace(/^\s*|\s*$/g, "") };
                    $.ajax({
                        type: 'POST',
                        url: '/WebService.asmx/PartNumberByComponent',
                        contentType: "application/json;charset=utf-8",
                        data: JSON.stringify(mycheck),
                        success: function (data) {
                            //alert(mycheck);             
                            $("#dataTable").replaceWith(
                                ` <table class="table table-bordered " id="dataTable" width="100%" cellspacing="0">
                                    <thead>
                                        <tr>
                                            <th>料件編號</th>
                                            <th>元件</th>
                                            <th>供應商</th>
                                            <th>規格</th>
                                            <th>庫存數量</th>
                                            <th>數量最後修改時間</th>
                                            <th>功能</th>
                                        </tr>
                                    </thead>
                                        <tbody id="myTableBody">
                                        </tbody>
                                         <tfoot>
                                            <tr>
                                                <th>料件編號</th>
                                                <th>元件</th>
                                                <th>供應商</th>
                                                <th>規格</th>
                                                <th>庫存數量</th>
                                                <th>數量最後修改時間</th>
                                                <th>功能</th>
                                        </tr>
                                    </tfoot>
                                </table>
                                    `);
                            $(data.d).each(function (index, item) {
                                $("#dataTable").append(
                                    ` <tr>
                                    <td>PARTN${padLeft(item.id, 5)}</td>
                                    <td>${item.component}</td>
                                    <td>${item.vendor}</td>
                                    <td>${item.config}</td> 
                                    <td>${item.qty}</td>
                                   <td>${item.qtyDateStr}</td>
                                    <td>
                                          <a href="/prod/PartQtyEdit.aspx?id=${item.id}" class="btn btn-info btn-icon-split">
                                            <span class="icon text-white-50" >
                                              <i class="fas fa-info-circle"></i>
                                            </span>
                                            <span id="btnEdit" class="text" value="${item.id}" title="${item.id}" >修改</span>
                                          </a>                           
                                    </td>
                            </tr>`
                                )
                            });
                        },
                        error: function (x) {
                            //alert("error");
                            $("#dataTable").replaceWith(
                                ` <table class="table table-bordered " id="dataTable" width="100%" cellspacing="0">
                                    <thead>
                                        <tr>
                                          <th>料件編號</th>
                                        <th>元件</th>
                                        <th>供應商</th>
                                        <th>規格</th>
                                        <th>庫存數量</th>
                                        <th>數量最後修改時間</th>
                                        <th>功能</th>
                                        </tr>
                                    </thead>
                                        <tbody id="myTableBody">
                                        </tbody>
                                         <tfoot>
                                            <tr>
                                          <th>料件編號</th>
                                        <th>元件</th>
                                        <th>供應商</th>
                                        <th>規格</th>
                                        <th>庫存數量</th>
                                        <th>數量最後修改時間</th>
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

                //以vendor搜尋
                if ($("#myContent_DropDownList1").val() == "vendor") {
                    var mycheck = { vendor: $("#myContent_searchTextBox").val().replace(/^\s*|\s*$/g, "") };
                    $.ajax({
                        type: 'POST',
                        url: '/WebService.asmx/PartNumberByVendor',
                        contentType: "application/json;charset=utf-8",
                        data: JSON.stringify(mycheck),
                        success: function (data) {
                            //alert(mycheck);             
                            $("#dataTable").replaceWith(
                                ` <table class="table table-bordered " id="dataTable" width="100%" cellspacing="0">
                                    <thead>
                                        <tr>
                                            <th>料件編號</th>
                                            <th>元件</th>
                                            <th>供應商</th>
                                            <th>規格</th>
                                            <th>庫存數量</th>
                                            <th>數量最後修改時間</th>
                                            <th>功能</th>
                                        </tr>
                                    </thead>
                                        <tbody id="myTableBody">
                                        </tbody>
                                         <tfoot>
                                            <tr>
                                                <th>料件編號</th>
                                                <th>元件</th>
                                                <th>供應商</th>
                                                <th>規格</th>
                                                <th>庫存數量</th>
                                                <th>數量最後修改時間</th>
                                                <th>功能</th>
                                        </tr>
                                    </tfoot>
                                </table>
                                    `);
                            $(data.d).each(function (index, item) {
                                $("#dataTable").append(
                                    ` <tr>
                                    <td>PARTN${padLeft(item.id, 5)}</td>
                                    <td>${item.component}</td>
                                    <td>${item.vendor}</td>
                                    <td>${item.config}</td> 
                                    <td>${item.qty}</td>
                                   <td>${item.qtyDateStr}</td>
                                    <td>
                                          <a href="/prod/PartQtyEdit.aspx?id=${item.id}" class="btn btn-info btn-icon-split">
                                            <span class="icon text-white-50" >
                                              <i class="fas fa-info-circle"></i>
                                            </span>
                                            <span id="btnEdit" class="text" value="${item.id}" title="${item.id}" >修改</span>
                                          </a>                           
                                    </td>
                            </tr>`
                                )
                            });
                        },
                        error: function (x) {
                            //alert("error");
                            $("#dataTable").replaceWith(
                                ` <table class="table table-bordered " id="dataTable" width="100%" cellspacing="0">
                                    <thead>
                                        <tr>
                                          <th>料件編號</th>
                                        <th>元件</th>
                                        <th>供應商</th>
                                        <th>規格</th>
                                        <th>庫存數量</th>
                                        <th>數量最後修改時間</th>
                                        <th>功能</th>
                                        </tr>
                                    </thead>
                                        <tbody id="myTableBody">
                                        </tbody>
                                         <tfoot>
                                            <tr>
                                          <th>料件編號</th>
                                        <th>元件</th>
                                        <th>供應商</th>
                                        <th>規格</th>
                                        <th>庫存數量</th>
                                        <th>數量最後修改時間</th>
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

            });

        });






    </script>
</asp:Content>

