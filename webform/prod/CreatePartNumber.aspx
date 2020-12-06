<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="CreatePartNumber.aspx.cs" Inherits="prod_CrestPartNumber" %>

<asp:Content ID="Content1" ContentPlaceHolderID="myCss" runat="Server">
    <%-- 引用my style css start --%>
    <link href="../css/MyStyleSheet.css" rel="stylesheet" />
    <%-- 引用my style css end--%>
    <%--引用textarea start--%>
    <link href="textarea-max-character-counter/textarea-max-character-counter/css/style.css" rel="stylesheet" />
    <link href="textarea-max-character-counter/textarea-max-character-counter/css/style.css" rel="stylesheet" />
    <%--引用textarea end--%>
    <%--引用uploadfile start--%>
    <link href="jQuery-Plugin-To-Beautify-File-Inputs-with-Custom-Styles-Dropify/dist/css/demo.css" rel="stylesheet" />
    <link href="jQuery-Plugin-To-Beautify-File-Inputs-with-Custom-Styles-Dropify/dist/css/dropify.css" rel="stylesheet" />
    <%--引用uploadfile end--%>
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
                &nbsp;<h4 class="m-0 font-weight-bold text-primary">新增料件編號</h4>
            </div>
            <div class="card-body">
                <div class="table">
                    <div class="row">
                        <%--CREAT PART NUMBER start--%>
                        <div class="col-sm-12 col-md-8 ">
                            <div id="dataTable_filter" class="dataTables_filter">
                                <%--料件編號  textbox改成可以複製或是改成label--%>
                                <label>
                                    <%-- 隱藏欄位下拉選單資料 --%>
                                    <asp:HiddenField ID="HiddenField1" runat="server" />
                                    <asp:HiddenField ID="HiddenField2" runat="server" />

                                    <asp:Label ID="PartNOLabel" runat="server" Text="料件編號:"></asp:Label>
                                    <div class="form-inline">
                                        <asp:TextBox ID="PartNOTextBox" class="form-control form-control-user" type="search" runat="server" placeholder="料件編號" ReadOnly="true" Text="" aria-controls="dataTable"></asp:TextBox>&nbsp;
                                        <asp:Label ID="PartNOLabel1" runat="server" ForeColor="Red" Text="*建立成功會產生料號"></asp:Label>
                                    </div>
                                </label>
                                <br/>
                                <%--元件--%>
                                <label>
                                    <asp:Label ID="ComponentLabel" runat="server" Text="供應商:"></asp:Label>
                                    <div class="form-inline">
                                        <%-- 自己刻選單1 --%>
                                        <select class="form-control form-control-user dropdown-toggle" id="DropDownList5" runat="server">
                                        </select>
                                        <%--元件下拉選單--%>
                                      <%--  <asp:DropDownList ID="ComponentDropDown" CssClass="form-control form-control-user dropdown-toggle" runat="server">
                                            <asp:ListItem Value="a">-----------------</asp:ListItem>
                                            <asp:ListItem>SSD</asp:ListItem>
                                            <asp:ListItem>MB</asp:ListItem>
                                            <asp:ListItem>Thermal</asp:ListItem>
                                            <asp:ListItem>Panel</asp:ListItem>
                                            <asp:ListItem>CPU</asp:ListItem>
                                            <asp:ListItem>GPU</asp:ListItem>
                                        </asp:DropDownList>--%>
                                        &nbsp;
                                        <asp:Label ID="ComponentLabel1" runat="server" ForeColor="Red" Text=""></asp:Label>
                                    </div>
                                </label>
                                <br/>
                                <%--供應商--%>
                                <label>
                                    <asp:Label ID="VendorLabel" runat="server" Text="元件類型:"></asp:Label>
                                    <div class="form-inline">
                                        <%-- 自己刻選單1 --%>
                                        <select class="form-control form-control-user dropdown-toggle" id="DropDownList6" runat="server">
                                        </select>
                                        <%--廠商下拉選單--%>
                                     <%--   <asp:DropDownList ID="VendorDropDown" CssClass="form-control form-control-user dropdown-toggle" runat="server">
                                            <asp:ListItem Value="a">-----------------</asp:ListItem>
                                            <asp:ListItem>Toshiba</asp:ListItem>
                                            <asp:ListItem>Delta</asp:ListItem>
                                            <asp:ListItem>Samsung</asp:ListItem>
                                            <asp:ListItem>Intel</asp:ListItem>
                                            <asp:ListItem>AMD</asp:ListItem>
                                            <asp:ListItem>Nvdia</asp:ListItem>
                                        </asp:DropDownList>--%>
                                        &nbsp;
                                        <asp:Label ID="VendorLabel1" runat="server" ForeColor="Red" Text=""></asp:Label>
                                    </div>
                                </label>
                               <br/>
                                <%--規格--%>
                                <label>
                                    <asp:Label ID="ConfigLabel" runat="server" Text="規格:"></asp:Label>
                                    <div class="form-inline">
                                        <asp:TextBox ID="ConfigTextbox" class="form-control form-control-user" type="search" runat="server" placeholder="規格" aria-controls="dataTable"></asp:TextBox>&nbsp;
                                        <asp:Label ID="ConfigLabel1" runat="server" ForeColor="Red" Text="*請填入尺寸單位，例如:14inch"></asp:Label> &nbsp;&nbsp;<input id="Button1" type="button" value="DEMO" class="btn btn-danger" />
                                    </div>
                                </label>
                              <br/>
                                <%--描述--%>
                                <asp:Label ID="DescriptionLabel" runat="server" Text="描述:"></asp:Label>
                                <asp:Label ID="DescriptionLabel1" runat="server" ForeColor="Red" Text="*MEMO:請填入方便RD辨別的關鍵字"></asp:Label>
                                <textarea id="resume" name="TextArea1" cols="20" class="form-control" placeholder="描述" runat="server" rows="5"></textarea>&nbsp;  
                                        <div class="textAreaCounter"></div>
                                </br>
                                <%--2d圖面--%>
                                <label>
                                    <asp:Label ID="drawingLabel" runat="server" Text="2D圖面:"></asp:Label>&nbsp;
                                    <asp:Label ID="drawingLabel1" runat="server" ForeColor="Red" Text="*PDF"></asp:Label>
                                    <%-- <div class="form-inline">--%>
                                    <asp:FileUpload ID="FileUpload1" class="dropify" data-default-file="" runat="server" />
                                    <%--</div>--%>
                                </label>
                               <br/>
                            </div>
                        </div>
                    </div>
                    </br>
                    </br>
                    <%--SUMIT BUTTON START--%>
                    <%--<input id="Button1" type="button" value="button" />--%>
                    <asp:Button ID="sumitbutton" runat="server" CssClass="btn btn-success" OnClick="sumitbutton_Click"  Text="確認送出" />
                    &nbsp;
                    <asp:Button ID="topartnolist" CssClass="btn btn-info" OnClick="topartnolist_Click" runat="server" Text="回料件表" />
                    &nbsp;
                    <%--<asp:Label ID="Labelerror" runat="server" Text=""></asp:Label>--%>
                   
                    <%--SUMIT BUTTON END--%>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="myScript" runat="Server">
    <%--引用textarea start--%>
    <script src="textarea-max-character-counter/textarea-max-character-counter/js/maxCaracter.js"></script>
    <%--引用textarea end--%>
    <%--引用uploadfile start--%>
    <script src="jQuery-Plugin-To-Beautify-File-Inputs-with-Custom-Styles-Dropify/dist/js/dropify.js"></script>
    <%--引用uploadfile end--%>
    <script type="text/javascript">
        $(function () {
            //textarea start
            $("#myContent_resume").maxCaracter({
                limit: 500,
                startCounter: $(this).val().length,
                titleColor: "#1578AD",
                textColor: "#ff0000",
            })
            //textarea end
            //uploadfile start
            $('.dropify').dropify()
            //$('#myContent_PartNOTextBox').val("PARTN");



            //下拉選單一填入資料
            $.ajax({
                type: 'POST',
                url: '/WebService.asmx/Getsupplier',
                contentType: "application/json;charset=utf-8",
                success: function (data) {
                    console.log(data)
                    $("#myContent_DropDownList5").append(
                        `<option value="a">==請選擇==</option>`);
                    $(data.d).each(function (index, item) {
                        $("#myContent_DropDownList5").append(
                            ` <option name="${item.CompanyName}" value="${item.supplierID}">${item.CompanyName}</option>`
                        )
                    });

                },
                error: function (x) { console.log("error"); }

            });

            //第二個下拉選單
            $("#myContent_DropDownList5").change(function () {
                var valuedp1 = parseInt($("#myContent_DropDownList5").val());
                console.log(valuedp1);
                var mydata = { supplierID: valuedp1 };
                $.ajax({
                    type: 'POST',
                    url: '/WebService.asmx/GetComponent',
                    contentType: "application/json;charset=utf-8",
                    data: JSON.stringify(mydata),
                    success: function (data) {
                        console.log(data);
                        $("#myContent_DropDownList6").empty();
                         $("#myContent_DropDownList6").append(
                        `<option value="a">==請選擇==</option>`);
                    $(data.d).each(function (index, item) {
                        $("#myContent_DropDownList6").append(
                            ` <option name="${item.Component}" value="${item.supplierID}">${item.Component}</option>`
                        )
                    });

                    },
                    error: function (x) { console.log("error"); }

                });
            });

            $("#myContent_sumitbutton").click(function () {
                $("#myContent_HiddenField1").val($("#myContent_DropDownList5 option:selected").text());
                $("#myContent_HiddenField2").val($("#myContent_DropDownList6 option:selected").text());
            });
            $("#Button1").click(function () {
                $("#myContent_ConfigTextbox").val("7921");
                $("#myContent_resume").val("非金屬散熱膏");
            });
        
        });
    </script>

    <%--引用textarea end--%>
</asp:Content>

