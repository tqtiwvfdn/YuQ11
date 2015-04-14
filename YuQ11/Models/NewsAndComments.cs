using System.ComponentModel.DataAnnotations;

namespace YuQ11.Models
{
    public class News
    {
        [Key]
        public long newsID { get; set; }
        public string userID { get; set; }
        public string newsTitle { get; set; }
        public System.DateTime newsDatetime { get; set; }
        public string newsContent { get; set; }
        public long countsOfZan { get; set; }
        public string attachmentName { get; set; }

    }

    public class Comment
    {
        [Key]
        public long commentID { get; set; }
        public long commentSourceID { get; set; }
        public string userId { get; set; }
        public string commentContent { get; set; }
        public short commentIsFor { get; set; }
        public System.DateTime commentDateTime { get; set; }
    }

    public class NewsView
    {
        [Key]
        public long newsID { get; set; }
        public string userNickName { get; set; }
        public string newsTitle { get; set; }
        public System.DateTime newsDatetime { get; set; }
        public string newsContent { get; set; }
        public long countsOfZan { get; set; }
        public string attachmentName { get; set; }
        public int collegeID { get; set; }
    }

    public class CommentList
    {
        [Key]
        public long commentID { get; set; }
        public long commentSourceID { get; set; }
        public string userId { get; set; }
        public string userNickName { get; set; }
        public string commentContent { get; set; }
        public short commentIsFor { get; set; }
        public System.DateTime commentDateTime { get; set; }
    }
}