using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI.HtmlControls;

namespace YuQ11.YuQ11Admin
{
    public partial class SubscribesManagement : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //引用外部css
            //HtmlLink link = new HtmlLink();
            //link.Attributes.Add("type", "text/css");
            //link.Attributes.Add("rel", "stylesheet");
            //link.Attributes.Add("href", "~/Content/jquery.datetimepicker.css");
            //Page.Header.Controls.Add(link);

            if (HttpContext.Current.User.IsInRole(Static.Variable.roleAdministrators))
            {
                //重置报名
                resetSubscribeContainer.Visible = true;
                //搜索选择学院
                CollegeListContainer.Visible = true;
            }
        }
    }
}