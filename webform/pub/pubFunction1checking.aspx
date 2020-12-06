<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" %>

<script runat="server">

    protected void Page_Load(object sender, EventArgs e)
    {

        if (Page.IsPostBack == false)
        {
            HiddenUserID.Value = HttpContext.Current.User.Identity.Name;
            if (HttpContext.Current.User.Identity.Name=="1")
            {
                Button1.Visible = true;
            }
        }
    }

    protected void Button1_Click(object sender, EventArgs e)
    {
        Response.Redirect("pubFunction5.aspx");
    }
</script>
<asp:Content ID="Content2" ContentPlaceHolderID="myCss" runat="Server">
    <link href="../Scripts/sweetalert/sweetalert2.min.css" rel="stylesheet" />
    <link href="../vendor/datatables/dataTables.bootstrap4.min.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="myContent" runat="Server">
    <!-- Begin Page Content -->
    <div class="container-fluid">

        <!-- Page Heading -->
        <h1 class="h3 mb-4 text-gray-800">審核狀態</h1>

        <div class="row">

            <div class="col-lg-12">

                <div class="card shadow mb-4">
                    <div class="card-header py-3">
                        <h6 class="m-0 font-weight-bold text-primary">審核清單</h6><hr/>

                        <asp:Button ID="Button1" runat="server" Text="查詢打卡紀錄" CssClass="btn btn-primary" Visible="false" onclick="Button1_Click"/>
                        <asp:HiddenField ID="HiddenUserID" runat="server" />
                    </div>
                    <div class="card-body">
                        <div class="table-responsive">
                            <%--                        <table class="table table-bordered" id="dataTable" style="font-size:small" width="100%" cellspacing="0">--%>

                            <table class="table table-bordered" id="dataTable" style="width: 100%;" cellspacing="0">
                                <thead>
                                    <tr>
                                        <th>單號</th>
                                        <th>姓名</th>
                                        <th>上班時間</th>
                                        <th>下班時間</th>
                                        <th>時數</th>
                                        <th style="width: 100px">說明</th>
                                        <th>狀態</th>
                                        <th>功能</th>
                                    </tr>
                                </thead>
                                <tbody id="myTableBody">
                                    <%--資料在這邊產生--%>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>

            </div>



        </div>

    </div>
    <!-- /.container-fluid -->
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="myScript" runat="Server">
    <script src="../Scripts/sweetalert/sweetalert2.min.js"></script>
    <script src="/vendor/datatables/jquery.dataTables.min.js"></script>
    <script src="/vendor/datatables/dataTables.bootstrap4.min.js"></script>

    <script>
        $(function () {
            if ($("#myContent_HiddenUserID").val() == "1") {
                $("#myContent_Button1").attr("Visible", "true");
                var dataall = { get: 1 };
                var cp = 0;
                $.ajax({
                    type: 'POST',
                    async:false,
                    url: '/WebService.asmx/GetAllCheckPunchcards',
                    contentType: "application/json;charset=utf-8",
                    data: JSON.stringify(dataall),
                    success: function (data) {
                        //alert("Hello");
                        $(data.d).each(function (index, item) {
                            cp++;

                            $("#myTableBody").append(
                                `<tr id="cpcardtr${cp}">
                                        <td><input type="text" id="cpcid${cp}" value="${item.CheckPunchcardID}"style="border:1px solid transparent;width:50px" readonly="true"/></td>
                                        <td><input type="text" id="cpcname${cp}" value="${item.Name}"style="border:1px solid transparent;width:60px" readonly="true"/></td>
                                        <td><input type="text" id="cpcpin${cp}" value="${item.Punchin}" style="border:1px solid transparent;width:200px" readonly="true"/></td>
                                        <td><input type="text" id="cpcpout${cp}" value="${item.Punchout}" style="border:1px solid transparent;width:200px" readonly="true"/></td>
                                        <td><input type="text" id="cpchours${cp}" value="${item.Hours}" style="border:1px solid transparent;width:60px" readonly="true"/></td>
                                        <td><input type="text" id="cpcreason${cp}" value="${item.Reason}"  style="border:1px solid transparent;height:50px"  readonly="true"/></td>
                                        <td><input type="text" id="cpccheckpunchcard${cp}" value="${item.CheckPunchcard}" style="border:1px solid transparent;width:60px" readonly="true"/></td>
                                        <td>
                                            <input type="hidden" id="hidden_CheckPunchcardid${cp}"  value="${item.CheckPunchcardID}"/>
                                            <input type="hidden" id ="hidden_CheckPunchcardempid${cp}" value="${item.EmployeeID}"/>
                                            <input type="hidden" id ="hidden_CheckPunchcarddpid${cp}" value="${item.DepartmentID}"/>
                                            <input type="hidden" id ="hidden_CheckPunchcardName${cp}" value="${item.Name}"/>
                                            <input type="hidden" id ="hidden_CheckPunchcardDate${cp}" value="${item.Date}"/>
                                            <input type="button" id ="Checkedyes_btn${cp}" class="btn btn-success" value="通過" title="${cp}" />
                                            <input type="button" id ="Checkedno_btn${cp}" class="btn btn-warning"  value="未通過" title="${cp}" />
                                            <a href="#" id="cpDelete_btn${cp}" class="btn btn-danger btn-icon-split" title="${cp}">
                                            <span class="icon text-white-50">
                                                <i class="fas fa-trash"></i>
                                            </span>
                                            </a>
                                        </td>
                                    </tr>`);
                            //$(`#goChecked_btn${cp}`).click(function () {
                            //    var cc = $(this).attr("title");
                            //    $("#goChecked_btn" + cc).css("display", "none");
                            //    $("#Checkedyes_btn" + cc).css("display", "");
                            //    $("#Checkedno_btn" + cc).css("display", "");
                            //    $("#cpDelete_btn" + cc).css("display", "none");
                            //});
          
                            $(`#Checkedyes_btn${cp}`).click(function () {
                                var upcpc = $(this).attr("title");
                                var dataupdatepc = { id: parseInt($("#hidden_CheckPunchcardempid" + upcpc).val()), name: $("#hidden_CheckPunchcardName" + upcpc).val(), departmentid: $("#hidden_CheckPunchcarddpid" + upcpc).val(), date: $("#hidden_CheckPunchcardDate" + upcpc).val(), punchin: $("#cpcpin" + upcpc).val(), punchout: $("#cpcpout" + upcpc).val(), hours: $("#cpchours" + upcpc).val() };
                                $.ajax({
                                    type: 'POST',
                                    async:false,
                                    url: '/WebService.asmx/UpdatePunchcard2',
                                    contentType: "application/json;charset=utf-8",
                                    data: JSON.stringify(dataupdatepc),
                                    success: function (data) {
                                        //alert("新增成功")

                                        //location.href="pubFunction3.aspx";
                                    },
                                    error: function (x) {
                                        alert("punchcard update error");
                                    }
                                });
                                var dataupdatecpc = { id: parseInt($("#hidden_CheckPunchcardempid" + upcpc).val()), name: $("#hidden_CheckPunchcardName" + upcpc).val(), departmentid: $("#hidden_CheckPunchcarddpid" + upcpc).val(), date: $("#hidden_CheckPunchcardDate" + upcpc).val(), punchin: $("#cpcpin" + upcpc).val(), punchout: $("#cpcpout" + upcpc).val(), hours: $("#cpchours" + upcpc).val(), reason: $("#cpcreason" + upcpc).val(), checkpunchcard: "通過" };
                                $.ajax({
                                    type: 'POST',
                                    async:false,
                                    url: '/WebService.asmx/UpdateCheckPunchcard',
                                    contentType: "application/json;charset=utf-8",
                                    data: JSON.stringify(dataupdatecpc),
                                    success: function (data) {
                                        //alert("新增成功")

                                        //location.href="pubFunction3.aspx";
                                    },
                                    error: function (x) {
                                        alert("cpunchcard update error");
                                    }
                                });
                                //$("#Checkedyes_btn" + cc).css("display", "none");
                                //$("#Checkedno_btn" + cc).css("display", "none");
                                //$("#cpDelete_btn" + cc).css("display", "");
                                //$("#goChecked_btn" + cc).css("display", "");

                                //window.setTimeout("window.location='pubFunction1checking.aspx'", 1000);
                                location.href = "pubFunction1checking.aspx";
                                //windows.location.href="pubFunction1checking.aspx";
                            });
                            $(`#Checkedno_btn${cp}`).click(function () {
                                var upcpc = $(this).attr("title");

                                var dataupdatecpc = { id: parseInt($("#hidden_CheckPunchcardempid" + upcpc).val()), name: $("#hidden_CheckPunchcardName" + upcpc).val(), departmentid: $("#hidden_CheckPunchcarddpid" + upcpc).val(), date: $("#hidden_CheckPunchcardDate" + upcpc).val(), punchin: $("#cpcpin" + upcpc).val(), punchout: $("#cpcpout" + upcpc).val(), hours: $("#cpchours" + upcpc).val(), reason: $("#cpcreason" + upcpc).val(), checkpunchcard: "未通過" };
                                $.ajax({
                                    type: 'POST',
                                    async:false,
                                    url: '/WebService.asmx/UpdateCheckPunchcard',
                                    contentType: "application/json;charset=utf-8",
                                    data: JSON.stringify(dataupdatecpc),
                                    success: function (data) {
                                        //alert("新增成功")

                                        //location.href="pubFunction3.aspx";
                                    },
                                    error: function (x) {
                                        alert("cpunchcard update error");
                                    }
                                });
                                //$("#Checkedyes_btn" + cc).css("display", "none");
                                //$("#Checkedno_btn" + cc).css("display", "none");
                                //$("#cpDelete_btn" + cc).css("display", "");
                                //$("#goChecked_btn" + cc).css("display", "");

                                //window.setTimeout("window.location='pubFunction1checking.aspx'", 1000);
                                location.href = "pubFunction1checking.aspx";

                            });
                            $(`#cpDelete_btn${cp}`).click(function () {
                                var cpc = $(this).attr("title");
                                swal({
                                    title: '確認?',
                                    text: "審核單即將被刪除!",
                                    type: 'warning',
                                    showCancelButton: true,
                                }).then(
                                    function () {

                                        var data5 = { cpid: $("#hidden_CheckPunchcardid" + cpc).val() };
                                        $.ajax({
                                            type: 'POST',
                                            async:false,
                                            url: '/WebService.asmx/DeleteCheckPunchcardBycpId',
                                            contentType: "application/json;charset=utf-8",
                                            data: JSON.stringify(data5),
                                            success: function (data) {

                                            },
                                            error: function (x) {
                                                alert("delete error");
                                            }
                                        });

                                        $("#cpcardtr" + cpc).remove();

                                        swal('完成!', '審核單已經刪除', 'success')
                                    },
                                    function (dismiss) {
                                        if (dismiss === 'cancel') {
                                            swal('取消', '審核單未被刪除', 'error')
                                        }
                                    });
                                //if (confirm("確定要刪除嗎?") == true) {
                                //    var data5 = { id: $("#hidden_menuLunchCompanyid"+d).val(), name: $("#hidden_menuLunchCompanyName"+d).val() };
                                //    $.ajax({
                                //        type: 'POST',
                                //        url: '/WebService.asmx/DeleteLunchMenuByIdandName',
                                //        contentType: "application/json;charset=utf-8",
                                //        data: JSON.stringify(data5),
                                //        success: function (data) {

                                //        },
                                //        error: function (x) {
                                //            alert("delete error");
                                //        }
                                //    });

                                //    $("#menutr" + d).remove();
                                //}

                            });
                        })
                        $("#dataTable").DataTable();
                        for (var i = 1; i <= cp; i++) {
                            if ($("#cpccheckpunchcard"+i).val()=="通過") {
                                $("#cpDelete_btn" + i).css("display", "none");
                            }
                        }
                    },
                    error: function (x) {
                        alert("show error111");
                    }
                });


            } else {


                var data1 = { id: $("#myContent_HiddenUserID").val() };
                var cp = 0;
                $.ajax({
                    type: 'POST',
                    async:false,
                    url: '/WebService.asmx/GetCheckPunchcardsById',
                    contentType: "application/json;charset=utf-8",
                    data: JSON.stringify(data1),
                    success: function (data) {
                        //alert("Hello");
                        $(data.d).each(function (index, item) {
                            cp++;

                            $("#myTableBody").append(
                                `<tr id="cpcardtr${cp}">
                                        <td><input type="text" id="cpcid${cp}" value="${item.CheckPunchcardID}"style="border:1px solid transparent;width:50px" readonly="true"/></td>
                                        <td><input type="text" id="cpcname${cp}" value="${item.Name}"style="border:1px solid transparent;width:60px" readonly="true"/></td>
                                        <td><input type="text" id="cpcpin${cp}" value="${item.Punchin}" style="border:1px solid transparent;width:200px" readonly="true"/></td>
                                        <td><input type="text" id="cpcpout${cp}" value="${item.Punchout}" style="border:1px solid transparent;width:200px" readonly="true"/></td>
                                        <td><input type="text" id="cpchours${cp}" value="${item.Hours}" style="border:1px solid transparent;width:60px" readonly="true"/></td>
                                        <td><input type="text" id="cpcreason${cp}" value="${item.Reason}"  style="border:1px solid transparent;height:50px"  readonly="true"/></td>
                                        <td><input type="text" id="cpccheckpunchcard${cp}" value="${item.CheckPunchcard}" style="border:1px solid transparent;width:60px" readonly="true"/></td>
                                        <td>
                                            <input type="hidden" id="hidden_CheckPunchcardid${cp}"  value="${item.CheckPunchcardID}"/>
                                            <input type="hidden" id ="hidden_CheckPunchcardempid${cp}" value="${item.EmployeeID}"/>
                                            <input type="hidden" id ="hidden_CheckPunchcarddpid${cp}" value="${item.DepartmentID}"/>
                                            <input type="hidden" id ="hidden_CheckPunchcardName${cp}" value="${item.Name}"/>
                                            <input type="hidden" id ="hidden_CheckPunchcardDate${cp}" value="${item.Date}"/>
                                            <a href="#" id="cpDelete_btn${cp}" class="btn btn-danger btn-icon-split" title="${cp}"style="display:none;">
                                            <span class="icon text-white-50">
                                                <i class="fas fa-trash"></i>
                                            </span>
                                            <span class="text">抽單</span>
                                            </a>
                                        </td>
                                    </tr>`);
                            $(`#cpDelete_btn${cp}`).click(function () {
                                var cpc = $(this).attr("title");
                                swal({
                                    title: '確認?',
                                    text: "審核單即將被刪除!",
                                    type: 'warning',
                                    showCancelButton: true,
                                }).then(
                                    function () {

                                        var data5 = { cpid: $("#hidden_CheckPunchcardid" + cpc).val() };
                                        $.ajax({
                                            type: 'POST',
                                            async:false,
                                            url: '/WebService.asmx/DeleteCheckPunchcardBycpId',
                                            contentType: "application/json;charset=utf-8",
                                            data: JSON.stringify(data5),
                                            success: function (data) {

                                            },
                                            error: function (x) {
                                                alert("delete error");
                                            }
                                        });

                                        $("#cpcardtr" + cpc).remove();

                                        swal('完成!', '審核單已經刪除', 'success')
                                    },
                                    function (dismiss) {
                                        if (dismiss === 'cancel') {
                                            swal('取消', '審核單未被刪除', 'error')
                                        }
                                    });
                                //if (confirm("確定要刪除嗎?") == true) {
                                //    var data5 = { id: $("#hidden_menuLunchCompanyid"+d).val(), name: $("#hidden_menuLunchCompanyName"+d).val() };
                                //    $.ajax({
                                //        type: 'POST',
                                //        url: '/WebService.asmx/DeleteLunchMenuByIdandName',
                                //        contentType: "application/json;charset=utf-8",
                                //        data: JSON.stringify(data5),
                                //        success: function (data) {

                                //        },
                                //        error: function (x) {
                                //            alert("delete error");
                                //        }
                                //    });

                                //    $("#menutr" + d).remove();
                                //}

                            });
                        })
                        $("#dataTable").DataTable();
                        for (var i = 1; i <= cp; i++) {
                            if ($("#cpccheckpunchcard"+i).val()=="審核中") {
                                $("#cpDelete_btn" + i).css("display", "");
                            }
                        }
                    },
                    error: function (x) {
                        alert("show error222");
                    }
                });
            }
        });
    </script>
</asp:Content>

