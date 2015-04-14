<%@ Page Title="登录" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="YuQ11.Account.Login" Async="true" %>
<asp:Content runat="server" ID="BodyContent" ContentPlaceHolderID="MainContent">
    <div class="page-header">
        <h2><%: Title %>.</h2>
        <h4>使用学号登录账号。</h4>
    </div>
    <div class="form-horizontal">
        <asp:PlaceHolder runat="server" ID="ErrorMessage" Visible="false">
            <p class="text-danger">
                <asp:Literal runat="server" ID="FailureText" />
            </p>
        </asp:PlaceHolder>
        <div class="form-group form-group-sm">
            <asp:Label runat="server" AssociatedControlID="UserName" CssClass="col-md-2 control-label">学号</asp:Label>
            <div class="col-md-3">
                <asp:TextBox runat="server" ID="UserName" CssClass="form-control" />
                <asp:RequiredFieldValidator runat="server" ControlToValidate="UserName"
                    CssClass="text-danger" ErrorMessage="请填写学号"  Display="Dynamic"/>
                <asp:RegularExpressionValidator runat="server" ControlToValidate="UserName" CssClass="text-danger"
                    ValidationExpression="^[0-9]{12}$"  ErrorMessage="请正确填写12位学号" />
            </div>
        </div>
        <div class="form-group form-group-sm">
            <asp:Label runat="server" AssociatedControlID="Password" CssClass="col-md-2 control-label">密码</asp:Label>
            <div class="col-md-3">
                <asp:TextBox runat="server" ID="Password" TextMode="Password" CssClass="form-control" />
                <asp:RequiredFieldValidator runat="server" ControlToValidate="Password" Display="Dynamic"
                    CssClass="text-danger" ErrorMessage="请填写密码" />
                <asp:RegularExpressionValidator runat="server" ControlToValidate="Password" CssClass="text-danger"
                     ValidationExpression="^[\@A-Za-z0-9\!\#\$\%\^\&\*\.\~]{6,16}$" ErrorMessage="请输入6-16位密码" />
            </div>
        </div>
        <div class="form-group form-group-sm">
            <div class="col-md-offset-2 col-md-3">
                <asp:CheckBox runat="server" ID="RememberMe" />
                <asp:Label runat="server" AssociatedControlID="RememberMe" Font-Bold="false">记住我?</asp:Label>
            </div>
        </div>
        <div class="form-group form-group-sm">
            <div class="col-md-offset-2 col-md-3">
                <asp:Button runat="server" OnClick="LogIn" Text="登录" CssClass="btn btn-primary" />
            </div>
        </div>
    </div>
    <p>
        <asp:HyperLink runat="server" ID="RegisterHyperLink" ViewStateMode="Disabled">注册</asp:HyperLink>
        ，如果您没有在该系统上注册。
    </p>

</asp:Content>
