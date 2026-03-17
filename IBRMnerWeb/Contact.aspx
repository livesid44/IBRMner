<%@ Page Title="Contact" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Contact.aspx.cs" Inherits="IBRMnerWeb.Contact" %>

<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>

<asp:Content ID="MainContent" ContentPlaceHolderID="MainContent" runat="server">
    <div class="page-header">
        <h1>Contact Us</h1>
    </div>
    <div class="page-content">
        <asp:Panel ID="pnlForm" runat="server">
            <div class="form-group">
                <asp:Label ID="lblName" runat="server" Text="Name:" AssociatedControlID="txtName" />
                <asp:TextBox ID="txtName" runat="server" CssClass="form-control" placeholder="Your name" />
                <asp:RequiredFieldValidator ID="rfvName" runat="server" ControlToValidate="txtName"
                    ErrorMessage="Name is required." CssClass="error" Display="Dynamic" />
            </div>
            <div class="form-group">
                <asp:Label ID="lblEmail" runat="server" Text="Email:" AssociatedControlID="txtEmail" />
                <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" TextMode="Email" placeholder="your@email.com" />
                <asp:RequiredFieldValidator ID="rfvEmail" runat="server" ControlToValidate="txtEmail"
                    ErrorMessage="Email is required." CssClass="error" Display="Dynamic" />
                <asp:RegularExpressionValidator ID="revEmail" runat="server" ControlToValidate="txtEmail"
                    ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"
                    ErrorMessage="Please enter a valid email address." CssClass="error" Display="Dynamic" />
            </div>
            <div class="form-group">
                <asp:Label ID="lblMessage" runat="server" Text="Message:" AssociatedControlID="txtMessage" />
                <asp:TextBox ID="txtMessage" runat="server" CssClass="form-control" TextMode="MultiLine"
                    Rows="5" placeholder="Your message..." />
                <asp:RequiredFieldValidator ID="rfvMessage" runat="server" ControlToValidate="txtMessage"
                    ErrorMessage="Message is required." CssClass="error" Display="Dynamic" />
            </div>
            <asp:Button ID="btnSubmit" runat="server" Text="Send Message" OnClick="btnSubmit_Click" CssClass="btn" />
        </asp:Panel>
        <asp:Panel ID="pnlSuccess" runat="server" Visible="false" CssClass="success-panel">
            <p>Thank you for your message! We will get back to you shortly.</p>
            <asp:Button ID="btnReset" runat="server" Text="Send Another Message" OnClick="btnReset_Click" CssClass="btn" />
        </asp:Panel>
    </div>
</asp:Content>
