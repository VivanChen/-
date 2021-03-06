﻿<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="PurchCheckModify.aspx.cs" Inherits="prod_PurchCheckModify" %>

<asp:Content ID="Content1" ContentPlaceHolderID="myCss" runat="Server">
    <%-- 引用自己的css --%>
    <link href="../css/MyStyleSheet.css" rel="stylesheet" />
    <%-- 引用自己的js --%>
    <script src="../js/prodUse.js"></script>
    <%--引用textarea start--%>
    <link href="textarea-max-character-counter/textarea-max-character-counter/css/style.css" rel="stylesheet" />
    <link href="textarea-max-character-counter/textarea-max-character-counter/css/style.css" rel="stylesheet" />
    <%--引用textarea end--%>
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
                &nbsp;<h3 class="m-0 font-weight-bold text-primary">採購單詳細資料及審核狀態</h3>
            </div>
            <%-- 接purchNO --%>
            <asp:HiddenField ID="HiddenField" runat="server" />
            <%-- 儲存登入者 --%>
            <asp:HiddenField ID="HiddenField1" runat="server" />

            <%-- card body start --%>
            <div class="card-body">
                <%-- 上方必填欄位 開始 --%>
                <div>
                    <%-- 上方必填欄位 公司 開始 --%>
                    <div>
                        <div class="form-inline">
                            <h4 class="m-0 font-weight-bold text-primary col-2">採購單資料及審核狀態</h4>
                            <span class="col-1">填寫日期 :</span>
                            <input id="TodayTextBox" type="text" readonly="readonly" style="border: 0px; background-color: rgba(255,255,255,0.2)" />
                            <span id="TodayTextBox1"></span>
                        </div>
                        <%--測試用欄位--%>
                        <%--                        <input id="boxtest" type="text" />
                        <input type="button" id="test" value="sessiontest" />
                        <br />--%>
                        <%-- 採購單號 --%>
                        <label class="col-5">
                            <asp:Label ID="PartNOLabel" runat="server" Text="採購單號:"></asp:Label>
                            <div class="form-inline">
                                <input id="PartNOTextBox" type="text" class="form-control form-control-user" placeholder="" readonly="readonly" style="border: 0px; background-color: rgba(255,255,255,0.2)" aria-controls="dataTable" />&nbsp;
                                <%--<span id="PartNOLabel1" style="color: red">*產生單號</span>--%>
                            </div>
                        </label>
                        <%-- 填寫人編號 --%>
                        <label class="col-5">
                            <asp:Label ID="Label1" runat="server" Text="員工編號:"></asp:Label>
                            <div class="form-inline">
                                <input id="NameTextBox" type="text" readonly="readonly" style="border: 0px; background-color: rgba(255,255,255,0.2)" class="form-control form-control-user" placeholder="" aria-controls="dataTable" />&nbsp;
                                <%--<span id="NameLabel2" style="color: red">*自動帶入</span>--%>
                            </div>
                        </label>
                        <%-- 填寫人編號 --%>
                         <%-- 填寫人 --%>
                        <label class="col-5">
                            <asp:Label ID="Label6" runat="server" Text="員工編號:"></asp:Label>
                            <div class="form-inline">
                                <input id="IDNameTextBox" type="text" readonly="readonly" style="border: 0px; background-color: rgba(255,255,255,0.2)" class="form-control form-control-user" placeholder="" aria-controls="dataTable" />&nbsp;
                                <%--<span id="NameLabel2" style="color: red">*自動帶入</span>--%>
                            </div>
                        </label>
                        <%-- 填寫人 --%>
                        <%-- 所屬部門 --%>
                        <label class="col-6">
                            <asp:Label ID="Label3" runat="server" Text="所屬部門:"></asp:Label>
                            <div class="form-inline">
                                <input id="DeTextBox" type="text" readonly="readonly" style="border: 0px; background-color: rgba(255,255,255,0.2)" class="form-control form-control-user" placeholder="" aria-controls="dataTable" />&nbsp;
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
                                <input id="VendorTextBox" type="text" class="form-control form-control-user" placeholder="" aria-controls="dataTable" readonly="readonly" style="border: 0px; background-color: rgba(255,255,255,0.2)" />&nbsp;
                                <%--<span id="VendorLabel" style="color: red">*必填</span>--%>
                            </div>
                        </label>
                        <%-- 聯絡人 --%>
                        <label class="col-6">
                            <asp:Label ID="Label9" runat="server" Text="聯絡人:"></asp:Label>
                            <div class="form-inline">
                                <input id="VendorNameTextBox" type="text" class="form-control form-control-user" placeholder="" aria-controls="dataTable" readonly="readonly" style="border: 0px; background-color: rgba(255,255,255,0.2)" />&nbsp;
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
                                <input id="EmailTextBox" type="text" class="form-control form-control-user" aria-controls="dataTable" readonly="readonly" style="border: 0px; background-color: rgba(255,255,255,0.2)" />&nbsp;
                                <%--<span id="EmailLabel" style="color: red">*必填</span>--%>
                            </div>
                        </label>
                        <%-- 電話 --%>
                        <label class="col-6">
                            <asp:Label ID="Label11" runat="server" Text="電話:"></asp:Label>
                            <div class="form-inline">
                                <input id="phoneTextBox" type="text" class="form-control form-control-user" aria-controls="dataTable" readonly="readonly" style="border: 0px; background-color: rgba(255,255,255,0.2)" />&nbsp;
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
                <%-- <a href="#" id="addcolumn" class="btn btn-info btn-icon-split">
                    <span class="icon text-white-50">
                        <i class="fas fa-plus"></i>
                    </span>
                    <span class="text">新增採購項目欄位</span>
                </a>
                <br />
                <br />--%>
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
                        </tr>
                    </thead>
                    <tbody id="myTableBody">
                        <%--補table內容--%>
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
                              <input id="TextBoxTex" type="number" class="form-control form-control-user" value="0" aria-controls="dataTable" readonly="readonly" style="border: 0px; background-color: rgba(255,255,255,0.2)" />&nbsp;
                                <%--<span id="LabelTex" style="color: red">*X % </span>--%>
                    </div>
                </label>
                <label class="col">
                    <div class="form-inline">
                        <asp:Label ID="Label2" runat="server" Text="稅額:"></asp:Label>
                        &nbsp;
                              <input id="TextBoxTex1" type="number" class="form-control form-control-user" min="0" value="0" aria-controls="dataTable" readonly="readonly" style="border: 0px; background-color: rgba(255,255,255,0.2)" />&nbsp;
                                <%--<span id="LabelTex1" style="color: red">*X % * 總價 = 稅額</span>--%>
                    </div>
                </label>
                <label class="col">
                    <div class="form-inline">
                        <asp:Label ID="Label19" runat="server" Text="運費:"></asp:Label>
                        &nbsp;+
                         <input id="TextBoxfre" type="number" class="form-control form-control-user" min="0" value="0" aria-controls="dataTable" readonly="readonly" style="border: 0px; background-color: rgba(255,255,255,0.2)" />&nbsp;
                                <%--<span id="Labelfre" style="color: red">*+運費</span>--%>
                    </div>
                </label>
                <%-- 橫線 --%>

                <hr style="width: 30%;" align="left" />
                <%-- 橫線 --%>
                <label class="col">
                    <div class="form-inline">
                        <asp:Label ID="Label21" runat="server" Text="總價:"></asp:Label>
                        &nbsp;
                        <%--  <input id="TextBox1total" type="number" class="form-control form-control-user" min="0" placeholder="0" aria-controls="dataTable" />&nbsp;
                                <span id="Labeltotal" style="color: red">*+</span>--%>
                        <input id="TextBox1total" type="number" class="form-control form-control-user" placeholder="0" readonly="readonly" style="border: 0px; background-color: rgba(255,255,255,0.2)" aria-controls="dataTable" />&nbsp;
                                <span id="Labeltotal" style="color: red"></span>
                    </div>
                </label>


            </div>
            <hr />
            <%-- 稅及運費及總價 end--%>
            <%-- 審核狀態與送出 start--%>

            <label class="col">
                <div class="form-inline">
                    <asp:Label ID="Label4" runat="server" Text="審核狀態:"></asp:Label>
                    &nbsp;
                        <%--  <input id="TextBox1total" type="number" class="form-control form-control-user" min="0" placeholder="0" aria-controls="dataTable" />&nbsp;
                                <span id="Labeltotal" style="color: red">*+</span>--%>
                    <input id="Textstatuspass" type="text" class="form-control form-control-user" placeholder="" readonly="readonly" style="border: 0px; background-color: rgba(255,255,255,0.2)" aria-controls="dataTable" />&nbsp;
                                <span id="Labelstatuspass" style="color: red"></span>
                </div>
            </label>
            <%-- 審核狀態與送出 end--%>
            <%-- 審核未通過原因填寫 start--%>
            <label class="col-3">

                <asp:Label ID="Label5" runat="server" Text="審核未通過原因:"></asp:Label>
                &nbsp;  <span id="Labelstatusfail" style="color: red"></span>
                <textarea id="Qtyresume" name="TextArea1" cols="20" class="form-control" placeholder="請描述未通過的原因" runat="server" rows="5"></textarea>&nbsp;  
                                        <div class="textAreaCounter"></div>
            </label>
            <%-- 審核未通過原因填寫 end --%>
            <hr />
            <div class="custom-control-inline">
                <%--取消返回按鈕--%>
                <label class="col-2">
                    <a href="/prod/PurchCheck.aspx" id="backbutton" class="btn btn-secondary btn-icon-split">
                        <span class="icon text-white-50">
                            <i class="fas fa-arrow-right"></i>
                        </span>
                        <span class="text">回首頁</span>
                    </a>
                </label>
                <%--送出按鈕--%>
                <label class="col-2">
                    <a id="buttonpass" class="btn btn-success btn-icon-split" style="color: white">
                        <span class="icon text-white-50">
                            <i class="fas fa-check"></i>
                        </span>
                        <span class="text">審核已通過</span>
                    </a>
                </label>
                <label class="col-2">
                    <a id="buttonfail" class="btn btn-warning btn-icon-split" style="color: white">
                        <span class="icon text-white-50">
                            <i class="fas fa-exclamation-triangle"></i>
                        </span>
                        <span class="text">審核未通過</span>
                    </a>
                </label>

            </div>

            <%-- card body end --%>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="myScript" runat="Server">
    <%--引用textarea start--%>
    <script src="textarea-max-character-counter/textarea-max-character-counter/js/maxCaracter.js"></script>
    <%--引用textarea end--%>
    <%-- 引用function products js --%>
    <script src="../js/prodUse.js"></script>
    <%--引用自己計算--%>
    <script src="../js/prodUse.js"></script>
    <script>
        $(function () {
            //隱藏按鈕 start
            var hid1 = $("#myContent_HiddenField1").val();
            console.log(hid1);
            if (hid1 == "a") {
                $("#buttonpass").css("display", "none");
                $("#buttonfail").css("display", "none");
                $("#myContent_Qtyresume").attr("readonly", "readonly")

            }


            //隱藏按鈕 end
            //textarea start
            $("#myContent_Qtyresume").maxCaracter({
                limit: 500,
                startCounter: $(this).val().length,
                titleColor: "#1578AD",
                textColor: "#ff0000",
            })
            //textarea end

            ////單號從session隱藏欄位拿
            //var purchId = $("#HiddenField").val();

            //填入填寫日期  ajax拉出
            //寫入目前登入人名
            //寫入目前登入人部門

            var data = parseInt($("#myContent_HiddenField").val());
            //alert(data) 
            //console.log(data);
            var myData = { purchNO: data };
            console.log(myData)
            $.ajax({
                type: 'POST',
                url: '/WebService.asmx/purchAll',
                contentType: "application/json;charset=utf-8",
                data: JSON.stringify(myData),
                success: function (data) {
                    console.log(data);
                    //拿到purchNO要塞入的標籤 上方
                    var purchNOData = "PURCH" + padLeft(parseInt(data.d.purchNO), 5);
                    console.log(purchNOData);
                    $("#PartNOTextBox").attr("value", purchNOData);
                    var buyerData = "A" + padLeft(parseInt(data.d.buyer), 4);
                    console.log(buyerData);
                    $("#NameTextBox").attr("value", buyerData);
                    $("#IDNameTextBox").attr("value", data.d.Name);
                    $("#DeTextBox").attr("value", data.d.department);
                      var MyDate_String_Value = data.d.ThisDay
                    var value = new Date
                        (
                        parseInt(MyDate_String_Value.replace(/(^.*\()|([+-].*$)/g, ''))
                        );
                    var dat = value.getFullYear() + "/" +
                        (value.getMonth() +
                        1 )+
                        "/" +
                        value.getDate();
                    $("#TodayTextBox").attr("value", dat);
                    //中間vendor
                    $("#VendorTextBox").attr("value", data.d.vendor);
                    $("#VendorNameTextBox").attr("value", data.d.vendorsales);
                    $("#EmailTextBox").attr("value", data.d.email);
                    $("#phoneTextBox").attr("value", data.d.phone);

                    ////拿到purchNO要塞入的標籤 下方總價
                    $("#TextBoxTex").attr("value", data.d.taxrate);
                    $("#TextBoxTex1").attr("value", data.d.tax);
                    $("#TextBoxfre").attr("value", data.d.freight);
                    $("#TextBox1total").attr("value", data.d.totalprice);
                    ////下方審核狀態帶入
                    $("#Textstatuspass").attr("value", data.d.checkstatus);
                    $("#myContent_Qtyresume").text(data.d.checkreason);

                },
                error: function (x) { console.log("error"); }

            });
            //purchpart撈資料庫的no新增列
            $.ajax({
                type: 'POST',
                url: '/WebService.asmx/purchpartall',
                contentType: "application/json;charset=utf-8",
                data: JSON.stringify(myData),
                success: function (data) {
                    console.log(data);
                    $(data.d).each(function (index, item) {
                        $("#myTableBody").append(
                            `<tr>
                            <td>${item.purchPart}</td>
                            <td>${item.config}</td>
                            <td>${item.count}</td>
                            <td>${item.price}</td>
                            <td>${item.partTotal}</td>
                             <td>${item.remark}</td>
                        </tr>` )
                    });
                },
                error: function (X) { console.log("error"); }
            });

            //$("#test").click(function () {

            //});

            //送出pass審核
            $("#buttonpass").click(function () {
                //組存狀態的資料依照purchNO
                var data = parseInt($("#myContent_HiddenField").val());
                var status = "已通過";
                var reason = $("#myContent_Qtyresume").val();
                //填入審核日期
                var da = new Date();
               

                var mydata = { purchNO: data, checkstatus: status, checkday: da, checkreason: reason };
                $.ajax({
                    type: 'POST',
                    url: '/WebService.asmx/UPdateCheck',
                    contentType: "application/json;charset=utf-8",
                    data: JSON.stringify(mydata),
                    success: function (data) {
                        console.log(data);
                        alert("已通過");
                        window.location.href = "/prod/PurchCheck.aspx";
                    },
                    error: function (x) { console.log("error"); }
                });

            });


            //送出fail審核
            $("#buttonfail").click(function () {
                //組存狀態的資料依照purchNO
                var datafail = parseInt($("#myContent_HiddenField").val());
                var statusfail = "未通過";
                var reasonfail = $("#myContent_Qtyresume").val();
                //填入審核日期
                var da = new Date();
             

                var mydata = { purchNOfail: datafail, checkstatusfail: statusfail, checkdayfail: da, checkreasonfail: reasonfail };
                $.ajax({
                    type: 'POST',
                    url: '/WebService.asmx/UPdateCheckfail',
                    contentType: "application/json;charset=utf-8",
                    data: JSON.stringify(mydata),
                    success: function (data) {
                        console.log(data);
                        alert("未通過");
                        window.location.href = "/prod/PurchCheck.aspx";
                    },
                    error: function (x) { console.log("error"); }
                });

            });




        });


    </script>
</asp:Content>

