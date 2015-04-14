using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;

namespace YuQ11.YuQ11Admin
{
    public partial class NewsManageMent : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //引用外部css
            HtmlLink link = new HtmlLink();
            link.Attributes.Add("type", "text/css");
            link.Attributes.Add("rel", "stylesheet");
            link.Attributes.Add("href", "~/Content/font-awesome.css");
            Page.Header.Controls.Add(link);
        }
    }
}