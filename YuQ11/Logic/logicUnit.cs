using System;
using System.Linq;
using System.Collections.Generic;
using YuQ11.Models;
using System.Data.Common;


namespace YuQ11.Logic
{
    public class logicUnit
    {
        YuQ11Context yuQ11context;

        public logicUnit()
        {
            yuQ11context = new YuQ11Context();
        }

        //获取学院列表
        public List<Department> getCollegeList()
        {
            return yuQ11context.Departments.ToList();
        }

        //获取班级列表
        public List<DepartmentsAndUnits> getCollegeAndClassList()
        {
            return yuQ11context.DepartmentsAndUnits.ToList();
        }

        //获取用户列表
        public IQueryable<Models.UsersList> getUsersList(string keyword, int collegeID)
        {
            return yuQ11context.UsersLists
                .Where(p => (p.className + p.userName + p.userNickName + p.userLongPhone + p.userShortPhone).Contains(keyword.Trim()) && p.collegeID == collegeID)
                .Take(100).DefaultIfEmpty(); ;
        }

        public Models.UsersList getUser(string userName)
        {
            return yuQ11context.UsersLists.FirstOrDefault(p => p.userName == userName);
        }
        public IQueryable<Models.UsersList> getUsersList(string classID)
        {
            long lClassID;
            if (Int64.TryParse(classID, out lClassID))
            {
                return yuQ11context.UsersLists.Where(p => p.classID == lClassID).DefaultIfEmpty();
            }
            else
            {
                return null;
            }
        }

        public IQueryable<Models.UsersList> getUsersList(string keyword, string collegeName)
        {
            return (collegeName == "all" ? yuQ11context.UsersLists
                .Where(p => (p.className + p.userName + p.userNickName + p.userLongPhone + p.userShortPhone).Contains(keyword.Trim()))
                .Take(100).DefaultIfEmpty() : null);
        }
        public IQueryable<Models.UsersList> getUsersListByRole(string userRole, string collegeID)
        {
            if (userRole == Static.Variable.roleAdministrators || collegeID.Trim()=="all")
            {
                return yuQ11context.UsersLists.Where(p => p.userRole == userRole).DefaultIfEmpty();
            }
            else
            {
                int iCollegeID;
                if (int.TryParse(collegeID.Trim(), out iCollegeID))
                {
                    return yuQ11context.UsersLists.Where(p => p.userRole == (userRole.Trim()) && p.collegeID == iCollegeID);
                }
                else
                {
                    return null;
                }
            }
        }

        //获取用户、班级、学院对应ID列表
        public Models.CollegeClassUserID getCollegeClassUserID(string userName)
        {
            return yuQ11context.CollegeClassUserIDs.FirstOrDefault(p => p.userName == userName);
        }
    }
}