using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.IO;

namespace YuQ11.Static
{
    public partial class setItemLimited : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            int itemLimitedCount = 2;
            string fileName = Server.MapPath("Config\\itemLimited.config");
            string msg = string.Empty;
            string status = "success";
            Response.Clear();
            if (Request["itemLimitedCount"] != null&&int.TryParse(Request["itemLimitedCount"],out itemLimitedCount))
            {
                try
                {
                    FileStream fileStream = new FileStream(Server.MapPath("Config\\itemLimited.config"), FileMode.OpenOrCreate, FileAccess.Write);
                    BinaryWriter binaryWriter = new BinaryWriter(fileStream);
                    binaryWriter.Write(itemLimitedCount);
                    binaryWriter.Close();
                    fileStream.Close();
                }
                catch (Exception ex)
                {
                    status = "fail";
                    msg = ex.Message;
                }
            }
            else
            {
                status = "fail";
                msg = "限制数量为空或为非数字";
            }
            Response.Write(string.Format("{{status:'{0}',msg:'{1}'}}", status, msg));
            Response.End();
        }
    }
}