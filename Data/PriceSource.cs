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
    
    public partial class PriceSource
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public PriceSource()
        {
            this.ItemPrices = new HashSet<ItemPrice>();
        }
    
        public int Id { get; set; }
        public int ItemId { get; set; }
        public int GradeId { get; set; }
        public Nullable<int> GradingServiceId { get; set; }
        public int SourceId { get; set; }
        public int ItemYearFrom { get; set; }
        public int ItemYearTo { get; set; }
        public string MintMark { get; set; }
        public string WebsiteUrl { get; set; }
        public string ElementQuery { get; set; }
        public string eBayQuery { get; set; }
        public Nullable<System.DateTime> LastChecked { get; set; }
        public bool HasError { get; set; }
        public string LastError { get; set; }
        public bool Active { get; set; }
    
        public virtual Grade Grade { get; set; }
        public virtual GradingService GradingService { get; set; }
        public virtual Item Item { get; set; }
        public virtual Source Source { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<ItemPrice> ItemPrices { get; set; }
    }
}
