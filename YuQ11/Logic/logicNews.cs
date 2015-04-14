using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.ModelBinding;

namespace YuQ11.Logic
{
    public class logicNews
    {
        Models.YuQ11Context yuQ11Context;

        public logicNews()
        {
            yuQ11Context = new Models.YuQ11Context();
        }
        //增
        public string addNews(string userID, string newsTitle, string newsContent)
        {
            string userRole = yuQ11Context.UsersLists.FirstOrDefault(p => p.userName == userID).userRole;
            if (userRole.CompareTo(Static.Variable.roleAdministrators) == 0 ||
                userRole.CompareTo(Static.Variable.roleOperators) == 0)
            {
                newsContent = newsContent.Replace("&lt;script", string.Empty).
                    Replace("&lt;iframe", string.Empty);
                Models.News sNews = new Models.News()
                {
                    userID = userID,
                    newsTitle = newsTitle,
                    newsDatetime = DateTime.Now,
                    newsContent = newsContent,
                    countsOfZan = 0,
                    attachmentName = string.Empty
                };

                try
                {
                    yuQ11Context.Newss.Add(sNews);
                    yuQ11Context.SaveChanges();
                }
                catch (Exception ex)
                {
                    return ("{status:'fail',msg:'" + ex.Message + "'}");
                }
                return ("{status:'success',id:" + sNews.newsID + "}");
            }
            else
            {
                return ("{status:'fail',msg:'您没有撰写新闻的权限'}");
            }
        }
        //删
        public string removeNews(string newsID)
        {
            long lNewsID;
            if (long.TryParse(newsID, out lNewsID))
            {
                try
                {
                    yuQ11Context.Newss.Remove(yuQ11Context.Newss.FirstOrDefault(p => p.newsID == lNewsID));
                    yuQ11Context.SaveChanges();
                }
                catch (Exception ex)
                {
                    return ("{status:'fail',msg:'" + ex.Message + "'}");
                }
                return ("{status:'success',id:" + newsID + "}");
            }
            else
            {
                return ("{status:'fail',msg:'找不到该新闻'}");
            }
        }
        //查
        public Models.NewsView getNewsByID([QueryString("newsID")] string id, [RouteData] string rID)
        {
            long newsID;
            if (long.TryParse(id, out newsID))
            {
                return yuQ11Context.NewsViews.FirstOrDefault(p => p.newsID == newsID);
            }
            else if (long.TryParse(rID, out newsID))
            {
                return yuQ11Context.NewsViews.FirstOrDefault(p => p.newsID == newsID);
            }
            else
            {
                return null;
            }
        }
        public IEnumerable<Models.NewsView> getNearNewsList(string collegeID)
        {

            int iCollegeID;
            if (int.TryParse(collegeID, out iCollegeID))
            {
                DateTime selectDateTime = DateTime.Now.AddMonths(-1);
                return yuQ11Context.NewsViews.Where(p => p.newsDatetime > selectDateTime && p.collegeID == iCollegeID).OrderBy(p => p.newsDatetime).DefaultIfEmpty();
            }
            else
            {
                return null;
            }
        }
        public IQueryable<Models.NewsView> getAllNewsList()
        {
            return yuQ11Context.NewsViews.OrderByDescending(p => p.newsDatetime).DefaultIfEmpty();
        }

        //改
        public string updateNews(string newsID, string userID, string newsTitle, string newsContent)
        {
            string userRole = yuQ11Context.UsersLists.FirstOrDefault(p => p.userName == userID).userRole;
            if (userRole.CompareTo(Static.Variable.roleAdministrators) == 0 ||
                userRole.CompareTo(Static.Variable.roleOperators) == 0)
            {
                long lNewsID;
                if (long.TryParse(newsID, out lNewsID))
                {
                    newsContent = newsContent.Replace("&lt;script", string.Empty).
                        Replace("&lt;iframe", string.Empty);
                    Models.News sNews = yuQ11Context.Newss.FirstOrDefault(p => p.newsID == lNewsID);

                    sNews.userID = userID;
                    sNews.newsTitle = newsTitle;
                    sNews.newsDatetime = DateTime.Now;
                    sNews.newsContent = newsContent;
                    try
                    {
                        yuQ11Context.SaveChanges();
                    }
                    catch (Exception ex)
                    {
                        return ("{status:'fail',msg:'" + ex.Message + "'}");
                    }
                    return ("{status:'success',id:" + sNews.newsID + "}");
                }
                else
                {
                    return ("{status:'fail',msg:'找不到该新闻'}");
                }
            }
            else
            {
                return ("{status:'fail',msg:'您没有撰写新闻的权限'}");
            }
        }
    }
}