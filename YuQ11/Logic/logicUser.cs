using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using YuQ11.Models;

namespace YuQ11.Logic
{
    public class logicUser
    {
        YuQ11Context yuQ11Context;
        public logicUser()
        {
            yuQ11Context = new YuQ11Context();
        }


        public string editUserInfo(string userName, string userLongPhone, string userShortPhone)
        {
            var user = yuQ11Context.AspNetUsers.First(p => p.UserName == userName);
            string response = "{userName:1}";
            if (user == null)
            {
                response = "{userName:-1,msg:'找不到用户'}";
            }
            else
            {
                user.userLongPhone = userLongPhone;
                user.userShortPhone = userShortPhone;
                try
                {
                    yuQ11Context.SaveChangesAsync();
                }
                catch (Exception ex)
                {
                    return "{userName:-1,msg:'" + ex.Message + "}";
                }
            }
            return response;
        }
        public string changeUserRole(string userName, string userRole)
        {
            string response = "{userName:1}";
            string adminID = yuQ11Context.AspNetRoles.First(p => p.name == Static.Variable.roleAdministrators).ID;



            Models.AspNetRole role = yuQ11Context.AspNetRoles.First(p => p.name == userRole);
            Models.AspNetUser user=yuQ11Context.AspNetUsers.First(p=>p.UserName==userName);

            if (role != null && user != null)
            {
                Models.AspNetUserRole userRoleLink = yuQ11Context.AspNetUserRoles.First(p => p.userID == user.Id);
                if (userRoleLink != null)
                {
                    if (!HttpContext.Current.User.IsInRole(Static.Variable.roleAdministrators) && userRoleLink.roleID == adminID)
                    {
                        response = "{userName:-1,msg:'您没有足够的权限对上一级用户进行权限控制。'}";
                    }
                    else
                    {
                        userRoleLink.roleID = role.ID;
                        try
                        {
                            yuQ11Context.SaveChangesAsync();
                        }
                        catch (Exception ex)
                        {
                            return "{userName:-1,msg:'" + ex.Message + "'}";
                        }
                    }
                }
                else
                {
                    userRoleLink = new AspNetUserRole()
                    {
                        userID = user.Id,
                        roleID = role.ID
                    };
                    try
                    {
                        yuQ11Context.AspNetUserRoles.Add(userRoleLink);
                        yuQ11Context.SaveChangesAsync();
                    }
                    catch (Exception ex)
                    {
                        return "{userName:-1,msg:'" + ex.Message + "'}";
                    }
                }
            }
            else
            {
                return "{userName:-1,msg:'找不到该用户或角色'}";
            }

            return response;
        }
        public string resetPassword(string userName)
        {
            var user = yuQ11Context.AspNetUsers.First(p => p.UserName == userName);
            string response = "{userName:1}";
            if (user == null)
            {
                response = "{userName:-1,msg:'找不到该用户！'}";
            }
            else
            {
                user.PasswordHash = "AAVKORbOq/eMyOELEhkJK6Y2GhY+C6cKA0A3I2m1RBNFQoO6U5tJyXpo3E8SZWBWvw==";
                user.SecurityStamp = "5e0aa8de-cf71-427b-8a64-2be8b7384c29";
                try
                {
                    yuQ11Context.SaveChangesAsync();
                }
                catch (Exception ex)
                {
                    return  "{userName:-1,msg:'" + ex.Message + "'}";
                }
            }
            return response;
        }

        //获取用户信息
    }
}