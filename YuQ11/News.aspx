<%@ Page Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="News.aspx.cs" Inherits="YuQ11.News" %>

<asp:Content ID="NewsContent" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        #newsContentContainer {
            -webkit-user-select: text;
            -ms-user-select: text;
            user-select: text;
        }

            #newsContentContainer img {
                display: block;
                max-width: 80%;
                margin: .5em auto 0;
            }

        .well, .list-group {
            margin: 1em auto;
            max-width: 90%;
            border-radius: 0;
        }

        .list-group-item:first-child,
        .list-group-item:last-child {
            border-radius: 0;
        }

        .list-group + .list-group {
            margin-top: -1.1em;
            margin-bottom: 2em;
        }

        .list-group-item {
            background-color: transparent;
        }

        #commentListArea {
            word-break: break-all;
        }

        .btn-scroll-comment {
            bottom: 9em;
            color: white;
            text-align: center;
        }

            .btn-scroll-comment:hover {
                text-decoration: none;
                -webkit-animation: none;
                animation: none;
            }
    </style>
    <div id="messageBox" runat="server"></div>
    <div class="page-header text-center">
        <h2><%:Title %>.</h2>
        <h6 class="gutter-top">
            <span runat="server" id="newsAttr"></span>
            <a href="javascript:;" class="btn btn-transparent pull-right" runat="server" visible="false" id="btnEdit">编辑</a>
        </h6>
    </div>
    <div id="newsContentContainer" class="well well-sm box">
        <div id="newsContainer" runat="server" class="table-responsive"></div>
    </div>
    <div class="form-horizontal list-group box" id="commentContainer">
        <span class="list-group-item active">评论</span>
        <div class="list-group-item">
            <div class="form-group">
                <label for="textArea" class="col-md-1 control-label">评论</label>
                <div class="col-md-5">
                    <textarea class="form-control" rows="4" id="commentContent" style="resize: none;" data-length="150" required="required"></textarea>
                    <span class="text-danger" style="visibility: hidden">请填写评论内容</span>
                    <span id="wordsLimit" class="text-right text-success pull-right">可输入150字</span>
                </div>
            </div>
            <div class="form-group">
                <div class="col-md-5 col-md-offset-1">
                    <a href="javascript:;" class="btn btn-primary" id="btnCreateComment">发布</a>
                    <span class="text-danger" style="visibility: hidden"></span>
                </div>
            </div>
        </div>
        <span class="list-group-item text-right text-danger" id="commentListMsgBox"></span>
    </div>
    <div class="list-group box" id="commentListArea"></div>
    <a class="btn-scroll-top btn-scroll-comment" data-target="#commentListArea">
        <h4 style="margin: 1.1em auto; color: #FFF;">评论</h4>
    </a>
    <script>
        $(function () {
            //阻止回车时提交表单
            $('#ctl01').submit(function () {
                return false;
            });
            var getNewsID = function (name) {
                var url = location.href;
                url = url.substring(url.lastIndexOf('/'));
                var match = url.match(new RegExp('(' + name + '=|\/)([0-9]+)', ['i']));
                if (!!match && match.length > 1) {
                    return match[2];
                } else {
                    return '-1';
                }
            }
            //加载评论
            ajaxForm($(), $(), 'POST', 'commentSourceID=' + getNewsID('newsID') + '&action=getByNews&t=' + Math.random(), '', '../Static/comment', function (result) {
                result = $.stringToObject(result);
                if (result.status == 'success') {
                    $('#commentListArea').html(result.html);
                } else {
                    $('#commentListArea').text(result.msg || '加载评论失败');
                }
            }, null, false, false, $('#commentListArea'), true);

            //输入评论
            var $comment = $('#commentContent'),
                $wordsLimit = $('#wordsLimit'),
                lenght = +$comment.data('length'),
                currentLength;
            $comment.keyup(function () {
                $comment.val($comment.val().substring(0, lenght));
                currentLength = $comment.val().length;
                $wordsLimit.text('还可输入' + (lenght - currentLength) + '字');
            });

            //发布评论
            var commentTemp = '<div class="list-group-item" data-id="commentID"><h5 class="list-group-item-heading">userNickName<small class="pull-right">刚刚&nbsp;&nbsp;<a href="javascript:;" data-role="del">删除</a></small></h5><p class="list-group-item-text">commentContent</p></div>';
            $('#btnCreateComment').click(function () {
                var extraData = new StringBuilder(),
                    $this = $(this);
                extraData.append('commentSourceID=' + getNewsID('newsID'));
                extraData.append('userId=' + getCookie('yuQ11UserName'));
                extraData.append('action=add');
                ajaxForm($this, $('#commentContainer'), 'GET', '&' + extraData.join('&'), '', '../Static/comment', function (result) {
                    result = $.stringToObject(result);
                    if (result.status == 'success') {
                        $('#commentListArea').prepend(
                            commentTemp.replace(/commentID/, result.id)
                            .replace(/userNickName/, decodeURIComponent(escape(getCookie("yuQ11UserNickName"))))
                            .replace(/commentContent/, $comment.val()));
                        $.iScrollTo($this);
                        $.resetFormData($('#commentContainer'));
                    } else {
                        $this.next().text(result.msg || '发布评论失败').css('visibility', 'visible');
                    }
                }, null, false, false, $this.next());
            });

            //删除评论
            $('#commentListArea').click(function (e) {
                var $this = $(e.target || event.srcElement);
                if ($this[0].tagName === 'A') {
                    ajaxForm($this, $(this), 'GET', 'action=del&commentID=' + $this.closest('div').data('id'), '', '../Static/comment', function (result) {
                        result = $.stringToObject(result);
                        if (result.status == 'success') {
                            $this.closest('div').remove();
                            $('#commentListMsgBox').css('visibility', 'hidden');
                        } else {
                            $('#commentListMsgBox').text(result.msg || '发布评论失败').css('visibility', 'visible');
                        }
                    }, null, false, false, $('#commentListMsgBox'));
                }
            });

            //滚动到target
            $('[data-target]').click(function () {
                $('html,body').animate({ scrollTop: $($(this).data('target')).offset().top }, 1000);
            });
        });
    </script>
</asp:Content>
