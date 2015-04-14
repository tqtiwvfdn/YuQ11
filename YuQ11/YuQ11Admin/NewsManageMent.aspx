<%@ Page Title="新闻发布" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="NewsManageMent.aspx.cs" Inherits="YuQ11.YuQ11Admin.NewsManageMent" %>

<asp:Content ID="NewContent" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        #newsContentContainer div[data-role="editor-toolbar"] {
            -webkit-user-select: none;
            -moz-user-select: none;
            -ms-user-select: none;
            user-select: none;
        }

        #newsContentContainer .dropdown-menu a {
            cursor: pointer;
        }

        #editor {
            max-height: 400px;
            height: 400px;
            background-color: white;
            border-collapse: separate;
            border: 1px solid rgb(204, 204, 204);
            padding: 1em;
            box-sizing: content-box;
            -webkit-box-shadow: rgba(0, 0, 0, 0.0745098) 0px 1px 1px 0px inset;
            box-shadow: rgba(0, 0, 0, 0.0745098) 0px 1px 1px 0px inset;
            overflow: auto;
            outline: none;
        }

            #editor img {
                display: block;
                max-width: 60%;
                margin: 0 auto;
            }

        #voiceBtn {
            width: 20px;
            color: transparent;
            background-color: transparent;
            transform: scale(2.0, 2.0);
            -webkit-transform: scale(2.0, 2.0);
            -moz-transform: scale(2.0, 2.0);
            border: transparent;
            cursor: pointer;
            box-shadow: none;
            -webkit-box-shadow: none;
        }
    </style>
    <div class="page-header">
        <h1><%: Title %>.</h1>
        <h4>发布新闻，报名消息，比赛消息、结果等。</h4>
    </div>
    <div class="text-right pull-right pull-responsive">
        <button type="button" class="btn btn-sm btn-primary" id="createNews"><span class="icon-plus"></span>&nbsp;&nbsp;新建新闻</button>
        <button type="button" class="btn btn-sm btn-danger hide" id="deleteNews"><span class="icon-remove"></span>&nbsp;&nbsp;删除新闻</button>
    </div>
    <ul class="nav nav-tabs">
        <li class="active">
            <a href="#newsTab" data-toggle="tab" aria-expanded="true">新闻列表</a>
        </li>
        <li>
            <a href="#editNewsTab" data-toggle="tab" aria-disabled="true">新建/编辑新闻</a>
        </li>
    </ul>
    <div class="tab-content">
        <div class="tab-pane fade active in table-responsive" id="newsTab">
            <div id="noRecord" class="text-danger" style="visibility: hidden;">暂无新闻纪录。</div>
            <table class="table table-condensed table-hover table-striped">
                <thead>
                    <tr>
                        <td>新闻标题</td>
                        <td>新闻创建日期</td>
                        <td>作者</td>
                        <td>操作</td>
                    </tr>
                </thead>
                <tbody></tbody>
            </table>
        </div>
        <div class="tab-pane fade form-horizontal" data-role="form" id="editNewsTab">
            <div id="errorMsg" class="text-danger" style="visibility: hidden">不知名错误</div>
            <div class="form-group form-group-sm">
                <label class="col-md-2 control-label" for="newsTitle">新闻标题*</label>
                <div class="col-md-9">
                    <input type="text" id="newsTitle" name="newsTitle" class="form-control" data-regex="^.{5,25}$" />
                    <span class="text-danger" style="visibility: hidden;">请用5-25个字简单扼要，清楚地描述新闻内容</span>
                </div>
            </div>
            <div class="form-group form-group-sm">
                <label class="col-md-2 control-label" for="newsContent">新闻内容*</label>
                <div id="newsContentContainer" class="col-md-9">
                    <div class="btn-toolbar" data-role="editor-toolbar" data-target="#editor" id="editToolbar">
                        <div class="btn-group">
                            <a class="btn btn-transparent dropdown-toggle" data-toggle="dropdown" title="字体" data-role="font"><i class="icon-font"></i><b class="caret"></b></a>
                            <ul class="dropdown-menu"></ul>
                        </div>
                        <div class="btn-group">
                            <a class="btn btn-transparent dropdown-toggle" data-toggle="dropdown" title="字体大小"><i class="icon-text-height"></i>&nbsp;<b class="caret"></b></a>
                            <ul class="dropdown-menu">
                                <li><a data-edit="fontSize 6"><span style="font-size: 3.5rem;">特大</span></a></li>
                                <li><a data-edit="fontSize 5"><span style="font-size: 2.5rem;">大</span></a></li>
                                <li><a data-edit="fontSize 3"><span style="font-size: 1.5rem;">中</span></a></li>
                                <li><a data-edit="fontSize 1"><span style="font-size: 1rem;">小</span></a></li>
                            </ul>
                        </div>
                        <div class="btn-group">
                            <a class="btn btn-transparent dropdown-toggle" data-toggle="dropdown" title="字体颜色"><i class="icon-tint"></i>&nbsp;<b class="caret"></b></a>
                            <ul class="dropdown-menu">
                                <li><a data-edit="foreColor #000000"><span style="color: #000000;">黑色</span></a></li>
                                <li><a data-edit="foreColor #2fa4e7"><span style="color: #2fa4e7;">浅蓝色</span></a></li>
                                <li><a data-edit="foreColor #0066FF"><span style="color: #0066FF;">深蓝色</span></a></li>
                                <li><a data-edit="foreColor #73a839"><span style="color: #73a839;">绿色</span></a></li>
                                <li><a data-edit="foreColor #ff6707"><span style="color: #ff6707;">橙色</span></a></li>
                                <li><a data-edit="foreColor #FF0000"><span style="color: #FF0000;">红色</span></a></li>
                            </ul>
                        </div>
                        <div class="btn-group">
                            <a class="btn btn-transparent" data-edit="bold" title="加粗(Ctrl/Cmd+B)"><i class="icon-bold"></i></a>
                            <a class="btn btn-transparent" data-edit="italic" title="倾斜(Ctrl/Cmd+I)"><i class="icon-italic"></i></a>
                            <a class="btn btn-transparent" data-edit="strikethrough" title="删除线"><i class="icon-strikethrough"></i></a>
                            <a class="btn btn-transparent" data-edit="underline" title="下划线(Ctrl/Cmd+U)"><i class="icon-underline"></i></a>
                        </div>
                        <div class="btn-group">
                            <a class="btn btn-transparent" data-edit="insertunorderedlist" title="项目符号"><i class="icon-list-ul"></i></a>
                            <a class="btn btn-transparent" data-edit="insertorderedlist" title="编号"><i class="icon-list-ol"></i></a>
                            <a class="btn btn-transparent" data-edit="indent" title="增加缩进量(Tab)"><i class="icon-indent-right"></i></a>
                            <a class="btn btn-transparent" data-edit="outdent" title="减少缩进量(Shift+Tab)"><i class="icon-indent-left"></i></a>
                        </div>
                        <div class="btn-group">
                            <a class="btn btn-transparent" data-edit="justifyleft" title="文本左对齐(Ctrl/Cmd+L)"><i class="icon-align-left"></i></a>
                            <a class="btn btn-transparent" data-edit="justifycenter" title="居中(Ctrl/Cmd+E)"><i class="icon-align-center"></i></a>
                            <a class="btn btn-transparent" data-edit="justifyright" title="文本右对齐(Ctrl/Cmd+R)"><i class="icon-align-right"></i></a>
                            <a class="btn btn-transparent" data-edit="justifyfull" title="分散对齐(Ctrl/Cmd+J)"><i class="icon-align-justify"></i></a>
                        </div>
                        <div class="btn-group form-horizontal">
                            <a class="btn btn-transparent dropdown-toggle" data-toggle="dropdown" title="插入超链接"><i class="icon-link"></i></a>
                            <div class="dropdown-menu form-group" style="width: 400px;">
                                <div class="col-lg-8">
                                    <input class="form-control input-sm" placeholder="地址" type="text" data-edit="createLink" />
                                </div>
                                <button class="btn btn-primary btn-sm col-xs-3" type="button">添加</button>
                            </div>
                            <a class="btn btn-transparent" data-edit="unlink" title="移除超链接"><i class="icon-cut"></i></a>
                        </div>

                        <div class="btn-group">
                            <a class="btn btn-transparent " title="插入或拉拽图片" id="pictureBtn"><i class="icon-picture"></i></a>
                            <input type="file" data-role="magic-overlay" data-target="#pictureBtn" data-edit="insertImage" style="opacity: 0;" />
                        </div>
                        <div class="btn-group pull-right">
                            <a class="btn btn-transparent" data-edit="undo" title="撤销(Ctrl/Cmd+Z)"><i class="icon-undo"></i></a>
                            <a class="btn btn-transparent" data-edit="redo" title="重做(Ctrl/Cmd+Y)"><i class="icon-repeat"></i></a>
                        </div>
                        <input type="text" data-edit="inserttext" id="voiceBtn" x-webkit-speech="">
                    </div>
                    <div id="editor"></div>
                    <span class="text-danger" style="visibility: hidden;">请输入新闻内容</span>
                </div>
            </div>
            <%--附件<div class="form-group form-group-sm">
            <label class="col-md-2 control-label" for="attachmentName">附件</label>
            <div class="col-md-10">
                <div class=""></div>
            </div>
        </div>--%>
            <div class="form-group form-group-sm">
                <div class="col-md-offset-2 col-md-10 gutter-top">
                    <button type="button" class="btn btn-primary" id="btnPressNews">发布</button>
                    <input type="hidden" id="newsID" name="newsID" />
                </div>
            </div>
        </div>
    </div>
    <script src="../Scripts/jquery.hotkeys.js"></script>
    <script src="../Scripts/prettify.js"></script>
    <script src="../Scripts/bootstrap-wysiwyg.js"></script>
    <script>
        $(function () {
            //新建新闻稿件
            $('#createNews').click(function () {
                $('[href="#editNewsTab"]').trigger('click');
                $('#newsTitle').focus();
                $.resetFormData($('#editNewsTab'));
                $('#editor').html('');
            });
            //删除新闻稿件
            $('#deleteNews').click(function () {
                $('[href="#newsTab"]').trigger('click');
                delNews($('#newsID').val(), $('#noRecord'),$('tbody', '#newsTab'), $('[data-id=' + $('#newsID').val() + ']'));
            });
            //删除新闻稿件外置函数
            function delNews(newsID, $noRecord,$newsList,$tr) {
                ajaxForm($(this), $(), 'POST', 'opt=del&newsID=' + newsID + '&collegeID=' + getCookie('yuQ11UserCollegeID'), '', '../Static/editNews', function (delResult) {
                    delResult = $.stringToObject(delResult);
                    if (!!delResult && delResult.status == 'success') {
                        $newsList.children().removeClass('success');
                        $tr.addClass('danger');
                        $noRecord.css('visibility', 'visible').text('删除“' + $tr.children(':eq(0)').text() + '”成功。');
                        $('html,body').animate({ scrollTop: $tr.offset().top - 80 }, 1000, function () {
                            $tr.fadeOut(1000).remove();
                            $.resetFormData($('#editNewsTab'));
                            $('#editor').html('');
                        });
                    } else {
                        $noRecord.css('visibility', 'visible').text('删除“' + $tr.children(0).text() + '”失败' + (!!result ? delResult.msg : '。'));
                    }
                }, null, false, false, $noRecord);
            }
            //编辑新闻外置函数
            function editNews(newsID, $noRecord, $editNewsTab) {
                ajaxForm($(this), $(), 'POST', 'newsID=' + newsID, '', '../Static/getNews', function (editResult) {
                    editResult = $.stringToObject(editResult);
                    if (!!editResult && editResult.status == 'success') {
                        $('#deleteNews').removeClass('hide');
                        $noRecord.css('visibility', 'hidden');
                        $('#newsID', $editNewsTab).val(newsID);
                        $('#editor', $editNewsTab).html(decodeURIComponent(editResult.newsContent.replace(/\+/g, '%20')).replace(/&lt;/g, '<').replace(/&gt;/g, '>'));
                        $('#newsTitle', $editNewsTab).val(editResult.newsTitle)
                        $('html,body').animate({ scrollTop: $('[href="#editNewsTab"]').trigger('click').offset().top - 80 }, 1000);
                    } else {
                        $noRecord.css('visibility', 'visible').text(editResult.msg || '无法获取该新闻信息。');
                    }
                }, null, false, false, $noRecord);
            }
            //新建或查看新闻列表时 隐藏删除新闻
            $('[href="#newsTab"],#createNews').click(function () {
                $('#deleteNews').addClass('hide');
            });
            //新闻列表
            ajaxForm($(), $(), 'GET', '', '', '../Static/Scripts/newsList' + getCookie('yuQ11UserCollegeID') + '.js?t=' + Math.random(), function (result) {
                var newsList = $.stringToObject(result),
                    $noRecord = $('#noRecord');
                if (newsList.length < 1) {
                    $noRecord.css('visibility', 'visible').text('暂无新闻纪录。').next().hide();
                } else {
                    var i = 0, elem, htmlBuilder = new StringBuilder(), 
                        $newsList = $('tbody', '#newsTab'), $tr,  $editNewsTab = $('#editNewsTab'),
                        newsID;
                    //插入新闻
                    while ((elem = newsList[i++]) != null) {
                        htmlBuilder.append('<tr data-id="' + elem.newsID + '"><td>' + elem.newsTitle + '</td><td>' + elem.newsDateTime + '</td><td>' + elem.userNickName + '</td><td><a href="javascript:;">删除</a></td></tr>');
                    }
                    $newsList.children().remove();
                    $newsList.append(htmlBuilder.toString());
                    $newsList.click(function (e) {
                        e = e.target || window.event.srcElement;
                        $tr = $(e).closest('tr');
                        newsID = $tr.data('id');
                        if (e.tagName === 'A') {
                            //删除新闻
                            delNews(newsID, $noRecord, $newsList, $tr);
                        } else {
                            //编辑新闻
                            if (!!newsID) {
                                editNews(newsID, $noRecord, $editNewsTab);
                            }
                        }
                    });
                }
            });
            //如果地址栏中含有新闻id
            (function () {
                var path = location.href,
                    newsID = path.substring(path.lastIndexOf('?')+1);
                if ($.isNumeric(newsID)) {
                    editNews(newsID, $('#noRecord'), $('#editNewsTab'));
                }
            })();


            //富文本工具
            function initToolbarBootstrapBindings() {
                var $editToolbar = $('#editToolbar'),
                    fonts = ['黑体', '宋体', 'Arial', '微软雅黑', '微软雅黑 Light'],
                    fontTarget = $('[data-role=font]', $editToolbar).siblings('.dropdown-menu');
                $.each(fonts, function (idx, fontName) {
                    fontTarget.append($('<li><a data-edit="fontName ' + fontName + '" style="font-family:\'' + fontName + '\'">' + fontName + '</a></li>'));
                });
                $('a[title]', $editToolbar).tooltip({ container: 'body' });
                $('.dropdown-menu input', $editToolbar).click(function () { return false; })
                    .change(function () { $(this).parent('.dropdown-menu').siblings('.dropdown-toggle').dropdown('toggle'); })
                .keydown('esc', function () { this.value = ''; $(this).change(); });
                if ("onwebkitspeechchange" in document.createElement("input")) {
                    var editorOffset = $('#editor').offset();
                    $('#voiceBtn').css('position', 'absolute').offset({ top: editorOffset.top, left: editorOffset.left + $('#editor').innerWidth() - 35 });
                } else {
                    $('#voiceBtn').hide();
                }
                $('[data-role=magic-overlay]').each(function () {
                    var overlay = $(this), target = $(overlay.data('target'));
                    overlay.css('opacity', 0).css('position', 'absolute').offset(target.offset()).width(target.outerWidth()).height(target.outerHeight());
                    target.click(function () {
                        overlay.trigger('click');
                    });
                });
            };
            function showErrorAlert(reason, detail) {
                var msg = [reason, detail].join(' ');
                if (reason === 'unsupported-file-type') {
                    msg = "不支持的格式 " + detail;
                } else if (detail === 'Internal Server Error') {
                    msg = "系统内部错误 ";
                }
                
                $('#errorMsg').text(msg).css('visibility', 'visible');
                $('html,body').animate({ scrollTop: $('#errorMsg').offset().top - 80 }, 1000);
            }
            initToolbarBootstrapBindings();
            var wysiwygElem = $('#editor').wysiwyg({ fileUploadError: showErrorAlert });
            window.prettyPrint && prettyPrint();
            //点击发布
            $('#btnPressNews').click(function () {
                var $errorMsg = $('#errorMsg'),
                    $editor = $('#editor');
                if ($('img', '#editor').length > 0) {
                    $('#backdrop').fadeIn();
                }
                for (var i = 0, $elem = $('img', '#editor'), $elem, flag = false, id; !!($elem = $elem.eq(i)).length; i++) {
                    if (flag) {
                        $('#backdrop').fadeOut();
                        return;
                    } else {
                        if (/^data/.test($elem.attr('src'))) {
                            id = $elem.attr('src');
                            $.ajax({
                                url: '../Static/uploadImg',
                                method: 'POST',
                                data: 'imgData=' + encodeURIComponent($elem.attr('src')),
                                contentType: "application/x-www-form-urlencoded;charset=ascii",
                            }).done(function (result) {
                                result = $.stringToObject(result);
                                if (!!result && result.status == 'success') {
                                    $('#' + id, editor).attr('src', '../Static/Images/' + result.name);
                                }
                            }).fail(function (jqXHR, textStatus, errorThrown) {
                                showErrorAlert('错误', '图片上传失败，请稍后重试');
                                flag = true;
                            });
                        }
                    }
                }
                $('#backdrop').fadeOut();
                if (!$editor.text()) {
                    $editor.next().css('visibility', 'visible');
                } else {
                    $editor.next().css('visibility', 'hidden');
                    ajaxForm($(this), $('#editNewsTab'), 'POST',
                        '&userID=' + getCookie('yuQ11UserName') +
                        '&collegeID=' + getCookie('yuQ11UserCollegeID') +
                        '&newsContent=' + encodeURIComponent(
                        $editor.cleanHtml().
                        replace(/<img id="[^"]+"/g, "<img ").
                        replace(/&lt;/g, '&lessThan;').
                        replace(/&gt;/g, '&greatThan;').
                        replace(/</g, '&lt;').
                        replace(/>/g, '&gt;')),
                        '', '../Static/editNews',
                        function (result) {
                            result = $.stringToObject(result);
                            if (!!result && result.status == 'success') {
                                location.href = '../News/' + result.id;
                            } else {
                                showErrorAlert('发布失败', result.msg || '无法访问服务器');
                            }
                        }, null, false, true, $errorMsg);
                }
            });
        });
    </script>
</asp:Content>
