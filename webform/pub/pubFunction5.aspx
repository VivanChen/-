<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" %>

<script runat="server">

    protected void Button1_Click(object sender, EventArgs e)
    {
        Response.Redirect("pubFunction1checking.aspx");
    }
</script>
<asp:Content ID="Content2" ContentPlaceHolderID="myCss" runat="Server">
    <link href="../vendor/datatables/dataTables.bootstrap4.min.css" rel="stylesheet" />

</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="myContent" runat="Server">
    <!-- Begin Page Content -->
    <div class="container-fluid">

        <!-- Page Heading -->
        <h1 class="h3 mb-4 text-gray-800">打卡資訊</h1>

        <div class="row">

            <div class="col-lg-12">

                <!-- Circle Buttons -->
                <div class="card shadow mb-4">
                    <div class="card-header py-3">
                        <h6 class="m-0 font-weight-bold text-primary">搜尋員工編號</h6>
                        <input type="text" id="searchpcid" class="form-control" style="width:200px;display:inline-block"/>
<%--                        <input type="button" id="searchbtnid" class="btn btn-primary" value="搜尋" style="display:inline-block"/>--%>
                        <a href="#" id="searchbtnid" class="btn btn-primary btn-icon-split" style="display:inline-block" >
                        <span class="icon text-white-50">
                        <i class="fa fa-search"></i>
                        </span>
                        <span class="text">搜尋</span>
                        </a>
                        <asp:Button ID="Button1" runat="server" cssClass="btn btn-danger" Text="返回" style="display:inline-block" OnClick="Button1_Click" />
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        <input type="button" id ="useradmin" value="DEMO" class="btn btn-sm btn-info"/>

                    </div>
                    <div class="card-body">

                        <hr />
                        <div class="table-responsive">

                            <table class="table table-bordered" id="dataTable8" style="width: 100%;" cellspacing="0">
                                <thead>
                                    <tr>
                                        <%--<th>訂單編號</th>--%>
                                        <th>員工編號</th>
                                        <th>姓名</th>
                                        <th>打卡日期</th>
                                        <th>上班時間</th>
                                        <th>下班時間</th>
                                        <th>時數</th>
                                        <th>功能</th>
                                    </tr>
                                </thead>
                                <tbody id="myTableBody8">
     
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




    </div>

    <!-- /.container-fluid -->
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="myScript" runat="Server">
    <script src="/vendor/datatables/jquery.dataTables.min.js"></script>
    <script src="/vendor/datatables/dataTables.bootstrap4.min.js"></script>
    <script src="../js/prodUse.js"></script>
    <script>
        $(function () {
            $("#useradmin").click(function () {
                $("#searchpcid").val("A0001");
            });


            $("#searchbtnid").click(function () {
                $("#myTableBody8").empty();
                //location.href = "pubFunction5.aspx";
                var datapunchcardall = { id: parseInt($("#searchpcid").val().substring(4)) };
                var p = 0;
                $.ajax({
                    type: 'POST',
                    async:false,
                    url: '/WebService.asmx/GetAllPunchcardQuery',
                    contentType: "application/json;charset=utf-8",
                    data: JSON.stringify(datapunchcardall),
                    success: function (data) {
                        //alert("Hello");
                        $(data.d).each(function (index, item) {
                            p++;
                            
                            $("#myTableBody8").append(
                                `<tr id="pcalltr${p}">
                                        <td><input type="text id="pcid${p}" value="A${padLeft(item.Id,4)}" style="border:1px solid transparent;width:70px" readonly="true"/></td>
                                        <td><input type="text" id="pcname${p}" value="${item.Name}" style="border:1px solid transparent;width:100px" readonly="true"/></td>
                                        <td><input type="text" id="pcdate${p}" value="${item.Date}" style="border:1px solid transparent;width:200px" readonly="true"/></td>
                                        <td><input type="text" id="pcin${p}" value="${item.Punchin}" style="border:1px solid transparent;width:200px" readonly="true"/></td>
                                        <td><input type="text" id="pcout${p}" value="${item.Punchout}" style="border:1px solid transparent;width:200px" readonly="true"/></td>
                                        <td><input type="text" id="pchours${p}" value="${item.Hours}" style="border:1px solid transparent;width:100px" readonly="true"/></td>
                                        <td>
                                            <input type="hidden" id="hidden_punchcardallid${p}"  value="${item.PunchcardID}"/>
                                            <input type="hidden" id="hidden_punchcardalldpid${p}"  value="${item.DepartmentID}"/>
                                            <input type="hidden" id ="hidden_punchcardallName${p}" value="${item.Id}"/>
                                            <input type="button" id="punchcardallUpdate_btn${p}"  class="btn btn-info" title="${p}" value="修改" onclick="return false"/>
                                            <input type="button" id="punchcardallDelete_btn${p}"  class="btn btn-danger" title="${p}" value="刪除" onclick="return false"/>
                                            <input type="button" id="punchcardallUpdateComplete_btn${p}"  class="btn btn-success" title="${p}" value="完成" onclick="return false" style="display:none;"/>
                                            <input type="button" id="punchcardallUpdateCancel_btn${p}"  class="btn btn-warning" title="${p}" value="取消" onclick="return false" style="display:none;"/>
                                        </td>
                                    </tr>`);
                            $(`#punchcardallUpdate_btn${p}`).click(function () {
                                var u = $(this).attr("title");
                                $("#pcalltr" + u + " input").css("border", "1px solid black");
                                $("#pcalltr" + u + " input").removeAttr("readonly");
                                $("#punchcardallUpdate_btn" + u).css("display", "none");
                                $("#punchcardallDelete_btn" + u).css("display", "none");
                                $("#punchcardallUpdateComplete_btn" + u).css("display","");
                                $("#punchcardallUpdateCancel_btn" + u).css("display", "");
                            });
                            $(`#punchcardallUpdateComplete_btn${p}`).click(function () {
                                var ucomp = $(this).attr("title");
                                $("#pcalltr" + ucomp + " input").css("border", "1px solid transparent");
                                $("#pcalltr" + ucomp + " input").attr("readonly","true");
                                $("#punchcardallUpdate_btn" + ucomp).css("display", "");
                                $("#punchcardallDelete_btn" + ucomp).css("display", "");
                                $("#punchcardallUpdateComplete_btn" + ucomp).css("display","none");
                                $("#punchcardallUpdateCancel_btn" + ucomp).css("display", "none");
                                var dataupdatepc = { id: parseInt($("#hidden_punchcardallName" + ucomp).val()), name: $("#pcname" + ucomp).val(), departmentid: $("#hidden_punchcardalldpid" + ucomp).val(), date: $("#pcdate" + ucomp).val(), punchin: $("#pcin" + ucomp).val(), punchout: $("#pcout" + ucomp).val(), hours: $("#pchours" + ucomp).val() };
                                $.ajax({
                                    type: 'POST',
                                    async:false,
                                    url: '/WebService.asmx/UpdatePunchcard',
                                    contentType: "application/json;charset=utf-8",
                                    data: JSON.stringify(dataupdatepc),
                                    success: function (data) {
                                        //alert("新增成功")

                                        //location.href="pubFunction3.aspx";
                                    },
                                    error: function (x) {
                                        alert("company add error");
                                    }
                                });

                            });
                            $(`#punchcardallUpdateCancel_btn${p}`).click(function () {
                                var uc = $(this).attr("title");
                                $("#pcalltr" + uc + " input").css("border", "1px solid transparent");
                                $("#pcalltr" + uc + " input").attr("readonly","true");
                                $("#punchcardallUpdate_btn" + uc).css("display", "");
                                $("#punchcardallDelete_btn" + uc).css("display", "");
                                $("#punchcardallUpdateComplete_btn" + uc).css("display","none");
                                $("#punchcardallUpdateCancel_btn" + uc).css("display", "none");
                                //location.href = "pubFunction5.aspx";
                                //alert(parseInt($("#searchpcid").val()));

                            });

                            $(`#punchcardallDelete_btn${p}`).click(function () {
                                var d = $(this).attr("title");
                                if (confirm("確定要取消訂單嗎?") == true) {
                                    var data8 = { id: $("#hidden_punchcardallid" + d).val() };
                                               $.ajax({
                                                   type: 'POST',
                                                   async:false,
                                                   url: '/WebService.asmx/DeletePunchcardById',
                                                   contentType: "application/json;charset=utf-8",
                                                   data: JSON.stringify(data8),
                                                   success: function (data) {

                                                   },
                                                   error: function (x) {
                                                       alert("delete error");
                                                   }
                                               });
                                               $("#pcalltr" + d).remove();

                                           }

                                       });

                                })
                                $("#dataTable8").DataTable();
                            },
                            error: function (x) {
                                alert("show error");
                            }
                        });

                });
            //Final Order Info
            //var dataorderFinal = { get: 1 };
            //var f = 0;
            //var Lasttotal = 0;
            //$.ajax({
            //    type: 'POST',
            //    url: '/WebService.asmx/GetLunchOrdersQueryFinal',
            //    contentType: "application/json;charset=utf-8",
            //    data: JSON.stringify(dataorderFinal),
            //    success: function (data) {
            //        //alert("Hello");           
            //        var totaltotal = 0;
            //        $(data.d).each(function (index, item) {
            //            f++;
                        
            //            $("#myTableBody5").append(
            //                `<tr id="orderFinaltr${f}" title="${f}">
            //                        <td>${item.OrderInfo}</td>
            //                        <td>${item.OrderCount}</td>
            //                        <td id="orderprice${f}" title="${item.OrderPrice}">${item.OrderPrice}</td>
            //                    </tr>
            //            `);
            //            Lasttotal += parseInt($("#orderprice"+f).attr("title"));
            //        })
            //        $("#LastTotalPrice").val(Lasttotal);
            //        //alert(Lasttotal);
            //    },
            //    error: function (x) {
            //        alert("show error");
            //    }
            //});
            //Final Order Info end
        });
    </script>
</asp:Content>

