using System;

namespace IBRMnerWeb
{
    public partial class Contact : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                // In a real application, send the email or save to database here.
                pnlForm.Visible = false;
                pnlSuccess.Visible = true;
            }
        }

        protected void btnReset_Click(object sender, EventArgs e)
        {
            txtName.Text = string.Empty;
            txtEmail.Text = string.Empty;
            txtMessage.Text = string.Empty;
            pnlForm.Visible = true;
            pnlSuccess.Visible = false;
        }
    }
}
