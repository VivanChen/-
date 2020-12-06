<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="PartEdit.aspx.cs" Inherits="prod_PartEdit" %>

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
                &nbsp;<h4 class="m-0 font-weight-bold text-primary">修改料件</h4>
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
                                        <asp:TextBox ID="PartNOTextBox" class="form-control form-control-user" type="search"  runat="server" placeholder="料件編號" ReadOnly="true" Text="" ></asp:TextBox>&nbsp;
                                        <asp:Label ID="PartNOLabel1" runat="server" ForeColor="Red" Text=""></asp:Label>
                                    </div>
                                </label>
                                </br>
                                <%--元件--%>
                                <label>
                                    <asp:Label ID="ComponentLabel" runat="server" Text="元件:"></asp:Label>
                                    <div class="form-inline">
                                        <%--元件下拉選單--%>
                                        <asp:TextBox ID="ComponentTextBox" class="form-control form-control-user" type="search" runat="server" placeholder="元件" ReadOnly="true" Text="" ></asp:TextBox>
                                        &nbsp;
                                        <asp:Label ID="ComponentLabel1" runat="server" ForeColor="Red" Text=""></asp:Label>
                                    </div>
                                </label>
                                <br/>
                                <%--供應商--%>
                                <label>
                                    <asp:Label ID="VendorLabel" runat="server" Text="供應商:"></asp:Label>
                                    <div class="form-inline">
                                        <%--廠商下拉選單--%>
                                        <asp:TextBox ID="VendorTextBox" class="form-control form-control-user" type="search" runat="server" placeholder="供應商" ReadOnly="true" Text="" ></asp:TextBox>
                                        &nbsp;
                                        <asp:Label ID="VendorLabel1" runat="server" ForeColor="Red" Text=""></asp:Label>
                                    </div>
                                </label>
                                </br/>
                                <%--規格--%>
                                <label>
                                    <asp:Label ID="ConfigLabel" runat="server" Text="規格:"></asp:Label>
                                    <div class="form-inline">
                                        <asp:TextBox ID="ConfigTextbox" class="form-control form-control-user" type="search" runat="server" placeholder="規格"></asp:TextBox>&nbsp;
                                        <asp:Label ID="ConfigLabel1" runat="server" ForeColor="Red" Text="*請填入尺寸單位，例如:14inch"></asp:Label>
                                    </div>
                                </label>
                                </br>
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
                                    <asp:FileUpload ID="FileUpload1" class="dropify" runat="server" data-default-file="" data-show-remove="false"  />
                                   <asp:HiddenField ID="HiddenField1" runat="server" />
                                </label>
                                <br/>
                            </div>
                        </div>
                    </div>
                     <br/>
                     <br/>
                    <%--SUMIT BUTTON START--%>
                    <asp:Button ID="sumitbutton" runat="server" CssClass="btn btn-success" OnClick="sumitbutton_Click" Text="確認送出" />
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
    <script>
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
            $("#myContent_FileUpload1").attr("data-default-file", $("#myContent_HiddenField1").val());
            $('.dropify').dropify()
            //uploadfile end
        });
        $("#myContent_sumitbutton").click(function () {
             $('.dropify').dropify()
        });

    </script>


</asp:Content>

