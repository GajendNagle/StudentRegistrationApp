using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml.Linq;

namespace StudentRegistrationApp
{
    public partial class StudentRegistrationNew : System.Web.UI.Page
    {
        private string connectionString = ConfigurationManager.ConnectionStrings["Conn"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                FillGrid();
            }
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            // Server-side validation
            if (Page.IsValid)  // This checks if all validators have passed
            {

                try
                {
                    string strName = txtName.Text.Trim();
                    string strParentName = txtParentName.Text.Trim();
                    string strGender = rblGender.SelectedItem.Text;
                    string strCourse = ddlCourse.SelectedItem.Text;
                    string strSelectedSubjects = string.Join(", ", cblSubject.Items.Cast<ListItem>()
                                                    .Where(li => li.Selected)
                                                    .Select(li => li.Text));

                    using (SqlConnection conn = new SqlConnection(connectionString))
                    {
                        if (btnSubmit.Text == "Save")
                        {
                            SqlCommand cmd = new SqlCommand("USP_InsertStudent", conn);
                            cmd.CommandType = CommandType.StoredProcedure;
                            cmd.Parameters.AddWithValue("@Name", strName);
                            cmd.Parameters.AddWithValue("@ParentsName", strParentName);
                            cmd.Parameters.AddWithValue("@Gender", strGender);
                            cmd.Parameters.AddWithValue("@Course", strCourse);
                            cmd.Parameters.AddWithValue("@Subjects", strSelectedSubjects);
                            conn.Open();
                            SqlDataAdapter sda = new SqlDataAdapter(cmd);
                            DataSet ds = new DataSet();
                            sda.Fill(ds);
                            if (ds.Tables.Count > 0)
                            {
                                if (Convert.ToBoolean(ds.Tables[0].Rows[0]["status"]))
                                {
                                    string msg = Convert.ToString(ds.Tables[0].Rows[0]["msg"]);
                                    string encodedMsg = HttpUtility.JavaScriptStringEncode(msg);
                                    ClientScript.RegisterStartupScript(GetType(), "alert", "alert('" + encodedMsg + "');", true);

                                }
                            }
                        }
                        else if (btnSubmit.Text == "Update")
                        {
                            SqlCommand cmd = new SqlCommand("[USP_StudentsUpdate]", conn);
                            cmd.CommandType = CommandType.StoredProcedure;
                            cmd.Parameters.AddWithValue("@StudentID", ViewState["StudentID"].ToString());
                            cmd.Parameters.AddWithValue("@Name", strName);
                            cmd.Parameters.AddWithValue("@ParentName", strParentName);
                            cmd.Parameters.AddWithValue("@Gender", strGender);
                            cmd.Parameters.AddWithValue("@Course", strCourse);
                            cmd.Parameters.AddWithValue("@Subjects", strSelectedSubjects);
                            DataSet ds = new DataSet();
                            SqlDataAdapter sda = new SqlDataAdapter(cmd);
                            sda.Fill(ds);

                            if (ds.Tables.Count > 0)
                            {
                                if (Convert.ToBoolean(ds.Tables[0].Rows[0]["status"]))
                                {
                                    string msg = Convert.ToString(ds.Tables[0].Rows[0]["msg"]);
                                    string encodedMsg = HttpUtility.JavaScriptStringEncode(msg);
                                    ClientScript.RegisterStartupScript(GetType(), "alert", "alert('" + encodedMsg + "');", true);

                                }
                            }

                        }

                    }
                    FillGrid();
                    ClearFields();

                }
                catch (Exception ex)
                {


                }



            }
        }

        protected void cvSubject_ServerValidate(object source, ServerValidateEventArgs args)
        {
            // Check if at least one checkbox is selected
            args.IsValid = cblSubject.SelectedIndex != -1;
        }

        // Bind Grid View
        public void FillGrid()
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();
                SqlCommand cmd = new SqlCommand("SELECT StudentID,Name,ISNULL(ParentsName, 'No Parent') AS ParentsName,Gender,Course,Subjects,RegistrationDate FROM Students", conn);
                cmd.CommandType = CommandType.Text;
                DataSet ds = new DataSet();
                SqlDataAdapter sda = new SqlDataAdapter(cmd);
                sda.Fill(ds);
                grdStudentData.DataSource = ds;
                grdStudentData.DataBind();
            }
        }

        // Clear All Fields
        protected void ClearFields()
        {
            txtName.Text = string.Empty;
            txtParentName.Text = string.Empty;
            ddlCourse.ClearSelection();
            rblGender.ClearSelection();
            cblSubject.ClearSelection();
        }
        protected void grdStudentData_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            try
            {
                GridViewRow row = (GridViewRow)((LinkButton)e.CommandSource).NamingContainer;
                Label lblName = (Label)row.FindControl("lblname");
                Label lblParentsName = row.FindControl("lblParentsName") as Label;
                Label lblGender = row.FindControl("lblGender") as Label;
                Label lblSubjects = row.FindControl("lblSubjects") as Label;
                Label lblCourse = row.FindControl("lblCourse") as Label;
                ViewState["StudentID"] = e.CommandArgument.ToString();
                if (e.CommandName == "EditRecord")
                {
                    txtName.Text = lblName.Text;
                    txtParentName.Text = lblParentsName.Text;
                    rblGender.ClearSelection();
                    rblGender.Items.FindByText(lblGender.Text).Selected = true;
                    string[] cblvalue = lblSubjects.Text.Split(',');
                    cblSubject.ClearSelection();
                    foreach (var item in cblvalue)
                    {
                        ListItem listItem = cblSubject.Items.FindByText(item.Trim());
                        if (listItem != null)
                        {
                            listItem.Selected = true;
                        }
                    }
                    ddlCourse.ClearSelection();
                    ddlCourse.Items.FindByText(lblCourse.Text).Selected = true;
                    rblGender.ClearSelection();
                    rblGender.Items.FindByText(lblGender.Text).Selected = true;
                    btnSubmit.Text = "Update";
                }
                else if (e.CommandName == "DeleteRecord")
                {
                    using (SqlConnection conn = new SqlConnection(connectionString))
                    {
                        conn.Open();
                        SqlCommand cmd = new SqlCommand("[USP_StudentDelete]", conn);
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("@StudentID", Convert.ToString(ViewState["StudentID"]));
                        DataSet ds = new DataSet();
                        SqlDataAdapter sda = new SqlDataAdapter(cmd);
                        sda.Fill(ds);
                        if (ds.Tables.Count > 0)
                        {
                            if (Convert.ToBoolean(ds.Tables[0].Rows[0]["status"]))
                            {
                                string msg = Convert.ToString(ds.Tables[0].Rows[0]["msg"]);
                                string encodedMsg = HttpUtility.JavaScriptStringEncode(msg);
                                ClientScript.RegisterStartupScript(GetType(), "alert", "alert('" + encodedMsg + "');", true);
                            }
                        }
                        FillGrid();
                    }
                }
            }
            catch (Exception)
            {
                throw;
            }
        }
    }
}