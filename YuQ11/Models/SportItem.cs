using System.ComponentModel.DataAnnotations;

namespace YuQ11.Models
{
    public class SportItem
    {
        [Key]
        public int itemID { get; set; }
        public string itemName { get; set; }
        public short itemSex { get; set; }
        public string itemRange { get; set; }
        public short itemType { get; set; }
        public int itemPlace { get; set; }
        public bool isLimit { get; set; }
        public string itemSite { get; set; }
        public bool isPreliminaries { get; set; }
    }

    public class Subscribe
    {
        [Key]
        public long subscribeID { get; set; }
        public int itemID { get; set; }
        public long classID { get; set; }
        public string userID { get; set; }
        public string isCheckIn { get; set; }
        public string matchDatetime { get; set; }
        public string racetrack { get; set; }
        public string result { get; set; }
    }

    public class SubscribesList
    {
        [Key]
        public long subscribeID { get; set; }
        public int collegeID { get; set; }
        public long classID { get; set; }
        public string className { get; set; }
        public int itemID { get; set; }
        public string itemName { get; set; }
        public string userName { get; set; }
        public string userNickName { get; set; }
        public string userLongPhone { get; set; }
        public string userShortPhone { get; set; }
        public string isCheckIn { get; set; }
        public string result { get; set; }
    }

    public class ItemLimited
    {
        [Key]
        public long subscribeID { get; set; }
        public string userID { get; set; }
        public int itemID { get; set; }
        public bool isLimit { get; set; }
    }
}