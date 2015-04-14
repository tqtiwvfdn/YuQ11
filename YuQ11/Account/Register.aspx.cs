using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.EntityFramework;
using Microsoft.AspNet.Identity.Owin;
using System;
using System.Linq;
using System.Web;
using System.Web.UI;
using YuQ11.Models;

namespace YuQ11.Account
{
    public partial class Register : Page
    {
        protected void CreateUser_Click(object sender, EventArgs e)
        {
            var manager = new UserManager();
            if (manager.FindByName(UserName.Text) != null)
            {
                ErrorMessage.Text = "已存在该学号的账号";
            }
            else
            {
                var user = new ApplicationUser()
                {
                    UserName = UserName.Text,
                    userClassID = Int64.Parse(Request["ctl00$MainContent$ClassList"]),
                    userNickName = UserNickName.Text,
                    userSex = short.Parse(UserSex.Value),
                    userLongPhone = UserLongPhone.Text,
                    userShortPhone = UserShortPhone.Text,
                };
                IdentityResult result = manager.Create(user, Password.Text);
                if (result.Succeeded)
                {
                   // manager.AddToRoleAsync(user.Id, "Users");

                    IdentityHelper.SignIn(manager, user, isPersistent: false);
                    IdentityHelper.RedirectToReturnUrl(Request.QueryString["ReturnUrl"], Response);
                }
                else
                {
                    ErrorMessage.Text = result.Errors.FirstOrDefault();
                }
            }
        }
    }
}