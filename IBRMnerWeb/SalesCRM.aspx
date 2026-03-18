<%@ Page Title="Sales CRM" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="SalesCRM.aspx.cs" Inherits="IBRMnerWeb.SalesCRM" %>

<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>

<asp:Content ID="MainContent" ContentPlaceHolderID="MainContent" runat="server">
    <div class="page-header">
        <h1>Sales CRM</h1>
    </div>

    <asp:Panel ID="pnlError" runat="server" Visible="false" CssClass="crm-alert crm-alert-error">
        <asp:Label ID="lblError" runat="server" />
    </asp:Panel>
    <asp:Panel ID="pnlSuccess" runat="server" Visible="false" CssClass="crm-alert crm-alert-success">
        <asp:Label ID="lblSuccess" runat="server" />
    </asp:Panel>

    <%-- Hidden fields persist customer details through postback --%>
    <asp:HiddenField ID="hfCustName"   runat="server" />
    <asp:HiddenField ID="hfCustRMN"    runat="server" />
    <asp:HiddenField ID="hfSolId"      runat="server" />
    <asp:HiddenField ID="hfCustEmail"  runat="server" />
    <asp:HiddenField ID="hfBranchName" runat="server" />

    <div class="crm-wrapper">

        <%-- ── Section 1: Caller Telephony Information ── --%>
        <div class="crm-section">
            <h2 class="crm-section-title">Caller Telephony Information</h2>
            <div class="cti-grid">
                <div class="cti-field">
                    <span class="cti-label">UCID</span>
                    <asp:Label ID="lblUCID" runat="server" CssClass="cti-value" />
                </div>
                <div class="cti-field">
                    <span class="cti-label">Language</span>
                    <asp:Label ID="lblLanguage" runat="server" CssClass="cti-value" />
                </div>
                <div class="cti-field">
                    <span class="cti-label">Account No.</span>
                    <asp:Label ID="lblCTIAccountNo" runat="server" CssClass="cti-value" />
                </div>
                <div class="cti-field">
                    <span class="cti-label">Cust ID</span>
                    <asp:Label ID="lblCustId" runat="server" CssClass="cti-value" />
                </div>
                <div class="cti-field">
                    <span class="cti-label">Caller ANI</span>
                    <asp:Label ID="lblCallerANI" runat="server" CssClass="cti-value" />
                </div>
                <div class="cti-field">
                    <span class="cti-label">RMN Flag</span>
                    <asp:Label ID="lblRMNFlag" runat="server" CssClass="cti-value" />
                </div>
                <div class="cti-field">
                    <span class="cti-label">Skill Set</span>
                    <asp:Label ID="lblSkillSet" runat="server" CssClass="cti-value" />
                </div>
                <div class="cti-field">
                    <span class="cti-label">Existing Customer</span>
                    <asp:Label ID="lblExistingCustomer" runat="server" CssClass="cti-value" />
                </div>
                <div class="cti-field cti-field-wide">
                    <span class="cti-label">IVR Last 2 Nodes</span>
                    <asp:Label ID="lblIVRLastNodes" runat="server" CssClass="cti-value" />
                </div>
            </div>
        </div>

        <%-- ── Section 2: Customer Details + Warm Transfer ── --%>
        <div class="crm-row">
            <div class="crm-section crm-section-grow">
                <h2 class="crm-section-title">Customer Details</h2>
                <div class="form-group">
                    <label>Search by Account No. or RMN</label>
                    <div class="crm-search-row">
                        <asp:TextBox ID="txtSearchTerm" runat="server" CssClass="form-control" MaxLength="50" />
                        <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="btn" OnClick="btnSearch_Click" />
                    </div>
                </div>
                <asp:Panel ID="pnlCustomerInfo" runat="server" Visible="false" CssClass="cust-info-grid">
                    <div class="cti-field">
                        <span class="cti-label">Customer Name</span>
                        <asp:Label ID="lblCustName" runat="server" CssClass="cti-value" />
                    </div>
                    <div class="cti-field">
                        <span class="cti-label">RMN</span>
                        <asp:Label ID="lblCustRMN" runat="server" CssClass="cti-value" />
                    </div>
                    <div class="cti-field">
                        <span class="cti-label">Sol ID</span>
                        <asp:Label ID="lblSolId" runat="server" CssClass="cti-value" />
                    </div>
                    <div class="cti-field">
                        <span class="cti-label">Email ID</span>
                        <asp:Label ID="lblCustEmail" runat="server" CssClass="cti-value" />
                    </div>
                    <div class="cti-field cti-field-wide">
                        <span class="cti-label">Branch Name</span>
                        <asp:Label ID="lblBranchName" runat="server" CssClass="cti-value" />
                    </div>
                </asp:Panel>
            </div>
            <div class="crm-section crm-section-aside">
                <h2 class="crm-section-title">Warm Transfer</h2>
                <asp:Button ID="btnWarmTransfer" runat="server" Text="Warm Transfer" CssClass="btn btn-warning" OnClick="btnWarmTransfer_Click" />
            </div>
        </div>

        <%-- ── Section 3: Data Capture Details ── --%>
        <div class="crm-section">
            <h2 class="crm-section-title">Data Capture Details</h2>
            <div class="crm-form-grid">
                <div class="form-group">
                    <label>Product</label>
                    <asp:DropDownList ID="ddlProduct" runat="server" CssClass="form-control">
                        <asp:ListItem Value="">-- Select Product --</asp:ListItem>
                        <asp:ListItem Value="Home Loan">Home Loan</asp:ListItem>
                        <asp:ListItem Value="Personal Loan">Personal Loan</asp:ListItem>
                        <asp:ListItem Value="Car Loan">Car Loan</asp:ListItem>
                        <asp:ListItem Value="Business Loan">Business Loan</asp:ListItem>
                        <asp:ListItem Value="Credit Card">Credit Card</asp:ListItem>
                        <asp:ListItem Value="Savings Account">Savings Account</asp:ListItem>
                        <asp:ListItem Value="Fixed Deposit">Fixed Deposit</asp:ListItem>
                        <asp:ListItem Value="Insurance">Insurance</asp:ListItem>
                        <asp:ListItem Value="Mutual Fund">Mutual Fund</asp:ListItem>
                    </asp:DropDownList>
                </div>
                <div class="form-group">
                    <label>Sub Product</label>
                    <asp:DropDownList ID="ddlSubProduct" runat="server" CssClass="form-control">
                        <asp:ListItem Value="">-- Select Sub Product --</asp:ListItem>
                        <asp:ListItem Value="New Application">New Application</asp:ListItem>
                        <asp:ListItem Value="Top Up">Top Up</asp:ListItem>
                        <asp:ListItem Value="Balance Transfer">Balance Transfer</asp:ListItem>
                        <asp:ListItem Value="Enhancement">Enhancement</asp:ListItem>
                        <asp:ListItem Value="Renewal">Renewal</asp:ListItem>
                        <asp:ListItem Value="Closure">Closure</asp:ListItem>
                    </asp:DropDownList>
                </div>
                <div class="form-group">
                    <label>Customer Name</label>
                    <asp:TextBox ID="txtDataCustName" runat="server" CssClass="form-control" MaxLength="200" />
                </div>
                <div class="form-group">
                    <label>Email ID</label>
                    <asp:TextBox ID="txtDataEmail" runat="server" CssClass="form-control" TextMode="Email" MaxLength="200" />
                </div>
                <div class="form-group">
                    <label>Alternate Contact No.</label>
                    <asp:TextBox ID="txtAltContact" runat="server" CssClass="form-control" MaxLength="20" />
                </div>
                <div class="form-group">
                    <label>Disposition</label>
                    <asp:DropDownList ID="ddlDisposition" runat="server" CssClass="form-control">
                        <asp:ListItem Value="">-- Select Disposition --</asp:ListItem>
                        <asp:ListItem Value="Interested">Interested</asp:ListItem>
                        <asp:ListItem Value="Not Interested">Not Interested</asp:ListItem>
                        <asp:ListItem Value="Call Back">Call Back</asp:ListItem>
                        <asp:ListItem Value="Already Applied">Already Applied</asp:ListItem>
                        <asp:ListItem Value="Do Not Entertain">Do Not Entertain</asp:ListItem>
                        <asp:ListItem Value="Language Barrier">Language Barrier</asp:ListItem>
                        <asp:ListItem Value="Wrong Number">Wrong Number</asp:ListItem>
                    </asp:DropDownList>
                </div>
                <div class="form-group">
                    <label>Sub Disposition</label>
                    <asp:DropDownList ID="ddlSubDisposition" runat="server" CssClass="form-control">
                        <asp:ListItem Value="">-- Select Sub Disposition --</asp:ListItem>
                        <asp:ListItem Value="Appointment Fixed">Appointment Fixed</asp:ListItem>
                        <asp:ListItem Value="Docs Pending">Docs Pending</asp:ListItem>
                        <asp:ListItem Value="Under Process">Under Process</asp:ListItem>
                        <asp:ListItem Value="Disbursed">Disbursed</asp:ListItem>
                        <asp:ListItem Value="Rejected">Rejected</asp:ListItem>
                        <asp:ListItem Value="Future Prospect">Future Prospect</asp:ListItem>
                    </asp:DropDownList>
                </div>
                <div class="form-group">
                    <label>Demanded Amount (&#8377;)</label>
                    <asp:TextBox ID="txtDemandedAmount" runat="server" CssClass="form-control" MaxLength="20" />
                </div>
                <div class="form-group">
                    <label>Appointment Date</label>
                    <asp:TextBox ID="txtAppointmentDate" runat="server" CssClass="form-control" TextMode="Date" />
                </div>
                <div class="form-group">
                    <label>Time</label>
                    <asp:TextBox ID="txtAppointmentTime" runat="server" CssClass="form-control" TextMode="Time" />
                </div>
                <div class="form-group">
                    <label>Select Branch / SMS / Dept</label>
                    <asp:DropDownList ID="ddlBranchSMSDept" runat="server" CssClass="form-control">
                        <asp:ListItem Value="">-- Select --</asp:ListItem>
                        <asp:ListItem Value="Branch">Branch</asp:ListItem>
                        <asp:ListItem Value="SMS">SMS</asp:ListItem>
                        <asp:ListItem Value="Department">Department</asp:ListItem>
                        <asp:ListItem Value="Email">Email</asp:ListItem>
                        <asp:ListItem Value="Online">Online</asp:ListItem>
                    </asp:DropDownList>
                </div>
                <div class="form-group">
                    <label>Select</label>
                    <asp:DropDownList ID="ddlSelect" runat="server" CssClass="form-control">
                        <asp:ListItem Value="">-- Select --</asp:ListItem>
                        <asp:ListItem Value="Self">Self</asp:ListItem>
                        <asp:ListItem Value="Spouse">Spouse</asp:ListItem>
                        <asp:ListItem Value="Parent">Parent</asp:ListItem>
                        <asp:ListItem Value="Other">Other</asp:ListItem>
                    </asp:DropDownList>
                </div>
            </div>
            <div class="form-group">
                <label>Address</label>
                <asp:TextBox ID="txtAddress" runat="server" CssClass="form-control crm-textarea" TextMode="MultiLine" Rows="3" MaxLength="500" />
            </div>
            <div class="form-group">
                <label>Remarks</label>
                <asp:TextBox ID="txtRemarks" runat="server" CssClass="form-control crm-textarea" TextMode="MultiLine" Rows="4" MaxLength="1000" />
            </div>
            <asp:Button ID="btnSubmit" runat="server" Text="Save Interaction" CssClass="btn" OnClick="btnSubmit_Click" />
        </div>

        <%-- ── Section 4: History + Additional Links ── --%>
        <div class="crm-row">
            <div class="crm-section crm-section-grow">
                <h2 class="crm-section-title">History</h2>
                <ul class="crm-link-list">
                    <li>
                        <asp:LinkButton ID="lnkSalesHistory" runat="server" CssClass="crm-link" OnClick="lnkSalesHistory_Click">Sales Call History</asp:LinkButton>
                    </li>
                    <li>
                        <asp:LinkButton ID="lnkInboundHistory" runat="server" CssClass="crm-link" OnClick="lnkInboundHistory_Click">Inbound Call History</asp:LinkButton>
                    </li>
                    <li>
                        <asp:LinkButton ID="lnkCustHistory" runat="server" CssClass="crm-link" OnClick="lnkCustHistory_Click">Customer History</asp:LinkButton>
                    </li>
                </ul>
            </div>
            <div class="crm-section crm-section-grow">
                <h2 class="crm-section-title">Additional Links</h2>
                <ul class="crm-link-list">
                    <li><a href="#" class="crm-link">EMI Calculator</a></li>
                    <li><a href="#" class="crm-link">Eligibility Calculator</a></li>
                    <li><a href="#" class="crm-link">System Calculator</a></li>
                    <li><a href="#" class="crm-link">GBM Product</a></li>
                    <li><a href="#" class="crm-link">Check Dispatch Status</a></li>
                    <li><a href="#" class="crm-link">FRMS Details</a></li>
                    <li><a href="#" class="crm-link">Email Update</a></li>
                    <li><a href="#" class="crm-link">Raise Customer Complaint</a></li>
                    <li><a href="#" class="crm-link">Outbound Logs</a></li>
                </ul>
            </div>
        </div>

        <%-- ── Section 5: Offers + Internal Transfer ── --%>
        <div class="crm-section crm-actions-bar">
            <asp:Button ID="btnClickForOffers"   runat="server" Text="Click for Offers"   CssClass="btn btn-offers"   OnClick="btnClickForOffers_Click" />
            <asp:Button ID="btnInternalTransfer" runat="server" Text="Internal Transfer"  CssClass="btn btn-transfer" OnClick="btnInternalTransfer_Click" />
        </div>

    </div>
</asp:Content>
