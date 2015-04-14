using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace YuQ11
{
    public partial class News : System.Web.UI.Page
    {
        Models.NewsView news;
        protected void Page_Load(object sender, EventArgs e)
        {
            Logic.logicNews lNews = new Logic.logicNews();
            string url = Request.Url.LocalPath;
            news=lNews.getNewsByID(Request["newsID"], url.Substring(url.LastIndexOf('/') + 1));
            if (news == null)
            {
                Response.Redirect("~");
            }
            else
            {
                Title = news.newsTitle;
                newsAttr.InnerHtml = string.Format("撰写时间：{0}&nbsp;&nbsp;作者：{1}",
                    news.newsDatetime.ToString("yyyy年MM月dd日 HH:mm"),
                    news.userNickName);
                newsContainer.InnerHtml = news.newsContent.Replace("&lt;", "<").Replace("&gt;", ">").Replace("&greatThan;", "&gt;").Replace("&lessThan;", "&lt;");

                if (HttpContext.Current.User.IsInRole(Static.Variable.roleOperators) || HttpContext.Current.User.IsInRole(Static.Variable.roleAdministrators))
                {
                    btnEdit.Visible = true;
                    btnEdit.HRef = "~/YuQ11Admin/NewsManageMent?" + news.newsID;
                }
            }
        }
    }
}