using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace JH.Loader.Models
{
    public class Item
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public int eBayCategoryId { get; set; }
        public int FirstYear { get; set; }
        public int LastYear { get; set; }
    }
}
