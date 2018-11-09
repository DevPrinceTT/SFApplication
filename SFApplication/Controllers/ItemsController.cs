using SFApplication.Helpers;
using SFApplication.Models;
using SFApplication.ViewModels;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Data.Entity;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Script.Serialization;
using WebMatrix.WebData;

namespace SFApplication.Controllers
{
    public class ItemsController : Controller
    {
        ForecastDBEntities db = new ForecastDBEntities();

        #region // GET:
        // GET: Items
        public ActionResult Index()
        {
            if (!WebSecurity.IsAuthenticated)
            {
                return RedirectToAction("Logout", "Account");
            }

            db.Database.ExecuteSqlCommand("EXEC AAA2018_SYNC_GP_ITEMS");

            return View();
        }

        // GET: Items/AddItem
        public ActionResult AddItem()
        {
            if (!WebSecurity.IsAuthenticated)
            {
                return RedirectToAction("Login", "Account");
            }

            return PartialView();
        }

        // GET: Items/EditItem/1
        public ActionResult EditItem(int id)
        {
            if (!WebSecurity.IsAuthenticated)
            {
                ViewBag.CloseWindow = true;
                ViewBag.LogoutUser = true;
                return RedirectToAction("Logout", "Account");
            }

            if(id < 1)
            {
                ViewBag.Message = "Item not found!";
                ViewBag.CloseWindow = true;
                return View();
            }

            gp_InventoryItems dbitem = db.gp_InventoryItems.Find(id);
            if(id < 1 || dbitem == null)
            {
                ViewBag.Message = "Item not found!";
                ViewBag.CloseWindow = true;
                return View();
            }
            gp_InventoryItems current_item = db.gp_InventoryItems.AsNoTracking().Where(d => d.ItemId == id).First();

            mdl_Item item = new mdl_Item();
            item.ItemId = dbitem.ItemId;
            item.VendorItemNumber = dbitem.VNDITNUM;
            item.VendorItemDescription = dbitem.VNDITDSC;
                       
            return PartialView(item);
        }

        #endregion

        #region // POST:

        [HttpPost]
        public JsonNetResult AddItem(string collection)
        {
            //server response
            obj_ServerResponse response = new obj_ServerResponse();
            int affectedRows = 0;

            JavaScriptSerializer jsonSerializer = new JavaScriptSerializer();
            mdl_Item item = jsonSerializer.Deserialize<mdl_Item>(collection);
            var context = new ValidationContext(item);
            var results = new List<ValidationResult>();
            if (Validator.TryValidateObject(item, context, results, true))
            {
                //validate existing vendor item number
                IQueryable<gp_InventoryItems> existingItems = db.gp_InventoryItems.Where(d => d.VNDITNUM == item.VendorItemNumber);
                if(existingItems.Count() > 0)
                {
                    response.MessageType = "warning";
                    response.Message = "An item already has that vendor code, try again!";
                    response.ShowDialog = true;

                    return new JsonNetResult(response);
                }

                gp_InventoryItems dbItem = new gp_InventoryItems();
                dbItem.VNDITNUM = item.VendorItemNumber;
                dbItem.VNDITDSC = item.VendorItemDescription;
                dbItem.CustomItem = true;
                dbItem.DateCreated = DateTime.Now;

                db.gp_InventoryItems.Add(dbItem);
                affectedRows = db.SaveChanges();

                if (affectedRows > 0)
                {
                    response.MessageType = "success";
                    response.Message = "Item added successfully!";
                    response.ShowDialog = true;
                }
                else
                {
                    response.MessageType = "danger";
                    response.Message = "There was a problem saving this item!";
                    response.ShowDialog = true;
                }

            }
            else
            {
                response.Errors = results.Select(d => new KeyValuePair<string, string>(d.MemberNames.First().ToString(), d.ErrorMessage));
            }

            return new JsonNetResult(response);
        }


