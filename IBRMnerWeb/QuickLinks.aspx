<%@ Page Title="Quick Links" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="QuickLinks.aspx.cs" Inherits="IBRMnerWeb.QuickLinks" %>

<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>

<asp:Content ID="MainContent" ContentPlaceHolderID="MainContent" runat="server">
    <div class="page-header">
        <h1>Quick Links</h1>
    </div>
    <div class="page-content">
        <asp:Panel ID="pnlError" runat="server" Visible="false" CssClass="quicklinks-error">
            <asp:Label ID="lblError" runat="server" />
        </asp:Panel>

        <asp:Panel ID="pnlNoData" runat="server" Visible="false">
            <p>No quick links are currently available.</p>
        </asp:Panel>

        <asp:Repeater ID="rptQuickLinks" runat="server">
            <HeaderTemplate>
                <ul class="quicklinks-list">
            </HeaderTemplate>
            <ItemTemplate>
                <li class="quicklinks-item">
                    <a href="#" class="quicklink"
                       data-id='<%# Eval("id") %>'
                       data-disposition1='<%# Server.HtmlEncode(Convert.ToString(Eval("Disposition1"))) %>'
                       data-disposition2='<%# Server.HtmlEncode(Convert.ToString(Eval("Disposition2"))) %>'
                       data-disposition3='<%# Server.HtmlEncode(Convert.ToString(Eval("Disposiution3"))) %>'
                       data-comment='<%# Server.HtmlEncode(Convert.ToString(Eval("Comment"))) %>'>
                        <%# Server.HtmlEncode(Convert.ToString(Eval("QuickLinktext"))) %>
                    </a>
                </li>
            </ItemTemplate>
            <FooterTemplate>
                </ul>
            </FooterTemplate>
        </asp:Repeater>
    </div>
</asp:Content>
