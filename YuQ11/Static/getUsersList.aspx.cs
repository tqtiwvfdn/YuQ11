using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.IO;

namespace YuQ11.Static
{
    public partial class getUsersList : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
                Logic.logicUnit lUnit = new Logic.logicUnit();
            if (!string.IsNullOrWhiteSpace(Request["usersInfo"]))
            {
                int outCollegeID;
                if (Int32.TryParse(Request["collegeID"], out outCollegeID))
                {
                    writeUsersList(lUnit.getUsersList(Request["usersInfo"], Int32.Parse(Request["collegeID"])));
                }
                else
                {
                    writeUsersList(lUnit.getUsersList(Request["usersInfo"], Request["collegeID"]));
                }
            }
            else if (!string.IsNullOrWhiteSpace(Request["classList"]))
            {
                writeUsersList(lUnit.getUsersList(Request["classList"]));
            }
            else if (!string.IsNullOrWhiteSpace(Request["userRole"]))
            {
                writeUsersList(lUnit.getUsersListByRole(Request["userRole"], Request["collegeID"]));
            }
            else
            {
                Response.Write("[]");
            }
        }

        protected void writeUsersList(IQueryable<Models.UsersList> usersList)
        {
            StringBuilder usersListStr = new StringBuilder();
            usersListStr.Append("([");
            if (usersList!=null&&usersList.First()!=null)
            {
                foreach (var user in usersList)
                {
                    usersListStr.Append("{className:'" + user.className + "',userName:'" + user.userName +
                        "',userLongPhone:'" + user.userLongPhone + "',userShortPhone:'" + user.userShortPhone +
                        "',userNickName:'" + user.userNickName + "',userSex:'" + user.userSex + "',userRole:'" + user.userRole +
                        "',itemIDs:'" + user.itemIDs + "'},");
                }
            }
            usersListStr.Append("])");
            Response.Write(usersListStr.ToString());
        }
    }
}