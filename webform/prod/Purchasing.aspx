<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="Purchasing.aspx.cs" Inherits="prod_Purchasing" %>

<asp:Content ID="Content1" ContentPlaceHolderID="myCss" runat="Server">
    <%-- 引用自己的css --%>
    <link href="../css/MyStyleSheet.css" rel="stylesheet" />
    <%-- 引用自己的js --%>
    <script src="../js/prodUse.js"></script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="myContent" runat="Server">
    <div class="container-fluid">

        <!-- DataTales Example -->
        <div class="card shadow mb-4 ">
            <div class="card-header py-2 form-inline ">
                <%--<i class="fas fa-clipboard-list fa-2x text-gray-300"></i>--%>
                <a href="#" class="btn btn-success">
                    <i class="fas fa-check"></i>
                </a>
                &nbsp;<h3 class="m-0 font-weight-bold text-primary">新增採購單</h3>
            </div>
            <%-- 隱藏欄位找登入者id --%>
            <asp:HiddenField ID="HiddenField1" runat="server" />
            <asp:HiddenField ID="HiddenField2" runat="server" />
            <asp:HiddenField ID="HiddenField4" runat="server" />
            <%--            <asp:hiddenfield id="HiddenField4" runat="server" />--%>

            <%-- session id到下一頁 --%>
            <asp:HiddenField ID="HiddenField3" runat="server" />

            <%-- card body start --%>
            <div class="card-body">
                <%-- 上方必填欄位 開始 --%>
                <div>
                    <%-- 上方必填欄位 公司 開始 --%>
                    <div>
                        <div class="form-inline">
                            <h4 class="m-0 font-weight-bold text-primary col-9">採購單資料</h4>
                            <span class="col-1">填寫日期 :</span>
                            <input id="TodayTextBox" type="text" readonly="readonly" style="width:250px; border: 0px; background-color: rgba(255,255,255,0.2)"  />

                        </div>
                        <br />
                        <%-- 採購單號 --%>
                        <label class="col-5">
                            <asp:Label ID="PartNOLabel" runat="server" Text="採購單號:"></asp:Label>
                            <div class="form-inline">
                                <input id="PartNOTextBox" type="text" class="form-control form-control-user" placeholder="料件編號" readonly="readonly" aria-controls="dataTable" />&nbsp;
                                <span id="PartNOLabel1" style="color: red">*建立成功會產生單號</span>
                            </div>
                        </label>
                        <%-- 填寫人 --%>
                        <%-- <label class="col-6">
                            <asp:label id="Label4" runat="server" text="填寫人:"></asp:label>
                            <div class="form-inline">
                                <input id="NameBox" type="text" readonly="readonly" class="form-control form-control-user" placeholder="" aria-controls="dataTable" />&nbsp;
                                <span id="NameBoxlabel" style="color: red">*自動帶入</span>
                            </div>
                        </label>--%>
                        <%-- 填寫人 --%>
                        <%-- 員工編號 --%>
                        <label class="col-6">
                            <asp:Label ID="Label1" runat="server" Text="員工編號:"></asp:Label>
                            <div class="form-inline">
                                <input id="NameTextBox" type="text" readonly="readonly" class="form-control form-control-user" placeholder="" aria-controls="dataTable" />&nbsp;
                                <%--<span id="NameLabel2" style="color: red">*自動帶入</span>--%>
                            </div>
                        </label>
                        <%-- 員工編號 --%>
                        <%-- 員工名子 --%>
                        <label class="col-5">
                            <asp:Label ID="Label4" runat="server" Text="員工名字:"></asp:Label>
                            <div class="form-inline">
                                <input id="IDNameTextBox" type="text" readonly="readonly" class="form-control form-control-user" placeholder="" aria-controls="dataTable" />&nbsp;
                                <%--<span id="IDNameLabel2" style="color: red">*自動帶入</span>--%>
                            </div>
                        </label>
                        <%-- 員工名子 --%>
                        <%-- 所屬部門 --%>
                        <label class="col-6">
                            <asp:Label ID="Label3" runat="server" Text="所屬部門:"></asp:Label>
                            <div class="form-inline">
                                <input id="DeTextBox" type="text" readonly="readonly" class="form-control form-control-user" placeholder="" aria-controls="dataTable" />&nbsp;
                                <%--<span id="DeLabel" style="color: red">*自動帶入</span>--%>
                            </div>
                        </label>
                        <%-- 填寫日期 --%>
                        <%--   <label class="col-6">
                            <asp:Label ID="Label5" runat="server" Text="填寫日期:"></asp:Label>
                            <div class="form-inline">   
                                <input id="TodayTextBox" type="text" class="form-control form-control-user" placeholder="" aria-controls="dataTable" readonly="readonly" />&nbsp;
                                <span id="TodayLabel" style="color: red">*自動填入</span>
                            </div>
                        </label>--%>
                    </div>
                    <%-- 上方必填欄位 公司 結束 --%>
                    <hr />
                    <%-- 上方必填欄位 廠商 開始 --%>
                    <div>
                        <div>
                            <h4 class="m-0 font-weight-bold text-primary">廠商資料</h4>
                        </div>
                        <br />
                        <%-- 廠商名稱 --%>
                        <label class="col-5">
                            <asp:Label ID="Label7" runat="server" Text="廠商名稱:"></asp:Label>
                            <div class="form-inline">
                                <input id="VendorTextBox" type="text" class="form-control form-control-user" placeholder="" aria-controls="dataTable" readonly="readonly" />&nbsp;
                                <%--<span id="VendorLabel" style="color: red">*必填</span>--%>
                                <%--<input id="Button1" type="button" value="選擇廠商" />--%>
                                <a id="chose" class="btn btn-warning btn-icon-split" title="選擇廠商" style="font-size: small; color: white;" data-toggle="modal" data-target=".fade">
                                    <span class="icon text-white-50">
                                        <i class="fa fa-wrench"></i>
                                    </span>
                                    <span class="text">請選擇廠商</span>
                                </a>
                            </div>
                        </label>
                        <%-- 聯絡人 --%>
                        <label class="col-6">
                            <asp:Label ID="Label9" runat="server" Text="聯絡人:"></asp:Label>
                            <div class="form-inline">
                                <input id="VendorNameTextBox" type="text" class="form-control form-control-user" placeholder="" aria-controls="dataTable" readonly="readonly" />&nbsp;
                                <%--<span id="VendorNameLabel" style="color: red">*必填</span>--%>
                            </div>
                        </label>
                        <%-- 到貨日期 --%>
                        <%--   <label class="col-5">
                            <asp:Label ID="Label15" runat="server" Text="到貨日期:"></asp:Label>
                            <div class="form-inline">
                                <input id="getdayTextBox" type="date" class="form-control form-control-user" aria-controls="dataTable" />&nbsp;
                                <span id="getdayLabel" style="color: red">*必填</span>
                            </div>
                        </label>--%>
                        <%-- Email --%>
                        <label class="col-5">
                            <asp:Label ID="Label17" runat="server" Text="Email:"></asp:Label>
                            <div class="form-inline">
                                <input id="EmailTextBox" type="text" class="form-control form-control-user" aria-controls="dataTable" readonly="readonly" />&nbsp;
                                <%--<span id="EmailLabel" style="color: red">*必填</span>--%>
                            </div>
                        </label>
                        <%-- 電話 --%>
                        <label class="col-6">
                            <asp:Label ID="Label11" runat="server" Text="電話:"></asp:Label>
                            <div class="form-inline">
                                <input id="phoneTextBox" type="text" class="form-control form-control-user" aria-controls="dataTable" readonly="readonly" />&nbsp;
                                <%--<span id="phoneLabel" style="color: red">*必填</span>--%>
                            </div>
                        </label>
                        <%-- 統一編號 --%>
                        <%-- <label class="col-6">
                        <asp:Label ID="Label13" runat="server" Text="統一編號:"></asp:Label>
                        <div class="form-inline">
                            <asp:TextBox ID="TextBox7" class="form-control form-control-user" type="search" runat="server" placeholder="" Text="" aria-controls="dataTable"></asp:TextBox>&nbsp;
                                        <asp:Label ID="Label14" runat="server" ForeColor="Red" Text="*必填"></asp:Label>
                        </div>
                    </label>--%>
                    </div>

                    <%-- 上方必填欄位 廠商 結束 --%>
                </div>
                <%-- 上方必填欄位 結束 --%>
                <hr />
                <%-- 下方表單 開始 --%>
                <div>
                    <h4 class="m-0 font-weight-bold text-primary">採購項目</h4>
                </div>
                <br />

                <%-- 新增欄位按鈕 --%>
                <a id="addcolumn" class="btn btn-info btn-icon-split" style="color: white">
                    <span class="icon text-white-50">
                        <i class="fas fa-plus"></i>
                    </span>
                    <span class="text">新增採購項目欄位</span>
                </a>
                <br />
                <br />
                <%-- 引用 table start --%>
                <table class="table table-bordered " id="dataTable" width="100%" cellspacing="0">
                    <thead>
                        <tr>
                            <th>採購項目</th>
                            <th>規格</th>
                            <th>數量</th>
                            <th>價格</th>
                            <th>總價</th>
                            <th>備註</th>
                            <th>功能</th>
                        </tr>
                    </thead>
                    <tbody id="myTableBody">
                        <%--補table內容--%>
                        <%--  <tr>
                            <td><input id="Text1" type="text" class="form-control form-control-user" /></td>
                            <td><input id="Text2" type="text"  class="form-control form-control-user"/></td>
                            <td><input id="Text3" type="text" class="form-control form-control-user"/></td>
                            <td><input id="Text4" type="text" class="form-control form-control-user"/></td>
                            <td><input id="Text5" type="text" readonly="readonly" class="form-control form-control-user" /></td>
                             <td><input id="Text6" type="text" class="form-control form-control-user"/></td>
                            <td>

                                <span class=" btn btn-danger btn-icon-split " title="i" id="DeleteItemi">
                                    <span class="icon text-white-50">
                                        <i class="fas fa-trash"></i>
                                    </span>
                                    <span id="btnDelete " class="text" value="i" title="i">刪除</span>
                                </span>
                            </td>
                        </tr>--%>
                    </tbody>

                </table>
                <%-- 引用 table end --%>
                <%-- 下方表單 結束 --%>
            </div>
            <%-- 稅及運費及總價 start--%>
            <div>
                <label class="col">
                    <div class="form-inline">
                        <asp:Label ID="Label13" runat="server" Text="稅(%):"></asp:Label>
                        &nbsp;
                              <input id="TextBoxTex" type="number" class="form-control form-control-user" value="0" aria-controls="dataTable" />&nbsp;
                                <span id="LabelTex" style="color: red">*X % (請填入X)</span>
                    </div>
                </label>
                <label class="col">
                    <div class="form-inline">
                        <asp:Label ID="Label2" runat="server" Text="稅額:"></asp:Label>
                        &nbsp;
                              <input id="TextBoxTex1" type="number" class="form-control form-control-user" min="0" value="0" aria-controls="dataTable" readonly="readonly" />&nbsp;
                                <span id="LabelTex1" style="color: red">*X % * 總價 = 稅額</span>
                    </div>
                </label>
                <label class="col">
                    <div class="form-inline">
                        <asp:Label ID="Label19" runat="server" Text="運費:"></asp:Label>
                        &nbsp;+
                         <input id="TextBoxfre" type="number" class="form-control form-control-user" min="0" value="0" aria-controls="dataTable" />&nbsp;
                                <span id="Labelfre" style="color: red">*+運費</span>
                    </div>
                </label>
                <%-- 橫線 --%>
                <hr style="width: 30%; float: left;" />
                <%-- 橫線 --%>
                <label class="col">
                    <div class="form-inline">
                        <asp:Label ID="Label21" runat="server" Text="總價:"></asp:Label>
                        &nbsp;
                        <%--  <input id="TextBox1total" type="number" class="form-control form-control-user" min="0" placeholder="0" aria-controls="dataTable" />&nbsp;
                                <span id="Labeltotal" style="color: red">*+</span>--%>
                        <input id="TextBox1total" type="number" class="form-control form-control-user" placeholder="0" readonly="readonly" value="0" aria-controls="dataTable" />&nbsp;
                                <span id="Labeltotal" style="color: red"></span>
                    </div>
                </label>


            </div>

            <%-- 稅及運費及總價 end--%>
            <hr />

            <div class="custom-control-inline">
                <%--送出按鈕--%>
                <label class="col-2">
                    <a href="#" id="submitbutton" class="btn btn-primary btn-icon-split">
                        <span class="icon text-white-50">
                            <i class="fas fa-flag"></i>
                        </span>
                        <span class="text">送出預覽</span>
                    </a>
                </label>
                <%--取消返回按鈕--%>
                <label class="col-2">
                    <a href="../index.aspx" id="backbutton" class="btn btn-secondary btn-icon-split">
                        <span class="icon text-white-50">
                            <i class="fas fa-arrow-right"></i>
                        </span>
                        <span class="text">回首頁</span>
                    </a>
                </label>

            </div>

            <%-- card body end --%>
        </div>
    </div>

    <!-- Modal 廠商選擇 -->
    <div class="modal fade" id="exampleModalCenter" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLongTitle">選擇廠商</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <select class="form-control form-control-user dropdown-toggle" id="DropDownListvendor" runat="server">
                    </select>
                </div>
                <span id="Labeldroplist" style="color: red"></span>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">關閉</button>
                    <input type="button" id="listvendorsubmit1" class="btn btn-primary" value="確認" />
                </div>
            </div>
        </div>
    </div>
    <!-- Modal 廠商選擇 -->
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="myScript" runat="Server">
    <%-- 引用function products js --%>
    <script src="../js/prodUse.js"></script>
    <%--引用自己計算--%>
    <script src="../js/prodUse.js"></script>
    <script>
        $(function () {

            //填入填寫日期
            var da = new Date();
            var datext = da.getFullYear() + "-" + (da.getMonth() + 1) + "-" + da.getDate();
            $("#TodayTextBox").val(datext);

            //寫入目前登入人id
            var a = $("#myContent_HiddenField1").val();
            var strid = "A" + padLeft(a, 4);
            $("#NameTextBox").attr("value", strid);
            //寫入登入人名
            var name = $("#myContent_HiddenField4").val();
            $("#IDNameTextBox").attr("value", name);

            //寫入目前登入人部門
            var b = $("#myContent_HiddenField2").val();
            $("#DeTextBox").attr("value", b); //拿過來就是空的
            console.log(b);
            //新增欄位 開始
            var i = 0;
            $("#addcolumn").click(function () {
                i++;
                $("#myTableBody").append(
                    `<tr id="column${i}">
                            <td><input id="Text1${i}" type="text" class="form-control form-control-user" value=""/></td>
                            <td><input id="Text2${i}" type="text"  class="form-control form-control-user" value=""/></td>
                            <td><input id="countText${i}" type="number" class="form-control form-control-user" value="0" min="0"/></td>
                            <td><input id="priceText${i}" type="number" class="form-control form-control-user" value="0" min="0"/></td>
                            <td><input id="allpriceText${i}" type="text" readonly="readonly" class="form-control form-control-user" value="0"/></td>
                             <td><input id="Text6${i}" type="text" class="form-control form-control-user" value=""/></td>
                            <td>

                                <span class=" btn btn-danger btn-icon-split" title="${i}" id="DeleteItem${i}">
                                    <span class="icon text-white-50">
                                        <i class="fas fa-trash"></i>
                                    </span>
                                    <span id="btnDelete " class="text" value="${i}" title="${i}">刪除</span>
                                </span>                 
                            </td>
                        </tr>`
                );

                //計算欄位總價開始 觸發價格
                $(`#priceText${i}`).blur(function () {
                    for (var k = 1; k <= i; k++) {
                        var columntotal = parseInt($(`#priceText${k}`).val()) * parseInt($(`#countText${k}`).val());
                        $(`#allpriceText${k}`).val(columntotal);
                    }

                    //上方總價
                    var total = 0;
                    for (var j = 1; j <= i; j++) {
                        var alltotal = $(`#allpriceText${j}`).val()
                        if (alltotal != undefined) {
                            total += parseInt(alltotal);
                        }

                        //alert("每行相加");
                    }
                    //稅
                    var tex = parseInt($("#TextBoxTex").val()) / 100;
                    $("#TextBoxTex1").val(total * tex);
                    //alert("稅");
                    //console.log(typeof tex);
                    //運費
                    var fre = parseInt($("#TextBoxfre").val());
                    var tol = total * (1 + tex) + fre;
                    $("#TextBox1total").val(tol.toFixed(2));

                });
                //計算欄位總價結束  觸發價格
                //計算欄位總價開始 觸發數量
                $(`#countText${i}`).blur(function () {

                    for (var k = 1; k <= i; k++) {
                        var columntotal = parseInt($(`#priceText${k}`).val()) * parseInt($(`#countText${k}`).val());
                        $(`#allpriceText${k}`).val(columntotal);
                    }
                    //上方總價
                    var total = 0;
                    for (var j = 1; j <= i; j++) {
                        var alltotal = $(`#allpriceText${j}`).val()
                        if (alltotal != undefined) {
                            total += parseInt(alltotal);
                        }

                        //alert("每行相加");
                    }
                    //稅
                    var tex = parseInt($("#TextBoxTex").val()) / 100;
                    $("#TextBoxTex1").val(total * tex);
                    //alert("稅");
                    //console.log(typeof tex);
                    //運費
                    var fre = parseInt($("#TextBoxfre").val());
                    var tol = total * (1 + tex) + fre;
                    $("#TextBox1total").val(tol.toFixed(2));

                });
                //計算欄位總價結束 觸發數量
                //稅觸發總價計算 開始
                $("#TextBoxTex").blur(function () {
                    //上方總價
                    var total = 0;
                    for (var j = 1; j <= i; j++) {
                        var alltotal = $(`#allpriceText${j}`).val()
                        if (alltotal != undefined) {
                            total += parseInt(alltotal);
                        }

                        //alert("每行相加");
                    }
                    //稅
                    var tex = parseInt($("#TextBoxTex").val()) / 100;
                    //console.log(typeof $("#TextBoxTex1"));
                    $("#TextBoxTex1").val(total * tex);
                    //alert("稅");

                    //運費
                    var fre = parseInt($("#TextBoxfre").val());
                    var tol = total * (1 + tex) + fre;
                    $("#TextBox1total").val(tol.toFixed(2));

                });
                //稅觸發總價計算 結束
                //運費觸發計算總價 開始
                $("#TextBoxfre").blur(function () {
                    var total = 0;
                    for (var j = 1; j <= i; j++) {
                        var alltotal = $(`#allpriceText${j}`).val()
                        if (alltotal != undefined) {
                            total += parseInt(alltotal);
                        }

                        //alert("每行相加");
                    }
                    //稅
                    var tex = parseInt($("#TextBoxTex").val()) / 100;
                    //console.log(typeof $("#TextBoxTex1"));
                    $("#TextBoxTex1").val(total * tex);
                    //alert("稅");

                    //運費
                    var fre = parseInt($("#TextBoxfre").val());
                    var tol = total * (1 + tex) + fre;
                    $("#TextBox1total").val(tol.toFixed(2));



                });
                //運費觸發計算總價結束
                //刪除欄位 開始
                //$("span[id^='DeleteItem']").click(function () {
                //    //alert("按鈕");
                //    if (confirm("Delete?")) {
                //        var removeid = $(this).attr("title");
                //        $("#column" + removeid).remove();
                //    }
                //});

                $(`#DeleteItem${i}`).click(function () {
                    //alert("按鈕");
                    if (confirm("Delete?")) {
                        var removeid = $(this).attr("title");
                        $("#column" + removeid).remove();

                        //如果刪除成功重新計算全部
                        for (var k = 1; k <= i; k++) {
                            var columntotal = parseInt($(`#priceText${k}`).val()) * parseInt($(`#countText${k}`).val());
                            $(`#allpriceText${k}`).val(columntotal);
                        }

                        //上方總價
                        var total = 0;
                        for (var j = 1; j <= i; j++) {
                            var alltotal = $(`#allpriceText${j}`).val()
                            if (alltotal != undefined) {
                                total += parseInt(alltotal);
                            }

                            //alert("每行相加");
                        }
                        //稅
                        var tex = parseInt($("#TextBoxTex").val()) / 100;
                        $("#TextBoxTex1").val(total * tex);
                        //alert("稅");
                        //console.log(typeof tex);
                        //運費
                        var fre = parseInt($("#TextBoxfre").val());
                        var tol = total * (1 + tex) + fre;
                        $("#TextBox1total").val(tol.toFixed(2));

                    }
                });
                //刪除欄位 結束


            });
            //新增欄位 結束


            //送出預覽
            $("#submitbutton").click(function () {


                //抓purchmain資料
                //填寫人
                var TodayText =new Date();
                //填寫人id 拆掉字
                var NameText = parseInt($("#NameTextBox").val().slice(1));
                var DeText = $("#DeTextBox").val();
                //廠商
                var VendorText = $("#VendorTextBox").val();
                var VendorName = $("#VendorNameTextBox").val();
                var EmailText = $("#EmailTextBox").val();
                var phoneText = $("#phoneTextBox").val();
                //總價自己算 抓稅率 (1+ x%)and運費
                //1=>稅額 沒數字稅
                var TextTex = parseInt($("#TextBoxTex").val());
                var TextTex1 = parseInt($("#TextBoxTex1").val());
                //運費
                var Textfre = parseInt($("#TextBoxfre").val());
                //總價
                var Texttotal = parseInt($("#TextBox1total").val());
                //抓計算欄位
                var PartDetail = Array();
                var strDetail = "";
                //放逗點隔開字串
                for (var j = 1; j < i + 1; j++) {
                    //var PartDetail11=[$(`#Text1${j}`).val(),$(`#Text2${j}`).val(),$(`#countText${j}`).val(),$(`#priceText${j}`).val(),$(`#allpriceText${j}`).val(),$(`#Text6${j}`).val()]
                    if ($(`#Text1${j}`).val() != undefined) {
                        strDetail += $(`#Text1${j}`).val() + ',',
                            strDetail += $(`#Text2${j}`).val() + ',',
                            strDetail += $(`#countText${j}`).val() + ',',
                            strDetail += $(`#priceText${j}`).val() + ',',
                            strDetail += $(`#allpriceText${j}`).val() + ',',
                            strDetail += $(`#Text6${j}`).val(),
                            strDetail += "*";
                    }


                }
              
                strDetail = strDetail.substring(0, strDetail.lastIndexOf('*'));
                console.log(strDetail);

                //寫ajax api
                var myData = {
                    buyer: NameText,
                    department: DeText,
                    ThisDay: TodayText,
                    vendor: VendorText,
                    vendorsales: VendorName,
                    phone: phoneText,
                    email: EmailText,
                    taxrate: TextTex,
                    tax: TextTex1,
                    freight: Textfre,
                    totalprice: Texttotal,
                    detail: strDetail
                }

                console.log(myData);
                $.ajax({
                    type: 'POST',
                    url: '/WebService.asmx/post',
                    contentType: "application/json;charset=utf-8",
                    dataType: 'json',
                    data: JSON.stringify(myData),
                    success: function (data) {
                        //alert("success");
                        console.log(data);
                        $("#myContent_HiddenField3").val(data.d);
                        console.log($("#myContent_HiddenField3").val());
                        window.location.href = `/prod/PurchDetail.aspx?id=${$("#myContent_HiddenField3").val()}`
                    },
                    error: function (x) { console.log("error"); }


                });





            });

            //dropdownlist ajax
            $.ajax({
                type: 'POST',
                url: '/WebService.asmx/Getsupplier',
                contentType: "application/json;charset=utf-8",
                success: function (data) {
                    console.log(data)
                    $("#myContent_DropDownListvendor").append(
                        `<option value="a">==========請選擇===========</option>`);
                    $(data.d).each(function (index, item) {
                        $("#myContent_DropDownListvendor").append(
                            ` <option name="${item.CompanyName}" value="${item.supplierID}">${item.CompanyName}</option>`
                        )
                    });

                },
                error: function (x) { console.log("error"); }

            });



            $("#listvendorsubmit1").click(function () {
                if ($("#myContent_DropDownListvendor").val() == "a") {
                    $("#Labeldroplist").text("請選擇廠商");

                }
                //如果不是a找ajax全部填入
                else {
                    var mydata = { supplierID: parseInt($("#myContent_DropDownListvendor").val()) };
                    //ajax select廠商資料 帶入原本欄位
                    $.ajax({
                        type: 'POST',
                        url: '/WebService.asmx/GetsuppliertById',
                        contentType: "application/json;charset=utf-8",
                        data: JSON.stringify(mydata),
                        success: function (data) {
                            console.log(data)
                            $("#VendorTextBox").val(data.d.CompanyName);
                            $("#VendorNameTextBox").val(data.d.Contact);
                            $("#EmailTextBox").val(data.d.Email);
                            $("#phoneTextBox").val(data.d.DirectTelephone);

                        },
                        error: function (x) { console.log("error"); }


                    });



                    $("#exampleModalCenter").modal('hide');
                }



            });

        });
    </script>

</asp:Content>

