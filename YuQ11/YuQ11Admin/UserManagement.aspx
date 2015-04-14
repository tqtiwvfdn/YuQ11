<%@ Page Title="用户管理" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="UserManagement.aspx.cs" Inherits="YuQ11.YuQ11Admin.UserManagement" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="page-header">
        <h1><%: Title %>.</h1>
        <h4>编辑用户信息、删除用户、重置用户密码，配置用户角色。</h4>
    </div>
    <div class="well well-sm">
        <div class="text-right pull-right pull-responsive">
            <span id="messageBox" class="text-danger"></span>
            <button type="button" class="btn btn-sm btn-primary" id="refreshCollegeAndClassList">刷新学院班级列表</button>
        </div>
        <ul class="nav nav-tabs">
            <li class="active">
                <a href="#searchUserTab" data-toggle="tab" aria-expanded="true">搜索学生</a>
            </li>
            <li>
                <a href="#selectUserTab" data-toggle="tab" aria-disabled="true">选择学生列表</a>
            </li>
            <li>
                <a href="#selectRoleTab" data-toggle="tab" aria-disabled="true">选择角色列表</a>
            </li>
        </ul>
        <div class="tab-content">
            <div class="tab-pane fade active in form-horizontal" id="searchUserTab" data-role="form">
                <div class="form-group form-group-sm">
                    <div class="col-lg-9 col-lg-offset-1">
                        <input type="text" class="form-control" name="usersInfo"
                            required="required" placeholder="键入学生班级、姓名、学号或手机号码部分或全部信息以搜索">
                        <span class="text-danger" style="visibility: hidden;">请输入搜索内容</span>
                    </div>
                    <div class="col-lg-2">
                        <button type="button" class="btn btn-primary btn-sm" id="searchUserInfoBtn">搜索</button>
                    </div>
                </div>
            </div>
            <div class="tab-pane fade form-horizontal" id="selectUserTab" data-role="form">
                <div class="form-group form-group-sm">
                    <div id="CollegeListContainer" runat="server" visible="false">
                        <label for="collegeList" class="col-lg-1 control-label  col-lg-offset-1">学院</label>
                        <div class="col-lg-3">
                            <select class="form-control" name="collegeList" id="collegeList" required="required">
                                <option value="" disabled="disabled" selected="selected">请选择…</option>
                            </select>
                            <span class="text-danger" style="visibility: hidden;">请选择学院</span>
                        </div>
                    </div>
                    <label for="classList" class="col-lg-1 col-lg-offset-1 control-label">班级</label>
                    <div class="col-lg-3">
                        <select class="form-control" name="classList" id="classList" required="required">
                            <option value="" disabled="disabled" selected="selected">请选择…</option>
                        </select>
                        <span class="text-danger" style="visibility: hidden;">请选择班级</span>
                    </div>
                    <div class="col-lg-2">
                        <button type="button" class="btn btn-primary btn-sm" id="selectClassBtn">显示</button>
                    </div>
                </div>
            </div>
            <div class="tab-pane fade form-horizontal" id="selectRoleTab" data-role="form">
                <div class="form-group form-group-sm">
                    <label for="collegeList" class="col-lg-1 control-label  col-lg-offset-1">角色</label>
                    <div class="col-lg-3">
                        <select class="form-control" name="userRole" required="required">
                            <option value="SportsLeaders">体育委员</option>
                            <option value="Operators">工作人员</option>
                            <option value="Administrators" id="SelectRoleAdministrorsOption" runat="server" visible="false">管理员</option>
                        </select>
                        <span class="text-danger" style="visibility: hidden;">请选择角色</span>
                    </div>

                    <div class="col-lg-2">
                        <button type="button" class="btn btn-primary btn-sm" id="selectRoleBtn">显示</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="collapse" id="userInfoContainer">
        <ul class="nav nav-tabs">
            <li class="active"><a href="#userInfoTab" data-toggle="tab" id="userInfoLink" >用户信息</a></li>
            <li><a href="#editUserInfoTab" data-toggle="tab"  class="hide" id="editUserInfoLink" >编辑用户信息</a></li>
        </ul>
        <div class="tab-content">
            <div class="tab-pane fade active in table-responsive" id="userInfoTab">
                <div id="noRecord" class="text-danger" style="display:none;">对不起，找不到您要的用户信息。</div>
                <table class="table table-condensed table-hover table-striped">
                    <thead>
                        <tr><td>班级</td><td>学号</td><td>姓名</td><td>长号</td><td>短号</td><td>性别</td><td>角色</td></tr>
                    </thead>
                    <tbody></tbody>
                </table>
            </div>
            <div class="tab-pane fade form-horizontal" id="editUserInfoTab" data-role="form">
                <h3 class="gutter-top" id="editTabTitle"></h3>
                <div class="text-danger col-md-offset-2" style="visibility: hidden;">修改失败！</div>
                <div class="row">
                    <div class="col-md-4">
                        <h4 class="page-header gutter-top">基本信息</h4>
                        <div class="form-group form-group-sm hide">
                            <label class="col-md-4 control-label" for="EditClassName">班级*</label>
                            <div class="col-md-8">
                                <input type="text" id="EditClassName" class="form-control" readonly="readonly" />
                                <span class="text-danger" style="visibility: hidden;">请勿修改班级</span>
                            </div>
                        </div>
                        <div class="form-group form-group-sm hide">
                            <label class="col-md-4 control-label" for="EditUserName">学号*</label>
                            <div class="col-md-8">
                                <input type="text" name="userName" id="EditUserName" class="form-control" readonly="readonly" />
                                <span class="text-danger" style="visibility: hidden;">请勿修改学号</span>
                            </div>
                        </div>
                        <div class="form-group form-group-sm hide">
                            <label class="col-md-4 control-label" for="EditUserNickName">姓名*</label>
                            <div class="col-md-8">
                                <input type="text" id="EditUserNickName" class="form-control" readonly="readonly" />
                                <span class="text-danger" style="visibility: hidden;">请填写正确的姓名</span>
                            </div>
                        </div>
                        <div class="form-group form-group-sm">
                            <label class="col-md-4 control-label" for="EditUserLongPhone">长号*</label>
                            <div class="col-md-8">
                                <input type="text" name="userLongPhone" id="EditUserLongPhone" class="form-control" data-regex="^1[0-9]{10}$"/>
                                <span class="text-danger" style="visibility: hidden;">请填写正确的手机号码</span>
                            </div>
                        </div>
                        <div class="form-group form-group-sm">
                            <label class="col-md-4 control-label" for="EditUserShortPhone">短号</label>
                            <div class="col-md-8">
                                <input type="text" name="userShortPhone" id="EditUserShortPhone" class="form-control" data-regex="^\s{0}$|^[0-9]{3,11}$" />
                                <span class="text-danger" style="visibility: hidden;">请填写正确的短号</span>
                            </div>
                        </div>
                        <div class="form-group form-group-sm">
                            <label class="col-md-4 control-label" for="EditUserSex">性别*</label>
                            <div class="col-md-8">
                                <input type="text" id="EditUserSex" class="form-control" readonly="readonly" />
                                <span class="text-danger" style="visibility: hidden;">请选择性别</span>
                            </div>
                        </div>
                        <div class="form-group form-group-sm">
                            <div class="col-md-offset-4 col-md-8">
                                <button class="btn btn-primary" id="editUserBtn" type="button" data-action="editUser">修改基本信息</button>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <h4 class="page-header gutter-top">权限</h4>
                        <div class="form-group form-group-sm">
                            <label class="col-md-4 control-label" for="EditUserRole">角色</label>
                            <div class="col-md-8">
                                <select class="form-control" id="EditUserRole" name="userRole">
                                    <option value="Users">普通用户</option>
                                    <option value="SportsLeaders">体育委员</option>
                                    <option value="Operators">工作人员</option>
                                    <option value="Administrators" id="RoleAdministrorsOption" runat="server" visible="false">管理员</option>
                                </select>
                                <span class="text-danger" style="visibility: hidden;">请选择角色</span>
                            </div>
                        </div>
                        <div class="form-group form-group-sm">
                            <div class="col-md-offset-4 col-md-8">
                                <button class="btn btn-warning btn-sm" id="changeUserRoleBtn" type="button" data-action="changeRole">修改用户角色</button>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <h4 class="page-header gutter-top">高级</h4>
                        <div class="form-group form-group-sm">
                            <label class="col-md-4 control-label" for="EditUserRole">密码</label>
                            <div class="col-md-8">
                                <button class="btn btn-sm btn-danger" type="button" id="resetPasswordBtn" data-action="resetPassword">重置密码</button>
                            </div>
                        </div>
                    </div>

                </div>
            </div>
        </div>
    </div>
    <script src="../Static/Scripts/units.js"></script>
    <script>
        $(function () {
            //禁用回车提交表单
            $('#ctl01').submit(function () { return false; });
            //刷新学院班级列表
            $('#refreshCollegeAndClassList').click(function () {
                ajaxForm($(this), $(), 'GET', '', '', '../Static/wrtieCollegeAndClassList', function (result) {
                    location.reload(true);
                }, null, false, false, $('#messageBox'));
            });
            //加载班级、学院列表
            var collegeAndClassClock = setInterval(function () {
                if (!!colleges) {
                    window.clearInterval(collegeAndClassClock);
                    loadCollegeAndClass();
                }
            }, 1000);
            //提交搜索学生表单
            var $tbody = $("tbody", $("#userInfoTab")), $tr = {};
            $('#searchUserInfoBtn,#selectClassBtn,#selectRoleBtn').click(function () {
                var extraData = '<%:(HttpContext.Current.User.IsInRole(YuQ11.Static.Variable.roleAdministrators)?"all":"")%>';
                ajaxForm($(this), $(this).closest('[data-role="form"]'), "GET", '&collegeID='+(!extraData?getCookie('yuQ11UserCollegeID'):extraData), '', '../Static/getUsersList', function (data) {
                    $('#userInfoContainer').collapse('show');
                    var usersList = $.stringToObject(data),itemHtml='';
                    if (!usersList||!usersList.length) {
                        $("#userInfoTab").children(":eq(0)").fadeIn();
                        $("#userInfoTab").children(":eq(1)").fadeOut();
                    } else {
                        $("#userInfoTab").children(":eq(0)").fadeOut();
                        $("#userInfoTab").children(":eq(1)").fadeIn();
                        for (var i = 0, user; (user = usersList[i]) != null; i++) {
                            itemHtml += '<tr><td>' + user.className + '</td><td>' + user.userName + '</td><td>' +
                                user.userNickName + '</td><td>' + user.userLongPhone + '</td><td>' + user.userShortPhone + '</td><td>' + (user.userSex == 0 ? '男' : '女') +
                                '</td><td>' + (user.userRole == 'Users' ? '普通用户' :
                                user.userRole == 'SportsLeaders' ? '体育委员' :
                                user.userRole == 'Operators' ? '工作人员' :
                                user.userRole == 'Administrators' ? '管理员' : '普通用户') + '</td></tr>';
                        }
                        $tbody[0].innerHTML = itemHtml;
                        $('#userInfoLink').trigger('click');
                        $('html,body').animate({ 'scrollTop': $('#userInfoContainer').offset().top - 100 }, 1000);
                    }
                }, null, false, false, $(this).closest('[data-role="form"]').children(':eq(1)'));
            });
            //编辑用户信息
            $tbody.click(function (e) {
                e = e.target || window.event.srcElement;
                $tr = $(e).closest('tr');
                var str = $tr.html().replace(/<td>/g, '').split('</td>');
                $('#editTabTitle').html(str[2] + '&nbsp;<small>' + str[0] +'，'+ str[1] + '</small>');
                $('#EditClassName').val(str[0]);
                $('#EditUserName').val(str[1]);
                $('#EditUserNickName').val(str[2]);
                $('#EditUserLongPhone').val(str[3]);
                $('#EditUserShortPhone').val(str[4]);
                $('#EditUserSex').val(str[5]);
                $('#EditUserRole').val((
                    str[6] == '管理员' ? 'Administrators' :
                    str[6]=='工作人员'?'Operators':
                    str[6] == '体育委员' ? 'SportsLeaders' : 'Users'));

                $('#editUserInfoLink').removeClass('hide').trigger('click');
                $('#editUserInfoTab').children(':eq(1)').css('visibility', 'hidden');
                $('html,body').animate({ 'scrollTop': $('#editUserInfoLink').offset().top - 100 }, 1000);
            });
            $('#editUserBtn,#changeUserRoleBtn,#resetPasswordBtn').click(function () {
                var action = $(this).attr('data-action'), $form = $(this).closest('[data-role="form"]');
                ajaxForm($(this), $form, 'POST', '&action=' + action, '', '../Static/editUsersList', function (data) {
                    data = $.stringToObject(data);
                    if (!!data && data.userName > 0) {
                        $form.children(':eq(1)').css('visibility', 'visible').text(
                            (action == 'resetPassword' ? '已将密码重置为：12345678！' :
                            action == 'changeRole' ? '修改用户角色成功，重新登陆后生效。' : '修改基本信息成功！'));
                    } else {
                        data = data || {};
                        $form.children(':eq(1)').css('visibility', 'visible').text(data.msg ||
                            (action == 'resetPassword' ? '重置密码' :
                            action == 'changeRole' ? '修改用户角色' : '修改基本信息') + '失败！');
                    }
                    $('html,body').animate({ 'scrollTop': $form.children(':eq(0)').offset().top-100}, 1000);
                }, null, false, (action == 'editUser'), $form.children(':eq(1)'));
            });
            //隐藏编辑用户Tab
            $('#userInfoLink').click(function () {
                $('#editUserInfoLink').addClass('hide');
            });
        });
        //加载学院班级部分
        function loadCollegeAndClass() {
            var $collegeList = $('#collegeList'),
                $classList = $('#classList');
            $collegeList.children(":not(:first)").remove();

            if (!!$collegeList.length) {
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
            } else {
                var singleCollegeClasses = classes[getCookie('yuQ11UserCollegeID')];
                for (var singleClass in singleCollegeClasses) {
                    $classList.append('<option value="' + singleClass + '">' + singleCollegeClasses[singleClass] + '</option>');
                }
            }
        }
        //regex
        function regexTest($checkForm) {
            $requiredParams = $('[data-regex]', $checkForm);
            for (var i = 0, $elem; !!($elem = $($requiredParams[i])).length; i++) {
                $elem.prev().children('.error').remove();
                if (!(new RegExp($elem.attr('data-regex'))).test($.trim($elem.val()))) {
                    $elem.next().css('visibility', 'visible');
                    $elem.focus();
                    $elem.change(function () {
                        $elem.next().css('visibility', 'hidden');
                    });
                    return false;
                }
            }
            return true;
        }
    </script>
</asp:Content>
