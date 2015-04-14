<%@ Page Title="报名管理" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="SubscribesManagement.aspx.cs" Inherits="YuQ11.YuQ11Admin.SubscribesManagement" %>

<asp:Content ID="ContentContainer" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        .label-selected {
            cursor: pointer;
        }
    </style>
    <div class="page-header">
        <h1><%: Title %>.</h1>
        <h4>查看项目报名情况、生成赛程。</h4>
    </div>
    <div class="well well-sm box">
        <div class="pull-right pull-responsive" id="resetSubscribeContainer" runat="server" visible="false">
            <span class="text-danger"></span>
            <button type="button" class="btn btn-sm btn-danger" id="btnResetSubscribe">清空所有报名</button>
        </div>
        <ul class="nav nav-tabs">
            <li class="active">
                <a href="#selectUnit" data-toggle="tab" aria-disabled="true">选择班级列表</a>
            </li>
            <li>
                <a href="#selectItem" data-toggle="tab" aria-disabled="true">选择项目列表</a>
            </li>
            <li>
                <a href="#matchSchedule" data-toggle="tab" aria-disabled="true">赛事安排</a>
            </li>
            <li>
                <a href="#matchScheduleResult" data-toggle="tab" aria-disabled="true" class="hide">赛事安排预览</a>
            </li>
        </ul>
        <div class="tab-content">
            <div class="tab-pane fade active in form-horizontal" id="selectUnit" data-role="form">
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
                            <option value="all">全部</option>
                        </select>
                        <span class="text-danger" style="visibility: hidden;">请选择班级</span>
                    </div>
                    <div class="col-lg-2">
                        <button type="button" class="btn btn-primary btn-sm" id="selectClassBtn">显示</button>
                    </div>
                </div>
            </div>
            <div class="tab-pane fade form-horizontal" id="selectItem" data-role="form">
                <div class="form-group form-group-sm">
                    <label for="itemList" class="col-lg-1 control-label  col-lg-offset-1">比赛项目</label>
                    <div class="col-lg-3">
                        <select class="form-control" id="itemList" name="itemList" required="required">
                            <option disabled="disabled" selected="selected" value="">请选择…</option>
                            <option value="all">全部</option>
                        </select>
                        <span class="text-danger" style="visibility: hidden;">请选择比赛项目</span>
                    </div>

                    <div class="col-lg-2">
                        <button type="button" class="btn btn-primary btn-sm" id="selectItemBtn">显示</button>
                    </div>
                </div>
            </div>
            <div class="tab-pane fade form-horizontal" id="matchSchedule">
                <h5>请选择赛事项目，系统将根据您选择的顺序及规则生成赛程安排</h5>
            </div>
            <div class="tab-pane fade form-horizontal table-responsive" id="matchScheduleResult">
                <div class="text-right">
                    <span id="pressMatchScheduleMessageBox"></span>
                    <button type="button" class="btn btn-sm btn-primary" id="btnPressMatchSchedule">发布赛事安排</button>
                </div>
                <div id="matchScheduleResultContainer">
                </div>
            </div>
        </div>
    </div>
    <div class="table-responsive box" id="subscribeContainer" style="display: none">
        <div id="noRecord" class="text-danger" style="visibility: hidden;">对不起，找不到您要的报名信息。</div>
        <table class="table table-condensed table-hover table-striped" id="subscribeTable">
            <thead>
                <tr>
                    <td>班级</td>
                    <td>学号</td>
                    <td>姓名</td>
                    <td>报名项目</td>
                    <td>长号</td>
                    <td>短号</td>
                </tr>
            </thead>
            <tbody></tbody>
        </table>
    </div>
    <div class="panel panel-primary" style="display: none" id="matchScheduleContainer">
        <div class="panel-body">
            <div class="text-right">
                <span id="messageBox" class="text-danger"></span>
                <button type="button" class="btn btn-sm btn-primary" id="btnCreateMatchSchedule" disabled="disabled">生成赛程安排</button>
            </div>
            <h5 class="page-header gutter-top">比赛项目</h5>
            <div class="form-horizontal">
                <%--                <div class="form-group form-group-sm">
                    <label class="col-md-2 control-label" for="matchStartTime">比赛开始时间*</label>
                    <div class="col-md-3">
                        <input type="text" name="matchStartTime" id="matchStartTime" class="form-control" data-regex="\d{1,2}:\d{1,2}">
                        <span class="text-danger" style="visibility: hidden;">请输入正确的比赛开始时间</span>
                    </div>
                    <label class="col-md-2 control-label" for="matchBreakTime">比赛休息时间*</label>
                    <div class="col-md-3">
                        <input type="text" name="matchBreakTime" id="matchBreakTime" class="form-control" data-regex="\d{1,2}:\d{1,2}">
                        <span class="text-danger" style="visibility: hidden;">请输入正确的比赛休息时间</span>
                    </div>
                </div>
                <div class="form-group form-group-sm">
                    <label class="col-md-2 control-label" for="matchRestartTime">比赛继续时间*</label>
                    <div class="col-md-3">
                        <input type="text" name="matchRestartTime" id="matchRestartTime" class="form-control" data-regex="\d{1,2}:\d{1,2}">
                        <span class="text-danger" style="visibility: hidden;">请输入正确的比赛继续时间</span>
                    </div>
                </div>--%>
                <div class="col-md-6" id="itemType0"></div>
                <div class="col-md-6" id="itemType1"></div>
            </div>
        </div>
    </div>
    <!--流程中的temp Start-->
    <div id="itemTemp0" class="hide">
        <div class="alert-dismissible">
            <button type="button" class="close pull-right" data-dismiss="alert" data-item="itemIDReplacMent">×</button>
            <h5 class="page-header gutter-top">itemName<label class="pull-right" style="font-weight: normal;"><input type="checkbox" name="preMatch" value="itemIDReplacMent">提前赛</label>
            </h5>
            <input name="itemID" value="itemIDReplacMent" type="hidden" />
            <div class="form-group form-group-sm">
                <label class="col-md-4 control-label" for="racetrack">赛道数*</label>
                <div class="col-md-6">
                    <input type="text" name="racetrack" class="form-control" data-regex="^[1-8]$" value="8">
                    <span class="text-danger" style="visibility: hidden;">请输入赛道数量</span>
                </div>
            </div>
            <div class="form-group form-group-sm">
                <label class="col-md-4 control-label" for="peopleLimit">每组最多人数*</label>
                <div class="col-md-6">
                    <input type="text" name="peopleLimit" class="form-control" data-regex="^([1-9]|([1-9][0-9]))$" value="8">
                    <span class="text-danger" style="visibility: hidden;">请输入每组最多人数</span>
                </div>
            </div>
        </div>
    </div>
    <div id="itemTemp1" class="hide">
        <div class="alert-dismissible">
            <button type="button" class="close pull-right" data-dismiss="alert" data-item="itemIDReplacMent">×</button>
            <h5 class="page-header gutter-top">itemName<label class="pull-right" style="font-weight: normal;"><input type="checkbox" name="preMatch" value="itemIDReplacMent">提前赛</label>
            </h5>
            <input name="itemID" value="itemIDReplacMent" type="hidden" />
        </div>
    </div>
    <!--流程中的temp Start-->
    <script src="../Static/Scripts/units.js"></script>
    <script src="../Static/Scripts/items.js"></script>
    <%--<script src="../Scripts/jquery.datetimepicker.min.js"></script>--%>
    <script>
        //查看部分
        $(function () {
            //禁用回车提交表单
            $('#ctl01').submit(function () { return false; });
            //加载学院、班级部分
            var htmlString = new StringBuilder(),
                $collegeList = $('#collegeList'),
                $classList = $('#classList'),
                $itemList = $('#itemList');

            $collegeList.children(":gt(0)").remove();
            if (!!$collegeList.length) {
                for (var college in colleges) {
                    htmlString.append('<option value="' + college + '">' + colleges[college] + '</option>');
                }
                $collegeList.append(htmlString.toString());
                $collegeList.change(function () {
                    $classList.val('');
                    $classList.children(":gt(1)").remove();
                    htmlString.clear();
                    var singleCollegeClasses = classes[$(this).val()];
                    for (var singleClass in singleCollegeClasses) {
                        htmlString.append('<option value="' + singleClass + '">' + singleCollegeClasses[singleClass] + '</option>');
                    }
                    $classList.append(htmlString.toString());
                });
            } else {
                var singleCollegeClasses = classes[getCookie('yuQ11UserCollegeID')];
                for (var singleClass in singleCollegeClasses) {
                    htmlString.append('<option value="' + singleClass + '">' + singleCollegeClasses[singleClass] + '</option>');
                }
                $classList.append(htmlString.toString());
            }

            //加载比赛项目部分
            var item, insertItem = function (sex, label, htmlString) {
                htmlString.append('<optgroup label="' + label + '">')
                for (item in sex) {
                    htmlString.append('<option value="' + item + '">' + sex[item].Name + '</option>');
                }
                htmlString.append('</optgroup>');
                return htmlString;
            }
            htmlString.clear();
            htmlString = insertItem(items.Sex0, '男子项目', htmlString);
            htmlString = insertItem(items.Sex1, '女子项目', htmlString);
            $itemList.append(htmlString.toString());

            //点击显示
            var $subscribeContainer = $('#subscribeContainer');
            $('#selectClassBtn,#selectItemBtn').click(function () {
                ajaxForm($(this), $(this).closest('[data-role="form"]'), 'POST', '&collegeID=' + getCookie('yuQ11UserCollegeID') + '&t=' + Math.random(), '', '../Static/getSubscribeList', function (result) {
                    result = $.stringToObject(result);
                    $subscribeContainer.slideDown();
                    if (!!result && result.status == 'success') {
                        $('tbody', '#subscribeTable').html(result.html);
                        $subscribeContainer.children(':eq(0)').css('visibility', 'hidden');
                        $subscribeContainer.children(':eq(1)').show();
                    } else {
                        $subscribeContainer.children(':eq(0)').text(result.msg || '对不起，找不到您要的报名信息。').css('visibility', 'visible');
                        $subscribeContainer.children(':eq(1)').hide();
                    }
                    $('html,body').animate({ 'scrollTop': $subscribeContainer.offset().top - 50 }, 1000);
                }, null, false, false, $subscribeContainer.children(':eq(0)'));
            });

            //重置报名
            $('#btnResetSubscribe').click(function () {
                var $this = $(this);
                ajaxForm($this, $(), 'POST', 'action=resetSubscribe&collegeID='+getCookie('yuQ11UserCollegeID'), '', '../Static/subscribe', function (result) {
                    result = $.stringToObject(result);
                    if (result.status == 'success') {
                        $this.prev().text(result.msg || '清空成功！');
                    } else {
                        $this.prev().text(result.msg || '清空失败！');
                    }
                }, null, false, false, $this.prev());
            });
        });
        //生成报表部分
        $(function () {
            //隐藏查看部分、显示生成部分
            $('.nav-tabs a').click(function () {
                if ($(this).text() == '赛事安排预览') {
                    $('#subscribeContainer').slideUp();
                    $('#matchScheduleContainer').slideUp();
                } else if ($(this).text() == '赛事安排') {
                    $('#subscribeContainer').slideUp();
                    $('#matchScheduleContainer').slideDown();
                } else {
                    $('#subscribeContainer').slideDown();
                    $('#matchScheduleContainer').slideUp();
                }
            });
            //加载项目到赛事安排中
            var htmlString = new StringBuilder(),
                item, totalItems = 0, insertItem = function (sex, label, htmlString) {
                    htmlString.append('<div class="panel panel-primary"><div class="panel-heading">' + label + '</div><div class="panel-body">')
                    for (item in sex) {
                        totalItems++;
                        htmlString.append('<span class="label label-selected" data-item="' + item + '" data-type="' + sex[item].Type + '">' + sex[item].Name + '</span>');
                    }
                    htmlString.append('</div></div>');
                    return htmlString;
                }
            htmlString = insertItem(items.Sex0, '男子项目', htmlString);
            htmlString = insertItem(items.Sex1, '女子项目', htmlString);
            $('#matchSchedule').append(htmlString.toString());

            //开始，结束时间绑定时间插件
            //$('#matchStartTime,#matchBreakTime,#matchRestartTime').datetimepicker({
            //    lang: 'ch',
            //    autoclose: true,
            //    datepicker: false,
            //    timepicker: true,
            //    format: 'H:i',
            //    step: 10
            //}).blur(function () { $(this).trigger('change') });

            //选择赛事项目时加入到流程中
            var $matchSchedule = $('#matchSchedule'),
                $itemType0 = $('#itemType0'),
                $itemType1 = $('#itemType1'),
                itemTemp0 = $('#itemTemp0').html(),
                itemTemp1 = $('#itemTemp1').html(),
                replaceFunc = function ($elem, temp, $this) {
                    $elem.append(temp.replace('itemName', $this.text()).replace(/itemIDReplacMent/g, $this.data('item')));
                };
            $matchSchedule.click(function (e) {
                var $this = $(e.target || window.event.srcElement);
                if ($this.hasClass('label-selected')) {
                    $this.addClass('hide');
                    if ($this.data('type') == '径赛') {
                        replaceFunc($itemType0, itemTemp0, $this);
                    } else {
                        replaceFunc($itemType1, itemTemp1, $this);
                    }
                    if ($('.hide', $matchSchedule).length == totalItems) {
                        $('#btnCreateMatchSchedule').removeAttr('disabled');
                    }
                }
            });

            //删除的时候在选择区域显示
            $('#itemType0,#itemType1').click(function (e) {
                var $this = $(e.target || window.event.srcElement);
                if ($this.hasClass('close')) {
                    $('[data-item=' + $this.data('item') + ']', $matchSchedule).removeClass('hide');
                    $('#btnCreateMatchSchedule').attr('disabled', 'disabled');
                }
            });

            //点击生成赛程安排按钮
            $('#btnCreateMatchSchedule').click(function () {
                var extraData = new StringBuilder(),
                    $matchScheduleContainer = $('#matchScheduleContainer'),
                    $messageBox = $('#messageBox'),
                    getValueIntoString = function (selector) {
                        var array = new Array();
                        $.each($matchScheduleContainer.find(selector), function () {
                            array.push(this.value);
                        });
                        return array;
                    };
                if ($.checkFormRequired($matchSchedule) && $.checkFormRegex($matchScheduleContainer)) {
                    //学院ID
                    extraData.append('collegeID=' + getCookie('yuQ11UserCollegeID'));
                    //基本信息
                    //extraData.append('matchStartTime=' + $('#matchStartTime').val());
                    //extraData.append('matchBreakTime=' + $('#matchBreakTime').val());
                    //extraData.append('matchRestartTime=' + $('#matchRestartTime').val());
                    //提前赛
                    extraData.append('preMatch=' + getValueIntoString(':checked').join(','));
                    //竞赛顺序
                    extraData.append('matchOrder=' + getValueIntoString('[name=itemID]').join(','));
                    //赛道数
                    extraData.append('racetrack=' + getValueIntoString('[name=racetrack]').join(','));
                    //每组最多人数
                    extraData.append('peopleLimit=' + getValueIntoString('[name=peopleLimit]').join(','));

                    ajaxForm($(this), $(), 'POST', extraData.join('&'), '', '../Static/createMatchSchedule', function (result) {
                        $messageBox.hide();
                        var $matchScheduleResult = $('#matchScheduleResultContainer');
                        $('[href="#matchScheduleResult"]').removeClass('hide').trigger('click');
                        $matchScheduleResult.html(result);
                        $matchScheduleResult.find('h4').addClass('pager-header');
                        $matchScheduleResult.find('table').addClass('table table-bordered');
                        $matchScheduleResult.find('table,p').addClass('collapse');
                        $matchScheduleResult.find('[colspan]').addClass('text-center');
                        $matchScheduleResult.find('blockquote').click(function () {
                            $(this).next().collapse('toggle');
                        }).css('cursor', 'pointer');
                    }, null, false, false, $messageBox);
                }

            });

            //发布赛程安排
            $('#btnPressMatchSchedule').click(function () {
                $('#pressMatchScheduleMessageBox').text();
                ajaxForm($(this), $('#editNewsTab'), 'POST',
                    '&userID=' + getCookie('yuQ11UserName') +
                    '&collegeID=' + getCookie('yuQ11UserCollegeID') +
                    '&newsTitle='+(new Date()).getYear()+'年运动会赛程安排'+
                    '&newsContent=' + encodeURIComponent(
                    $('#matchScheduleResultContainer').html().
                    replace(/collapse/g, "").
                    replace(/&lt;/g, '&lessThan;').
                    replace(/&gt;/g, '&greatThan;').
                    replace(/</g, '&lt;').
                    replace(/>/g, '&gt;')) ,
                    '', '../Static/editNews', function (result) {
                        result = $.stringToObject(result);
                        if (!!result && result.status == 'success') {
                            location.href = '../News/' + result.id;
                        } else {
                            $('#pressMatchScheduleMessageBox').text('发布失败', result.msg || '无法访问服务器');
                        }
                    }, null, false, true, $('#pressMatchScheduleMessageBox'));
            });
        });
    </script>
</asp:Content>
