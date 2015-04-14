using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.IO;


namespace YuQ11.Static
{
    public partial class createMatchSchedule : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string collegeID = Request["collegeID"];
            if (!string.IsNullOrEmpty(collegeID))
            {
                Response.Write("<h2>比赛分组</h2>");
                int i, max, j,
                    matchOrderLength, racetrackLength, peopleLimitLength,
                    racetrack = 0, peopleLimit = 0;

                //提前赛，单赛循环，不用考虑先后顺序
                string[] preMatchList = Request["preMatch"].Split(new char[] { ',' }, StringSplitOptions.RemoveEmptyEntries);
                //比赛顺序
                string[] matchOrderList = Request["matchOrder"].Split(new char[] { ',' }, StringSplitOptions.RemoveEmptyEntries);
                matchOrderLength = matchOrderList.Length;
                //赛道数
                string[] racetrackList = Request["racetrack"].Split(new char[] { ',' }, StringSplitOptions.RemoveEmptyEntries);
                racetrackLength = racetrackList.Length;
                //每组最多人数
                string[] peopleLimitList = Request["peopleLimit"].Split(new char[] { ',' }, StringSplitOptions.RemoveEmptyEntries);
                peopleLimitLength = peopleLimitList.Length;

                //逻辑类
                Logic.logicSubscribe lSubscribe = new Logic.logicSubscribe();
                List<Models.SportItem> itemList = (new Logic.logicSportItem()).getSportItemList();
                if (preMatchList != null)
                {
                    Response.Write("<h3>提前赛分组</h3>");
                    for (i = 0, max = preMatchList.Length; i < max; i++)
                    {
                        for (j = i; j < racetrackLength && matchOrderList[j] != preMatchList[i]; j++) ;
                        if (j < racetrackLength)
                        {
                            //赛道数
                            racetrack = int.Parse(racetrackList[j]);
                            //人数限制
                            peopleLimit = int.Parse(peopleLimitList[j]);
                            //在orderMatch移除
                            matchOrderList[j] = null;
                        }
                        else
                        {
                            racetrack = Static.Variable.racetrackDefault;
                            peopleLimit = Static.Variable.peopleLimitDefault;
                        }
                        writeOutResult(getItemName(itemList, int.Parse(preMatchList[i])),racetrack, peopleLimit, lSubscribe.getSubscribeListByItemID(collegeID, preMatchList[i]));
                    }
                }

                //径赛
                j = 0;
                Response.Write("<h3>径赛分组</h3>");
                for (j = 0; j < racetrackLength; j++)
                {
                    if (matchOrderList[j] == null) continue;
                    writeOutResult(getItemName(itemList, int.Parse(matchOrderList[j])),int.Parse(racetrackList[j]), int.Parse(peopleLimitList[j]), lSubscribe.getSubscribeListByItemID(collegeID, matchOrderList[j]));
                }

                //田赛
                Response.Write("<h3>田赛分组</h3>");
                for (j = 0; j < matchOrderLength; j++)
                {
                    if (matchOrderList[j] == null) continue;
                    writeOutResult(getItemName(itemList, int.Parse(matchOrderList[j])),Static.Variable.racetrackDefault, Static.Variable.peopleLimitDefault, lSubscribe.getSubscribeListByItemID(collegeID, matchOrderList[j]));
                }
            }
        }

        protected void writeOutResult(string itemName,int racetrack, int peopleLimit, List<Models.SubscribesList> list)
        {
            list = list.OrderBy(p => p.userNickName).ToList();

            if (list.Count > 0)
            {
                StringBuilder stringBuilder = new StringBuilder();
                int i, n = 1, j = 0,
                    length = list.Count;

                stringBuilder.Append("<table>");

                //不分组的情况
                if (peopleLimit == Static.Variable.peopleLimitDefault)
                {
                    peopleLimit = length;
                }

                if (racetrack >= peopleLimit)
                {
                    while (j < length)
                    {
                        stringBuilder.Append("<tr><th colspan=\"" + peopleLimit + "\">第" + (n++) + "组</th></tr><tr>");
                        for (i = 0; i < peopleLimit && j < length; i++)
                        {
                            stringBuilder.Append("<td>" + list[j].className + ' ' + list[j++].userNickName + "</td>");
                        }
                        while (i++ < peopleLimit)
                        {
                            stringBuilder.Append("<td></td>");
                        }
                        stringBuilder.Append("</tr>");
                    }
                }
                else
                {
                    while (j < length)
                    {
                        stringBuilder.Append("<tr><th colspan=\"" + racetrack + "\">第" + (n++) + "组</th></tr>");
                        while (j < length && (j < (n - 1) * peopleLimit))
                        {
                            stringBuilder.Append("<tr>");
                            for (i = 0; i < racetrack && j < length; i++)
                            {
                                stringBuilder.Append("<td>" + list[j].className + ' ' + list[j++].userNickName + "</td>");
                            }
                            while (i++ < racetrack)
                            {
                                stringBuilder.Append("<td></td>");
                            }
                            stringBuilder.Append("</tr>");
                        }
                    }
                }
                Response.Write(string.Format("<blockquote>{0}，{1}组，共{2}人</blockquote>",itemName,n-1,length));
                stringBuilder.Append("</table>");
                Response.Write(stringBuilder.ToString());
            }
            else
            {
                Response.Write(string.Format("<blockquote>{0}，{1}组，共{2}人</blockquote>", itemName, 0, 0));
                Response.Write("<p>该项目报名人数为0。</p>");
            }
        }

        protected string getItemName(List<Models.SportItem> itemList,int itemID)
        {
            var item = itemList.FirstOrDefault(p => p.itemID == itemID);
            return (item.itemSex == 0 ? "男子" : "女子") + item.itemName;
        }
    }
}