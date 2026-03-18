<%@ Page Title="Home" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="IBRMnerWeb.Default" %>

<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>

<asp:Content ID="MainContent" ContentPlaceHolderID="MainContent" runat="server">
    <div class="page-header">
        <h1>Welcome to IBRMner</h1>
    </div>
    <div class="page-content">
        <p>
            IBRMner is a basic ASP.NET Web Forms application built on .NET Framework 4.8.
        </p>
        <p>
            Use the navigation links above to explore the application.
        </p>
        <asp:Label ID="lblMessage" runat="server" CssClass="message" />
        <div class="action-panel">
            <asp:Button ID="btnGreet" runat="server" Text="Say Hello" OnClick="btnGreet_Click" CssClass="btn" />
        </div>
    </div>
</asp:Content>
