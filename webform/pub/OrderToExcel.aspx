<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" EnableEventValidation="false"%>

<script runat="server">
    public override void VerifyRenderingInServerForm(Control control) { }
    protected void Page_Load(object sender, EventArgs e)
    {
        HiddenField1.Value = DateTime.Now.ToShortDateString();
        string todayordername = DateTime.Now.ToShortDateString()+"訂餐統計";
        Response.ClearContent();
        Response.AddHeader("content-disposition", $"attachment; filename={todayordername}.xls");
        Response.ContentEncoding = System.Text.Encoding.GetEncoding("big5");
        HttpContext.Current.Response.Write("<meta http-equiv=Content-Type content=text/html;charset=big5>");
        HttpContext.Current.Response.Write("<head><meta http-equiv=Content-Type content=text/html;charset=big5></head>");
        Response.Charset = "big5";
        Response.ContentType = "application/excel";


        System.IO.StringWriter sw = new System.IO.StringWriter();
        HtmlTextWriter htw = new HtmlTextWriter(sw);
        GridView1.RenderControl(htw);
        Response.Write(sw.ToString());
        Response.End();
    }
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="myCss" Runat="Server">
    <style type="text/css">
        .auto-style1 {
            margin-top: 20px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="myContent" Runat="Server">
    <asp:GridView ID="GridView1" runat="server" DataSourceID="SqlDataSource1" AutoGenerateColumns="False" CssClass="auto-style1">
        <Columns>
            <asp:BoundField DataField="LunchOrderID" HeaderText="dd" InsertVisible="False" ReadOnly="True" SortExpression="LunchOrderID" />
            <asp:BoundField DataField="EmployeeID" HeaderText="EmployeeID" SortExpression="EmployeeID" />
            <asp:BoundField DataField="OrderDate" HeaderText="OrderDate" SortExpression="OrderDate" />
            <asp:BoundField DataField="OrderName" HeaderText="OrderName" SortExpression="OrderName" />
            <asp:BoundField DataField="OrderInfo" HeaderText="OrderInfo" SortExpression="OrderInfo" />
            <asp:BoundField DataField="OrderCount" HeaderText="OrderCount" SortExpression="OrderCount" />
            <asp:BoundField DataField="OrderPrice" HeaderText="OrderPrice" SortExpression="OrderPrice" />
        </Columns>
    </asp:GridView>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:WebsiteConnectionString1 %>" SelectCommand="SELECT * FROM [LunchOrders] WHERE ([OrderDate] = @OrderDate)">
        <SelectParameters>
            <asp:ControlParameter ControlID="HiddenField1" Name="OrderDate" PropertyName="Value" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:HiddenField ID="HiddenField1" runat="server" />
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="myScript" Runat="Server">
</asp:Content>

