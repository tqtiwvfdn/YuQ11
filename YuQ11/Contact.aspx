<%@ Page Title="联系我们" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Contact.aspx.cs" Inherits="YuQ11.Contact" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <div class="page-header">
        <h2><%: Title %>.</h2>
        <h4>高校运动会内容发布系统</h4>
        <p>信息学院、软件学院 团委学生会 - 222办公室</p>
    </div>
    <div class="row">
        <div class=" col-md-6">
            <div class="list-group" id="adminList" runat="server">
                <span class="list-group-item active">负责人</span>
            </div>
        </div>
        <div class=" col-md-6">
            <div class="list-group" id="operatorList" runat="server">
                <span class="list-group-item active">工作人员</span>
            </div>
        </div>
    </div>
</asp:Content>
