using System.ComponentModel.DataAnnotations;

namespace YuQ11.Models
{
    public class AspNetRole
    {
        [Key]
        public string ID { get; set; }
        public string name { get; set; }
    }

    public class AspNetUserRole
    {
        [Key]
        public string userID { get; set; }
        public string roleID { get; set; }
    }

    public class Department
    {
        [Key]
        public int collegeID { get; set; }
        public string collegeName { get; set; }
    }

    public class Unit
    {
        [Key]
        public long classID { get; set; }
        public string className { get; set; }
        public int collegeID { get; set; }
    }

    public class AspNetUser
    {
        [Key]
        public string Id { get; set; }
        public string PasswordHash { get; set; }
        public string SecurityStamp { get; set; }
        public string UserName { get; set; }
        public long userClassID { get; set; }
        public string userNickName { get; set; }
        public short userSex { get; set; }
        public string userLongPhone { get; set; }
        public string userShortPhone { get; set; }
        public string itemIDs { get; set; }
    }

    public class DepartmentsAndUnits
    {
        [Key]
        public long classID { get; set; }
        public int collegeID { get; set; }
        public string collegeName { get; set; }
        public string className { get; set; }
    }

    public class UsersList
    {
        [Key]
        public string userName { get; set; }
        public string userNickName { get; set; }
        public long classID { get; set; }
        public string className { get; set; }
        public string userLongPhone { get; set; }
        public string userShortPhone { get; set; }
        public short userSex { get; set; }
        public int collegeID { get; set; }
        public string userRole { get; set; }
        public string itemIDs { get; set; }
    }

    public class CollegeClassUserID
    {
        [Key]
        public string userName { get; set; }
        public long classID { get; set; }
        public int collegeID { get; set; }
    }
}