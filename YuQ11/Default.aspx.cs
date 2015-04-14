using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace YuQ11
{
    public partial class _Default : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!string.IsNullOrEmpty(HttpContext.Current.User.Identity.Name)&& string.IsNullOrEmpty(Request.Cookies["yuQ11UserName"].ToString()))
            {
                Logic.logicUnit lUnit = new Logic.logicUnit();
                var user = lUnit.getUser(HttpContext.Current.User.Identity.Name);

                var cookies = HttpContext.Current.Response.Cookies;

                cookies.Add(new HttpCookie("yuQ11UserName", HttpUtility.UrlEncode(user.userName, System.Text.Encoding.UTF8)));
                cookies.Add(new HttpCookie("yuQ11UserNickName", HttpUtility.UrlEncode(user.userNickName, System.Text.Encoding.UTF8)));
                cookies.Add(new HttpCookie("yuQ11UserSex", HttpUtility.UrlEncode(user.userSex.ToString(), System.Text.Encoding.UTF8)));
                cookies.Add(new HttpCookie("yuQ11UserLongPhone", HttpUtility.UrlEncode(user.userLongPhone.ToString(), System.Text.Encoding.UTF8)));
                cookies.Add(new HttpCookie("yuQ11UserShortPhone", HttpUtility.UrlEncode(user.userShortPhone.ToString(), System.Text.Encoding.UTF8)));
                cookies.Add(new HttpCookie("yuQ11UserClassID", user.classID.ToString()));
                cookies.Add(new HttpCookie("yuQ11UserCollegeID", user.collegeID.ToString()));
            }
        }
    }
}