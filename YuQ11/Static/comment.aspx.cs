using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text;

namespace YuQ11.Static
{
    public partial class comment : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Response.Clear();
            Logic.logicComment lComment = new Logic.logicComment();
            switch (Request["action"])
            {
                case "add":
                    Response.Write(lComment.addComment(Request["commentSourceID"], Request["userId"], Request["commentContent"]));
                    break;
                case "getByNews":
                    Response.Write(getCommentListByNews(lComment.getCommentListByNews(Request["commentSourceID"])));
                    break;
                case "getByUserName":
                    Response.Write(getCommentListByUserName(lComment.getCommentListByUserName(Request["userName"])));
                    break;
                case "del":
                    Response.Write(lComment.delComment(Request["commentID"], HttpContext.Current.User.Identity.Name));
                    break;
                default:
                    Response.Write("{status:'fail',msg:'找不到评论操作指令'}");
                    break;
            }
            Response.End();
        }

        protected string getCommentListByNews(List<Models.CommentList> commentList)
        {
            StringBuilder stringBuilder = new StringBuilder();
            string userId = HttpContext.Current.User.Identity.Name;
            foreach (var p in commentList)
            {
                stringBuilder.Append(string.Format("<div class='list-group-item' data-id='{0}'><h5 class='list-group-item-heading'>{1}<small class='pull-right'>{2}{3}</small></h5><p class='list-group-item-text'>{4}</p></div>",
                    p.commentID, p.userNickName,
                    (p.commentDateTime < DateTime.Today ? p.commentDateTime.ToString("yyyy年MM月dd日 HH:mm") : p.commentDateTime.ToString("HH:mm")),
                    (p.userId == userId ? "&nbsp;&nbsp;<a href='javascript:;' data-role='del'>删除</a>" : ""),
                    p.commentContent).Replace('\'','"'));

            }
            return "{status:'success',html:'" + stringBuilder.ToString() + "'}";
        }
        protected string getCommentListByUserName(List<Models.Comment> commentList)
        {
            StringBuilder stringBuilder = new StringBuilder();
            string userId = HttpContext.Current.User.Identity.Name;
            foreach (var p in commentList)
            {
                stringBuilder.Append(string.Format("<a class='list-group-item' href='News/{0}#commentListMsgBox' title='{1}' ><span class='badge'>{2}</span>{1}</a>",
                    p.commentSourceID, p.commentContent, p.commentDateTime.ToString("yyyy/MM/dd HH:mm")).Replace('\'', '"'));

            }
            return "{status:'success',html:'" + stringBuilder.ToString() + "'}";
        }
    }
}