<%@ Page Title="管理帐户" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Manage.aspx.cs" Inherits="YuQ11.Account.Manage" %>


<asp:Content ContentPlaceHolderID="MainContent" runat="server">
    <div class="page-header">
        <h2><%: Title %>.</h2>
        <h4>当前账号：
        <script>
            document.write(getCookie("yuQ11UserName"));
        </script>
        </h4>
    </div>
    <div>
        <asp:PlaceHolder runat="server" ID="successMessage" Visible="false" ViewStateMode="Disabled">
            <p class="text-success"><%: SuccessMessage %></p>
        </asp:PlaceHolder>
    </div>
    <div class="form-horizontal">
        <h4>更改密码</h4>
        <asp:ValidationSummary runat="server" ShowModelStateErrors="true" CssClass="text-danger" />
        <div class="form-group form-group-sm">
            <asp:Label runat="server" ID="CurrentPasswordLabel" AssociatedControlID="CurrentPassword" CssClass="col-md-2 control-label">当前密码</asp:Label>
            <div class="col-md-3">
                <asp:TextBox runat="server" ID="CurrentPassword" TextMode="Password" CssClass="form-control" />
                <asp:RequiredFieldValidator runat="server" ControlToValidate="CurrentPassword" Display="Dynamic"
                    CssClass="text-danger" ErrorMessage="请填写当前密码"
                    ValidationGroup="ChangePassword" />
                <asp:RegularExpressionValidator runat="server" ControlToValidate="CurrentPassword" CssClass="text-danger"
                    ValidationExpression="^[\@A-Za-z0-9\!\#\$\%\^\&\*\.\~]{6,16}$" ErrorMessage="请输入6-16位当前密码" />
            </div>
        </div>
        <div class="form-group form-group-sm">
            <asp:Label runat="server" ID="NewPasswordLabel" AssociatedControlID="NewPassword" CssClass="col-md-2 control-label">新密码</asp:Label>
            <div class="col-md-3">
                <asp:TextBox runat="server" ID="NewPassword" TextMode="Password" CssClass="form-control" />
                <asp:RequiredFieldValidator runat="server" ControlToValidate="NewPassword" Display="Dynamic"
                    CssClass="text-danger" ErrorMessage="请填写新密码。"
                    ValidationGroup="ChangePassword" />
                <asp:RegularExpressionValidator runat="server" ControlToValidate="NewPassword" CssClass="text-danger"
                    ValidationExpression="^[\@A-Za-z0-9\!\#\$\%\^\&\*\.\~]{6,16}$" ErrorMessage="请输入6-16位新密码" />
            </div>
        </div>
        <div class="form-group form-group-sm">
            <asp:Label runat="server" ID="ConfirmNewPasswordLabel" AssociatedControlID="ConfirmNewPassword" CssClass="col-md-2 control-label">确认新密码</asp:Label>
            <div class="col-md-3">
                <asp:TextBox runat="server" ID="ConfirmNewPassword" TextMode="Password" CssClass="form-control" />
                <asp:RequiredFieldValidator runat="server" ControlToValidate="ConfirmNewPassword"
                    CssClass="text-danger" Display="Dynamic" ErrorMessage="请填写确认新密码"
                    ValidationGroup="ChangePassword" />
                <asp:CompareValidator runat="server" ControlToCompare="NewPassword" ControlToValidate="ConfirmNewPassword"
                    CssClass="text-danger"  ErrorMessage="新密码和确认密码不匹配。"
                    ValidationGroup="ChangePassword" />
            </div>
        </div>
        <div class="form-group form-group-sm">
            <div class="col-md-offset-2 col-md-2">
                <asp:Button runat="server" Text="更改密码" ValidationGroup="ChangePassword" OnClick="ChangePassword_Click" CssClass="btn btn-primary" />
            </div>
        </div>
    </div>

</asp:Content>
