using System.Data.Entity;

namespace YuQ11.Models
{
    public class YuQ11Context : DbContext
    {
        public YuQ11Context()
            : base("YuQ11Connection")
        {
        }

        public DbSet<AspNetRole> AspNetRoles { get; set; }
        public DbSet<AspNetUserRole> AspNetUserRoles { get; set; }

        public DbSet<Unit> Units { get; set; }
        public DbSet<Department> Departments { get; set; }
        public DbSet<AspNetUser> AspNetUsers { get; set; }

        public DbSet<SportItem> SportItems { get; set; }
        public DbSet<Subscribe> Subscribes { get; set; }

        public DbSet<News> Newss { get; set; }
        public DbSet<Comment> Comments { get; set; }
        //View
        public DbSet<DepartmentsAndUnits> DepartmentsAndUnits { get; set; }
        public DbSet<UsersList> UsersLists { get; set; }
        public DbSet<CollegeClassUserID> CollegeClassUserIDs { get; set; }
        
        public DbSet<SubscribesList> SubscribesLists { get; set; }
        
        public DbSet<ItemLimited> ItemLimiteds { get; set; }
        
        public DbSet<NewsView> NewsViews { get; set; }
        public DbSet<CommentList> CommentLists { get; set; }
    }
}