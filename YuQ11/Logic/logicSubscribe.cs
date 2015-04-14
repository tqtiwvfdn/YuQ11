using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Text.RegularExpressions;

namespace YuQ11.Logic
{
    public class logicSubscribe
    {
        Models.YuQ11Context yuQ11Context;
        public logicSubscribe()
        {
            yuQ11Context = new Models.YuQ11Context();
        }

        //取消报名
        public string cancelSubscribe(string userName, string userItem)
        {
            try
            {
                Models.AspNetUser user = yuQ11Context.AspNetUsers.First(p => p.UserName == userName);
                int iItemID = Int32.Parse(userItem);
                if (user != null)
                {
                    user.itemIDs = Regex.Replace(user.itemIDs, string.Format("(^{0}(,|$))|(,{0}(?![0-9]))", userItem), string.Empty, RegexOptions.None);
                }
                Models.Subscribe subscribe = yuQ11Context.Subscribes.First(p => p.userID == userName && p.itemID == iItemID);
                if (subscribe != null)
                {
                    yuQ11Context.Subscribes.Remove(subscribe);
                }
                yuQ11Context.SaveChangesAsync();
            }
            catch (Exception ex)
            {
                return ("{status:'fail',msg:'" + ex.Message + "'}");
            }
            return "{status:'success'}";
        }

        //添加报名
        public string subscribe(string classID, string userID, string userItem, int itemLimitedCount)
        {
            string msg = string.Empty;
            string status = "fail";
            try
            {
                int iItem = Int32.Parse(userItem);
                long iClassID = Int64.Parse(classID);
                Models.SportItem item = yuQ11Context.SportItems.First(p => p.itemID == iItem);
                if (yuQ11Context.Subscribes.Count(p => p.itemID == iItem && p.classID == iClassID) >= item.itemPlace)
                {
                    msg = "超过该项目报名人数限制。";
                }
                else if (yuQ11Context.ItemLimiteds.Count(p => p.isLimit == true && p.userID == userID) >= itemLimitedCount && item.isLimit)
                {
                    msg = "超过该用户报名项目限制。";
                }
                else if (yuQ11Context.Subscribes.Count(p => p.itemID == iItem && p.userID == userID) > 0)
                {
                    msg = "该用户的该项目已报名。";
                }
                else
                {
                    Models.Subscribe subscribe = new Models.Subscribe()
                    {
                        classID = iClassID,
                        userID = userID,
                        itemID = iItem
                    };
                    Models.AspNetUser user = yuQ11Context.AspNetUsers.First(p => p.UserName == userID);
                    if (user != null)
                    {
                        user.itemIDs = (user.itemIDs == null || user.itemIDs == "" ? userItem : user.itemIDs + ',' + userItem);
                    }
                    yuQ11Context.Subscribes.Add(subscribe);
                    yuQ11Context.SaveChangesAsync();
                    status = "success";
                }
            }
            catch (Exception ex)
            {
                return ("{status:'fail',msg:'" + ex.Message + "'}");
            }
            return string.Format("{{status:'{0}',msg:'{1}'}}", status, msg);
        }

        //报名列表
        public List<Models.SubscribesList> getSubscribeListByClassID(
            string collegeID,
            string classID)
        {
            long lCollegeID;
            int iClassID;
            if (long.TryParse(collegeID, out lCollegeID) && int.TryParse(classID, out iClassID))
            {
                return yuQ11Context.SubscribesLists.Where(p => p.collegeID == lCollegeID && p.classID == iClassID).OrderBy(p => p.userName).ToList();
            }
            else if (classID == "all")
            {
                return yuQ11Context.SubscribesLists.Where(p => p.collegeID == lCollegeID).OrderBy(p => p.userName).ToList();
            }
            else
            {
                return null;
            }
        }

        public List<Models.SubscribesList> getSubscribeListByItemID(
            string collegeID,
            string itemID)
        {
            long lCollegeID;
            int iItemID;
            if (long.TryParse(collegeID, out lCollegeID) && int.TryParse(itemID, out iItemID))
            {
                return yuQ11Context.SubscribesLists.Where(p => p.collegeID == lCollegeID && p.itemID == iItemID).OrderBy(p => p.itemName).ToList();
            }
            else if (itemID == "all")
            {
                return yuQ11Context.SubscribesLists.Where(p => p.collegeID == lCollegeID).OrderBy(p => p.itemName).ToList();
            }
            else
            {
                return null;
            }
        }

        //清空报名
        public string resetSubscribe(string collegeID)
        {
            int iCollegeID;
            if (int.TryParse(collegeID, out iCollegeID))
            {
                IEnumerable<long> classID = from units in yuQ11Context.Units
                                            where units.collegeID == iCollegeID
                                            select units.classID;

                IEnumerable<Models.Subscribe> query =
                    from subscribes in yuQ11Context.Subscribes
                    where classID.Contains(subscribes.classID)
                    select subscribes;
                yuQ11Context.Subscribes.RemoveRange(query);

                IEnumerable<Models.AspNetUser> user =
                    from users in yuQ11Context.AspNetUsers
                    where classID.Contains(users.userClassID)
                    select users;

                foreach (var u in user)
                {
                    u.itemIDs = null;
                }

                try
                {
                    yuQ11Context.SaveChanges();
                    return "{status:'success'}";
                }
                catch (Exception ex)
                {
                    return ("{status:'fail',msg:'" + ex.Message + "'}");
                }
            }
            else
            {
                return ("{status:'fail',msg:'无法转化学院ID'}");
            }
        }


        //检录
        public string checkIn(string subscribeID, string action)
        {
            string checkIn = action == "checkIn" ? "1" : "0";
            long lSubscribeID;

            if (long.TryParse(subscribeID, out lSubscribeID))
            {
                try
                {
                    var sub=yuQ11Context.Subscribes.FirstOrDefault(p => p.subscribeID == lSubscribeID);
                    sub.isCheckIn = checkIn;
                    yuQ11Context.SaveChanges();
                    return "{status:'success'}";
                }
                catch (Exception ex)
                {
                    return "status:'fail',msg:'" + ex.Message + "'";
                }
            }
            else
            {
                return "status:'fail',msg:'无法转化报名ID'";
            }
        }
    }
}