<%@ Page Title="赛事管理" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="MatchManageMent.aspx.cs" Inherits="YuQ11.YuQ11Admin.MatchManageMent" %>

<asp:Content ID="MatchContent" ContentPlaceHolderID="MainContent" runat="server">
    <div class="page-header">
        <h1><%: Title %>.</h1>
        <h4>录入选手检录情况、比赛成绩，生成比赛结果。</h4>
    </div>
    <section class="box">
        <ul class="nav nav-tabs">
            <li class="active">
                <a href="#checkInTab" data-toggle="tab" aria-disabled="true">选手检录</a>
            </li>
            <li>
                <a href="#resultLogTab" data-toggle="tab" aria-disabled="true">成绩登记</a>
            </li>
            <li>
                <a href="#matchResultTab" data-toggle="tab" aria-disabled="true">赛事结果</a>
            </li>
        </ul>
        <div class="tab-content">
            <div class="tab-pane fade active in form-horizontal" id="checkInTab" data-role="tab">
                <div class="form-group form-group-sm" data-role="form">
                    <label for="itemList" class="col-lg-1 control-label  col-lg-offset-1">比赛项目</label>
                    <div class="col-lg-3">
                        <select class="form-control" id="checkInItemList" name="itemList" required="required">
                            <option disabled="disabled" selected="selected" value="">请选择…</option>
                        </select>
                        <span class="text-danger" style="visibility: hidden;">请选择比赛项目</span>
                    </div>
                    <div class="col-lg-2">
                        <button type="button" class="btn btn-primary btn-sm" id="checkInBtn" data-action="checkIn">显示</button>
                    </div>
                </div>
                <div  data-role="container">
                    <div class="text-danger" style="visibility: hidden;" data-role="msg">对不起，找不到您要的选手检录信息。</div>
                </div>
            </div>
            <div class="tab-pane fade form-horizontal" id="resultLogTab" data-role="tab">
                <div class="form-group form-group-sm" data-role="form">
                    <label for="itemList" class="col-lg-1 control-label  col-lg-offset-1">比赛项目</label>
                    <div class="col-lg-3">
                        <select class="form-control" id="resultItemList" name="itemList" required="required">
                            <option disabled="disabled" selected="selected" value="">请选择…</option>
                        </select>
                        <span class="text-danger" style="visibility: hidden;">请选择比赛项目</span>
                    </div>
                    <div class="col-lg-2">
                        <button type="button" class="btn btn-primary btn-sm" id="resultLogBtn" data-action="resultLog">显示</button>
                    </div>
                </div>
                <div class="table-responsive" data-role="container">
                    <div class="text-danger" style="visibility: hidden;" data-role="msg">对不起，找不到您要的选手成绩登记信息。</div>
                </div>
            </div>
            <div class="tab-pane fade form-horizontal" id="matchResultTab" data-role="tab">
                <div class="form-group form-group-sm" data-role="form">
                    <label for="itemList" class="col-lg-1 control-label  col-lg-offset-1">比赛项目</label>
                    <div class="col-lg-3">
                        <select class="form-control" id="matchResultItemList" name="itemList" required="required">
                            <option disabled="disabled" selected="selected" value="">请选择…</option>
                            <option value="all">全部</option>
                        </select>
                        <span class="text-danger" style="visibility: hidden;">请选择比赛项目</span>
                    </div>
                    <div class="col-lg-2">
                        <button type="button" class="btn btn-primary btn-sm" id="matchResultBtn" data-action="matchResult">显示</button>
                    </div>
                </div>
                <div class="table-responsive" data-role="container">
                    <div class="text-danger" style="visibility: hidden;" data-role="msg">对不起，找不到您要的比赛结果信息。</div>
                </div>
            </div>
        </div>
    </section>
    <script src="../Static/Scripts/items.js"></script>
    <script>
        $(function () {
            //加载比赛项目部分
            var $itemList = $('#checkInItemList,#resultItemList,#matchResultItemList'),
                htmlString = new StringBuilder(),
                item, insertItem = function (sex, label, htmlString) {
                    htmlString.append('<optgroup label="' + label + '">')
                    for (item in sex) {
                        htmlString.append('<option value="' + item + '">' + sex[item].Name + '</option>');
                    }
                    htmlString.append('</optgroup>');
                    return htmlString;
                };
            htmlString = insertItem(items.Sex0, '男子项目', htmlString);
            htmlString = insertItem(items.Sex1, '女子项目', htmlString);
            $itemList.append(htmlString.toString());

            //显示结果
            $('#checkInBtn,#resultLogBtn,#matchResultBtn').click(function () {
                var $this = $(this);
                ajaxForm($this, $this.closest('[data-role=form]'), 'POST',
                    '&action=' + $this.data('action') + '&collegeID=' + getCookie('yuQ11UserCollegeID') + '&t=' + Math.random(), '', '../Static/getSubscribeList', function (result) {
                        result = $.stringToObject(result);
                        var $container = $this.closest('[data-role=tab]').children('[data-role=container]');
                        $container.children(':not([data-role=msg])').remove();
                        if (!!result && result.status == 'success') {
                            $container.append(result.html);
                            $('div', $container).addClass('table-responsive');
                            $('table', $container).addClass('table table-condensed table-hover table-striped');
                            $container.children('[data-role=msg]').css('visibility', 'hidden');
                        } else {
                            $container.children('[data-role=msg]').css('visibility', 'visible').text(result.msg || '对不起，找不到您要的信息。');
                        }
                        $('html,body').animate({ 'scrollTop': $container.offset().top - 50 }, 1000);
                    }, null, false, false, $this.closest('[data-role=tab]').children('[data-role=container]').children('[data-role=msg]'));
            });

            //检录
            $('#checkInTab').children('[data-role=container]').click(function (e) {
                var $container = $(this),
                    $boxCheckIn,
                    $boxCancelCheckIn,
                    $this = $(e.target || event.srcElement),
                    action, $msgBox, html;
                if ($this[0].tagName === 'A') {
                    action = $this.data('action');
                    $boxCheckIn = $('[data-role=notCheckIn]', $container),
                    $boxCancelCheckIn = $('[data-role=checkIn]', $container),
                    $msgBox = $container.children('[data-role=msg]');
                    ajaxForm($this, $(), 'GET', 'subscribeID=' + $this.data('id') + '&action=' + action, '', '../Static/subscribe', function (result) {
                        result = $.stringToObject(result);
                        if (result.status == 'success') {
                            $msgBox.css('visibility', 'hidden');
                            html = $this.closest('tr')[0].outerHTML;
                            $this.closest('tr').remove();
                            if (action == 'checkIn') {
                                $boxCancelCheckIn.children('p').addClass('hide');
                                $boxCancelCheckIn.children('table').removeClass('hide');
                                $boxCancelCheckIn.find('tbody').append(html.replace(/checkIn/, 'cancelCheckIn').replace('检录','取消检录'));
                                if ($boxCheckIn.find('tbody').children().length < 1) {
                                    $boxCheckIn.children('p').removeClass('hide');
                                    $boxCheckIn.children('table').addClass('hide');
                                }
                            } else {
                                $boxCheckIn.children('p').addClass('hide');
                                $boxCheckIn.children('table').removeClass('hide');
                                $boxCheckIn.find('tbody').append(html.replace(/cancelCheckIn/, 'checkIn').replace('取消检录', '检录'));
                                if ($boxCancelCheckIn.find('tbody').children().length < 1) {
                                    $boxCancelCheckIn.children('p').removeClass('hide');
                                    $boxCancelCheckIn.children('table').addClass('hide');
                                }
                            }
                        } else {
                            $msgBox.text(result.msg || '检录操作失败').css('visibility', 'visible');
                            $.iScrollTo($msgBox);
                        }
                    }, null, false, false, $msgBox);
                }
            });
        });
    </script>
</asp:Content>
