using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using YuQ11.Models;
using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.EntityFramework;

namespace YuQ11.Logic
{
    internal class logicRole
    {

        internal void AddRoleAndAdminstration()
        {
            ApplicationDbContext context = new ApplicationDbContext();
            IdentityResult idRoleResult;
            IdentityResult idUserResult;


            var roleStore = new RoleStore<IdentityRole>(context);
            var roleMgr = new RoleManager<IdentityRole>(roleStore);

            if (!roleMgr.RoleExists(Static.Variable.roleAdministrators))
            {
                idRoleResult = roleMgr.Create(new IdentityRole { Name = Static.Variable.roleAdministrators });
                idRoleResult = roleMgr.Create(new IdentityRole { Name = Static.Variable.roleSportsLeaders });
                idRoleResult = roleMgr.Create(new IdentityRole { Name = Static.Variable.roleOperators });
                idRoleResult = roleMgr.Create(new IdentityRole { Name = Static.Variable.roleUsers});
            }

            var userMgr = new UserManager<ApplicationUser>(new UserStore<ApplicationUser>(context));
            var appUser = new ApplicationUser
            {
                UserName="201130720310",
                userClassID=45,
                userNickName="黎健成",
                userLongPhone="18826495458",
                userShortPhone="625458",
                userSex=0
            };
            idUserResult = userMgr.Create(appUser, "272006764");

            if (!userMgr.IsInRole(userMgr.FindByName("201130720310").Id, Static.Variable.roleAdministrators))
            {
                userMgr.AddToRoleAsync(userMgr.FindByName("201130720310").Id, Static.Variable.roleAdministrators);
            }
        }
    }
}