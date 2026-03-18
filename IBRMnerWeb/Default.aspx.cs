using System;

namespace IBRMnerWeb
{
    public partial class Default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                lblMessage.Text = string.Empty;
            }
        }

        protected void btnGreet_Click(object sender, EventArgs e)
        {
            lblMessage.Text = "Hello from IBRMner! The current time is: " + DateTime.Now.ToString("F");
        }
    }
}
