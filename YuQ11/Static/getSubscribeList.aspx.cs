using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.IO;

namespace YuQ11.Static
{
    public partial class getItemList : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Logic.logicSubscribe lSubscribe = new Logic.logicSubscribe();
            Response.Clear();
            if (!string.IsNullOrWhiteSpace(Request["classList"]))
            {
                if (!string.IsNullOrWhiteSpace(Request["collegeList"]))
                {
                    Response.Write(GetSubscribeList(lSubscribe.getSubscribeListByClassID(Request["collegeList"], Request["classList"])));
                }
                else
                {
                    Response.Write(GetSubscribeList(lSubscribe.getSubscribeListByClassID(Request["collegeID"], Request["classList"])));
                }
            }
            else if (!string.IsNullOrWhiteSpace(Request["itemList"]))
            {
                var list = lSubscribe.getSubscribeListByItemID(Request["collegeID"], Request["itemList"]);
                switch (Request["action"])
                {
                    case "checkIn":
                        Response.Write("{status:'success',html:'" + GetCheckInHtml(list) + "'}");
                        break;
                    case "resultLog":
                        break;
                    case "matchResult":
                        break;
                    default:
                        Response.Write(GetSubscribeList(list));
                        break;
                }
            }
            else
            {
                Response.Write("{status:'fail',msg:'没有提供参数。'}");
            }
            Response.End();
        }

        protected string GetSubscribeList(List<Models.SubscribesList> subscribeList)
        {
            if (subscribeList == null || subscribeList.Count < 1)
            {
                return "{status:'fail',msg:'找不到报名信息数据。'}";
            }
            else
            {
                StringBuilder stringBuilder = new StringBuilder();

                foreach (var p in subscribeList)
                {
                    stringBuilder.Append(
                         string.Format(
                             "<tr><td>{0}</td><td>{1}</td><td>{2}</td><td>{3}</td><td>{4}</td><td>{5}</td></tr>",
                         p.className,
                         p.userName,
                         p.userNickName,
                         p.itemName,
                         p.userLongPhone,
                         p.userShortPhone));
                }
                return "{status:'success',html:'" + stringBuilder.ToString() + "'}";
            }
        }

        protected string GetCheckInHtml(List<Models.SubscribesList> subscribeList)
        {
            StringBuilder html = new StringBuilder();
            string header = "<table><thead><tr><td>班级</td><td>学号</td><td>姓名</td><td>报名项目</td><td>检录</td><td>长号</td><td>短号</td></tr></thead><tbody>";
            string footer = "</tbody></table>";
            string noRecord = "<p>没有检录选手。</p>";
            string checkInChar = "1";
            var notCheckIn = subscribeList.Where(p => p.isCheckIn != checkInChar).OrderBy(p => p.userNickName).ToList();
            var checkIn = subscribeList.Where(p => p.isCheckIn == checkInChar).OrderBy(p => p.userNickName).ToList();

            html.Append("<blockquote>未检录</blockquote><div data-role='notCheckIn'>");
            if (notCheckIn.Count > 0)
            {
                html.Append(noRecord.Replace("<p>", "<p class='hide'>"));
                html.Append(header);
                foreach (var p in notCheckIn)
                {
                    html.Append(string.Format("<tr><td>{0}</td><td>{1}</td><td>{2}</td><td>{3}</td><td><a href='javascript:;' data-id='{4}' data-action='checkIn'>检录</a></td><td>{5}</td><td>{6}</td></tr>",
                        p.className, p.userName, p.userNickName, p.itemName, p.subscribeID, p.userLongPhone, p.userShortPhone+p.isCheckIn));
                }
                html.Append(footer);
            }
            else
            {
                html.Append(noRecord);
                html.Append(header.Replace("<table>", "<table class='hide'>") + footer);
            }

            html.Append("</div><blockquote>已检录</blockquote><div data-role='checkIn'>");
            if (checkIn.Count > 0)
            {
                html.Append(noRecord.Replace("<p>", "<p class='hide'>"));
                html.Append(header);
                foreach (var p in checkIn)
                {
                    html.Append(string.Format("<tr><td>{0}</td><td>{1}</td><td>{2}</td><td>{3}</td><td><a href='javascript:;' data-id='{4}' data-action='cancelCheckIn'>取消检录</a></td><td>{5}</td><td>{6}</td></tr>",
                        p.className, p.userName, p.userNickName, p.itemName, p.subscribeID, p.userLongPhone, p.userShortPhone));
                }
                html.Append(footer);
            }
            else
            {
                html.Append(noRecord);
                html.Append(header.Replace("<table>", "<table class='hide'>") + footer);
            }
            html.Append("</div>");
            return html.ToString().Replace('\'', '"');
        }
    }
}