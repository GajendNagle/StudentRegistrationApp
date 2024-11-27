<%@ Page Title="" Language="C#" MasterPageFile="~/MainMaster.Master" AutoEventWireup="true" CodeBehind="StudentRegistration.aspx.cs" Inherits="StudentRegistrationApp.StudentRegistrationNew" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentHead" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentBody" runat="server">
    <asp:ValidationSummary runat="server" Enabled="true" ShowMessageBox ="true" DisplayMode="BulletList" ShowSummary="false" ValidationGroup="StudentReg" ></asp:ValidationSummary>
    <!-- Content Header (Page header) -->
    <section class="content-header">
        <div class="container-fluid">
            <div class="row mb-2">
                <div class="col-sm-6">
                    <h1>Student Registration</h1>
                </div>
                <div class="col-sm-6">
                    <ol class="breadcrumb float-sm-right">
                        <li class="breadcrumb-item"><a href="#">Home</a></li>
                        <li class="breadcrumb-item active">Student Registration</li>
                    </ol>
                </div>
            </div>
        </div>
        <!-- /.container-fluid -->
    </section>

    <!-- Main content -->
    <div class="container-fluid">
        <div class="row">
            <!-- left column -->
            <div class="col-md-12">
                <div class="card card-primary">
                    <div class="card-header">
                        <h3 class="card-title">Student Basic Information</h3>
                    </div>
                    <!-- /.card-header -->
                    <!-- form start -->
                    <div class="card-body">
                        <div class="row">
                            <div class="col-lg-4 col-md-6 col-sm-12">
                                <div class="form-group">
                                    <label>Name <span class="text-danger"><strong>*</strong></span></label>
                                    <asp:TextBox runat="server" CssClass="form-control" ID="txtName" AutoComplete="off" placeholder="Enter Name"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="rfvName" runat="server" ControlToValidate="txtName"
                                        ErrorMessage="Name is required." CssClass="text-danger" ValidationGroup="StudentReg" Display="Dynamic">
                                    </asp:RequiredFieldValidator>
                                </div>
                            </div>

                            <div class="col-lg-4 col-md-6 col-sm-12">
                                <div class="form-group">
                                    <label>Parent Name</label>
                                    <asp:TextBox runat="server" CssClass="form-control" ID="txtParentName" AutoComplete="off" placeholder="Enter Parent Name"></asp:TextBox>
                                </div>
                            </div>

                            <div class="col-lg-4 col-md-6 col-sm-12">
                                <div class="form-group">
                                    <label>Gender <span class="text-danger"><strong>*</strong></span></label>
                                    <asp:RadioButtonList RepeatDirection="Horizontal" runat="server" ID="rblGender">
                                        <asp:ListItem Text="Male" Value="Male"></asp:ListItem>
                                        <asp:ListItem Text="Female" Value="Female"></asp:ListItem>
                                        <asp:ListItem Text="Other" Value="Other"></asp:ListItem>
                                    </asp:RadioButtonList>
                                    <asp:RequiredFieldValidator ID="rfvGender" runat="server" ControlToValidate="rblGender"
                                        ErrorMessage="Gender is required." CssClass="text-danger" ValidationGroup="StudentReg" Display="Dynamic"></asp:RequiredFieldValidator>
                                </div>
                            </div>

                            <div class="col-lg-4 col-md-6 col-sm-12">
                                <div class="form-group">
                                    <label>Course <span class="text-danger"><strong>*</strong></span></label>
                                    <asp:DropDownList CssClass="form-control" runat="server" ID="ddlCourse">
                                        <asp:ListItem Text="Select" Value="0"></asp:ListItem>
                                        <asp:ListItem Text="BBA" Value="BBA"></asp:ListItem>
                                        <asp:ListItem Text="BCom" Value="BCom"></asp:ListItem>
                                        <asp:ListItem Text="Bsc" Value="Bsc"></asp:ListItem>
                                        <asp:ListItem Text="BA" Value="BA"></asp:ListItem>
                                        <asp:ListItem Text="BE" Value="BE"></asp:ListItem>
                                    </asp:DropDownList>
                                    <asp:RequiredFieldValidator ID="rfvCourse" runat="server" ControlToValidate="ddlCourse" InitialValue="0"
                                        ErrorMessage="Course is required." CssClass="text-danger" ValidationGroup="StudentReg" Display="Dynamic"></asp:RequiredFieldValidator>
                                </div>
                            </div>

                            <!-- Subjects (CheckBoxList) -->
                            <div class="col-md-8 col-sm-12">
                                <div class="form-group">
                                    <label>Subjects <span class="text-danger"><strong>*</strong></span></label>
                                    <asp:CheckBoxList CssClass="form-control" runat="server" RepeatDirection="Horizontal" ID="cblSubject">
                                        <asp:ListItem Text="Maths" Value="Maths"></asp:ListItem>
                                        <asp:ListItem Text="Science" Value="Science"></asp:ListItem>
                                        <asp:ListItem Text="English" Value="English"></asp:ListItem>
                                        <asp:ListItem Text="History" Value="History"></asp:ListItem>
                                        <asp:ListItem Text="Computer Science" Value="Computer Science"></asp:ListItem>
                                    </asp:CheckBoxList>

                                    <!-- Custom Validator for Subject Selection -->
                                    <asp:CustomValidator
                                        ID="cvSubject"
                                        runat="server"
                                        OnServerValidate="cvSubject_ServerValidate"
                                        ErrorMessage="Please select at least one subject."
                                        CssClass="text-danger"
                                        ValidationGroup="StudentReg"
                                        Display="Dynamic" />
                                </div>
                            </div>
                            <div class="col-12">
                                <hr />
                                <div class="form-group">
                                    <asp:Button CssClass="btn btn-primary" ValidationGroup="StudentReg" runat="server" ID="btnSubmit" Text="Save" OnClick="btnSubmit_Click" />
                                    <a href="StudentRegistration.aspx" class="btn btn-danger">Clear</a>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="card-footer">
                        <div class="row">
                            <div class="col-md-12">
                                <div class="table table-responsive">
                                    <asp:GridView runat="server" OnRowCommand="grdStudentData_RowCommand" ID="grdStudentData" CssClass="table table-bordered" AutoGenerateColumns="false">
                                        <Columns>
                                            <asp:TemplateField HeaderText="S.No.">
                                                <ItemTemplate>
                                                    <asp:Label runat="server" ID="lblid" Text='<%# Container.DataItemIndex+1 %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Name">
                                                <ItemTemplate>
                                                    <asp:Label runat="server" ID="lblname" Text='<%# Eval("Name") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Parents Name">
                                                <ItemTemplate>
                                                    <asp:Label runat="server" ID="lblParentsName" Text='<%# Eval("ParentsName") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Gender">
                                                <ItemTemplate>
                                                    <asp:Label runat="server" ID="lblGender" Text='<%# Eval("Gender") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Course">
                                                <ItemTemplate>
                                                    <asp:Label runat="server" ID="lblCourse" Text='<%# Eval("Course") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Subjects">
                                                <ItemTemplate>
                                                    <asp:Label runat="server" ID="lblSubjects" Text='<%# Eval("Subjects") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Registration Date">
                                                <ItemTemplate>
                                                    <asp:Label runat="server" ID="lblRegistrationDate" Text='<%# Eval("RegistrationDate") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>

                                            <asp:TemplateField HeaderText="Action" ItemStyle-Width="12%" ItemStyle-HorizontalAlign="Center" > 
                                                <ItemTemplate>
                                                    <asp:LinkButton runat="server" CommandName="EditRecord" CommandArgument='<%# Eval("StudentID") %>'  CssClass="btn btn-sm btn-info"><i class="fa fa-pencil-alt"></i></asp:LinkButton>

                                                    <asp:LinkButton runat="server" CommandName="DeleteRecord" CommandArgument='<%# Eval("StudentID") %>'  CssClass="btn btn-sm btn-danger"><i class="fa fa-trash-alt"></i></asp:LinkButton>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                        </Columns>
                                    </asp:GridView>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- /.card -->
            </div>
            <!--/.col (left) -->
            <!-- right column -->
            <div class="col-md-6">
            </div>
            <!--/.col (right) -->
        </div>
        <!-- /.row -->
    </div>
    <!-- /.container-fluid -->
    <!-- /.content -->
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentFooter" runat="server">
</asp:Content>
