<%@ Page Title="管理中心" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Admin.aspx.cs" Inherits="YuQ11.YuQ11Admin.YuQ11Admin" %>
<asp:Content ID="ContentContainer" ContentPlaceHolderID="MainContent" runat="server">
    <div class="page-header">
        <h2><%:Title %>.</h2>
        <h4>管理您的系统。</h4>
    </div>
    <div class="row">
        <div class="col-md-4">
            <h4 class="page-header gutter-top">用户</h4>
            <blockquote>
                <p>搜索、编辑用户信息、重置用户密码，配置用户角色。</p>
                <p class="text-right">
                    <a class="btn btn-primary" href="UserManagement">用户管理 &raquo;</a>
                </p>
            </blockquote>
        </div>
        <div class="col-md-4">
            <h4 class="page-header gutter-top">比赛</h4>
            <blockquote>
                <p>添加、删除运动会项目，或编辑已有的运动会项目。</p>
                <p class="text-right">
                    <a class="btn btn-primary" href="ItemManagement">赛事项目管理 &raquo;</a>
                </p>
            </blockquote>
            <blockquote>
                <p>查看项目报名情况、生成赛程。</p>
                <p class="text-right">
                    <a class="btn btn-primary" href="SubscribesManagement">报名管理 &raquo;</a>
                </p>
            </blockquote>
            <blockquote>
                <p>录入选手检录情况、比赛成绩，生成比赛结果。</p>
                <p class="text-right">
                    <a class="btn btn-primary" href="MatchManageMent">赛事管理 &raquo;</a>
                </p>
            </blockquote>
        </div>
        <div class="col-md-4">
            <h4 class="page-header gutter-top">内容管理</h4>
            <blockquote>
                <p>发布新闻，报名消息，比赛消息、结果等。</p>
                <p class="text-right">
                    <a class="btn btn-primary" href="NewsManageMent">新闻管理 &raquo;</a>
                </p>
            </blockquote>
<%--            <blockquote>
                <p>回复评论、删除评论。</p>
                <p class="text-right">
                    <a class="btn btn-primary" href="UserManagement">消息管理 &raquo;</a>
                </p>
            </blockquote>--%>
        </div>
    </div>
</asp:Content>
