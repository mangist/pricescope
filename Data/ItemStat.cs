//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace JH.PriceScope.Data
{
    using System;
    using System.Collections.Generic;
    
    public partial class ItemStat
    {
        public int Id { get; set; }
        public int ItemId { get; set; }
        public int ItemYear { get; set; }
        public string MintMark { get; set; }
        public int GradeId { get; set; }
        public int GradingServiceId { get; set; }
        public Nullable<int> Population { get; set; }
        public Nullable<decimal> PriceGuide { get; set; }
        public System.DateTime LastUpdate { get; set; }
    
        public virtual Grade Grade { get; set; }
        public virtual GradingService GradingService { get; set; }
        public virtual Item Item { get; set; }
    }
}
