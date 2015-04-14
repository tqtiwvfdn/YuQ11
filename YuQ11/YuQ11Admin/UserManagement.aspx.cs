using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace YuQ11.YuQ11Admin
{
    public partial class UserManagement : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (HttpContext.Current.User.IsInRole(Static.Variable.roleAdministrators))
            {
                //搜索选择学院
                CollegeListContainer.Visible = true;
                //搜索选择角色
                SelectRoleAdministrorsOption.Visible = true;
                //权限选择角色
                RoleAdministrorsOption.Visible = true;
            }
        }
    }
}