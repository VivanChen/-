<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" %>

<script runat="server">

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.QueryString["LeaveID"] !=null)
        {
            int id = int.Parse(Request.QueryString["LeaveID"]);
            LeaveUtility.DeleteLeave(id);
        }
        Response.Redirect("leaveList.aspx");
    }
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="myCss" Runat="Server">
    
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="myContent" Runat="Server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="myScript" Runat="Server">
</asp:Content>

