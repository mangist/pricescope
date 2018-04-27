using JH.PriceScope.Data.Enums;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace JH.PriceScope.Data
{
    public class DataLayer
    {
        private PriceScopeEntities GetDbContext()
        {
            return new PriceScopeEntities();
        }

        #region Items

        // Returns a list of the items in the database
        public List<Item> GetItems(Metals? metal = null)
        {
            using (var dbContext = GetDbContext())
            {
                return dbContext.Items
                                .Where(i => i.MetalId == (int)metal || metal == null)
                                .ToList();
            }
        }

        public List<Item> GetGoldItems()
        {
            return GetItems(Metals.Gold);
        }

        public List<Item> GetSilverItems()
        {
            return GetItems(Metals.Silver);
        }

        #endregion

        #region Price Sources

        public List<PriceSource> GetEBayPriceSources()
        {
            using (var dbContext = GetDbContext())
            {
                return dbContext.PriceSources.Where(p => p.SourceId == 1 && p.Active).ToList();
            }
        }

        public List<PriceSource> GetWebPriceSources()
        {
            using (var dbContext = GetDbContext())
            {
                return dbContext.PriceSources.Where(p => p.SourceId != 1 && p.Active).ToList();
            }
        }

        public void UpdateItemPrice(ItemPrice itemPrice, bool hasError, string error)
        {
            using (var dbContext = GetDbContext())
            {
                using (var trans = dbContext.Database.BeginTransaction())
                {
                    try
                    {
                        // Add the item price
                        dbContext.ItemPrices.Add(itemPrice);

                        // Update price source 
                        var ps = dbContext.PriceSources.Single(p => p.Id == itemPrice.PriceSourceId);

                        ps.LastChecked = itemPrice.UpdateTime;
                        ps.HasError = hasError;
                        ps.LastError = error;

                        // Commit changes
                        dbContext.SaveChanges();

                        trans.Commit();
                    }
                    catch (Exception ex)
                    {
                        trans.Rollback();
                    }
                }
            }
        }

        public void UpdatePriceSourceError(int id, string message)
        {
            using (var dbContext = GetDbContext())
            {
                var ps = dbContext.PriceSources.Single(p => p.Id == id);
                ps.HasError = true;
                ps.LastError = message;

                dbContext.SaveChanges();
            }
        }

        #endregion

    }
}
