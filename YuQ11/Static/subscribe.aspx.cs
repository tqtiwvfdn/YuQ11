using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.IO;

namespace YuQ11.Static
{
    public partial class subscribe : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Logic.logicSubscribe lSubscribe = new Logic.logicSubscribe();
            Response.Clear();
            switch (Request["action"])
            {
                case "cancelSubscribe":
                    Response.Write(lSubscribe.cancelSubscribe(Request["userName"], Request["userItem"]));
                    break;
                case "subscribe":
                    FileStream fileStream = new FileStream(Server.MapPath("Config\\itemLimited.config"), FileMode.Open, FileAccess.Read);
                    BinaryReader binaryReader = new BinaryReader(fileStream);
                    Response.Write(lSubscribe.subscribe(Request["classID"], Request["userName"], Request["userItem"], binaryReader.ReadInt32()));
                    binaryReader.Close();
                    fileStream.Close();
                    break;
                case "resetSubscribe":
                    Response.Write(lSubscribe.resetSubscribe(Request["collegeID"]));
                    break;
                case "checkIn":
                case "cancelCheckIn":
                    Response.Write(lSubscribe.checkIn(Request["subscribeID"], Request["action"]));
                    break;
                default:
                    break;
            }
            Response.End();
        }
    }
}