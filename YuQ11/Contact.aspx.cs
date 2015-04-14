using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text;

namespace YuQ11
{
    public partial class Contact : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string collegeID = Request.Cookies.Get("yuQ11UserCollegeID").Value;
            if (!string.IsNullOrEmpty(collegeID))
            {
                Logic.logicUnit lUnit = new Logic.logicUnit();
                adminList.InnerHtml += getHTMLString(lUnit.getUsersListByRole(Static.Variable.roleAdministrators, collegeID).ToList());
                operatorList.InnerHtml += getHTMLString(lUnit.getUsersListByRole(Static.Variable.roleOperators, collegeID).ToList());

            }
        }

        protected string getHTMLString(List<Models.UsersList> userList)
        {
            StringBuilder stringBuilder = new StringBuilder();
            if (userList.Count > 0)
            {
                foreach (var p in userList)
                {
                    stringBuilder.Append( "<span class='list-group-item'>" + p.userNickName + "<a href='tel:" + p.userLongPhone + "' class='badge'>" + p.userLongPhone + "</a><a href='tel:" + p.userShortPhone + "' class='badge'>" + p.userShortPhone + "</a></span>" );
                }
            }
            else
            {
                stringBuilder.Append("<span class='list-group-item'>暂无人员</span>");
            }

            return stringBuilder.ToString();
        }
    }
}