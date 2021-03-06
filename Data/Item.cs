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
    
    public partial class Item
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public Item()
        {
            this.PriceSources = new HashSet<PriceSource>();
            this.ItemStats = new HashSet<ItemStat>();
        }
    
        public int Id { get; set; }
        public string Description { get; set; }
        public int MintId { get; set; }
        public int MetalId { get; set; }
        public decimal TotalWeight { get; set; }
        public int UomId { get; set; }
        public int PurityId { get; set; }
        public decimal ActualMetalWeightTroyOz { get; set; }
        public Nullable<int> EBayCategoryId { get; set; }
        public Nullable<int> FirstYear { get; set; }
        public Nullable<int> LastYear { get; set; }
        public bool Active { get; set; }
        public System.DateTime DateCreated { get; set; }
        public Nullable<System.DateTime> DateUpdated { get; set; }
    
        public virtual Metal Metal { get; set; }
        public virtual Mint Mint { get; set; }
        public virtual Uom Uom { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<PriceSource> PriceSources { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<ItemStat> ItemStats { get; set; }
    }
}
