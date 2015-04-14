using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace YuQ11.Logic
{
    public class logicComment
    {
        Models.YuQ11Context yuQ11Context;
        public logicComment()
        {
            yuQ11Context = new Models.YuQ11Context();
        }

        //添加评论
        public string addComment(string commentSourceID, string userId, string commentContent)
        {
            long lCommentSourceID;
            if (long.TryParse(commentSourceID, out lCommentSourceID))
            {
                Models.Comment comment = new Models.Comment()
                {
                    commentSourceID = lCommentSourceID,
                    userId = userId,
                    commentContent = commentContent,
                    commentDateTime = DateTime.Now,
                    commentIsFor = 0,
                };
                try
                {
                    yuQ11Context.Comments.Add(comment);
                    yuQ11Context.SaveChanges();
                }
                catch (Exception ex)
                {
                    return "{status:'fail',msg:'" + ex.Message + "'}";
                }
                return "{status:'success',id:'" + comment.commentID + "'}";
            }
            else
            {
                return "{status:'fail',msg:'无法将获取新闻名'}";
            }
        }

        //删除评论
        public string delComment(string commentID, string userId)
        {
            long iCommentID;
            string status = "success", msg = "成功删除";
            if (long.TryParse(commentID, out iCommentID))
            {
                Models.Comment comment = yuQ11Context.Comments.FirstOrDefault(p => p.commentID == iCommentID && p.userId == userId);
                if (comment != null)
                {
                    try
                    {
                        yuQ11Context.Comments.Remove(comment);
                        yuQ11Context.SaveChangesAsync();
                    }
                    catch (Exception ex)
                    {
                        status = "fail";
                        msg = ex.Message;
                    }
                }
                else
                {
                    status = "fail";
                    msg = "无法找到该评论";
                }
            }
            else
            {
                status = "fail";
                msg = "无法找到该评论";
            }
            return string.Format("{{status:'{0}',msg:'{1}'}}", status, msg);
        }

        //评论列表
        public List<Models.CommentList> getCommentListByNews(string commetnSourceID)
        {
            long lCommentSourceID;
            if (long.TryParse(commetnSourceID, out lCommentSourceID))
            {
                return yuQ11Context.CommentLists.Where(p => p.commentSourceID == lCommentSourceID).OrderByDescending(p => p.commentDateTime).ToList();
            }
            else
            {
                return null;
            }
        }

        public List<Models.Comment> getCommentListByUserName(string userId)
        {
            return yuQ11Context.Comments.Where(p => p.userId == userId).OrderByDescending(p => p.commentDateTime).ToList();
        }
    }
}