<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" %>

<script runat="server">

    protected void Page_Load(object sender, EventArgs e)
    {
        Employee emp = EmployeesUtility.FindEmployeeById(Convert.ToInt32(HttpContext.Current.User.Identity.Name));
        HiddenUserID.Value = HttpContext.Current.User.Identity.Name;
        HiddenFieldID.Value = emp.EmployeeID.ToString();
        HiddenFieldName.Value = emp.Name;
        HiddenFieldDate.Value = DateTime.Now.ToShortDateString();
        if (Session["ShowMenu"] == null)
        {
            Session["ShowMenu"] = 0;
        }
        HiddenSession.Value = Session["ShowMenu"].ToString();
        if (Session["ShowMenuname"] == null)
        {
            Session["ShowMenuname"] = "無";
        }
        //HiddenSessionname.Value = Session["ShowMenuname"].ToString();
        menuCompanyName_txt.Text = Session["ShowMenuname"].ToString();
    }


    protected void Button2_Click(object sender, EventArgs e)
    {
        Response.Redirect("/pub/pubFunction4.aspx");
    }
</script>
<asp:Content ID="Content2" ContentPlaceHolderID="myCss" runat="Server">
    <link href="../Scripts/sweetalert/sweetalert2.min.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="myContent" runat="Server">
    <!-- Begin Page Content -->
    <div class="container-fluid">

        <!-- Page Heading -->
        <h1 class="h3 mb-4 text-gray-800">訂餐系統</h1>

        <div class="row">

            <div class="col-lg-12">

                <!-- Circle Buttons -->
                <div class="card shadow mb-4">
                    <div class="card-header py-3">
                        <h6 class="m-0 font-weight-bold text-primary">廠商名稱:<asp:Label ID="menuCompanyName_txt" runat="server" Text="Label" ForeColor="Black"></asp:Label>
                            <%--                            <input type="text" id="menuCompanyName_txt" style="border:0px;background-color:rgba(255,255,255,0.2)"/>--%>
                        </h6>
                        <span>
                            <!--菜單選單-->
                            <select id="ChoseMenuaddhere">
                            </select>
                            <%--                          <a href="#"  id="choseshowmenu" class="btn btn-primary btn-icon-split" onclick="return false">
                            <span class="icon text-white-50">
                              <i class="fa fa-bullhorn"></i>
                            </span>
                            <span class="text">發布</span>
                          </a>--%>
                            <input type="button" id="choseshowmenu" class="btn btn-primary" value="發布" onclick="return false" />
                            <asp:HiddenField ID="HiddenUserID" runat="server" />
                        </span>
                        <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="~/pub/pubFunction3.aspx" CssClass="btn btn-info" ><i class="fa fa-list" aria-hidden="true"></i> &nbsp;廠商資訊</asp:HyperLink>
                        <asp:HyperLink ID="HyperLink2" runat="server" NavigateUrl="~/pub/pubFunction4.aspx" CssClass="btn btn-warning" ><i class="fa fa-list" aria-hidden="true"></i> &nbsp;訂餐資訊</asp:HyperLink>

