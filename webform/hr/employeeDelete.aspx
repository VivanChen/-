<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" %>

<script runat="server">

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!User.IsInRole("hr"))
        {
            Response.Redirect("~/AuthorityInfo.aspx");
        }
        if (Request.QueryString["EmployeeID"] !=null)
        {
            int id = int.Parse(Request.QueryString["EmployeeID"]);
            EmployeeUtility.DeleteEmployee(id);
        }
        Response.Redirect("~/employeeList.aspx");
    }
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="myCss" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="myContent" Runat="Server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="myScript" Runat="Server">
</asp:Content>

