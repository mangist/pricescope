﻿//------------------------------------------------------------------------------
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
    using System.Data.Entity;
    using System.Data.Entity.Infrastructure;
    
    public partial class PriceScopeEntities : DbContext
    {
        public PriceScopeEntities()
            : base("name=PriceScopeEntities")
        {
        }
    
        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            throw new UnintentionalCodeFirstException();
        }
    
        public virtual DbSet<Designation> Designations { get; set; }
        public virtual DbSet<Grade> Grades { get; set; }
        public virtual DbSet<GradingService> GradingServices { get; set; }
        public virtual DbSet<Item> Items { get; set; }
        public virtual DbSet<ItemPrice> ItemPrices { get; set; }
        public virtual DbSet<Metal> Metals { get; set; }
        public virtual DbSet<Mint> Mints { get; set; }
        public virtual DbSet<PriceSource> PriceSources { get; set; }
        public virtual DbSet<Purity> Purities { get; set; }
        public virtual DbSet<Source> Sources { get; set; }
        public virtual DbSet<StrikeCharacter> StrikeCharacters { get; set; }
        public virtual DbSet<StrikeType> StrikeTypes { get; set; }
        public virtual DbSet<Uom> Uoms { get; set; }
    }
}
