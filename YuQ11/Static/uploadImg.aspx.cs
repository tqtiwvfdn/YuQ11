using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.IO;

namespace YuQ11.Static
{
    public partial class uploadImg : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Request.ContentType = "application/x-www-form-urlencoded";
            Response.Clear();
            if (string.IsNullOrEmpty(Request["imgData"]))
            {
                ThrowError("noOption");
            }
            else
            {
                string data = Request["imgData"];

                string type = data.Substring(data.IndexOf('/') + 1, data.IndexOf(';') - data.IndexOf('/') - 1);
                String fileName = Server.MapPath(string.Format("Images\\{0}{1}.{2}", DateTime.Now.ToString("yyyyMMddHHmmss"), Guid.NewGuid().ToString(), type));
                data = data.Substring(data.IndexOf(',') + 1);
                try
                {
                    BinaryWriter writer = new BinaryWriter(File.Open(fileName, FileMode.OpenOrCreate));
                    writer.Write(Convert.FromBase64String(data));
                    writer.Flush();
                    writer.Close();
                    Response.Write("{status:'success','name':'" + fileName.Substring(fileName.LastIndexOf('\\') + 1) + "'}");
                }
                 catch (Exception ex)
                {
                    ThrowError(ex.Message);
                }
            }
            Response.End();
        }

        protected void ThrowError(string error)
        {
            switch (error)
            {
                case "noOption":
                    Response.Write("{status:'fail',msg:'无参数或无效参数。'}");
                    break;
                case "writerError":
                    Response.Write("{status:'fail',msg:'无法写入文件。'}");
                    break;
                default:
                    Response.Write("{status:'fail',msg:'" + error + "'}");
                    break;
            }
        }
    }
}