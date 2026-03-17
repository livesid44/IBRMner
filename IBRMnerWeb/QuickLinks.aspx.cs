using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace IBRMnerWeb
{
    public partial class QuickLinks : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadQuickLinks();
            }
        }

        private void LoadQuickLinks()
        {
            pnlError.Visible   = false;
            pnlNoData.Visible  = false;
            lblSuccess.Visible = false;

            string connectionString = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;

            DataTable dt = new DataTable();

            using (SqlConnection conn = new SqlConnection(connectionString))
            using (SqlCommand cmd = new SqlCommand("USp_gettaggingmaster", conn))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                try
                {
                    conn.Open();
                    using (SqlDataAdapter adapter = new SqlDataAdapter(cmd))
                    {
                        adapter.Fill(dt);
                    }
                }
                catch (SqlException ex)
                {
                    pnlError.Visible = true;
                    lblError.Text = "Unable to load quick links. Please try again later.";
                    System.Diagnostics.Trace.TraceError("QuickLinks LoadQuickLinks error: {0}", ex.Message);
                    return;
                }
            }

            if (dt.Rows.Count == 0)
            {
                pnlNoData.Visible = true;
                return;
            }

            rptQuickLinks.DataSource = dt;
            rptQuickLinks.DataBind();
        }

        /// <summary>
        /// Encodes the per-row values into the CommandArgument for a quick link button.
        /// Each value is URL-encoded so that any delimiter character in the data is safe.
        /// </summary>
        protected string BuildCommandArg(object id, object disp1, object disp2, object disp3, object comment)
        {
            return string.Join("|", new[]
            {
                Uri.EscapeDataString(Convert.ToString(id)),
                Uri.EscapeDataString(Convert.ToString(disp1)),
                Uri.EscapeDataString(Convert.ToString(disp2)),
                Uri.EscapeDataString(Convert.ToString(disp3)),
                Uri.EscapeDataString(Convert.ToString(comment))
            });
        }

        protected void rptQuickLinks_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName != "tag")
                return;

            string[] parts = e.CommandArgument.ToString().Split('|');
            if (parts.Length < 5)
                return;

            string disposition1 = Uri.UnescapeDataString(parts[1]);
            string disposition2 = Uri.UnescapeDataString(parts[2]);
            string disposition3 = Uri.UnescapeDataString(parts[3]);
            string comment      = Uri.UnescapeDataString(parts[4]);

            string accountNo = Request.QueryString["AccountNo"] ?? string.Empty;
            string mobileNo  = Request.QueryString["Mobileno"]  ?? string.Empty;
            string roleName  = Convert.ToString(Session["RoleName"]);
            string teamId    = Convert.ToString(Session["TeamID"]);
            string createdBy = Convert.ToString(Session["CreatedBy"]);

            if (string.IsNullOrEmpty(roleName) || string.IsNullOrEmpty(teamId) || string.IsNullOrEmpty(createdBy))
            {
                pnlError.Visible = true;
                lblError.Text    = "Session has expired. Please log in again.";
                return;
            }

            string connectionString = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connectionString))
            using (SqlCommand cmd = new SqlCommand("usp_InsertTaggingComment", conn))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@Category",       disposition1);
                cmd.Parameters.AddWithValue("@SubCategory",    disposition2);
                cmd.Parameters.AddWithValue("@SubsubCategory", disposition3);
                cmd.Parameters.AddWithValue("@Natureofquery",  string.Empty);
                cmd.Parameters.AddWithValue("@AccountNo",      accountNo);
                cmd.Parameters.AddWithValue("@Mobileno",       mobileNo);
                cmd.Parameters.AddWithValue("@RoleName",       roleName);
                cmd.Parameters.AddWithValue("@TeamID",         teamId);
                cmd.Parameters.AddWithValue("@Comment",        comment);
                cmd.Parameters.AddWithValue("@CreatedBy",      createdBy);

                try
                {
                    conn.Open();
                    cmd.ExecuteNonQuery();
                    lblSuccess.Visible = true;
                    lblSuccess.Text    = "Tagging saved successfully.";
                }
                catch (SqlException ex)
                {
                    pnlError.Visible = true;
                    lblError.Text    = "Unable to save tagging. Please try again later.";
                    System.Diagnostics.Trace.TraceError("QuickLinks InsertTaggingComment error: {0}", ex.Message);
                    return;
                }
            }

            LoadQuickLinks();
        }
    }
}
