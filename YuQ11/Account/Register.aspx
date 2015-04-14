<%@ Page Title="注册" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="YuQ11.Account.Register" %>

<asp:Content runat="server" ID="BodyContent" ContentPlaceHolderID="MainContent">
    <div class="page-header">
        <h2><%: Title %>.</h2>
        <h4>创建新帐户。</h4>
    </div>
    <p class="text-danger">
        <asp:Literal runat="server" ID="ErrorMessage" />
    </p>
    <div class="form-horizontal">
        <div class="form-group form-group-sm">
            <asp:Label runat="server" AssociatedControlID="CollegeList" CssClass="col-md-2 control-label">学院*</asp:Label>
            <div class="col-md-3">
                <select class="form-control" id="CollegeList" runat="server">
                    <option value="" selected="selected" disabled="disabled">请选择…</option>
                </select>
                <asp:RequiredFieldValidator runat="server" ControlToValidate="CollegeList"
                    CssClass="text-danger" ErrorMessage="请选择学院" />
            </div>
            <asp:Label runat="server" AssociatedControlID="ClassList" CssClass="col-md-2 control-label">班级*</asp:Label>
            <div class="col-md-3">
                <select class="form-control" id="ClassList" runat="server">
                    <option value="" selected="selected" disabled="disabled">请选择…</option>
                </select>
                <asp:RequiredFieldValidator runat="server" ControlToValidate="CollegeList"
                    CssClass="text-danger" ErrorMessage="请选择班级" />
            </div>
        </div>
        <div class="form-group form-group-sm">
            <asp:Label runat="server" AssociatedControlID="UserName" CssClass="col-md-2 control-label">学号*</asp:Label>
            <div class="col-md-3">
                <asp:TextBox runat="server" ID="UserName" CssClass="form-control" />
                <asp:RequiredFieldValidator runat="server" ControlToValidate="UserName"
                    CssClass="text-danger" ErrorMessage="请填写学号"  Display="Dynamic"/>
                <asp:RegularExpressionValidator runat="server" ControlToValidate="UserName" CssClass="text-danger"
                    ValidationExpression="^[0-9]{12}$"  ErrorMessage="请正确填写12位学号" />
            </div>
            <asp:Label runat="server" AssociatedControlID="UserNickName" CssClass="col-md-2 control-label">姓名*</asp:Label>
            <div class="col-md-3">
                <asp:TextBox runat="server" ID="UserNickName" CssClass="form-control" />
                <asp:RequiredFieldValidator runat="server" ControlToValidate="UserNickName"
                    CssClass="text-danger" ErrorMessage="请填写姓名"  Display="Dynamic"/>
                <asp:RegularExpressionValidator runat="server" ControlToValidate="UserNickName" CssClass="text-danger"
                    ValidationExpression="^[\u4E00-\u9FFF]{2,5}$" ErrorMessage="请正确填写2-5位汉字姓名"  />
            </div>
        </div>
        <div class="form-group form-group-sm">
            <asp:Label runat="server" AssociatedControlID="UserSex" CssClass="col-md-2 control-label">性别*</asp:Label>
            <div class="col-md-3">
                <select class="form-control" id="UserSex" runat="server">
                    <option value="" selected="selected" disabled="disabled">请选择…</option>
                    <option value="0">♂&nbsp;男</option>
                    <option value="1">♀&nbsp;女</option>
                </select>                     
                <asp:RequiredFieldValidator runat="server" ControlToValidate="UserSex"
                    CssClass="text-danger" ErrorMessage="请选择性别" />
            </div>
        </div>
        <div class="form-group form-group-sm">
            <asp:Label runat="server" AssociatedControlID="UserLongPhone" CssClass="col-md-2 control-label">长号*</asp:Label>
            <div class="col-md-3">
                <asp:TextBox runat="server" ID="UserLongPhone" CssClass="form-control" />
                <asp:RequiredFieldValidator runat="server" ControlToValidate="UserLongPhone"
                    CssClass="text-danger" ErrorMessage="请填写手机号码" Display="Dynamic" />
                <asp:RegularExpressionValidator runat="server" ControlToValidate="UserLongPhone" CssClass="text-danger"
                    ValidationExpression="^1[0-9]{10}$" ErrorMessage="请正确填写11位手机号码"  />
            </div>
            <asp:Label runat="server" AssociatedControlID="UserShortPhone" CssClass="col-md-2 control-label">短号</asp:Label>
            <div class="col-md-3">
                <asp:TextBox runat="server" ID="UserShortPhone" CssClass="form-control" />
                <asp:RegularExpressionValidator runat="server" ControlToValidate="UserShortPhone" CssClass="text-danger"
                    ValidationExpression="^[0-9]{3,11}$" ErrorMessage="请正确填写短号" />
            </div>
        </div>
        <div class="form-group form-group-sm">
            <asp:Label runat="server" AssociatedControlID="Password" CssClass="col-md-2 control-label">密码*</asp:Label>
            <div class="col-md-3">
                <asp:TextBox runat="server" ID="Password" TextMode="Password" CssClass="form-control" />
                <asp:RequiredFieldValidator runat="server" ControlToValidate="Password" Display="Dynamic"
                    CssClass="text-danger" ErrorMessage="请填写密码" />
                <asp:RegularExpressionValidator runat="server" ControlToValidate="Password" CssClass="text-danger"
                     ValidationExpression="^[\@A-Za-z0-9\!\#\$\%\^\&\*\.\~]{6,16}$" ErrorMessage="请输入6-16位密码" />
            </div>
            <asp:Label runat="server" AssociatedControlID="ConfirmPassword" CssClass="col-md-2 control-label">确认密码*</asp:Label>
            <div class="col-md-3">
                <asp:TextBox runat="server" ID="ConfirmPassword" TextMode="Password" CssClass="form-control" />
                <asp:RequiredFieldValidator runat="server" ControlToValidate="ConfirmPassword"
                    CssClass="text-danger"  Display="Dynamic" ErrorMessage="请填写确认密码" />
                <asp:CompareValidator runat="server" ControlToCompare="Password" ControlToValidate="ConfirmPassword"
                    CssClass="text-danger"  ErrorMessage="密码和确认密码不匹配" />
            </div>
        </div>
        <div class="form-group form-group-sm">
            <div class="col-md-offset-7 col-md-2">
                <asp:Button runat="server" OnClick="CreateUser_Click" Text="注册" CssClass="btn btn-primary" />
            </div>
        </div>
    </div>
    <script src="<%=Request.ApplicationPath=="/"?"":Request.ApplicationPath %>/Static/Scripts/units.js"></script>
    
    <script>
        $(function () {
            var collegeAndClassClock = setInterval(function () {
                if (!!colleges) {
                    window.clearInterval(collegeAndClassClock);
                    loadCollegeAndClass();
                }
            }, 1000);
        });
        function loadCollegeAndClass() {
            var $collegeList = $('#MainContent_CollegeList'),
                $classList = $('#MainContent_ClassList');
            $collegeList.children(":not(:first)").remove();
            for (var college in colleges) {
                $collegeList.append('<option value="' + college + '">' + colleges[college] + '</option>');
            }
            $collegeList.change(function () {
                $classList.val('');
                $classList.children(":not(:first)").remove();
                var singleCollegeClasses = classes[$(this).val()];
                for (var singleClass in singleCollegeClasses) {
                    $classList.append('<option value="' + singleClass + '">' + singleCollegeClasses[singleClass] + '</option>');
                }
            });
        }
    </script>
</asp:Content>
