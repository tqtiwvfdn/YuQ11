using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.IO;

namespace YuQ11.Static
{
    public partial class wrtieCollegeAndClassList : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            StringBuilder stringBuilder = new StringBuilder();
            YuQ11.Logic.logicUnit _unit = new Logic.logicUnit();


            var colleges = _unit.getCollegeList();
            stringBuilder.Append("var colleges={");
            foreach (var college in colleges)
            {
                stringBuilder.Append("'" + college.collegeID + "':'" + college.collegeName + "',");
            }


            var classes = _unit.getCollegeAndClassList();
            int collegeID = -1;
            stringBuilder.Append("},classes={'-1':{");
            foreach (var singleClass in classes)
            {
                if (collegeID != singleClass.collegeID)
                {
                    collegeID = singleClass.collegeID;
                    stringBuilder.Append("},'" + singleClass.collegeID + "':{");
                }
                stringBuilder.Append("'" + singleClass.classID + "':'" + singleClass.className + "',\r");
            }
            stringBuilder.Append("}};");


            StreamWriter streamWriter = null;
            String fileName = Server.MapPath("Scripts\\units.js");
            try
            {
                streamWriter = new System.IO.StreamWriter(
                    fileName,
                    false,
                    Encoding.UTF8);
                streamWriter.Write(stringBuilder.ToString());
                streamWriter.Flush();
                streamWriter.Close();
                Response.Write(fileName + " 生成成功！");
            }
            catch (Exception ex)
            {
                Response.Write(ex.Message);
            }
        }
    }
}