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

        <asp:Label ID="lblSuccess" runat="server" CssClass="quicklinks-success" Visible="false" />

        <asp:Panel ID="pnlNoData" runat="server" Visible="false">
            <p>No quick links are currently available.</p>
        </asp:Panel>

        <asp:Repeater ID="rptQuickLinks" runat="server" OnItemCommand="rptQuickLinks_ItemCommand">
            <HeaderTemplate>
                <ul class="quicklinks-list">
            </HeaderTemplate>
            <ItemTemplate>
                <li class="quicklinks-item">
                    <asp:LinkButton ID="lnkQuickLink" runat="server"
                        CssClass="quicklink"
                        CommandName="tag"
                        CommandArgument='<%# BuildCommandArg(Eval("id"), Eval("Disposition1"), Eval("Disposition2"), Eval("Disposiution3"), Eval("Comment")) %>'
                        Text='<%# Server.HtmlEncode(Convert.ToString(Eval("QuickLinktext"))) %>' />
                </li>
            </ItemTemplate>
            <FooterTemplate>
                </ul>
            </FooterTemplate>
        </asp:Repeater>
    </div>
</asp:Content>
