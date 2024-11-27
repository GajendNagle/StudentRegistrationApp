<%@ Page Title="" Language="C#" MasterPageFile="~/MainMaster.Master" AutoEventWireup="true" CodeBehind="StudentSummaryReport.aspx.cs" Inherits="StudentRegistrationApp.StudentSummaryReport1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentHead" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentBody" runat="server">
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
                        <li class="breadcrumb-item active">Student Summary Report</li>
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
                <!-- jquery validation -->
                <div class="card card-primary">
                    <div class="card-header">
                        <div class="row">

                            <div class="col-md-6">
                                <h3 class="card-title">Student Summary Report</h3>
                            </div>
                            <div class="col-md-6" style="text-align:end;">
                                <asp:Button ID="btnLoadReport" runat="server" Text="Reload Report" CssClass="btn btn-sm btn-outline-light" OnClick="btnLoadReport_Click" />

                            </div>
                        </div>


                    </div>
                    <!-- /.card-header -->
                    <!-- form start -->
                    <div class="card-body">
                        <div class="row">
                            <div class="col-md-12">

                                <div class="text-center">
                                    <h5>Total Students Registered: 
                                        <asp:Label ID="lblTotalStudents" runat="server"></asp:Label></h5>
                                </div>
                                <hr />
                                <fieldset>
                                    <legend>Student Count by Gender</legend>


                                    <table border="1" class="table table-striped table-bordered">
                                        <thead>
                                            <tr>
                                                <th>Gender</th>
                                                <th>Count</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <tr>
                                                <td>Male</td>
                                                <td>
                                                    <asp:Label ID="lblMaleCount" runat="server"></asp:Label></td>
                                            </tr>
                                            <tr>
                                                <td>Female</td>
                                                <td>
                                                    <asp:Label ID="lblFemaleCount" runat="server"></asp:Label></td>
                                            </tr>
                                            <tr>
                                                <td>Other</td>
                                                <td>
                                                    <asp:Label ID="lblOtherCount" runat="server"></asp:Label></td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </fieldset>
                                <fieldset>
                                    <legend>Student Count by Course</legend>

                                    <table border="1" class="table table-striped table-bordered">
                                        <thead>
                                            <tr>
                                                <th>Course</th>
                                                <th>Count</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <tr>
                                                <td>BBA</td>
                                                <td>
                                                    <asp:Label ID="lblBBACount" runat="server"></asp:Label></td>
                                            </tr>
                                            <tr>
                                                <td>BCom</td>
                                                <td>
                                                    <asp:Label ID="lblBComCount" runat="server"></asp:Label></td>
                                            </tr>
                                            <tr>
                                                <td>BSc</td>
                                                <td>
                                                    <asp:Label ID="lblBScCount" runat="server"></asp:Label></td>
                                            </tr>
                                            <tr>
                                                <td>BA</td>
                                                <td>
                                                    <asp:Label ID="lblBACount" runat="server"></asp:Label></td>
                                            </tr>
                                            <tr>
                                                <td>BE</td>
                                                <td>
                                                    <asp:Label ID="lblBECount" runat="server"></asp:Label></td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </fieldset>

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
