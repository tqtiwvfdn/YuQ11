<%@ Page Title="赛事项目管理" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ItemManagement.aspx.cs" Inherits="YuQ11.YuQ11Admin.ItemManagement" %>

<asp:Content ID="ContentContainer" ContentPlaceHolderID="MainContent" runat="server">
    <div class="page-header">
        <h1><%: Title %>.</h1>
        <h4>添加、删除运动会项目，或编辑已有的运动会项目。</h4>
    </div>
    <div class="text-right pull-right pull-responsive">
        <span id="messageBox" class="text-danger"></span>
        <button type="button" class="btn btn-sm btn-primary" id="refreshItems">刷新赛事项目</button>
    </div>
    <ul class="nav nav-tabs">
        <li class="active">
            <a href="#itemsTab" data-toggle="tab" aria-expanded="true">现有项目</a>
        </li>
        <li>
            <a href="#addItemTab" data-toggle="tab" aria-disabled="true">添加项目</a>
        </li>
        <li>
            <a href="#editItemTab" data-toggle="tab" aria-disabled="true" class="hide" id="editItemLink">编辑项目</a>
        </li>
    </ul>
    <div class="tab-content">
        <div class="tab-pane fade active in table-responsive" id="itemsTab">
            <table class="table table-condensed table-hover table-striped">
                <thead>
                    <tr>
                        <td>项目名</td>
                        <td>项目类别</td>
                        <td>获奖范围</td>
                        <td>报名人数限制（人）</td>
                        <td>场地</td>
                        <td>是否有预赛</td>
                        <td>项目独立性</td>
                    </tr>
                </thead>
                <tbody></tbody>
            </table>
        </div>
        <div class="tab-pane fade form-horizontal" id="addItemTab" data-role="form">
            <p class="text-danger col-md-offset-2" style="visibility: hidden;">创建失败！</p>
            <div class="form-group form-group-sm">
                <label class="col-md-2 control-label" for="ItemName">项目名称*</label>
                <div class="col-md-3">
                    <input type="text" name="ItemName" id="ItemName" class="form-control" required="required" />
                    <span class="text-danger" style="visibility: hidden;">请输入项目名称</span>
                </div>
                <label class="col-md-2 control-label" for="ItemSex">项目范围*</label>
                <div class="col-md-3">
                    <select class="form-control" id="ItemSex" required="required">
                        <option value="" selected="selected" disabled="disabled">请选择…</option>
                        <option value="0">男</option>
                        <option value="1">女</option>
                    </select>
                    <span class="text-danger" style="visibility: hidden;">请选择项目范围</span>
                </div>
            </div>
            <div class="form-group form-group-sm">
                <label class="col-md-2 control-label" for="ItemType">项目类别*</label>
                <div class="col-md-3">
                    <select class="form-control" id="ItemType" required="required">
                        <option value="" selected="selected" disabled="disabled">请选择…</option>
                        <option value="0">径赛</option>
                        <option value="1">田赛</option>
                    </select>
                    <span class="text-danger" style="visibility: hidden;">请选择项目类别</span>
                </div>
                <label class="col-md-2 control-label" for="ItemRange">获奖范围*</label>
                <div class="col-md-3">
                    <select class="form-control" id="ItemRange" required="required">
                        <option value="" selected="selected" disabled="disabled">请选择…</option>
                        <option value="1-8">前8</option>
                        <option value="1-5">前5</option>
                        <option value="1-3">前3</option>
                    </select>
                    <span class="text-danger" style="visibility: hidden;">请选择获奖范围</span>
                </div>
            </div>
            <div class="form-group form-group-sm">
                <label class="col-md-2 control-label" for="ItemPlace">报名人数限制（人）*</label>
                <div class="col-md-3">
                    <input type="text" name="ItemPlace" id="ItemPlace" class="form-control" data-regex="^[1-9]$" />
                    <span class="text-danger" style="visibility: hidden;">请填写正确的报名人数限制人数</span>
                </div>
                <label class="col-md-2 control-label" for="ItemSite">比赛地点*</label>
                <div class="col-md-3">
                    <select class="form-control" id="ItemSite" required="required" name="ItemSite">
                        <option value="" selected="selected" disabled="disabled">请选择…</option>
                        <option value="跑道">跑道</option>
                        <option value="跳高台">跳高台</option>
                        <option value="男子跳远区">男子跳远区</option>
                        <option value="女子跳远区">女子跳远区</option>
                    </select>
                    <span class="text-danger" style="visibility: hidden;">请选择比赛地点</span>
                </div>
            </div>
            <div class="form-group form-group-sm">
                <label class="col-md-2 control-label" for="IsPreliminaries">是否有预赛*</label>
                <div class="col-md-3">
                    <select class="form-control" id="IsPreliminaries" required="required" name="IsPreliminaries">
                        <option value="" selected="selected" disabled="disabled">请选择…</option>
                        <option value="true">是</option>
                        <option value="false">否</option>
                    </select>
                    <span class="text-danger" style="visibility: hidden;">请选择是否有预赛</span>
                </div>
                <label class="col-md-2 control-label" for="IsLimit">项目独立性</label>
                <div class="col-md-3">
                    <select class="form-control" id="IsLimit" name="IsLimit">
                        <option value="true">受限于每人限报项目数</option>
                        <option value="false">不受每人限报项目数限制</option>
                    </select>
                    <span class="text-danger" style="visibility: hidden;">请选择项目独立性</span>
                </div>
            </div>
            <div class="form-group form-group-sm">
                <div class="col-md-offset-7 col-md-2">
                    <button class="btn btn-primary" id="addItemBtn" type="button">添加项目</button>
                </div>
            </div>
        </div>
        <div class="tab-pane fade form-horizontal" id="editItemTab" data-role="form">
            <p class="text-danger col-md-offset-2" style="visibility: hidden;">修改失败！</p>
            <input type="hidden" name="ItemID" id="EditItemID" value="" />
            <div class="form-group form-group-sm">
                <label class="col-md-2 control-label" for="EditItemName">项目名称*</label>
                <div class="col-md-3">
                    <input type="text" name="ItemName" id="EditItemName" class="form-control" required="required" />
                    <span class="text-danger" style="visibility: hidden;">请输入项目名称</span>
                </div>
                <label class="col-md-2 control-label" for="EditItemSex">项目范围*</label>
                <div class="col-md-3">
                    <select class="form-control" id="EditItemSex" name="ItemSex" required="required">
                        <option value="" selected="selected" disabled="disabled">请选择…</option>
                        <option value="0">男</option>
                        <option value="1">女</option>
                    </select>
                    <span class="text-danger" style="visibility: hidden;">请选择项目范围</span>
                </div>
            </div>
            <div class="form-group form-group-sm">
                <label class="col-md-2 control-label" for="EditItemType">项目类别*</label>
                <div class="col-md-3">
                    <select class="form-control" id="EditItemType" name="ItemType" required="required">
                        <option value="" selected="selected" disabled="disabled">请选择…</option>
                        <option value="0">径赛</option>
                        <option value="1">田赛</option>
                    </select>
                    <span class="text-danger" style="visibility: hidden;">请选择项目类别</span>
                </div>
                <label class="col-md-2 control-label" for="EditItemRange">获奖范围*</label>
                <div class="col-md-3">
                    <select class="form-control" id="EditItemRange" name="ItemRange" required="required">
                        <option value="" selected="selected" disabled="disabled">请选择…</option>
                        <option value="1-8">前8</option>
                        <option value="1-5">前5</option>
                        <option value="1-3">前3</option>
                    </select>
                    <span class="text-danger" style="visibility: hidden;">请选择获奖范围</span>
                </div>
            </div>
            <div class="form-group form-group-sm">
                <label class="col-md-2 control-label" for="EditItemPlace">报名人数限制（人）*</label>
                <div class="col-md-3">
                    <input type="text" name="ItemPlace" id="EditItemPlace" class="form-control" data-regex="^[1-9]$" />
                    <span class="text-danger" style="visibility: hidden;">请填写正确的报名人数限制人数</span>
                </div>
                <label class="col-md-2 control-label" for="ItemSite">比赛地点*</label>
                <div class="col-md-3">
                    <select class="form-control" id="EditItemSite" required="required" name="ItemSite">
                        <option value="" selected="selected" disabled="disabled">请选择…</option>
                        <option value="跑道">跑道</option>
                        <option value="跳高台">跳高台</option>
                        <option value="男子跳远区">男子跳远区</option>
                        <option value="女子跳远区">女子跳远区</option>

                    </select>
                    <span class="text-danger" style="visibility: hidden;">请选择比赛地点</span>
                </div>
            </div>
            <div class="form-group form-group-sm">
                <label class="col-md-2 control-label" for="IsPreliminaries">是否有预赛*</label>
                <div class="col-md-3">
                    <select class="form-control" id="EditIsPreliminaries" required="required" name="IsPreliminaries">
                        <option value="" selected="selected" disabled="disabled">请选择…</option>
                        <option value="true">是</option>
                        <option value="false">否</option>
                    </select>
                    <span class="text-danger" style="visibility: hidden;">请选择是否有预赛</span>
                </div>
                <label class="col-md-2 control-label" for="IsLimit">项目独立性</label>
                <div class="col-md-3">
                    <select class="form-control" id="EditIsLimit" name="IsLimit">
                        <option value="true">受限于每人限报项目数</option>
                        <option value="false">不受每人限报项目数限制</option>
                    </select>
                    <span class="text-danger" style="visibility: hidden;">请选择项目独立性</span>
                </div>
            </div>
            <div class="form-group form-group-sm">
                <div class="col-md-offset-7 col-md-3 btn-group">
                    <button class="btn btn-primary" id="editItemBtn" type="button">保存修改</button>
                    <button class="btn btn-danger" id="deleteItemBtn" type="button">删除项目</button>
                </div>
            </div>
        </div>
    </div>
    <script src="../Static/Scripts/items.js"></script>
    <script>
        $(function () {
            //阻止回车时提交表单
            $('#ctl01').submit(function () {
                return false;
            });
            loadItems();
            //刷新赛事项目
            $('#refreshItems').click(function () {
                ajaxForm($(this), $(), 'GET', '', '', '../Static/writerSportItems', function (result) {
                    location.reload(true);
                }, null, false, false, $('#messageBox'));
            });
            //创建Item
            $('#addItemBtn').click(function () {
                var $form = $(this).closest('[data-role="form"]');
                ajaxForm($(this), $form, 'GET', '', null, '../Static/writerSportItems', function (data) {
                    data = $.stringToObject(data);
                    if (!!data && data.id > 0) {
                        var $tbody = $("tbody", $("#itemsTab")),
                            itemHtml = '<tr class="success" data-id="' + data.id + '"><td>' +
                            ($('#ItemSex', $form).val() == 0 ? '男子' : '女子') +
                            ($.trim($('#ItemName', $form).val()).replace(/^[男女][子]/, '')) + '</td><td>' +
                            ($('#ItemType', $form).val() == 0 ? '径' : '田') + '赛</td><td>' +
                            $('#ItemRange', $form).val() + '</td><td>' +
                            $('#ItemPlace', $form).val() + '</td><td>' +
                            $('#ItemSite', $form).val() + '</td><td>' +
                            ($('#IsPreliminaries', $form).val() == 'true' ? '是' : '否') + '</td><td>' +
                            ($('#IsLimit', $form).val() == 'true' ? '受限于每人限报项目数' : '不受每人限报项目数限制') + '</td></tr>';
                        $tbody.children().removeClass('success');
                        $tbody.append(itemHtml);
                        $('a[href="#itemsTab"]').trigger('click');
                        $('html,body').animate({ scrollTop: $('footer').offset().top + 1000 }, 2000);
                        $.resetFormData($form);
                    } else {
                        $form.children(':eq(0)').css('visibility', 'visible').text(data.msg || '创建失败');
                        $(':input', $form).change(function () {
                            $form.children(':eq(0)').css('visibility', 'hidden');
                        });
                    }
                }, null, false, true, $form.children(':eq(0)'));
            });
            //编辑Item
            $('#editItemBtn').click(function () {
                $form = $(this).closest('[data-role="form"]');
                ajaxForm($(this), $form, 'GET', '&opr=edit', null, '../Static/writerSportItems', function (data) {
                    data = $.stringToObject(data);
                    if (!!data && data.id > 0) {
                        var itemHtml = '<td>' +
                            ($('#EditItemSex', $form).val() == 0 ? '男子' : '女子') +
                            ($.trim($('#EditItemName', $form).val()).replace(/^[男女][子]/, '')) + '</td><td>' +
                            ($('#EditItemType', $form).val() == 0 ? '径' : '田') + '赛</td><td>' +
                            $('#EditItemRange', $form).val() + '</td><td>' +
                            $('#EditItemPlace', $form).val() + '</td><td>' +
                            $('#EditItemSite', $form).val() + '</td><td>' +
                            ($('#EditIsPreliminaries', $form).val() == 'true' ? '是' : '否') + '</td><td>' +
                            ($('#EditIsLimit', $form).val() == 'true' ? '受限于每人限报项目数' : '不受每人限报项目数限制') + '</td></tr>';
                        $tbody.children().removeClass('success');
                        $tr[0].innerHTML = itemHtml;
                        $('a[href="#itemsTab"]').trigger('click');
                        $tr.addClass('success');
                        $.resetFormData($form);
                        window.setTimeout(function () {
                            $('html,body').animate({ scrollTop: $tr.offset().top - 80 }, 1000);
                        }, 500);
                    } else {
                        $form.children(':eq(0)').css('visibility', 'visible').text(data.msg || '修改失败');
                        $(':input', $form).change(function () {
                            $form.children(':eq(0)').css('visibility', 'hidden');
                        });
                    }
                }, null, false, true, $form.children(':eq(0)'));

            });
            $('#deleteItemBtn').click(function () {
                var $form = $(this).closest('[data-role="form"]');
                ajaxForm($(this), $form, 'GET', '&opr=del', null, '../Static/writerSportItems', function (data) {
                    data = $.stringToObject(data);
                    if (!!data && data.id > 0) {
                        $('a[href="#itemsTab"]').trigger('click');
                        $tbody.children().removeClass('success');
                        $tr.addClass('danger');
                        $.resetFormData($form);
                        window.setTimeout(function () {
                            $('html,body').animate({ scrollTop: $tr.offset().top - 80 }, 1000, function () {
                                $tr.fadeOut(1000).remove();
                            });
                        }, 500);
                    } else {
                        $form.children(':eq(0)').css('visibility', 'visible').text(data.msg || '删除失败');
                        $(':input', $form).change(function () {
                            $form.children(':eq(0)').css('visibility', 'hidden');
                        });
                    }
                }, null, false, false, $form.children(':eq(0)'));
            });
        });
        var $tr = {}, $tbody = $("tbody", $("#itemsTab"));
        function loadItems() {
            var itemsHtml = "", item, sex, prop, p;
            for (p in items) {
                sex = items[p];
                for (prop in sex) {
                    itemsHtml +=
                        '<tr data-id="' + prop + '"><td>'
                        + sex[prop].Name + '</td><td>'
                        + sex[prop].Type + '</td><td>'
                        + sex[prop].Range + '</td><td>'
                        + sex[prop].Place + '</td><td>'
                        + sex[prop].Site + '</td><td>'
                        + (sex[prop].IsPreliminaries == true ? '是' : '否') + '</td><td>'
                        + (sex[prop].IsLimit == true ? '受限于每人限报项目数' : '不受每人限报项目数限制') + '</td></tr>';
                }
            }
            $tbody.append(itemsHtml);
            $tbody.click(function (e) {
                e = e.target || window.event.srcElement;
                $tr = $(e).closest('tr');
                var str = $tr.html().replace(/<td>/g, '').split('</td>');
                $('#EditItemID').val($tr.attr('data-id'));
                $('#EditItemName').val(str[0].substr(2));
                $('#EditItemSex').val((str[0].substr(0, 1) == '男' ? 0 : 1));
                $('#EditItemType').val((str[1] == '径赛' ? 0 : 1));
                $('#EditItemRange').val(str[2]);
                $('#EditItemPlace').val(str[3]);
                $('#EditItemSite').val(str[4]);
                $('#EditIsPreliminaries').val((str[5] == '是' ? 'true' : 'false'));
                $('#EditIsLimit').val((str[6] == '受限于每人限报项目数' ? 'true' : 'false'));
                $('#editItemLink').removeClass('hide').trigger('click');
            });
            $('.nav-tabs').click(function (e) {
                e = $(e.target || window.event.srcElement)[0];
                if (e.tagName.toLowerCase() == 'a' && e.id != 'editItemLink') {
                    $('#editItemLink').addClass('hide');
                }
            });
        }
    </script>
</asp:Content>
