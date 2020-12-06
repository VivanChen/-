<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" %>

<script runat="server">

    protected void Page_Load(object sender, EventArgs e)
    {
        //Hiddendate.Value = DateTime.Now.ToShortDateString();
        Hiddentodaydate.Value = DateTime.Now.ToShortDateString();
    }

    protected void Button1_Click(object sender, EventArgs e)
    {
        Response.Redirect("OrderToExcel.aspx");
    }

    protected void Button2_Click(object sender, EventArgs e)
    {
        Response.Redirect("pubFunction2.aspx");
    }
</script>
<asp:Content ID="Content2" ContentPlaceHolderID="myCss" runat="Server">
    <link href="../vendor/datatables/dataTables.bootstrap4.min.css" rel="stylesheet" />
    <link href="../Scripts/sweetalert/sweetalert2.min.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="myContent" runat="Server">
    <!-- Begin Page Content -->
    <div class="container-fluid">

        <!-- Page Heading -->
        <h1 class="h3 mb-4 text-gray-800">訂餐資訊</h1>

        <div class="row">

            <div class="col-lg-12">

                <!-- Circle Buttons -->
                <div class="card shadow mb-4">
                    <div class="card-header py-3">
                        <h6 class="m-0 font-weight-bold text-primary">訂單資訊</h6>
                    </div>
                    <div class="card-body">
                        <input type="text" id="searchorderdate_txt" placeholder="" /><span style="color: red;">範例：2020/7/19</span>
                        <a href="#" id="searchorder_btn" class="btn btn-secondary btn-icon-split">
                            <span class="icon text-white-50">
                                <i class="fa fa-search"></i>
                            </span>
                            <span class="text">搜尋</span>
                        </a>
                        <a href="#" id="searchhistroyorder" class="btn btn-secondary btn-icon-split">
                            <span class="icon text-white-50">
                                <i class="fa fa-search"></i>
                            </span>
                            <span class="text">歷史訂單</span>
                        </a>
                        <hr />
                        <div class="table-responsive">

                            <table class="table table-bordered" id="dataTable4" style="width: 100%;" cellspacing="0">
                                <thead>
                                    <tr>
                                        <%--<th>訂單編號</th>--%>
                                        <th>員工編號</th>
                                        <th>訂單日期</th>
                                        <th>姓名</th>
                                        <th>訂單資訊</th>
                                        <th>訂單數量</th>
                                        <th>訂單價格</th>
                                        <th>功能</th>
                                    </tr>
                                </thead>
                                <tbody id="myTableBody4">
                                </tbody>
                            </table>
                        </div>
                        <hr />

                    </div>

                </div>
            </div>
            <%--                        <div class="col-lg-6">

                <div class="card shadow mb-4">
                    <div class="card-header py-3">
                        <h6 class="m-0 font-weight-bold text-primary">廠商名單</h6>
                    </div>
                    <div class="card-body">

                    </div>
                </div>

            </div>--%>
        </div>

        <!-- Brand Buttons -->
        <div class="card shadow mb-4">
            <div class="card-header py-3">
                <h6 class="m-0 font-weight-bold text-primary">結算</h6>
                <asp:HiddenField ID="Hiddendate" runat="server" />
                <asp:HiddenField ID="Hiddentodaydate" runat="server" />

            </div>
            <div class="card-body">
                <div class="table-responsive">

                    <table class="table-bordered" id="dataTable5" style="width: 100%;" cellspacing="0">
                        <thead>
                            <tr>
                                <th>訂單資訊</th>
                                <th>訂單數量</th>
                                <th>訂單價格</th>
                            </tr>
                        </thead>
                        <tbody id="myTableBody5">
                        </tbody>
                    </table>
                </div>
                <hr />
                <asp:Button ID="Button1" runat="server" Text="輸出Excel" CssClass="btn btn-success" OnClick="Button1_Click"/>
                <asp:Button ID="Button2" runat="server" Text="返回" CssClass="btn btn-danger" OnClick="Button2_Click" />

                <div style="text-align: right; margin-right: 100px;">總金額：<input type="text" id="LastTotalPrice" style="text-align: right; border: 0px; background-color: rgba(255,255,255,0.2)" />&nbsp;元</div>
            </div>
        </div>



    </div>

    <!-- /.container-fluid -->
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="myScript" runat="Server">
    <script src="/vendor/datatables/jquery.dataTables.min.js"></script>
    <script src="/vendor/datatables/dataTables.bootstrap4.min.js"></script>
    <script src="../js/prodUse.js"></script>
    <script src="../Scripts/sweetalert/sweetalert2.min.js"></script>
    <script>
        $(function () {
            //1
            var dataorderbydate = { date: $("#myContent_Hiddentodaydate").val() };
            var o = 0;
            $.ajax({
                type: 'POST',
                async:false,
                url: '/WebService.asmx/GetLunchOrdersQueryByDate',
                contentType: "application/json;charset=utf-8",
                data: JSON.stringify(dataorderbydate),
                success: function (data) {
                    //alert("Hello");
                    $(data.d).each(function (index, item) {
                        o++;

                        $("#myTableBody4").append(
                            `<tr id="orderalltr${o}">
                                    <td>A${padLeft(item.EmployeeID, 4)}</td>
                                    <td>${item.OrderDate}</td>
                                    <td>${item.OrderName}</td>
                                    <td>${item.OrderInfo}</td>
                                    <td>${item.OrderCount}</td>
                                    <td>${item.OrderPrice}</td>
                                    <td>
                                        <input type="hidden" id="hidden_LunchOrderallid${o}"  value="${item.LunchOrderID}"/>
                                        <input type="hidden" id ="hidden_LunchOrderallName${o}" value="${item.EmployeeID}"/>
                                        <a href="#" id="orderallDelete_btn${o}" class="btn btn-danger btn-icon-split" title="${o}">
                                        <span class="icon text-white-50">
                                            <i class="fas fa-trash"></i>
                                        </span>
                                        <span class="text">刪除</span>
                                        </a>
                                    </td>
                                </tr>`);
                        $(`#orderallDelete_btn${o}`).click(function () {
                            var d = $(this).attr("title");
                            swal({
                                title: '確認?',
                                text: "訂單即將被刪除!",
                                type: 'warning',
                                showCancelButton: true,
                            }).then(
                                function () {

                                    var data5 = { orderid: $("#hidden_LunchOrderallid" + d).val() };
                                    $.ajax({
                                        type: 'POST',
                                        async:false,
                                        url: '/WebService.asmx/DeleteLunchOrderByOrderId',
                                        contentType: "application/json;charset=utf-8",
                                        data: JSON.stringify(data5),
                                        success: function (data) {

                                        },
                                        error: function (x) {
                                            alert("delete error");
                                        }
                                    });
                                    $("#orderalltr" + d).remove();
                                    $("#myTableBody5").empty();
                                    //location.href = "pubFunction4.aspx";

                                    swal('完成!', '訂單已經刪除', 'success')
                                },
                                function (dismiss) {
                                    if (dismiss === 'cancel') {
                                        swal('取消', '訂單未被刪除', 'error')
                                    }
                                });
                            //if (confirm("確定要取消訂單嗎?") == true) {
                            //    var data5 = { orderid: $("#hidden_LunchOrderallid"+d).val() };
                            //    $.ajax({
                            //        type: 'POST',
                            //        url: '/WebService.asmx/DeleteLunchOrderByOrderId',
                            //        contentType: "application/json;charset=utf-8",
                            //        data: JSON.stringify(data5),
                            //        success: function (data) {

                            //        },
                            //        error: function (x) {
                            //            alert("delete error");
                            //        }
                            //    });
                            //    $("#orderalltr" + d).remove();
                            //    $("#myTableBody5").empty();
                            //    location.href = "pubFunction4.aspx";

                            //}

                        });

                    })
                    $("#dataTable4").DataTable();
                },
                error: function (x) {
                    alert("show error");
                }
            });
            //

            //$("#dataTable4_filter input").val($("#myContent_Hiddendate").val());
            $("#myTableBody5").empty();
            //Final Order Info by date
            var dataorderFinalbydate = { date: $("#myContent_Hiddentodaydate").val() };
            var f = 0;
            var Lasttotal = 0;
            $.ajax({
                type: 'POST',
                async:false,
                url: '/WebService.asmx/GetLunchOrdersQueryFinalByDate',
                contentType: "application/json;charset=utf-8",
                data: JSON.stringify(dataorderFinalbydate),
                success: function (data) {
                    //alert("Hello");           
                    var totaltotal = 0;
                    $(data.d).each(function (index, item) {
                        f++;

                        $("#myTableBody5").append(
                            `<tr id="orderFinaltr${f}" title="${f}">
                                        <td>${item.OrderInfo}</td>
                                        <td>${item.OrderCount}</td>
                                        <td id="orderprice${f}" title="${item.OrderPrice}">${item.OrderPrice}</td>
                                    </tr>
                            `);
                        Lasttotal += parseInt($("#orderprice" + f).attr("title"));
                    })
                    $("#LastTotalPrice").val(Lasttotal);
                    //alert(Lasttotal);
                },
                error: function (x) {
                    alert("show error");
                }
            });
            //1
            $("#searchorder_btn").click(function () {
                $("#myContent_Hiddendate").val($("#searchorderdate_txt").val());
                $("#myTableBody4").empty();
                //
                var dataorderbydate = { date: $("#myContent_Hiddendate").val() };
                var o = 0;
                $.ajax({
                    type: 'POST',
                    async:false,
                    url: '/WebService.asmx/GetLunchOrdersQueryByDate',
                    contentType: "application/json;charset=utf-8",
                    data: JSON.stringify(dataorderbydate),
                    success: function (data) {
                        //alert("Hello");
                        $(data.d).each(function (index, item) {
                            o++;

                            $("#myTableBody4").append(
                                `<tr id="orderalltr${o}">
                                    <td>A${padLeft(item.EmployeeID, 4)}</td>
                                    <td>${item.OrderDate}</td>
                                    <td>${item.OrderName}</td>
                                    <td>${item.OrderInfo}</td>
                                    <td>${item.OrderCount}</td>
                                    <td>${item.OrderPrice}</td>
                                    <td>
                                        <input type="hidden" id="hidden_LunchOrderallid${o}"  value="${item.LunchOrderID}"/>
                                        <input type="hidden" id ="hidden_LunchOrderallName${o}" value="${item.EmployeeID}"/>
                                        <a href="#" id="orderallDelete_btn${o}" class="btn btn-danger btn-icon-split" title="${o}">
                                        <span class="icon text-white-50">
                                            <i class="fas fa-trash"></i>
                                        </span>
                                        <span class="text">刪除</span>
                                        </a>
                                    </td>
                                </tr>`);
                            $(`#orderallDelete_btn${o}`).click(function () {
                                var d = $(this).attr("title");
                                swal({
                                    title: '確認?',
                                    text: "訂單即將被刪除!",
                                    type: 'warning',
                                    showCancelButton: true,
                                }).then(
                                    function () {

                                        var data5 = { orderid: $("#hidden_LunchOrderallid" + d).val() };
                                        $.ajax({
                                            type: 'POST',
                                            async:false,
                                            url: '/WebService.asmx/DeleteLunchOrderByOrderId',
                                            contentType: "application/json;charset=utf-8",
                                            data: JSON.stringify(data5),
                                            success: function (data) {

                                            },
                                            error: function (x) {
                                                alert("delete error");
                                            }
                                        });
                                        $("#orderalltr" + d).remove();
                                        $("#myTableBody5").empty();
                                        //location.href = "pubFunction4.aspx";

                                        swal('完成!', '訂單已經刪除', 'success')
                                    },
                                    function (dismiss) {
                                        if (dismiss === 'cancel') {
                                            swal('取消', '訂單未被刪除', 'error')
                                        }
                                    });
                                //if (confirm("確定要取消訂單嗎?") == true) {
                                //    var data5 = { orderid: $("#hidden_LunchOrderallid"+d).val() };
                                //    $.ajax({
                                //        type: 'POST',
                                //        url: '/WebService.asmx/DeleteLunchOrderByOrderId',
                                //        contentType: "application/json;charset=utf-8",
                                //        data: JSON.stringify(data5),
                                //        success: function (data) {

                                //        },
                                //        error: function (x) {
                                //            alert("delete error");
                                //        }
                                //    });
                                //    $("#orderalltr" + d).remove();
                                //    $("#myTableBody5").empty();
                                //    location.href = "pubFunction4.aspx";

                                //}

                            });

                        })
                        $("#dataTable4").DataTable();
                    },
                    error: function (x) {
                        alert("show error");
                    }
                });
                //

                //$("#dataTable4_filter input").val($("#myContent_Hiddendate").val());
                $("#myTableBody5").empty();
                //Final Order Info by date
                var dataorderFinalbydate = { date: $("#myContent_Hiddendate").val() };
                var f = 0;
                var Lasttotal = 0;
                $.ajax({
                    type: 'POST',
                    async:false,
                    url: '/WebService.asmx/GetLunchOrdersQueryFinalByDate',
                    contentType: "application/json;charset=utf-8",
                    data: JSON.stringify(dataorderFinalbydate),
                    success: function (data) {
                        //alert("Hello");           
                        var totaltotal = 0;
                        $(data.d).each(function (index, item) {
                            f++;

                            $("#myTableBody5").append(
                                `<tr id="orderFinaltr${f}" title="${f}">
                                        <td>${item.OrderInfo}</td>
                                        <td>${item.OrderCount}</td>
                                        <td id="orderprice${f}" title="${item.OrderPrice}">${item.OrderPrice}</td>
                                    </tr>
                            `);
                            Lasttotal += parseInt($("#orderprice" + f).attr("title"));
                        })
                        $("#LastTotalPrice").val(Lasttotal);
                        //alert(Lasttotal);
                    },
                    error: function (x) {
                        alert("show error");
                    }
                });
                //Final Order Info by date end
            });
            $("#searchhistroyorder").click(function () {
                $("#myTableBody4").empty();

                var dataorderall = { get: 1 };
                var o = 0;
                $.ajax({
                    type: 'POST',
                    async:false,
                    url: '/WebService.asmx/GetLunchOrdersQuery',
                    contentType: "application/json;charset=utf-8",
                    data: JSON.stringify(dataorderall),
                    success: function (data) {
                        //alert("Hello");
                        $(data.d).each(function (index, item) {
                            o++;

                            $("#myTableBody4").append(
                                `<tr id="orderalltr${o}">
                                    <td>A${padLeft(item.EmployeeID, 4)}</td>
                                    <td>${item.OrderDate}</td>
                                    <td>${item.OrderName}</td>
                                    <td>${item.OrderInfo}</td>
                                    <td>${item.OrderCount}</td>
                                    <td>${item.OrderPrice}</td>
                                    <td>
                                        <input type="hidden" id="hidden_LunchOrderallid${o}"  value="${item.LunchOrderID}"/>
                                        <input type="hidden" id ="hidden_LunchOrderallName${o}" value="${item.EmployeeID}"/>
                                        <a href="#" id="orderallDelete_btn${o}" class="btn btn-danger btn-icon-split" title="${o}">
                                        <span class="icon text-white-50">
                                            <i class="fas fa-trash"></i>
                                        </span>
                                        <span class="text">刪除</span>
                                        </a>
                                    </td>
                                </tr>`);
                            $(`#orderallDelete_btn${o}`).click(function () {
                                var d = $(this).attr("title");
                                swal({
                                    title: '確認?',
                                    text: "訂單即將被刪除!",
                                    type: 'warning',
                                    showCancelButton: true,
                                }).then(
                                    function () {

                                        var data5 = { orderid: $("#hidden_LunchOrderallid" + d).val() };
                                        $.ajax({
                                            type: 'POST',
                                            async:false,
                                            url: '/WebService.asmx/DeleteLunchOrderByOrderId',
                                            contentType: "application/json;charset=utf-8",
                                            data: JSON.stringify(data5),
                                            success: function (data) {

                                            },
                                            error: function (x) {
                                                alert("delete error");
                                            }
                                        });
                                        $("#orderalltr" + d).remove();
                                        $("#myTableBody5").empty();
                                        //location.href = "pubFunction4.aspx";

                                        swal('完成!', '訂單已經刪除', 'success')
                                    },
                                    function (dismiss) {
                                        if (dismiss === 'cancel') {
                                            swal('取消', '訂單未被刪除', 'error')
                                        }
                                    });


                            });

                        })
                        $("#dataTable4").DataTable();
                    },
                    error: function (x) {
                        alert("show error");
                    }
                });
                //Final Order Info
                $("#myTableBody5").empty();

                var dataorderFinal = { get: 1 };
                var f = 0;
                var Lasttotal = 0;
                $.ajax({
                    type: 'POST',
                    async:false,
                    url: '/WebService.asmx/GetLunchOrdersQueryFinal',
                    contentType: "application/json;charset=utf-8",
                    data: JSON.stringify(dataorderFinal),
                    success: function (data) {
                        //alert("Hello");           
                        var totaltotal = 0;
                        $(data.d).each(function (index, item) {
                            f++;

                            $("#myTableBody5").append(
                                `<tr id="orderFinaltr${f}" title="${f}">
                                    <td>${item.OrderInfo}</td>
                                    <td>${item.OrderCount}</td>
                                    <td id="orderprice${f}" title="${item.OrderPrice}">${item.OrderPrice}</td>
                                </tr>
                        `);
                            Lasttotal += parseInt($("#orderprice" + f).attr("title"));
                        })
                        $("#LastTotalPrice").val(Lasttotal);
                        //alert(Lasttotal);
                    },
                    error: function (x) {
                        alert("show error");
                    }
                });
                //Final Order Info end
                //location.href = "pubFunction4.aspx";
            });
        });
    </script>
</asp:Content>

