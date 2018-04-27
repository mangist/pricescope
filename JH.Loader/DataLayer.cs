using JH.Loader.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace JH.Loader
{
    public class DataLayer
    {
        public List<Item> GetItems()
        {
            return new List<Item>
            {
                new Item
                {
                    Id = 1,
                    Name = "US Gold $20 Double Eagle",
                    eBayCategoryId = 39472,
                    FirstYear = 1907,
                    LastYear = 1933
                }
            };
        }
    }
}
