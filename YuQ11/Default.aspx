<%@ Page Title="羽晴" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="YuQ11._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <div class="page-header">
        <h1><%: Title %>.</h1>
        <h4>欢迎使用“高校运动会内容发布系统”</h4>
    </div>
    <div class="row">
        <div class=" col-md-6">
            <div class="list-group" id="newsList">
                <span class="list-group-item active">新闻</span>
                <a href="javascript:;" class="list-group-item">暂无新闻</a>
            </div>
        </div>
        <div class=" col-md-6">
            <div class="list-group" id="classNewsList">
                <span class="list-group-item active">班级消息</span>
                <a href="javascript:;" class="list-group-item">暂无消息</a>
            </div>
        </div>
        <div class=" col-md-6">
            <div class="list-group" id="commentList">
                <span class="list-group-item active">评论消息</span>
                <a href="javascript:;" class="list-group-item">暂无消息</a>
            </div>
        </div>
    </div>
    <script>
        $(function () {
            //插入新闻
            ajaxForm($(), $(), 'GET', '', '', 'Static/Scripts/newsList' + getCookie('yuQ11UserCollegeID') + '.js?t=' + Math.random(), function (result) {
                var newsList = $.stringToObject(result),
                    newsTemp = '<a class="list-group-item" href="News/newsID" title="newsTitle" ><span class="badge">newsDateTime</span>newsTitle</a>',
                    i = 0, elem,
                htmlBuilder = new StringBuilder(),
                    $newsList = $('#newsList');
                while ((elem = newsList[i++]) != null) {
                    htmlBuilder.append(newsTemp.replace(/newsID/, elem.newsID).replace(/newsDateTime/, elem.newsDateTime).replace(/newsTitle/g, elem.newsTitle));
                }
                $newsList.children(':gt(0)').remove();
                $newsList.append(htmlBuilder.toString());
            });
            //插入评论
            ajaxForm($(), $(), 'GET', 'action=getByUserName&userName=' + getCookie('yuQ11UserName')+'&t='+Math.random(), '', 'Static/comment', function (result) {
                result = $.stringToObject(result);
                if (result.status = 'success'&&!!result.html) {
                    $('#commentList').children(':gt(0)').remove();
                    $('#commentList').append(result.html);
                }
            }, null, false, false, $(), false);

        });
    </script>
</asp:Content>