        [HttpPost]
        public JsonNetResult EditItem(string collection)
        {
            //server response
            obj_ServerResponse response = new obj_ServerResponse();
            int affectedRows = 0;

            JavaScriptSerializer jsonSerializer = new JavaScriptSerializer();
            mdl_Item item = jsonSerializer.Deserialize<mdl_Item>(collection);
            var context = new ValidationContext(item);
            var results = new List<ValidationResult>();
            if (Validator.TryValidateObject(item, context, results, true))
            {
                gp_InventoryItems dbItem = db.gp_InventoryItems.Find(item.ItemId);
                if(dbItem == null)
                {
                    //item not found
                    response.MessageType = "warning";
                    response.Message = "Item not found!";
                    response.ShowDialog = true;
                }
                
                //validate existing vendor item number
                IQueryable<gp_InventoryItems> existingItems = db.gp_InventoryItems.Where(d => d.VNDITNUM == item.VendorItemNumber && d.ItemId != item.ItemId);
                if (existingItems.Count() > 0)
                {
                    response.MessageType = "warning";
                    response.Message = "An item already has that vendor code, try again!";
                    response.ShowDialog = true;

                    return new JsonNetResult(response);
                }

                //only edit custom, unsynced items
                if (dbItem.CustomItem != true || dbItem.Synced == true )
                {
                    //item not found
                    response.MessageType = "warning";
                    response.Message = "Can't edit this item!";
                    response.ShowDialog = true;
                    return new JsonNetResult(response);
                }


                gp_InventoryItems currentItem = db.gp_InventoryItems.AsNoTracking().Where(d => d.ItemId == item.ItemId).First();

                dbItem.VNDITNUM = item.VendorItemNumber;
                dbItem.VNDITDSC = item.VendorItemDescription;

                db.Entry(dbItem).State = EntityState.Modified;
                affectedRows = db.SaveChanges();

                if (affectedRows > 0)
                {
                    response.MessageType = "success";
                    response.Message = "Item updated successfully!";
                    response.ShowDialog = true;
                }
                else
                {
                    response.MessageType = "warning";
                    response.Message = "There was a problem updating this item!";
                    response.ShowDialog = true;
                }

            }
            else
            {
                response.Errors = results.Select(d => new KeyValuePair<string, string>(d.MemberNames.First().ToString(), d.ErrorMessage));
            }

            return new JsonNetResult(response);
        }

        // POST: Items/DeleteItem/1
        [HttpPost]
        public ActionResult DeleteItem(int id)
        {
            //server response
            obj_ServerResponse response = new obj_ServerResponse();
            int affectedRows = 0;

            gp_InventoryItems dbItem = db.gp_InventoryItems.Find(id);
            if (id < 1 || dbItem == null)
            {
                //item not found
                response.MessageType = "warning";
                response.Message = "Item not found!";
                response.ShowDialog = true;
            }

            //only delete custom, unsynced items
            if (dbItem.CustomItem != true || dbItem.Synced == true)
            {
                //item not found
                response.MessageType = "warning";
                response.Message = "Can't delete this item!";
                response.ShowDialog = true;
                return new JsonNetResult(response);
            }

            db.gp_InventoryItems.Remove(dbItem);
            affectedRows = db.SaveChanges();

            if (affectedRows > 0)
            {
                response.MessageType = "success";
                response.Message = "Item deleted successfully!";
                response.ShowDialog = true;
            }
            else
            {
                response.MessageType = "warning";
                response.Message = "There was a problem deleting this item!";
                response.ShowDialog = true;
            }

            return new JsonNetResult(response);
        }

        #endregion

        #region AJAX

        public JsonNetResult ListItems()
        {
            if (!WebSecurity.IsAuthenticated)
            {
                return null;
            }

            //get items
            IQueryable<mdl_Item> items = db.gp_InventoryItems.Select(d => new mdl_Item()
            {
                CustomItem = d.CustomItem,
                Synced = d.Synced,
                DateCreated = d.DateCreated,
                ItemDescription = d.ITEMDESC,
                ItemId = d.ItemId,
                ItemNumber = d.ITEMNMBR ?? "",
                ItemWeight = d.ITEMSHWT ?? 0,
                Status = ((d.CustomItem ?? false) == true && (d.Synced ?? false) == false) ? "Custom" : (((d.CustomItem ?? false) == true && (d.Synced ?? false) == true) ? "Synced" : ((d.CustomItem ?? false) == false && (d.Synced ?? false) == false) ? "Imported" : ""),
                SyncDate = d.SyncDate,
                VendorId = d.VENDORID ?? "",
                VendorItemDescription = d.VNDITDSC ?? "",
                VendorItemNumber = d.VNDITNUM ?? ""
            });

            return new JsonNetResult(items);
        }

        #endregion
    }
}