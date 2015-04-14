using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.IO;
using System.Web;

namespace YuQ11.Static
{
    public partial class editNews : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Logic.logicNews lNews = new Logic.logicNews();
            Response.Clear();
            if (Request["opt"] == "del")
            {
                Response.Write(lNews.removeNews(Request["newsID"]));
            }
            else
            {
                if (!string.IsNullOrEmpty(Request["newsID"]))
                {
                    Response.Write(lNews.updateNews(Request["newsID"], Request["userID"], Request["newsTitle"], Request["newsContent"]));
                }
                else if (string.IsNullOrEmpty(Request["newsTitle"]))
                {
                    Response.Write("{status:'fail',msg:'参数不能为空。'}");
                }
                else
                {
                    Response.Write(lNews.addNews(Request["userID"], Request["newsTitle"], Request["newsContent"]));
                }
            }
            writeNearNewsList(lNews.getNearNewsList(Request["collegeID"]));
            Response.End();
        }

        protected void writeNearNewsList(IEnumerable<Models.NewsView> newsList)
        {
            if (newsList != null)
            {
                StringBuilder stringBuilder = new StringBuilder();

                stringBuilder.Append("[");
                foreach (var n in newsList)
                {
                    stringBuilder.Append(
                        string.Format("{{newsID:'{0}',newsTitle:'{1}',newsDateTime:'{2}',userNickName:'{3}'}},",
                        n.newsID, n.newsTitle, n.newsDatetime.ToString("yyyy/MM/dd HH:mm"), n.userNickName));
                }
                string str = stringBuilder.ToString();
                StreamWriter streamWriter = null;
                String fileName = Server.MapPath("Scripts\\newsList" + Request["collegeID"] + ".js");
                try
                {
                    streamWriter = new System.IO.StreamWriter(
                        fileName,
                        false,
                        Encoding.UTF8);
                    streamWriter.Write(str.Substring(0, str.Length - 1) + "]");
                    streamWriter.Flush();
                    streamWriter.Close();
                }
                catch (Exception ex)
                {
                    Response.Write(ex.Message);
                }
            }
        }
    }
}