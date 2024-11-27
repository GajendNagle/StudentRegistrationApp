using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;    
using System.Configuration;

namespace StudentRegistrationApp
{
    public partial class StudentSummaryReport1 : System.Web.UI.Page
    {
        private string connectionString = ConfigurationManager.ConnectionStrings["Conn"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadReport();
            }
        }
        protected void btnLoadReport_Click(object sender, EventArgs e)
        {
            LoadReport();
        }
        private void LoadReport()
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();

                // Create the command to call the stored procedure
                SqlCommand cmd = new SqlCommand("USP_StudentReportGet", conn);
                cmd.CommandType = CommandType.StoredProcedure;

                // Create a data reader to read the result from the stored procedure
                SqlDataReader reader = cmd.ExecuteReader();

                if (reader.Read())
                {
                    // Retrieve the counts from the result set and bind them to labels
                    lblTotalStudents.Text = reader["TotalStudents"].ToString();
                    lblMaleCount.Text = reader["MaleCount"].ToString();
                    lblFemaleCount.Text = reader["FemaleCount"].ToString();
                    lblOtherCount.Text = reader["OtherCount"].ToString();
                    lblBBACount.Text = reader["BBACount"].ToString();
                    lblBComCount.Text = reader["BComCount"].ToString();
                    lblBScCount.Text = reader["BScCount"].ToString();
                    lblBACount.Text = reader["BACount"].ToString();
                    lblBECount.Text = reader["BECount"].ToString();
                }

                // Close the reader
                reader.Close();
            }
        }
    }
}