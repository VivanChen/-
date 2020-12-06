<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="PurchDetail.aspx.cs" Inherits="prod_PurchDetail" %>

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
                &nbsp;<h3 class="m-0 font-weight-bold text-primary">新增採購單確認</h3>
            </div>
            <%-- session 接purchNO --%>
            <asp:HiddenField ID="HiddenField" runat="server" />
            <%-- 員工編號 --%>
            <asp:HiddenField ID="HiddenField1" runat="server" />
            <%-- 存員工名子 --%>
            <asp:HiddenField ID="HiddenField2" runat="server" />

            <%-- card body start --%>
            <div class="card-body">
                <%-- 上方必填欄位 開始 --%>
                <div>
                    <%-- 上方必填欄位 公司 開始 --%>
                    <div>
                        <div class="form-inline">
                            <h4 class="m-0 font-weight-bold text-primary col-2">採購單資料</h4>
                            <span class="col-1">填寫日期 :</span>
                            <input id="TodayTextBox" type="text" readonly="readonly" style="border: 0px; background-color: rgba(255,255,255,0.2)" />
                            <span id="TodayTextBox1"></span>
                        </div>
                        <%--測試用欄位--%>
                        <%-- <input id="boxtest" type="text" />
                        <input type="button" id="test" value="sessiontest" />
                        <br />--%>
                        <%-- 採購單號 --%>
                        <label class="col-5">
                            <asp:Label ID="PartNOLabel" runat="server" Text="採購單號:"></asp:Label>
                            <div class="form-inline">
                                <input id="PartNOTextBox" type="text" class="form-control form-control-user" placeholder="" readonly="readonly" style="border: 0px; background-color: rgba(255,255,255,0.2)" aria-controls="dataTable" />&nbsp;
                                <span id="PartNOLabel1" style="color: red">*產生單號</span>
                            </div>
                        </label>
                        <%-- 填寫人id --%>
                        <label class="col-6">
                            <asp:Label ID="Label1" runat="server" Text="員工編號:"></asp:Label>
                            <div class="form-inline">
                                <input id="NameTextBox" type="text" readonly="readonly" style="border: 0px; background-color: rgba(255,255,255,0.2)" class="form-control form-control-user" placeholder="" aria-controls="dataTable" />&nbsp;
                                <%--<span id="NameLabel2" style="color: red">*自動帶入</span>--%>
                            </div>
                        </label>
                        <%-- 填寫人id --%>
                        <%-- 填寫人id --%>
                        <label class="col-5">
                            <asp:Label ID="Label4" runat="server" Text="員工名字:"></asp:Label>
                            <div class="form-inline">
                                <input id="idNameTextBox" type="text" readonly="readonly" style="border: 0px; background-color: rgba(255,255,255,0.2)" class="form-control form-control-user" placeholder="" aria-controls="dataTable" />&nbsp;
                                <%--<span id="NameLabel2" style="color: red">*自動帶入</span>--%>
                            </div>
                        </label>
                        <%-- 填寫人id --%>
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
                        &nbsp;
                         <input id="TextBoxfre" type="number" class="form-control form-control-user" min="0" value="0" aria-controls="dataTable" readonly="readonly" style="border: 0px; background-color: rgba(255,255,255,0.2)" />&nbsp;
                                <%--<span id="Labelfre" style="color: red">*+運費</span>--%>
                    </div>
                </label>
                <%-- 橫線 --%>
                <asp:Label ID="Label23" runat="server" Text="_____________________________________________"></asp:Label>
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

            <%-- 稅及運費及總價 end--%>
            <hr />

            <div class="custom-control-inline">
                <%--送出按鈕--%>
                <label class="col-2">
                    <a id="submitbutton" class="btn btn-primary btn-icon-split" style="color: white">
                        <span class="icon text-white-50">
                            <i class="fas fa-flag"></i>
                        </span>
                        <span class="text">送出審核</span>
                    </a>
                </label>
                <%--取消返回按鈕--%>
                <label class="col-2">
                    <a href="PurchCheck.aspx" id="backbutton" class="btn btn-secondary btn-icon-split">
                        <span class="icon text-white-50">
                            <i class="fas fa-arrow-right"></i>
                        </span>
                        <span class="text">取消審核回首頁</span>
                    </a>
                </label>

            </div>

            <%-- card body end --%>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="myScript" runat="Server">
    <%-- 引用function products js --%>
    <script src="../js/prodUse.js"></script>
    <%--引用自己計算--%>
    <script src="../js/prodUse.js"></script>
    <script>
        $(function () {

            ////單號從session隱藏欄位拿
            var purchId = parseInt($("#myContent_HiddenField").val());
            console.log(purchId)
            //填入填寫日期  ajax拉出
            //寫入目前登入人名
            //寫入目前登入人部門


            //alert(data)
            var myData = { purchNO: purchId };
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

                    //多補的塞入名子
                    $("#idNameTextBox").attr("value", data.d.Name);
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
        });

        //送出審核
        $("#submitbutton").click(function () {
            alert("送出審核成功");
            window.location.href = "/prod/PurchCheck.aspx";


        });

        //取消送審ajax刪除內容
        $("#backbutton").click(function () {
            var Id = parseInt($("#myContent_HiddenField").val());
            if (Id >= 1) {
                var theData = { purchNO: Id };
                $.ajax({
                    type: 'POST',
                    url: '/WebService.asmx/delete',
                    contentType: "application/json;charset=utf-8",
                    data: JSON.stringify(theData),
                    success: function (data) {
                        alert("已取消送審回採購首頁");
                    },
                    error: function (X) { console.log("error"); }
                })
            }




        });







    </script>

</asp:Content>
