<%@ Page Title="About" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="About.aspx.cs" Inherits="IBRMnerWeb.About" %>

<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>

<asp:Content ID="MainContent" ContentPlaceHolderID="MainContent" runat="server">
    <div class="page-header">
        <h1>About IBRMner</h1>
    </div>
    <div class="page-content">
        <p>
            IBRMner is a demonstration ASP.NET Web Forms application targeting .NET Framework 4.8.
        </p>
        <p>
            This solution showcases classic Web Forms features including:
        </p>
        <ul>
            <li>Master pages for consistent page layout</li>
            <li>ASPX pages with code-behind files</li>
            <li>Server-side controls and event handling</li>
            <li>Web.config configuration</li>
            <li>Global application lifecycle (Global.asax)</li>
        </ul>
        <p>
            <strong>Framework:</strong> .NET Framework 4.8<br />
            <strong>Technology:</strong> ASP.NET Web Forms
        </p>
    </div>
</asp:Content>