<%--                        <asp:Button ID="Button1" runat="server" Text="廠商資訊" CssClass="btn btn-info" onclick="Button1_Click"/>--%>
<%--                        <asp:Button ID="Button2" runat="server" Text="訂餐資訊" CssClass="btn btn-warning" onclick="Button2_Click"/>--%>

                        <asp:HiddenField ID="Hiddenchose" runat="server" />
                        <asp:HiddenField ID="Hiddenchosename" runat="server" />
                        <asp:HiddenField ID="HiddenSession" runat="server" />
                        <asp:HiddenField ID="HiddenSessionname" runat="server" />
                        <asp:HiddenField ID="HiddenFieldID" runat="server" />
                        <asp:HiddenField ID="HiddenFieldName" runat="server" />
                        <asp:HiddenField ID="HiddenFieldDate" runat="server" />
                    </div>
                    <div class="card-body">
                        <div id="addhere" class="row">
                            <!--菜單資訊新增在這-->
                        </div>
                        <hr />
                        <a href="#" id="confirmOrder_btn" class="btn btn-success btn-icon-split" onclick="return false">
                            <span class="icon text-white-50">
                                <i class="fa fa-plus"></i>
                            </span>
                            <span class="text">訂餐</span>
                        </a>
                    </div>

                </div>
            </div>
            <%--            <div class="col-lg-2">

                <div class="card shadow mb-4">
                    <div class="card-header py-3">
                        <h6 class="m-0 font-weight-bold text-primary">Split Buttons with Icon</h6>
                    </div>
                    <div class="card-body">
                        <p>Works with any button colors, just use the <code>.btn-icon-split</code> class and the markup in the examples below. The examples below also use the <code>.text-white-50</code> helper class on the icons for additional styling, but it is not required.</p>
  
                    </div>
                </div>

            </div>--%>
        </div>
        <!-- Brand Buttons -->
        <div class="card shadow mb-4">
            <div class="card-header py-3">
                <h6 class="m-0 font-weight-bold text-primary">訂餐資訊</h6>
            </div>
            <div class="card-body">
                <div class="table-responsive">

                    <table class="table table-bordered" id="dataTable3" style="width: 100%;">
                        <thead>
                            <tr>
                                <th>訂單編號</th>
                                <th>員工編號</th>
                                <th>訂單日期</th>
                                <th>姓名</th>
                                <th>訂單資訊</th>
                                <th>訂單數量</th>
                                <th>訂單價格</th>
                                <th>功能</th>
                            </tr>
                        </thead>
                        <tbody id="myTableBody3">
                        </tbody>
                    </table>
                </div>
                <hr />
                <hr />
                <div style="text-align: right; margin-right: 100px;">總金額：<input type="text" id="LastTotalPrice" style="text-align: right; border: 0px; background-color: rgba(255,255,255,0.2)" />&nbsp;元</div>

                <%--                        <div style="text-align:right;margin-right:100px;">訂單金額：<input type="text" id="orderTotalPrice" style="text-align:right;border:0px;background-color: rgba(255,255,255,0.2)"/>&nbsp;元</div>--%>
            </div>
        </div>



    </div>

    <!-- /.container-fluid -->
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="myScript" runat="Server">
    <script src="../js/prodUse.js"></script>
    <script src="../Scripts/sweetalert/sweetalert2.min.js"></script>
    <script>
        $(function () {
            if ($("#myContent_HiddenUserID").val() != "1") {
                $("#ChoseMenuaddhere").css("display", "none");
                $("#choseshowmenu").css("display", "none");
                $("#myContent_HyperLink1").css("display", "none");
                $("#myContent_HyperLink2").css("display", "none");
            }


            var dataselect = { get: 1 };
            var s = 0;

            $.ajax({
                type: 'POST',
                async:false,
                url: '/WebService.asmx/GetLunchCompanysQuery',
                contentType: "application/json;charset=utf-8",
                data: JSON.stringify(dataselect),
                success: function (data) {
                    $(data.d).each(function (index, item) {
                        s++;
                        $("#ChoseMenuaddhere").append(
                            `
                                <option id="menu${s}" title="${s}" value="${item.LunchCompanyID}">${item.LunchCompanyName}</option>

                               `);

                    })

                },
                error: function (x) {
                    alert("select error");
                }
            });
            //發布button 抓下拉選單的value
            $("#choseshowmenu").click(function () {
                $("#myContent_Hiddenchose").val($("#ChoseMenuaddhere").val());

                //送webservice 找廠商名稱 存session and get return 廠商名稱
                var datamenunamebar = { name: $("#myContent_Hiddenchose").val() };

                $.ajax({
                    type: 'POST',
                    async:false,
                    url: '/WebService.asmx/Getmenubarnamebyid',
                    contentType: "application/json;charset=utf-8",
                    data: JSON.stringify(datamenunamebar),
                    success: function (data) {
                        //$("#myContent_menuCompanyName_txt").text(data.d);
                    },
                    error: function (x) {
                        alert("session name error");
                    }
                });

                var datasession = { get: $("#myContent_Hiddenchose").val() };

                $.ajax({
                    type: 'POST',
                    async:false,
                    url: '/WebService.asmx/SavetoSession',
                    contentType: "application/json;charset=utf-8",
                    data: JSON.stringify(datasession),
                    success: function (data) {


                    },
                    error: function (x) {
                        alert("session error2");
                    }
                });


                $("#addhere div").remove();
                //$("#addhere div").empty();

                //
                //var menu =parseInt($("#myContent_Hiddenchose").val());

                //var data = { id: menu };
                //var i = 0;

                //$.ajax({
                //    type: 'POST',
                //    url: '/WebService.asmx/GetMenusQueryById',
                //    contentType: "application/json;charset=utf-8",
                //    data: JSON.stringify(data),
                //    success: function (data) {
                //        $(data.d).each(function (index, item) {
                //            i++;
                //            $("#addhere").append(
                //                `<div id="no${i}" class="col-lg-2 col-md-4 col-sm-1" style="text-align:right;border:1px solid white;background-color:#f5f5f5;">
                //                        <span id="orderLunchName${i}">${item.LunchName}</span>
                //                        <b>$</b>
                //                        <span id="orderLunchPrice${i}" >${item.Price}</span>
                //                        <span><input type="text" id=ordercount_txt${i} title="${i}" style="width:30px;"  value="0" placeholder="0"/></span>
                //                    </div>`);

                //        })
                //    },
                //    error: function (x) {
                //        alert("error");
                //    }
                //});
                //
                window.setTimeout("window.location='pubFunction2.aspx'",1000);

                //location.href = "pubFunction2.aspx";

                //$("#menuCompanyName_txt").val($("#myContent_HiddenSessionname").val());
            });



            var menu = parseInt($("#myContent_HiddenSession").val());

            var data = { id: menu };
            var i = 0;

            $.ajax({
                type: 'POST',
                async:false,
                url: '/WebService.asmx/GetMenusQueryById',
                contentType: "application/json;charset=utf-8",
                data: JSON.stringify(data),
                success: function (data) {
                    $(data.d).each(function (index, item) {
                        i++;
                        $("#addhere").append(
                            `<div id="no${i}" class="col-lg-2 col-md-4 col-sm-1" style="text-align:right;border:1px solid white;background-color:#f5f5f5;">
                                        <span id="orderLunchName${i}">${item.LunchName}</span>
                                        <b>$</b>
                                        <span id="orderLunchPrice${i}" >${item.Price}</span>
                                        <span><input type="text" id=ordercount_txt${i} title="${i}" style="width:30px;"  value="0" placeholder="0"/></span>
                                    </div>`);

                    })

                },
                error: function (x) {
                    alert("error");
                }
            });
            //新增訂單
            $("#confirmOrder_btn").click(function () {
                var total = 0;
                var order = "";
                var Count = 0;
                for (var c = 1; c <= i; c++) {
                    //alert(c);
                    if (parseInt($("#ordercount_txt" + c).val()) != parseInt($("#ordercount_txt" + c).attr("value"))) {
                        order = $("#orderLunchName" + c).text();
                        Count = parseInt($("#ordercount_txt" + c).val());
                        total = Math.floor(parseFloat($("#orderLunchPrice" + c).text()) * parseInt($("#ordercount_txt" + c).val()));
                        var data1 = { id: $("#myContent_HiddenFieldID").val(), date: $("#myContent_HiddenFieldDate").val(), name: $("#myContent_HiddenFieldName").val(), order: order, count: Count, price: total };
                        $.ajax({
                            type: 'POST',
                            async:false,
                            url: '/WebService.asmx/OrderAdd',
                            contentType: "application/json;charset=utf-8",
                            data: JSON.stringify(data1),
                            success: function (data) {
                            },
                            error: function (x) {
                                alert("Confirmorder add error");
                            }
                        });
                    }

                }
                //alert(total);
                //alert(order);
                window.location = 'pubFunction2.aspx';
                //location.href = "pubFunction2.aspx";



            });
            //新增訂單end
            //訂單資訊
            var dataorder = { id: $("#myContent_HiddenFieldID").val() };
            var o = 0;
            var Lasttotal = 0;
            $.ajax({
                type: 'POST',
                async:false,
                url: '/WebService.asmx/GetLunchOrderQueryById',
                contentType: "application/json;charset=utf-8",
                data: JSON.stringify(dataorder),
                success: function (data) {
                    //alert("Hello");
                    $(data.d).each(function (index, item) {
                        o++;

                        $("#myTableBody3").append(
                            `<tr id="ordertr${o}">
                                    <td>${item.LunchOrderID}</td>
                                    <td>A${padLeft(item.EmployeeID, 4)}</td>
                                    <td>${item.OrderDate}</td>
                                    <td>${item.OrderName}</td>
                                    <td>${item.OrderInfo}</td>
                                    <td>${item.OrderCount}</td>
                                    <td id="orderprice${o}" title="${item.OrderPrice}">${item.OrderPrice}</td>
                                    <td>
                                        <input type="hidden" id="hidden_LunchOrderid${o}"  value="${item.LunchOrderID}"/>
                                        <input type="hidden" id ="hidden_LunchOrderName${o}" value="${item.EmployeeID}"/>
                                        <a href="#" id="orderDelete_btn${o}" class="btn btn-danger btn-icon-split" title="${o}">
                                        <span class="icon text-white-50">
                                            <i class="fas fa-trash"></i>
                                        </span>
                                        <span class="text">刪除</span>
                                        </a>
                                    </td>
                                </tr>`);
                        Lasttotal += parseInt($("#orderprice" + o).attr("title"));

                        $(`#orderDelete_btn${o}`).click(function () {
                            var d = $(this).attr("title");
                            swal({
                                title: '確認?',
                                text: "訂單即將被刪除!",
                                type: 'warning',
                                showCancelButton: true,
                            }).then(
                                function () {

                                    var data5 = { orderid: $("#hidden_LunchOrderid" + d).val() };
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

                                    $("#ordertr" + d).remove();

                                    swal('完成!', '訂單已經刪除', 'success')
                                },
                                function (dismiss) {
                                    if (dismiss === 'cancel') {
                                        swal('取消', '訂單未被刪除', 'error')
                                    }
                                });


                        });

                    })
                    $("#LastTotalPrice").val(Lasttotal);

                },
                error: function (x) {
                    alert("show error");
                }
            });
        });//pageloadend


    </script>
</asp:Content>

