using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace YuQ11.Logic
{
    public class logicSportItem
    {
        Models.YuQ11Context yuQ11Context;

        public logicSportItem()
        {
            yuQ11Context = new Models.YuQ11Context();
        }

        public List<Models.SportItem> getSportItemList()
        {
            return yuQ11Context.SportItems.OrderBy(p => p.itemName).OrderBy(p=>p.itemSex).ToList();
        }

        public string addSportItem(
            string newItemName,
            string newItemSex,
            string newItemRange,
            string newItemType,
            string newItemPlace,
            string IsLimit,
            string newItemSite,
            string isPreliminaries
            )
        {
            Models.SportItem item = new Models.SportItem()
            {
                itemName = newItemName,
                itemRange = newItemRange,
                itemSex = short.Parse(newItemSex),
                itemType = short.Parse(newItemType),
                itemPlace = int.Parse(newItemPlace),
                isLimit = IsLimit == "false" ? false : true,
                itemSite = newItemSite,
                isPreliminaries = isPreliminaries == "false" ? false : true,
            };
            try
            {
                yuQ11Context.SportItems.Add(item);
                yuQ11Context.SaveChanges();
            }
            catch (Exception ex)
            {
                return ("{id:-1,msg:'" + ex.Message + "'}");
            }
            return ("{id:" + item.itemID.ToString() + "}");
        }
        public string delSportItem(string ItemID)
        {
            try
            {
                int iItemID = Int32.Parse(ItemID);
                Models.SportItem item = yuQ11Context.SportItems.FirstOrDefault(p => p.itemID == iItemID);
                yuQ11Context.SportItems.Remove(item);
                yuQ11Context.SaveChanges();
            }
            catch (Exception ex)
            {
                return ("{id:-1,msg:'" + ex.Message + "'}");
            }
            return ("{id:" + ItemID + "}");
        }
        public string editSportItem(
            string ItemID,
            string ItemName,
            string ItemSex,
            string ItemRange,
            string ItemType,
            string ItemPlace,
            string IsLimit,
            string ItemSite,
            string isPreliminaries)
        {
            try
            {
                int iItemID = Int32.Parse(ItemID);
                Models.SportItem item = yuQ11Context.SportItems.FirstOrDefault(p => p.itemID == iItemID);
                item.itemName = ItemName;
                item.itemRange = ItemRange;
                item.itemSex = short.Parse(ItemSex);
                item.itemType = short.Parse(ItemType);
                item.itemPlace = int.Parse(ItemPlace);
                item.isLimit = IsLimit == "false" ? false : true;
                item.isPreliminaries = isPreliminaries == "false" ? false : true;
                item.itemSite = ItemSite;
                yuQ11Context.SaveChanges();
            }
            catch (Exception ex)
            {
                return ("{id:-1,msg:'" + ex.Message + "'}");
            }
            return ("{id:" + ItemID + "}");
        }
    }
}