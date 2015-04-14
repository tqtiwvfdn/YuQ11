using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.IO;

namespace YuQ11.Static
{
    public partial class writerSportItems : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            StringBuilder stringBuilder = new StringBuilder();
            Logic.logicSportItem _item = new Logic.logicSportItem();
            if (Request["opr"] != null)
            {
                Response.Write((Request["opr"] == "del" ?
                    _item.delSportItem(Request["ItemID"]) :
                    _item.editSportItem(Request["ItemID"], Request["ItemName"], Request["ItemSex"], Request["ItemRange"], Request["ItemType"], Request["ItemPlace"], Request["IsLimit"], Request["ItemSite"], Request["IsPreliminaries"])).Replace("\n", ""));
            }
            else if (Request["ItemName"] != null)
            {
                Response.Write(_item.addSportItem(Request["ItemName"], Request["ItemSex"], Request["ItemRange"], Request["ItemType"], Request["ItemPlace"], Request["IsLimit"], Request["ItemSite"], Request["IsPreliminaries"]).Replace("\n", ""));
            }

            var items = _item.getSportItemList();
            stringBuilder.Append("var items={'Sex2':{");
            short itemSex = -1;
            string itemSexChar = string.Empty;
            foreach (var item in items)
            {
                if (itemSex != item.itemSex)
                {
                    itemSex = item.itemSex;
                    itemSexChar = itemSex == 0 ? "男子" : "女子";
                    stringBuilder.Append("},'Sex" + itemSex + "':{");
                }
                stringBuilder.Append("'" +
                    item.itemID + "':{'Name':'" + itemSexChar + item.itemName + "',\r"
                    + "'Range':'" + item.itemRange + "',\r"
                    + "'Place':" + item.itemPlace + ",\r"
                    + "'Site':'" + item.itemSite + "',\r"
                    + "'IsLimit':" + item.isLimit.ToString().ToLower() + ",\r"
                    + "'IsPreliminaries':" + item.isPreliminaries.ToString().ToLower() + ",\r"
                    + "'Type':'" + (item.itemType == 0 ? "径" : "田") + "赛'},\r");
            }
            stringBuilder.Append("}};");
            StreamWriter streamWriter = null;

            String fileName = Server.MapPath("Scripts\\items.js");
            try
            {
                streamWriter = new System.IO.StreamWriter(
                    fileName,
                    false,
                    Encoding.UTF8);
                streamWriter.Write(stringBuilder.ToString());
                streamWriter.Flush();
                streamWriter.Close();
            }
            catch (Exception ex)
            {
                Response.Write(ex.Message);
            }
        }
    }
}