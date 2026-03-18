using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace IBRMnerWeb
{
    public partial class SalesCRM : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                PopulateCTI();
            }

            // Restore customer panel from hidden fields on every load
            // (needed because pnlCustomerInfo is invisible by default and
            // controls inside a hidden panel do not persist via ViewState).
            RestoreCustomerInfo();
        }

        // ── CTI ────────────────────────────────────────────────────────────

        private void PopulateCTI()
        {
            lblUCID.Text             = Server.HtmlEncode(Request.QueryString["UCID"]             ?? string.Empty);
            lblLanguage.Text         = Server.HtmlEncode(Request.QueryString["Language"]         ?? string.Empty);
            lblCTIAccountNo.Text     = Server.HtmlEncode(Request.QueryString["AccountNo"]        ?? string.Empty);
            lblCustId.Text           = Server.HtmlEncode(Request.QueryString["CustId"]           ?? string.Empty);
            lblCallerANI.Text        = Server.HtmlEncode(Request.QueryString["CallerANI"]        ?? string.Empty);
            lblRMNFlag.Text          = Server.HtmlEncode(Request.QueryString["RMNFlag"]          ?? string.Empty);
            lblSkillSet.Text         = Server.HtmlEncode(Request.QueryString["SkillSet"]         ?? string.Empty);
            lblExistingCustomer.Text = Server.HtmlEncode(Request.QueryString["ExistingCustomer"] ?? string.Empty);
            lblIVRLastNodes.Text     = Server.HtmlEncode(Request.QueryString["IVRLastNodes"]     ?? string.Empty);
        }

        // ── Customer Info restore ──────────────────────────────────────────

        private void RestoreCustomerInfo()
        {
            if (string.IsNullOrEmpty(hfCustName.Value))
                return;

            lblCustName.Text   = Server.HtmlEncode(hfCustName.Value);
            lblCustRMN.Text    = Server.HtmlEncode(hfCustRMN.Value);
            lblSolId.Text      = Server.HtmlEncode(hfSolId.Value);
            lblCustEmail.Text  = Server.HtmlEncode(hfCustEmail.Value);
            lblBranchName.Text = Server.HtmlEncode(hfBranchName.Value);
            pnlCustomerInfo.Visible = true;
        }

        // ── Customer Search ────────────────────────────────────────────────

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            pnlError.Visible   = false;
            pnlSuccess.Visible = false;

            string searchTerm = txtSearchTerm.Text.Trim();
            if (string.IsNullOrEmpty(searchTerm))
            {
                ShowError("Please enter an Account No. or RMN to search.");
                return;
            }

            string connectionString = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connectionString))
            using (SqlCommand cmd = new SqlCommand("usp_GetCustomerDetails", conn))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@SearchTerm", searchTerm);

                try
                {
                    conn.Open();
                    using (SqlDataReader rdr = cmd.ExecuteReader())
                    {
                        if (rdr.Read())
                        {
                            string name   = Convert.ToString(rdr["CustomerName"]);
                            string rmn    = Convert.ToString(rdr["CustomerRMN"]);
                            string solId  = Convert.ToString(rdr["SolId"]);
                            string email  = Convert.ToString(rdr["CustomerEmail"]);
                            string branch = Convert.ToString(rdr["BranchName"]);

                            hfCustName.Value   = name;
                            hfCustRMN.Value    = rmn;
                            hfSolId.Value      = solId;
                            hfCustEmail.Value  = email;
                            hfBranchName.Value = branch;

                            lblCustName.Text   = Server.HtmlEncode(name);
                            lblCustRMN.Text    = Server.HtmlEncode(rmn);
                            lblSolId.Text      = Server.HtmlEncode(solId);
                            lblCustEmail.Text  = Server.HtmlEncode(email);
                            lblBranchName.Text = Server.HtmlEncode(branch);
                            pnlCustomerInfo.Visible = true;
                        }
                        else
                        {
                            pnlCustomerInfo.Visible = false;
                            hfCustName.Value = string.Empty;
                            ShowError("No customer found for the given Account No. or RMN.");
                        }
                    }
                }
                catch (SqlException ex)
                {
                    ShowError("Unable to search customer. Please try again later.");
                    System.Diagnostics.Trace.TraceError("SalesCRM btnSearch_Click error: {0}", ex.Message);
                }
            }
        }

        // ── Save Interaction ───────────────────────────────────────────────

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            pnlError.Visible   = false;
            pnlSuccess.Visible = false;

            // Agent identity: prefer session, fall back to query string
            string roleName  = Convert.ToString(Session["RoleName"]);
            if (string.IsNullOrEmpty(roleName))
                roleName = Request.QueryString["RoleName"] ?? string.Empty;

            string teamId    = Convert.ToString(Session["TeamID"]);
            if (string.IsNullOrEmpty(teamId))
                teamId = Request.QueryString["TeamID"] ?? string.Empty;

            string createdBy = Convert.ToString(Session["CreatedBy"]);
            if (string.IsNullOrEmpty(createdBy))
                createdBy = Request.QueryString["CreatedBy"] ?? string.Empty;

            // Parse optional appointment date
            DateTime? apptDate = null;
            if (!string.IsNullOrEmpty(txtAppointmentDate.Text) &&
                DateTime.TryParse(txtAppointmentDate.Text, out DateTime parsed))
            {
                apptDate = parsed;
            }

            string connectionString = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connectionString))
            using (SqlCommand cmd = new SqlCommand("usp_InsertSalesCRMInteraction", conn))
            {
                cmd.CommandType = CommandType.StoredProcedure;

                // CTI fields (from query string)
                cmd.Parameters.AddWithValue("@UCID",             Request.QueryString["UCID"]             ?? string.Empty);
                cmd.Parameters.AddWithValue("@Language",          Request.QueryString["Language"]         ?? string.Empty);
                cmd.Parameters.AddWithValue("@CallerAccountNo",   Request.QueryString["AccountNo"]        ?? string.Empty);
                cmd.Parameters.AddWithValue("@CustId",            Request.QueryString["CustId"]           ?? string.Empty);
                cmd.Parameters.AddWithValue("@CallerANI",         Request.QueryString["CallerANI"]        ?? string.Empty);
                cmd.Parameters.AddWithValue("@RMNFlag",           Request.QueryString["RMNFlag"]          ?? string.Empty);
                cmd.Parameters.AddWithValue("@SkillSet",          Request.QueryString["SkillSet"]         ?? string.Empty);
                cmd.Parameters.AddWithValue("@ExistingCustomer",  Request.QueryString["ExistingCustomer"] ?? string.Empty);
                cmd.Parameters.AddWithValue("@IVRLastNodes",      Request.QueryString["IVRLastNodes"]     ?? string.Empty);

                // Customer details (from hidden fields, populated by search)
                cmd.Parameters.AddWithValue("@CustomerName",  hfCustName.Value);
                cmd.Parameters.AddWithValue("@CustomerRMN",   hfCustRMN.Value);
                cmd.Parameters.AddWithValue("@SolId",         hfSolId.Value);
                cmd.Parameters.AddWithValue("@CustomerEmail", hfCustEmail.Value);
                cmd.Parameters.AddWithValue("@BranchName",    hfBranchName.Value);

                // Data Capture form fields
                cmd.Parameters.AddWithValue("@Product",            ddlProduct.SelectedValue);
                cmd.Parameters.AddWithValue("@SubProduct",         ddlSubProduct.SelectedValue);
                cmd.Parameters.AddWithValue("@DataCustName",       txtDataCustName.Text.Trim());
                cmd.Parameters.AddWithValue("@DataEmail",          txtDataEmail.Text.Trim());
                cmd.Parameters.AddWithValue("@AlternateContactNo", txtAltContact.Text.Trim());
                cmd.Parameters.AddWithValue("@Disposition",        ddlDisposition.SelectedValue);
                cmd.Parameters.AddWithValue("@SubDisposition",     ddlSubDisposition.SelectedValue);
                cmd.Parameters.AddWithValue("@DemandedAmount",     txtDemandedAmount.Text.Trim());
                cmd.Parameters.AddWithValue("@AppointmentDate",    (object)apptDate ?? DBNull.Value);
                cmd.Parameters.AddWithValue("@AppointmentTime",    txtAppointmentTime.Text.Trim());
                cmd.Parameters.AddWithValue("@BranchSMSDept",      ddlBranchSMSDept.SelectedValue);
                cmd.Parameters.AddWithValue("@SelectField",        ddlSelect.SelectedValue);
                cmd.Parameters.AddWithValue("@Address",            txtAddress.Text.Trim());
                cmd.Parameters.AddWithValue("@Remarks",            txtRemarks.Text.Trim());

                // Agent identity
                cmd.Parameters.AddWithValue("@AgentRoleName",  roleName);
                cmd.Parameters.AddWithValue("@AgentTeamID",    teamId);
                cmd.Parameters.AddWithValue("@AgentCreatedBy", createdBy);

                try
                {
                    conn.Open();
                    cmd.ExecuteNonQuery();
                    pnlSuccess.Visible = true;
                    lblSuccess.Text    = "Interaction saved successfully.";
                }
                catch (SqlException ex)
                {
                    ShowError("Unable to save interaction. Please try again later.");
                    System.Diagnostics.Trace.TraceError("SalesCRM btnSubmit_Click error: {0}", ex.Message);
                }
            }
        }

        // ── Action Buttons ─────────────────────────────────────────────────

        protected void btnWarmTransfer_Click(object sender, EventArgs e)
        {
            pnlError.Visible   = false;
            pnlSuccess.Visible = true;
            lblSuccess.Text    = "Warm transfer initiated.";
        }

        protected void lnkSalesHistory_Click(object sender, EventArgs e)
        {
            pnlError.Visible   = false;
            pnlSuccess.Visible = true;
            lblSuccess.Text    = "Sales Call History feature coming soon.";
        }

        protected void lnkInboundHistory_Click(object sender, EventArgs e)
        {
            pnlError.Visible   = false;
            pnlSuccess.Visible = true;
            lblSuccess.Text    = "Inbound Call History feature coming soon.";
        }

        protected void lnkCustHistory_Click(object sender, EventArgs e)
        {
            pnlError.Visible   = false;
            pnlSuccess.Visible = true;
            lblSuccess.Text    = "Customer History feature coming soon.";
        }

        protected void btnClickForOffers_Click(object sender, EventArgs e)
        {
            pnlError.Visible   = false;
            pnlSuccess.Visible = true;
            lblSuccess.Text    = "Offers feature coming soon.";
        }

        protected void btnInternalTransfer_Click(object sender, EventArgs e)
        {
            pnlError.Visible   = false;
            pnlSuccess.Visible = true;
            lblSuccess.Text    = "Internal Transfer initiated.";
        }

        // ── Helpers ────────────────────────────────────────────────────────

        private void ShowError(string message)
        {
            pnlError.Visible = true;
            lblError.Text    = message;
        }
    }
}
