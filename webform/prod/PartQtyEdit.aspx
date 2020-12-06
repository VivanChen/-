<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="PartQtyEdit.aspx.cs" Inherits="prod_PartQtyEdit" %>

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
    <%--引用number start--%>
    <link href="jQuery-Plugin-To-Create-Increment-Decrement-Input-Spinners-handleCounter/app/css/handle-counter.css" rel="stylesheet" />
    <%--引用number end--%>
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
                &nbsp;<h4 class="m-0 font-weight-bold text-primary">修改料件庫存</h4>
            </div>
            <div class="card-body">
                <div class="table">
                    <div class="row">
                        <%--CREAT PART NUMBER start--%>
                        <div class="col-sm-12 col-md-8 ">
                            <div id="dataTable_filter" class="dataTables_filter">
                                <%--料件編號  textbox改成可以複製或是改成label--%>
                                <label>
                                    <asp:Label ID="PartNOLabel" runat="server" Text="料件編號:"></asp:Label>
                                    <div class="form-inline">
                                        <asp:TextBox ID="PartNOTextBox" class="form-control form-control-user" type="search" runat="server" placeholder="料件編號" ReadOnly="true" Text=""></asp:TextBox>&nbsp;
                                        <asp:Label ID="PartNOLabel1" runat="server" ForeColor="Red" Text=""></asp:Label>
                                    </div>
                                </label>
                                </br>
                                <%--元件--%>
                                <label>
                                    <asp:Label ID="ComponentLabel" runat="server" Text="元件:"></asp:Label>
                                    <div class="form-inline">
                                        <%--元件下拉選單--%>
                                        <asp:TextBox ID="ComponentTextBox" class="form-control form-control-user" type="search" runat="server" placeholder="元件" ReadOnly="true" Text=""></asp:TextBox>
                                        &nbsp;
                                        <asp:Label ID="ComponentLabel1" runat="server" ForeColor="Red" Text=""></asp:Label>
                                    </div>
                                </label>
                                <br />
                                <%--供應商--%>
                                <label>
                                    <asp:Label ID="VendorLabel" runat="server" Text="供應商:"></asp:Label>
                                    <div class="form-inline">
                                        <%--廠商下拉選單--%>
                                        <asp:TextBox ID="VendorTextBox" class="form-control form-control-user" type="search" runat="server" placeholder="供應商" ReadOnly="true" Text=""></asp:TextBox>
                                        &nbsp;
                                        <asp:Label ID="VendorLabel1" runat="server" ForeColor="Red" Text=""></asp:Label>
                                    </div>
                                </label>
                                </br/>
                                <%--規格--%>
                                <label>
                                    <asp:Label ID="ConfigLabel" runat="server" Text="規格:"></asp:Label>
                                    <div class="form-inline">
                                        <asp:TextBox ID="ConfigTextbox" class="form-control form-control-user" type="search" runat="server" placeholder="規格" ReadOnly="true"></asp:TextBox>&nbsp;
                                        <asp:Label ID="ConfigLabel1" runat="server" ForeColor="Red" Text=""></asp:Label>
                                    </div>
                                </label>
                                </br>
                                <%--描述--%>
                                <%--<asp:Label ID="DescriptionLabel" runat="server" Text="描述:"></asp:Label>
                                <asp:Label ID="DescriptionLabel1" runat="server" ForeColor="Red" Text="*MEMO:請填入方便RD辨別的關鍵字"></asp:Label>
                                <textarea id="resume" name="TextArea1" cols="20" class="form-control" placeholder="描述" runat="server" rows="5" ReadOnly="true" ></textarea>&nbsp;  
                                        <div class="textAreaCounter"></div>
                                </br>--%>
                                <%--2d圖面--%>
                                <label>
                                    <asp:Label ID="drawingLabel" runat="server" Text="2D圖面:"></asp:Label>&nbsp;
                                    <asp:Label ID="drawingLabel1" runat="server" ForeColor="Red" Text="*PDF"></asp:Label>
                                    <asp:FileUpload ID="FileUpload1" class="dropify" runat="server" data-default-file="" EnableTheming="False" />
                                    <asp:HiddenField ID="HiddenField1" runat="server" />
                                </label>
                                <br />
                                <%-- 修改數量 --%>
                                <label>
                                    <asp:Label ID="numberLabel" runat="server" Text="庫存數量:"></asp:Label>&nbsp;
                                    <asp:Label ID="numberLabel1" runat="server" ForeColor="Red" Text="*修改庫存數量"></asp:Label>
                                    <br />
                                    <div class="handle-counter" id="handleCounter">
                                        <button class="counter-minus btn btn-primary" onclick="return false">-</button>
                                        <%--<input type="text" value="3">--%>
                                        <asp:TextBox ID="textboxnumber" type="text" placeholder="0" min="0" runat="server"></asp:TextBox>
                                        <button class="counter-plus btn btn-primary" onclick="return false">+</button>
                                    </div>
                                </label>
                                <br />
                                <%-- 修改數量異常描述 --%>
                                <label>
                                <asp:Label ID="QtyDescriptionLabel" runat="server" Text="描述庫存狀態:"></asp:Label>
                                &nbsp;
                                 <asp:Label ID="QtyDescriptionLabel1" runat="server" ForeColor="Red" Text="*MEMO:請填入料件異常影響庫存備註"></asp:Label>
                                <textarea id="Qtyresume" name="TextArea1" cols="20" class="form-control" placeholder="描述" runat="server" rows="5"></textarea>&nbsp;  
                                        <div class="textAreaCounter"></div>
                                </label>
                                <%-- 修改數量異常描述 --%>
                            </div>
                        </div>
                    </div>
                    <%--SUMIT BUTTON START--%>
                    <asp:Button ID="sumitbutton" runat="server" CssClass="btn btn-success" OnClick="sumitbutton_Click" Text="確認送出" />
                    &nbsp;
                    <asp:Button ID="topartnolist" CssClass="btn btn-info" OnClick="topartnolist_Click" runat="server" Text="回料件表" />
                    &nbsp;
                    <input id="Button1" type="button" value="DEMO" class="btn btn-danger" />
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
    <%--引用number start--%>
    <script src="jQuery-Plugin-To-Create-Increment-Decrement-Input-Spinners-handleCounter/app/js/handleCounter.js"></script>

    <%--引用number end--%>
    <script>
        $(function () {


            //uploadfile start
            $("#myContent_FileUpload1").attr("data-default-file", $("#myContent_HiddenField1").val());
            $("#myContent_FileUpload1").attr("disabled", "disabled");
            $('.dropify').dropify()
            //uploadfile end
            //textarea start
            $("#myContent_Qtyresume").maxCaracter({
                limit: 500,
                startCounter: $(this).val().length,
                titleColor: "#1578AD",
                textColor: "#ff0000",
            })
            //textarea end
            //number start
            $('#handleCounter').handleCounter({
                minimum: 1,
                maximize: null,
            });
            //number end
        });
        $("#myContent_sumitbutton").click(function () {
            $('.dropify').dropify()
        });
        $("#Button1").click(function () {
            $("#myContent_Qtyresume").val("1個料件異常未上線");
        });
    </script>
</asp:Content>

