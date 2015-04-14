using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.IO;

namespace YuQ11.Static
{
    public partial class getNews : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Response.Clear();
            if (string.IsNullOrEmpty(Request["newsID"]))
            {
                ThrowError("noOption");
            }
            else
            {
                Logic.logicNews lNews = new Logic.logicNews();
                Models.NewsView news = lNews.getNewsByID(Request["newsID"], null);
                if (news == null)
                {
                    ThrowError("null");
                }
                else
                {
                    Response.Write(string.Format
                        ("{{status:'success',newsTitle:'{0}',newsDateTime:'{1}',newsContent:'{2}',attachmentName:'{3}',countOfZan:'{4}',userNickName:'{5}'}}",
                        news.newsTitle, news.newsDatetime, 
                        System.Web.HttpUtility.UrlEncode(news.newsContent, Encoding.UTF8), 
                        news.attachmentName, news.countsOfZan, news.userNickName));
                }
            }
            Response.End();
        }

        protected void ThrowError(string error)
        {
            switch (error)
            {
                case "noOption":
                    Response.Write("{status:'fail',msg:'无参数或无效参数。'}");
                    break;
                case "null":
                    Response.Write("{status:'fail',msg:'找不到该新闻。'}");
                    break;
                default:
                    Response.Write("{status:'fail',msg:'" + error + "'}");
                    break;
            }
        }

    }
}