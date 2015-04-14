<%@ Page Title="体委中心" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Leaders.aspx.cs" Inherits="YuQ11.Leaders.Default" %>

<asp:Content ID="ContentContainer" ContentPlaceHolderID="MainContent" runat="server">
    <div class="page-header">
        <h2><%:Title %>.</h2>
        <h4>体育委员管理中心，查看与管理您的班级体育运动事务。</h4>
    </div>
    <blockquote class="pull-right pull-responsive" style="margin: 0">
        <small id="summaryTips"></small>
    </blockquote>
    <ul class="nav nav-tabs">
        <li class="active">
            <a href="#userTab" data-toggle="tab" aria-expanded="true">用户信息</a>
        </li>
        <li>
            <a href="#subscribeTab" data-toggle="tab" aria-disabled="true">项目报名</a>
        </li>
        <li>
            <a href="#editTab" data-toggle="tab" aria-disabled="true" class="hide" id="editLink">编辑用户信息与报名</a>
        </li>
    </ul>
    <div class="tab-content collapse">
        <div class="tab-pane fade active in table-responsive" id="userTab">
            <div class="text-danger" style="visibility: hidden;">对不起，找不到用户信息。</div>
            <table class="table table-condensed table-hover table-striped">
                <thead>
                    <tr>
                        <td>学号</td>
                        <td>姓名</td>
                        <td>长号</td>
                        <td>短号</td>
                        <td>报名项目</td>
                    </tr>
                </thead>
                <tbody></tbody>
            </table>
        </div>
        <div class="tab-pane fade table-responsive" id="subscribeTab">
            <div class="text-danger" style="visibility: hidden;">对不起，找不到项目报名信息。</div>
            <div class="container">
                <div class="row" id="itemContainer"></div>
            </div>
        </div>
        <div class="tab-pane fade form-horizontal" id="editTab" data-role="form">
            <h3 class="gutter-top" id="editTabTitle"></h3>
            <div class="text-danger col-md-offset-2" style="visibility: hidden;">修改失败！</div>
            <div class="row">
                <div class="col-md-4">
                    <h4 class="page-header gutter-top">比赛报名</h4>
                    <div class="form-group form-group-sm">
                        <label class="col-md-4 control-label" for="EditUserRole">项目</label>
                        <div class="col-md-8">
                            <select class="form-control" id="EditUserItem" name="userItem">
                                <option value="" selected="selected" disabled="disabled">请选择…</option>
                            </select>
                            <span class="text-danger" style="visibility: hidden;">请选择比赛项目</span>
                        </div>
                    </div>
                    <div class="form-group form-group-sm">
                        <div class="col-md-offset-4 col-md-8">
                            <button class="btn btn-success" id="subscribeBtn" type="button" data-action="subscribe">报名</button>
                            <span class="text-danger" style="visibility: hidden;">报名数不能超过名额</span>
                        </div>
                    </div>
                    <div class="form-group form-group-sm">
                        <div class="col-md-offset-4 col-md-8" id="subscribeContainer"></div>
                    </div>
                </div>
                <div class="col-md-4">
                    <h4 class="page-header gutter-top">基本信息</h4>
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
                            <input type="text" name="userLongPhone" id="EditUserLongPhone" class="form-control" data-regex="^1[0-9]{10}$" />
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
                        <div class="col-md-offset-4 col-md-8">
                            <button class="btn btn-primary" id="editUserBtn" type="button" data-action="editUser">修改基本信息</button>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <h4 class="page-header gutter-top">高级</h4>
                    <div class="form-group form-group-sm">
                        <label class="col-md-4 control-label" for="EditUserRole">密码</label>
                        <div class="col-md-8">
                            <button class="btn btn-danger" type="button" id="resetPasswordBtn" data-action="resetPassword">重置密码</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <script src="../Static/Scripts/items.js"></script>
    <script>
        $(function () {
            var $userTbody = $('tbody', $('#userTab')),
                $itemContainer = $('#itemContainer', $('#subscribeTab')),
                maleItemOption = new StringBuilder(),
                femaleItemOption = new StringBuilder();
            //加载用户信息和报名项目
            $.ajaxFormModule({
                method: 'POST',
                extraData: 'collegeID=' + getCookie('yuQ11UserCollegeID') + '&classList=' + getCookie('yuQ11UserClassID'),
                targetUrl: '../Static/getUsersList',
                successFunc: function (data) {
                    var totalItemPlace = 0,//项目名额
                        totalItemSubscribe = 0,//项目报名个数
                        totalPeopleSubscribe = 0;//用户报名名额
                    $('.tab-content').collapse('show');
                    var usersList = $.stringToObject(data), itemHtml = new StringBuilder(), userItems, i, j, user, userItem, itemArray, sportItem;
                    if (!usersList || !usersList.length) {
                        $("#userTab,#subscribeTab").children(":eq(0)").fadeIn();
                        $("#userTab,#subscribeTab").children(":eq(1)").fadeOut();
                    } else {
                        $("#userTab,#subscribeTab").children(":eq(0)").fadeOut();
                        $("#userTab,#subscribeTab").children(":eq(1)").fadeIn();
                        //班级用户列表
                        for (i = 0, user; (user = usersList[i]) != null; i++) {
                            itemHtml.append('<tr data-id="' + user.userName + '" data-sex="' + user.userSex + '"><td>' + user.userName + '</td><td>' + user.userNickName + '</td><td>' + user.userLongPhone + '</td><td>' + user.userShortPhone + '</td><td>');
                            if (!!user.itemIDs) {
                                itemArray = new StringBuilder();
                                for (j = 0, userItems = (user.itemIDs).split(',') ; (userItem = userItems[j]) != null; j++) {
                                    sportItem = items['Sex' + user.userSex][userItem];
                                    console.log(sportItem);
                                    itemArray.append('<span data-item="' + userItem + '">' + sportItem.Name + '</span>');
                                    if (!sportItem.people) {
                                        sportItem.people = [{ 'userNickName': user.userNickName, 'userName': user.userName }];
                                    } else {
                                        sportItem.people[sportItem.people.length] = { 'userNickName': user.userNickName, 'userName': user.userName };
                                    }
                                }
                                itemHtml.append(itemArray.join('，'));
                            }
                            itemHtml.append('</td></tr>');
                        }
                        $userTbody[0].innerHTML = itemHtml.join();
                        itemHtml = new StringBuilder();
                        //项目列表
                        var sex, sItem, prop,
                            itemTemp = '<div class="col-md-3" data-item="itemID"><div class="panel panel-primary"><div class="panel-heading">itemName</div><div class="panel-body">people</div></div></div>',
                            peoples, itemOption;
                        for (sex in items) {
                            sItem = items[sex];
                            if (sex == 'Sex1') {
                                itemOption = femaleItemOption;
                            }
                            else if (sex == 'Sex0') {
                                itemOption = maleItemOption;
                            }
                            for (prop in sItem) {
                                itemOption.append('<option value=' + prop + '>' + sItem[prop].Name + '</option>');
                                totalItemPlace += sItem[prop].Place;
                                peoples = new StringBuilder();
                                if (!!sItem[prop].people) {
                                    itemArray = sItem[prop].people;
                                    totalItemSubscribe += 1, totalPeopleSubscribe += itemArray.length;
                                    for (i = 0; (user = itemArray[i]) != null; i++) {
                                        peoples.append('<p data-id="' + user.userName + '">' + user.userNickName + '</p>');
                                    }
                                }
                                itemHtml.append(itemTemp.replace(/itemName/, sItem[prop].Name).replace(/people/, peoples.join()).replace(/itemID/, prop));
                            }
                        }
                        $itemContainer[0].innerHTML = itemHtml.join();
                        $('html,body').animate({ 'scrollTop': $('#userTab').offset().top - 120 }, 1000);
                        $('#summaryTips')[0].innerHTML = '共' + (femaleItemOption.data.length + maleItemOption.data.length) + '个项目，' + '已报名项目' + totalItemSubscribe + '个。共' + totalItemPlace + '个名额，使用了' + totalPeopleSubscribe + '个名额，还剩' + (totalItemPlace - totalPeopleSubscribe) + '个名额';
                    }
                },
                $showErrorElem: $("#userTab,#subscribeTab").children(":eq(0)"),
            });
            //加载完后的点击事件
            var $editTab=$('#editTab'),
                $editTabInputs = $('input,select', $editTab), $editLink = $('#editLink'),
                $subscribeContainer = $('#subscribeContainer'),
                $EditUserItem = $('#EditUserItem'),
                userInfo = [],
                showUserInfo = function ($tr) {
                    $editTab.children(':eq(1)').css('visibility', 'hidden');
                    userInfo = $tr[0].innerHTML.replace(/<td>/g, '').split('</td>');
                    $editTabInputs[1].value = userInfo[0];
                    $editTabInputs[2].value = userInfo[1];
                    $editTabInputs[3].value = userInfo[2];
                    $editTabInputs[4].value = userInfo[3];
                    $EditUserItem.children(':gt(0)').remove();
                    $EditUserItem.append((($tr.attr('data-sex') == '0') ? maleItemOption.join() : femaleItemOption.join())).val('');
                    $subscribeContainer.html(userInfo[4].replace(/<span/g, '<span class="label label-selected"')
                        .replace(/<\/span>，?/g, '<button type="button" class="close">×</button></span>'));
                    $('#editTabTitle', $editTab).html(userInfo[1] + '&nbsp;<small>' + userInfo[0] + '</small>');
                    $editLink.removeClass('hide').trigger('click');
                };
            //点击选择用户
            $userTbody.click(function (e) {
                e = e.target || window.event.srcElement;
                showUserInfo($(e).closest('tr'));
            });
            $itemContainer.click(function (e) {
                e = e.target || window.event.srcElement;
                if (e.tagName.toLowerCase() === 'p') {
                    showUserInfo($('[data-id="' + e.attributes['data-id'].value + '"]', $userTbody));
                }
            });
            $('.nav-tabs').click(function (e) {
                e = $(e.target || window.event.srcElement)[0];
                if (e.tagName.toLowerCase() == 'a' && e.id != 'editLink') {
                    $editLink.addClass('hide');
                }
            });
            //编辑用户信息、重置密码
            $('#editUserBtn,#resetPasswordBtn').click(function () {
                var action = $(this).attr('data-action'), $form = $(this).closest('[data-role="form"]');
                ajaxForm($(this), $form, 'POST', '&action=' + action, '', '../Static/editUsersList', function (data) {
                    data = $.stringToObject(data);
                    if (!!data && data.userName > 0) {
                        $form.children(':eq(1)').css('visibility', 'visible').text(
                            (action == 'resetPassword' ? '已将密码重置为：12345678！' : '修改基本信息成功！'));

                    } else {
                        data = data || {};
                        $form.children(':eq(1)').css('visibility', 'visible').text(data.msg ||
                            (action == 'resetPassword' ? '重置密码' : '修改基本信息') + '失败！');
                    }
                    $('html,body').animate({ 'scrollTop': $form.children(':eq(1)').offset().top - 100 }, 1000);
                }, null, false, (action == 'editUser'), $form.children(':eq(1)'));
            });
            //报名、取消报名
            $('#subscribeBtn,#subscribeContainer').click(function (e) {
                var $this = $(e.target || window.event.srcElement),
                    action = $this.attr('data-action'),
                    $form = $this.closest('[data-role="form"]'),
                    value, $itemBox,userItem,
                    extraData = new StringBuilder(),
                    userName = $('#EditUserName', $form).val();
                if ($this[0].tagName.toLowerCase() == 'button') {
                    //用户名
                    extraData.append('userName=' + userName);
                    if (!action) {
                        //取消报名
                        extraData.append('action=cancelSubscribe');
                        $itemBox = $(e.target || window.event.srcElement, $form).parent();
                        userItem=$itemBox.attr('data-item');
                        extraData.append('userItem=' + userItem);
                    } else {
                        //报名
                        $itemBox = $('#EditUserItem', $form);
                        userItem = $itemBox.val();
                        extraData.append('action=' + action);
                        if (!userItem) {
                            $itemBox.next().css('visibility', 'visible');
                            return;
                        } else {
                            $itemBox.next().css('visibility', 'hidden');
                            extraData.append('userItem=' + userItem);
                        }
                    }
                    extraData.append("classID=" + getCookie('yuQ11UserClassID'));
                    ajaxForm($this, $(), 'GET', extraData.join('&'), '', '../Static/subscribe', function (result) {
                        var $subscibeTab = $('#subscribeTab'),
                            $userItemInfo = $('[data-id="' + userName + '"]', $('#userTab')).children(':last'),
                            $subscribeTabItem = $('[data-item="' + userItem + '"]', $subscibeTab),
                            htmlStringBuilder = new StringBuilder();
                        result = $.stringToObject(result);
                        $form.children(':eq(1)').css('visibility', 'visible').text(function () {
                            var str = ((!action) ? '取消报名' : '报名');
                            if (result.status == 'success') {
                                str += '成功！';
                                var $EditUserItem = $('#EditUserItem'),
                                    userItemName,
                                    params = $('#summaryTips').text().match(/\d+/g);
                                if (!action) {
                                    //取消报名
                                    //在编辑部分移除
                                    $this.closest('span').remove();
                                    //在用户列表移除
                                    $.each($userItemInfo.children(':not([data-item="' + userItem + '"])'), function () {
                                        htmlStringBuilder.append(this.outerHTML);
                                    });
                                    $userItemInfo.html(htmlStringBuilder.join('，'));
                                    //在项目列表移除
                                    $subscribeTabItem.find('[data-id="' + userName + '"]').remove();
                                    //修改提示语句
                                    params[3] = +params[3] - 1;
                                    params[4] = +params[4] + 1;
                                } else {
                                    //报名
                                    userItemName = $EditUserItem.children(':eq(' + $EditUserItem[0].selectedIndex + ')').text();
                                    //编辑部分添加
                                    $('#subscribeContainer').append(
                                        '<span class="label label-selected" data-item="' + $EditUserItem.val() + '">' + userItemName
                                        + '<button type="button" class="close">×</button></span>');
                                    //在用户列表添加
                                    if ($userItemInfo.children().length > 0) {
                                        $userItemInfo.append(',<span data-item="' + userItem + '">' + userItemName + '</span>');
                                    } else {
                                        $userItemInfo.append('<span data-item="' + userItem + '">' + userItemName + '</span>');
                                    }
                                    //在项目列表添加
                                    $('.panel-body', $subscribeTabItem).append('<p data-id="' + userName + '">' + $('#EditUserNickName', $form).val() + '</p>');
                                    //修改提示语句
                                    params[3] = +params[3] + 1;
                                    params[4] = +params[4] - 1;

                                }
                                //最终修改提示语句
                                console.log(params.length);
                                $('#summaryTips').text('共' + params[0] + '个项目，' + '已报名项目' + $('.panel-body:not(:empty)', $subscibeTab).length + '个。共' + params[2]
                                    + '个名额，使用了' + params[3] + '个名额，还剩' + params[4] + '个名额');
                            } else {
                                str += '失败，' + (result.msg);
                            }
                            return str;
                        });
                    }, null, false, false, $form.children(':eq(1)'));
                }
            });
        });
    </script>
</asp:Content>