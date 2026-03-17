<%@ Page Title="Error" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Error.aspx.cs" Inherits="IBRMnerWeb.ErrorPage" %>

<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>

<asp:Content ID="MainContent" ContentPlaceHolderID="MainContent" runat="server">
    <div class="page-header">
        <h1>An Error Occurred</h1>
    </div>
    <div class="page-content">
        <p>We're sorry, but an unexpected error has occurred. Please try again later.</p>
        <p><a href="Default.aspx">Return to Home</a></p>
    </div>
</asp:Content>
