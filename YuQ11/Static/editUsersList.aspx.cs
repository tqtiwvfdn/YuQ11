using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace YuQ11.Static
{
    public partial class editUsersList : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (string.IsNullOrWhiteSpace(Request["action"]))
            {
                Response.Write("[]");
            }
            else
            {
                var lUser=new Logic.logicUser();
                switch (Request["action"].Trim())
                {
                    case "resetPassword":
                        Response.Write(lUser.resetPassword(Request["userName"].Trim()));
                        break;
                    case "changeRole":
                        Response.Write(lUser.changeUserRole(Request["userName"].Trim(),
                            Request["userRole"].Trim()));
                        break;
                    default:
                        Response.Write(lUser.editUserInfo(Request["userName"].Trim(),
                            Request["userLongPhone"].Trim(),
                            Request["userShortPhone"].Trim()));
                        break;
                }
            }
        }
    }
}