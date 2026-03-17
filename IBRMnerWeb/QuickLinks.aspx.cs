using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

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
    }
}
