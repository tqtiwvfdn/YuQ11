using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.EntityFramework;
using Microsoft.Owin.Security;
using System.Web;
using System;
using YuQ11.Models;

namespace YuQ11.Models
{
    // You can add User data for the user by adding more properties to your User class, please visit http://go.microsoft.com/fwlink/?LinkID=317594 to learn more.
    public class ApplicationUser : IdentityUser
    {
        public long userClassID { get; set; }
        public string userNickName { get; set; }
        public short userSex { get; set; }
        public string userLongPhone { get; set; }
        public string userShortPhone { get; set; }
    }

    public class ApplicationDbContext : IdentityDbContext<ApplicationUser>
    {
        public ApplicationDbContext()
            : base("YuQ11Connection")
        {
        }
    }

    #region Helpers
    public class UserManager : UserManager<ApplicationUser>
    {
        public UserManager()
            : base(new UserStore<ApplicationUser>(new ApplicationDbContext()))
        {
        }
    }
}

namespace YuQ11
{
    public static class IdentityHelper
    {
        // Used for XSRF when linking external logins
        public const string XsrfKey = "XsrfId";

        public static void SignIn(UserManager manager, ApplicationUser user, bool isPersistent)
        {
            IAuthenticationManager authenticationManager = HttpContext.Current.GetOwinContext().Authentication;
            authenticationManager.SignOut(DefaultAuthenticationTypes.ExternalCookie);
            var identity = manager.CreateIdentity(user, DefaultAuthenticationTypes.ApplicationCookie);
            authenticationManager.SignIn(new AuthenticationProperties() { IsPersistent = isPersistent }, identity);

            Logic.logicUnit lUnit = new Logic.logicUnit();
            var collegeClassUserID = lUnit.getCollegeClassUserID(user.UserName);

            var cookies = HttpContext.Current.Response.Cookies;

            cookies.Add(new HttpCookie("yuQ11UserName",HttpUtility.UrlEncode(user.UserName,System.Text.Encoding.UTF8)));
            cookies.Add(new HttpCookie("yuQ11UserNickName",HttpUtility.UrlEncode(user.userNickName,System.Text.Encoding.UTF8)));
            cookies.Add(new HttpCookie("yuQ11UserSex",HttpUtility.UrlEncode(user.userSex.ToString(),System.Text.Encoding.UTF8)));
            cookies.Add(new HttpCookie("yuQ11UserLongPhone",HttpUtility.UrlEncode(user.userLongPhone.ToString(),System.Text.Encoding.UTF8)));
            cookies.Add(new HttpCookie("yuQ11UserShortPhone",HttpUtility.UrlEncode(user.userShortPhone.ToString(),System.Text.Encoding.UTF8)));
            cookies.Add(new HttpCookie("yuQ11UserClassID", collegeClassUserID.classID.ToString()));
            cookies.Add(new HttpCookie("yuQ11UserCollegeID",collegeClassUserID.collegeID.ToString()));


        }
        //private async System.Threading.Tasks.Task SignInAsync(UserManager manager, ApplicationUser user, bool isPersistent)
        //{
        //    IAuthenticationManager authenticationManager = HttpContext.Current.GetOwinContext().Authentication;
        //    authenticationManager.SignOut(DefaultAuthenticationTypes.ExternalCookie);
        //    var identity = await manager.CreateIdentityAsync(user, DefaultAuthenticationTypes.ApplicationCookie);
        //    authenticationManager.SignIn(new AuthenticationProperties() { IsPersistent = isPersistent }, identity);
        //}

        public const string ProviderNameKey = "YuQ11";
        public static string GetProviderNameFromRequest(HttpRequest request)
        {
            return request[ProviderNameKey];
        }

        public static string GetExternalLoginRedirectUrl(string accountProvider)
        {
            return "/Account/RegisterExternalLogin?" + ProviderNameKey + "=" + accountProvider;
        }

        private static bool IsLocalUrl(string url)
        {
            return !string.IsNullOrEmpty(url) && ((url[0] == '/' && (url.Length == 1 || (url[1] != '/' && url[1] != '\\'))) || (url.Length > 1 && url[0] == '~' && url[1] == '/'));
        }

        public static void RedirectToReturnUrl(string returnUrl, HttpResponse response)
        {
            if (!String.IsNullOrEmpty(returnUrl) && IsLocalUrl(returnUrl))
            {
                response.Redirect(returnUrl);
            }
            else
            {
                response.Redirect("~/");
            }
        }
    }
    #endregion
}