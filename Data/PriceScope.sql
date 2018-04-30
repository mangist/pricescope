create table Metal (
  Id int not null,
  Description nvarchar(50) not null,
  constraint PK_Metal primary key (Id))
go
insert into Metal values (1, 'Gold')
insert into Metal values (2, 'Silver')
go

create table StrikeType (
  Id varchar(2) not null,
  SortOrder int not null,
  Description nvarchar(max) not null,
  constraint PK_StrikeType primary key (Id)
)
go

insert into StrikeType values ('PO', 1, 'Poor')
insert into StrikeType values ('FR', 2, 'Fair')
insert into StrikeType values ('AG', 3, 'About Good')
insert into StrikeType values ('G', 4, 'Good')
insert into StrikeType values ('VG', 5, 'Very Good')
insert into StrikeType values ('F', 6, 'Fine')
insert into StrikeType values ('VF', 7, 'Very Fine')
insert into StrikeType values ('XF', 8, 'Extra Fine')
insert into StrikeType values ('AU', 9, 'Almost Uncirculated')
insert into StrikeType values ('MS', 10, 'Mint State')
insert into StrikeType values ('PF', 11, 'Proof')
insert into StrikeType values ('SP', 12, 'Specimen')
insert into StrikeType values ('BU', 13, 'Brilliant Uncirculated')
go
  
create table Mint (
  Id int not null identity (1,1),
  Description nvarchar(100) not null,
  Active bit not null,
  constraint PK_Mint primary key (Id),
  constraint UK_Mint unique (Description)
)
go

insert into Mint values ('US', 1)
insert into Mint values ('Canada', 1)
insert into Mint values ('Perth', 1)
insert into Mint values ('Mexico', 1)
insert into Mint values ('Korea', 1)
insert into Mint values ('UK', 1)
insert into Mint values ('Austria', 1)
insert into Mint values ('South Africa', 1)
insert into Mint values ('France', 1)
insert into Mint values ('China', 1)

create table Purity (
  Id int not null identity (1,1),
  Description nvarchar(50) not null,
  MetalId int not null,
  constraint PK_Purity primary key (Id),
  constraint FK_Purity_Metal foreign key (MetalId) references Metal (Id),
  constraint UK_Purity unique (Description, MetalId)
)
go

insert into Purity values ('9999 (pure)', 1)
insert into Purity values ('999 (24k)', 1)
insert into Purity values ('900', 1)
insert into Purity values ('916 (22k)', 1)
insert into Purity values ('833 (20k)', 1)
insert into Purity values ('750 (18k)', 1)
insert into Purity values ('625 (15k)', 1)
insert into Purity values ('585 (14k)', 1)
insert into Purity values ('417 (10k)', 1)

insert into Purity values ('9999 (pure)', 2)
insert into Purity values ('999', 2)
insert into Purity values ('925 (sterling)', 2)
insert into Purity values ('900 (90% junk)', 2)
insert into Purity values ('800', 2)
insert into Purity values ('400 (40% junk)', 2)
go

create table Uom (
  Id int not null,
  Description nvarchar(20) not null,
  constraint PK_Uom primary key (Id),
  constraint UK_Uom unique (Description)
)
go

insert into Uom values (1, 'tr oz')
insert into Uom values (2, 'gm')
insert into Uom values (3, 'kg')

create table Item (
  Id int not null identity (1,1),
  Description nvarchar(100) not null,
  MintId int not null,
  MetalId int not null,
  TotalWeight smallmoney not null,
  UomId int not null,
  PurityId int not null,
  ActualMetalWeightTroyOz smallmoney not null,
  EBayCategoryId int null,
  FirstYear int null,
  LastYear int null,
  Active bit not null,
  DateCreated datetime not null,
  DateUpdated datetime null,
  constraint PK_Item primary key (Id),
  constraint FK_Item_Metal foreign key (MetalId) references Metal (Id),
  constraint FK_Item_Mint foreign key (MintId) references Mint (Id),
  constraint FK_Item_Uom foreign key (UomId) references Uom (Id),
  constraint UK_Item unique (MetalId, Description)
)
go

create table Grade (
  Id int not null identity (1,1),
  Description nvarchar(500) not null,
  StrikeTypeId varchar(2) not null,
  Score int not null,
  Active bit not null constraint DF_Grade_Active default (1)
  constraint PK_Grade primary key (Id),
  constraint FK_Grade_StrikeType foreign key (StrikeTypeId) references StrikeType (Id),
  constraint UK_Grade unique (Description),
  constraint UK_Grade_StrikeTypeScore unique (StrikeTypeId, Score)
)
go

create table StrikeCharacter (
  Id int not null identity (1,1),
  Census varchar(10) not null,
  Label nvarchar(100) not null,
  Description nvarchar(max) not null,
  constraint PK_StrikeCharacter primary key (Id),
  constraint UK_StrikeCharacter unique (Census)
)
go

insert into StrikeCharacter (Census, Label, Description) values ('5DP', '5FS DPL','Five Full Steps, Deep Prooflike')
insert into StrikeCharacter (Census, Label, Description) values ('5FS', '5FS','Five Full Steps')
insert into StrikeCharacter (Census, Label, Description) values ('5PL', '5FS PL','Five Full Steps, Prooflike')
insert into StrikeCharacter (Census, Label, Description) values ('5SC', '5FS CAMEO','Five Full Steps, Cameo')
insert into StrikeCharacter (Census, Label, Description) values ('5SU', '5FS ULTRA CAMEO','Five Full Steps, Ultra Cameo')
insert into StrikeCharacter (Census, Label, Description) values ('6FS', '6FS','Six Full Steps')
insert into StrikeCharacter (Census, Label, Description) values ('6PL', '6FS PL','Six Full Steps, Prooflike')
insert into StrikeCharacter (Census, Label, Description) values ('6SC', '6FS CAMEO','Six Full Steps, Cameo')
insert into StrikeCharacter (Census, Label, Description) values ('6SU', '6FS ULTRA CAMEO','Six Full Steps, Ultra Cameo')
insert into StrikeCharacter (Census, Label, Description) values ('BN', 'BN','Brown')
insert into StrikeCharacter (Census, Label, Description) values ('BNB', 'BN BRILLIANT','Brown, Brilliant')
insert into StrikeCharacter (Census, Label, Description) values ('BNC', 'BN CAMEO','Brown, Cameo')
insert into StrikeCharacter (Census, Label, Description) values ('BND', 'BN DPL','Brown, Deep Prooflike')
insert into StrikeCharacter (Census, Label, Description) values ('BNM', 'BN MATTE','Brown, Matte')
insert into StrikeCharacter (Census, Label, Description) values ('BNP', 'BN PL','Brown, Prooflike')
insert into StrikeCharacter (Census, Label, Description) values ('BNS', 'BN SATIN','Brown, Satin')
insert into StrikeCharacter (Census, Label, Description) values ('BNU', 'BN ULTRA CAMEO','Brown, Ultra Cameo')
insert into StrikeCharacter (Census, Label, Description) values ('CA', 'CAMEO','Cameo')
insert into StrikeCharacter (Census, Label, Description) values ('DFM', 'DPL FIRST DAY OF MINTAGE','Deep Prooflike, First Day of Mintage')
insert into StrikeCharacter (Census, Label, Description) values ('DME', 'DPL MINT ERROR','Deep Prooflike, Mint Error')
insert into StrikeCharacter (Census, Label, Description) values ('DPL', 'DPL','Deep Prooflike')
insert into StrikeCharacter (Census, Label, Description) values ('FB', 'FB','Full Bands')
insert into StrikeCharacter (Census, Label, Description) values ('FBD', 'FB DPL','Full Bands, Deep Prooflike')
insert into StrikeCharacter (Census, Label, Description) values ('FBL', 'FBL','Full Bell Lines')
insert into StrikeCharacter (Census, Label, Description) values ('FBP', 'FB PL','Full Bands, Prooflike')
insert into StrikeCharacter (Census, Label, Description) values ('FD', 'FIRST DAY OF ISSUE','First Day of Issue')
insert into StrikeCharacter (Census, Label, Description) values ('FDD', 'DPL FIRST DAY OF ISSUE','Deep Prooflike, First Day of Issue')
insert into StrikeCharacter (Census, Label, Description) values ('FDP', 'PL FIRST DAY OF ISSUE','Prooflike, First Day of Issue')
insert into StrikeCharacter (Census, Label, Description) values ('FH', 'FH','Full Head')
insert into StrikeCharacter (Census, Label, Description) values ('FHD', 'FH DPL','Full Head, Deep Prooflike')
insert into StrikeCharacter (Census, Label, Description) values ('FHP', 'FH PL','Full Head, Prooflike')
insert into StrikeCharacter (Census, Label, Description) values ('FLD', 'FBL DPL','Full Bell Lines, Deep Prooflike')
insert into StrikeCharacter (Census, Label, Description) values ('FLP', 'FBL PL','Full Bell Lines, Prooflike')
insert into StrikeCharacter (Census, Label, Description) values ('FM', 'FIRST DAY OF MINTAGE','First Day of Mintage')
insert into StrikeCharacter (Census, Label, Description) values ('FT', 'FT','Full Torch')
insert into StrikeCharacter (Census, Label, Description) values ('FTD', 'FT DPL','Full Torch, Deep Prooflike')
insert into StrikeCharacter (Census, Label, Description) values ('FTP', 'FT PL','Full Torch, Prooflike')
insert into StrikeCharacter (Census, Label, Description) values ('MA', 'MATTE','Matte')
insert into StrikeCharacter (Census, Label, Description) values ('ME', 'MINT ERROR','Mint Error')
insert into StrikeCharacter (Census, Label, Description) values ('PFM', 'PL FIRST DAY OF MINTAGE','Prooflike, First Day of Mintage')
insert into StrikeCharacter (Census, Label, Description) values ('PL', 'PL','Prooflike')
insert into StrikeCharacter (Census, Label, Description) values ('PME', 'PL MINT ERROR','Prooflike, Mint Error')
insert into StrikeCharacter (Census, Label, Description) values ('RB', 'RB','Red Brown')
insert into StrikeCharacter (Census, Label, Description) values ('RBB', 'RB BRILLIANT','Red Brown, Brilliant')
insert into StrikeCharacter (Census, Label, Description) values ('RBC', 'RB CAMEO','Red Brown, Cameo')
insert into StrikeCharacter (Census, Label, Description) values ('RBD', 'RB DPL','Red Brown, Deep Prooflike')
insert into StrikeCharacter (Census, Label, Description) values ('RBM', 'RB MATTE','Red Brown, Matte')
insert into StrikeCharacter (Census, Label, Description) values ('RBP', 'RB PL','Red Brown, Prooflike')
insert into StrikeCharacter (Census, Label, Description) values ('RBS', 'RB SATIN','Red Brown, Satin')
insert into StrikeCharacter (Census, Label, Description) values ('RBU', 'RB ULTRA CAMEO','Red Brown, Ultra Cameo')
insert into StrikeCharacter (Census, Label, Description) values ('RD', 'RD','Red')
insert into StrikeCharacter (Census, Label, Description) values ('RDB', 'RD BRILLIANT','Red, Brilliant')
insert into StrikeCharacter (Census, Label, Description) values ('RDC', 'RD CAMEO','Red, Cameo')
insert into StrikeCharacter (Census, Label, Description) values ('RDD', 'RD DPL','Red, Deep Prooflike')
insert into StrikeCharacter (Census, Label, Description) values ('RDM', 'RD MATTE','Red, Matte')
insert into StrikeCharacter (Census, Label, Description) values ('RDP', 'RD PL','Red, Proof Like')
insert into StrikeCharacter (Census, Label, Description) values ('RDS', 'RD SATIN','Red, Satin')
insert into StrikeCharacter (Census, Label, Description) values ('RDU', 'RD ULTRA CAMEO','Red, Ultra Cameo')
insert into StrikeCharacter (Census, Label, Description) values ('RFD', 'RD FIRST DAY OF ISSUE','Red, First Day of Issue')
insert into StrikeCharacter (Census, Label, Description) values ('RY', 'RELEASE CEREMONY','Release Ceremony')
insert into StrikeCharacter (Census, Label, Description) values ('RFY', 'RD RELEASE CEREMONY','Red, Release Ceremony')
insert into StrikeCharacter (Census, Label, Description) values ('SA', 'SATIN','Satin')
insert into StrikeCharacter (Census, Label, Description) values ('UC', 'ULTRA CAMEO','Ultra Cameo')
go

create table GradeStrikeCharacter (
  GradeId int not null,
  StrikeCharacterId int not null,
  constraint PK_GradeStrikeCharacter primary key (GradeId, StrikeCharacterId),
  constraint FK_GradeStrikeCharacter_Grade foreign key (GradeId) references Grade (Id),
  constraint FK_GradeStrikeCharacter_StrikeCharacter foreign key (StrikeCharacterId) references StrikeCharacter (Id)
)
go

create table Designation (
  Id char(10) not null,
  Description nvarchar(200) not null,
  Active bit not null constraint DF_Designation_Active default (1),
  constraint PK_Designation primary key (Id),
  constraint UK_Designation unique (Description)
)
go

insert into Designation values ('+', 'Plus', 1)
insert into Designation values ('*', 'Star', 1)
insert into Designation values ('FR', 'First Release', 1)
insert into Designation values ('FS', 'First Strike', 1)
insert into Designation values ('ER', 'Early Release', 1)
insert into Designation values ('FDI', 'First Day of Issue', 1)
insert into Designation values ('FYI', 'First Year of Issue', 1)
insert into Designation values ('FDC', 'First Day Ceremony', 1)
insert into Designation values ('FSC', 'First Strike Ceremony', 1)
insert into Designation values ('FDP', 'First Day of Production', 1)
insert into Designation values ('1000', 'One of First 1000 Struck', 1) -- can add more
go

create table GradeDesignation (
  GradeId int not null,
  DesignationId char(10) not null,
  constraint PK_GradeDesignation primary key (GradeId, DesignationId),
  constraint FK_GradeDesignation_Grade foreign key (GradeId) references Grade (Id),
  constraint FK_GradeDesignation_Designation foreign key (DesignationId) references Designation (Id)
)
go

create table GradingService (
  Id int not null,
  Code nvarchar(10) not null,
  Description nvarchar(100) not null,
  constraint PK_GradingService primary key (Id),
  constraint UK_GradingService unique (Code),
  constraint UK_GradingService_Description unique (Description))
go

insert into GradingService values (1, 'PCGS', 'Professional Coin Grading Service')
insert into GradingService values (2, 'NGC', 'Numismatic Guaranty Corporation')
insert into GradingService values (3, 'ICG', 'Independent Coin Graders')
insert into GradingService values (4, 'ANACS', 'American Numismatic Association')
go

create table Source (
  Id int not null,
  Description nvarchar(100) not null,
  Active bit not null constraint DF_Source_Active default (1),
  constraint PK_Source primary key (Id),
  constraint UK_Source unique (Description)
)
go

insert into Source values (1, 'eBay', 1)
insert into Source values (2, 'APMEX', 1)
insert into Source values (3, 'JM Bullion', 1)
insert into Source values (4, 'SD Bullion', 1)
insert into Source values (5, 'Bullion Exchanges', 1)
insert into Source values (6, 'Gold Silver', 1)
insert into Source values (7, 'Provident Metals', 1)
insert into Source values (8, 'Kitco', 1)
insert into Source values (9, 'Bgasc', 1)
insert into Source values (10, 'Silver.com', 1)
insert into Source values (11, 'Gainesville', 1)
insert into Source values (12, 'Monument Metals', 1)
go

create table PriceSource (
  Id int not null identity (1,1),
  ItemId int not null,
  GradeId int not null,
  GradingServiceId int null, -- Maybe no grade?
  SourceId int not null,
  ItemYearFrom int not null, -- 0 for random year?
  ItemYearTo int not null, -- Can be used for prices e.g. 1878-1904 random date
  MintMark nvarchar(10) not null, -- D, S, P, CC etc
  WebsiteUrl nvarchar(500) not null,
  ElementQuery nvarchar(500) not null,
  eBayQuery nvarchar(500) null, -- for eBay only 
  LastChecked datetime null,
  HasError bit not null,
  LastError nvarchar(max) null,
  Active bit not null constraint DF_PriceSource_Active default (1),
  constraint PK_PriceSource primary key (Id),
  constraint UK_PriceSource unique (ItemId, GradeId, GradingServiceId, SourceId, ItemYearFrom, ItemYearTo, MintMark),
  constraint FK_PriceSource_Item foreign key (ItemId) references Item (Id),
  constraint FK_PriceSource_Grade foreign key (GradeId) references Grade (Id),
  constraint FK_PriceSource_GradingService foreign key (GradingServiceId) references GradingService (Id),
  constraint FK_PriceSource_Source foreign key (SourceId) references Source (Id)
)
go

create table ItemPrice (
  PriceSourceId int not null,
  UpdateTime datetime not null,
  MinPrice money not null, -- for eBay
  MaxPrice money not null, -- for eBay
  WireCheckPrice money not null,
  CCPaypalPrice money not null,
  BitcoinPrice money not null,
  ItemUrl nvarchar(max) null,
  constraint PK_ItemPrice primary key (PriceSourceId, UpdateTime),
  constraint FK_ItemPrice_PriceSource foreign key (PriceSourceId) references PriceSource (Id)
)
go

create table ItemStats (
  Id int not null identity (1,1),
  ItemId int not null,
  ItemYear int not null, 
  MintMark nvarchar(10) not null,
  GradeId int not null,
  GradingServiceId int not null,
  [Population] int null,
  PriceGuide money null,
  LastUpdate datetime not null,
  constraint PK_ItemStats primary key (Id),
  constraint FK_ItemStats_Item foreign key (ItemId) references Item (Id),
  constraint FK_ItemStats_Grade foreign key (GradeId) references Grade (Id),
  constraint FK_ItemStats_GradingService foreign key (GradingServiceId) references GradingService (Id)
)
go

-- Fill in some basic items to start testing 
insert into Item values ('Saint Gaudens $20 Gold (1907-1933)', 1, 1, 33.431, 2, 15, 0.96750, 39472, 1907, 1933, 1, getdate(), null)
insert into Item values ('Morgan Dollar', 1, 2, 26.73, 2, 12, 0.7734, 39464, 1878, 1921, 1, getdate(), null)
insert into Item values ('American Silver Eagle', 1, 2, 31.101, 2, 10, 1, 177653, 1986, null, 1, getdate(), null)

insert into Grade values ('MS 70', 'MS', 70, 1)
insert into Grade values ('MS 69', 'MS', 69, 1)
insert into Grade values ('MS 68', 'MS', 68, 1)
insert into Grade values ('MS 67', 'MS', 67, 1)
insert into Grade values ('MS 66', 'MS', 66, 1)
insert into Grade values ('MS 65', 'MS', 65, 1)
insert into Grade values ('MS 64', 'MS', 64, 1)
insert into Grade values ('MS 63', 'MS', 63, 1)
insert into Grade values ('MS 62', 'MS', 62, 1)
insert into Grade values ('MS 61', 'MS', 61, 1)
insert into Grade values ('MS 60', 'MS', 60, 1)

insert into PriceSource values (1, 7/*MS64*/, 2/*NGC*/,  1, 1907, 1907, '', '', '', '1907 gaudens ngc ms 64 -random', null, 0, null, 1)
insert into PriceSource values (1, 7/*MS64*/, 1/*PCGS*/, 1, 1907, 1907, '', '', '', '1907 gaudens pcgs ms 64 -random', null, 0, null, 1)

insert into PriceSource values (1, 6/*MS65*/, 2/*NGC*/,  1, 1908, 1908, '', '', '', '1908 gaudens ngc ms 65 -random -motto', null, 0, null, 1)
insert into PriceSource values (1, 6/*MS65*/, 1/*PCGS*/,  1, 1908, 1908, '', '', '', '1908 gaudens pcgs ms 65 -random -motto', null, 0, null, 1)

insert into PriceSource values (1, 6/*MS65*/, 1/*PCGS*/,  1, 1908, 1908, 'D', '', '', '1908 gaudens pcgs ms 65 -random +d -s -motto', null, 0, null, 1)
insert into PriceSource values (1, 6/*MS65*/, 1/*PCGS*/,  1, 1908, 1908, 'S', '', '', '1908 gaudens pcgs ms 65 -random -d +s -motto', null, 0, null, 1)

insert into PriceSource values (1, 6/*MS65*/, 1/*PCGS*/,  1, 1909, 1909, '', '', '', '1909 gaudens pcgs ms 65 -random -d -s', null, 0, null, 1)
insert into PriceSource values (1, 6/*MS65*/, 1/*PCGS*/,  1, 1909, 1909, 'D', '', '', '1909 gaudens pcgs ms 65 -random +d -s', null, 0, null, 1)
insert into PriceSource values (1, 6/*MS65*/, 1/*PCGS*/,  1, 1909, 1909, 'S', '', '', '1909 gaudens pcgs ms 65 -random +s -d', null, 0, null, 1)

insert into PriceSource values (1, 6/*MS65*/, 1/*PCGS*/,  1, 1910, 1910, '', '', '', '1910 gaudens pcgs ms 65 -random -d -s', null, 0, null, 1)
insert into PriceSource values (1, 6/*MS65*/, 1/*PCGS*/,  1, 1910, 1910, 'D', '', '', '1910 gaudens pcgs ms 65 -random +d', null, 0, null, 1)
insert into PriceSource values (1, 6/*MS65*/, 1/*PCGS*/,  1, 1910, 1910, 'S', '', '', '1910 gaudens pcgs ms 65 -random +s', null, 0, null, 1)

insert into PriceSource values (1, 6/*MS65*/, 1/*PCGS*/,  1, 1911, 1911, '', '', '', '1911 gaudens pcgs ms 65 -random -d -s', null, 0, null, 1)
insert into PriceSource values (1, 6/*MS65*/, 1/*PCGS*/,  1, 1911, 1911, 'D', '', '', '1911 gaudens pcgs ms 65 -random +d', null, 0, null, 1)
insert into PriceSource values (1, 6/*MS65*/, 1/*PCGS*/,  1, 1911, 1911, 'S', '', '', '1911 gaudens pcgs ms 65 -random +s', null, 0, null, 1)

insert into PriceSource values (1, 6/*MS65*/, 1/*PCGS*/,  1, 1912, 1912, '', '', '', '1912 gaudens pcgs ms 65 -random -d -s', null, 0, null, 1)

insert into PriceSource values (1, 6/*MS65*/, 1/*PCGS*/,  1, 1913, 1913, '', '', '', '1913 gaudens pcgs ms 65 -random -d -s', null, 0, null, 1)
insert into PriceSource values (1, 6/*MS65*/, 1/*PCGS*/,  1, 1913, 1913, 'D', '', '', '1913 gaudens pcgs ms 65 -random +d', null, 0, null, 1)
insert into PriceSource values (1, 6/*MS65*/, 1/*PCGS*/,  1, 1913, 1913, 'S', '', '', '1913 gaudens pcgs ms 65 -random +s', null, 0, null, 1)

insert into PriceSource values (1, 6/*MS65*/, 1/*PCGS*/,  1, 1914, 1914, '', '', '', '1914 gaudens pcgs ms 65 -random -d -s', null, 0, null, 1)
insert into PriceSource values (1, 6/*MS65*/, 1/*PCGS*/,  1, 1914, 1914, 'D', '', '', '1914 gaudens pcgs ms 65 -random +d', null, 0, null, 1)
insert into PriceSource values (1, 6/*MS65*/, 1/*PCGS*/,  1, 1914, 1914, 'S', '', '', '1914 gaudens pcgs ms 65 -random +s', null, 0, null, 1)

insert into PriceSource values (1, 6/*MS65*/, 1/*PCGS*/,  1, 1915, 1915, '', '', '', '1915 gaudens pcgs ms 65 -random -d -s', null, 0, null, 1)
insert into PriceSource values (1, 6/*MS65*/, 1/*PCGS*/,  1, 1915, 1915, 'S', '', '', '1915 gaudens pcgs ms 65 -random +s', null, 0, null, 1)

insert into PriceSource values (1, 6/*MS65*/, 1/*PCGS*/,  1, 1916, 1916, 'S', '', '', '1916 gaudens pcgs ms 65 -random +s', null, 0, null, 1)

insert into PriceSource values (1, 6/*MS65*/, 1/*PCGS*/,  1, 1920, 1920, '', '', '', '1920 gaudens pcgs ms 65 -random -s', null, 0, null, 1)
insert into PriceSource values (1, 6/*MS65*/, 1/*PCGS*/,  1, 1920, 1920, 'S', '', '', '1920 gaudens pcgs ms 65 -random +s', null, 0, null, 1)

insert into PriceSource values (1, 6/*MS65*/, 1/*PCGS*/,  1, 1921, 1921, '', '', '', '1921 gaudens pcgs ms 65 -random', null, 0, null, 1)

insert into PriceSource values (1, 6/*MS65*/, 1/*PCGS*/,  1, 1922, 1922, '', '', '', '1922 gaudens pcgs ms 65 -random -d -s', null, 0, null, 1)
insert into PriceSource values (1, 6/*MS65*/, 1/*PCGS*/,  1, 1922, 1922, 'S', '', '', '1922 gaudens pcgs ms 65 -random +s', null, 0, null, 1)

insert into PriceSource values (1, 6/*MS65*/, 1/*PCGS*/,  1, 1923, 1923, '', '', '', '1923 gaudens pcgs ms 65 -random -d -s', null, 0, null, 1)
insert into PriceSource values (1, 6/*MS65*/, 1/*PCGS*/,  1, 1923, 1923, 'D', '', '', '1923 gaudens pcgs ms 65 -random +d', null, 0, null, 1)

insert into PriceSource values (1, 6/*MS65*/, 1/*PCGS*/,  1, 1924, 1924, '', '', '', '1924 gaudens pcgs ms 65 -random -d -s', null, 0, null, 1)
insert into PriceSource values (1, 6/*MS65*/, 1/*PCGS*/,  1, 1924, 1924, 'D', '', '', '1924 gaudens pcgs ms 65 -random +d', null, 0, null, 1)
insert into PriceSource values (1, 6/*MS65*/, 1/*PCGS*/,  1, 1924, 1924, 'S', '', '', '1924 gaudens pcgs ms 65 -random +s', null, 0, null, 1)

insert into PriceSource values (1, 6/*MS65*/, 1/*PCGS*/,  1, 1925, 1925, '', '', '', '1925 gaudens pcgs ms 65 -random -d -s', null, 0, null, 1)
insert into PriceSource values (1, 6/*MS65*/, 1/*PCGS*/,  1, 1925, 1925, 'D', '', '', '1925 gaudens pcgs ms 65 -random +d', null, 0, null, 1)
insert into PriceSource values (1, 6/*MS65*/, 1/*PCGS*/,  1, 1925, 1925, 'S', '', '', '1925 gaudens pcgs ms 65 -random +s', null, 0, null, 1)

insert into PriceSource values (1, 6/*MS65*/, 1/*PCGS*/,  1, 1926, 1926, '', '', '', '1926 gaudens pcgs ms 65 -random -d -s', null, 0, null, 1)
insert into PriceSource values (1, 6/*MS65*/, 1/*PCGS*/,  1, 1926, 1926, 'D', '', '', '1926 gaudens pcgs ms 65 -random +d', null, 0, null, 1)
insert into PriceSource values (1, 6/*MS65*/, 1/*PCGS*/,  1, 1926, 1926, 'S', '', '', '1926 gaudens pcgs ms 65 -random +s', null, 0, null, 1)

insert into PriceSource values (1, 6/*MS65*/, 1/*PCGS*/,  1, 1927, 1927, '', '', '', '1927 gaudens pcgs ms 65 -random -d -s', null, 0, null, 1)
insert into PriceSource values (1, 6/*MS65*/, 1/*PCGS*/,  1, 1927, 1927, 'D', '', '', '1927 gaudens pcgs ms 65 -random +d', null, 0, null, 1)
insert into PriceSource values (1, 6/*MS65*/, 1/*PCGS*/,  1, 1927, 1927, 'S', '', '', '1927 gaudens pcgs ms 65 -random +s', null, 0, null, 1)

insert into PriceSource values (1, 6/*MS65*/, 1/*PCGS*/,  1, 1928, 1928, '', '', '', '1928 gaudens pcgs ms 65 -random', null, 0, null, 1)

insert into PriceSource values (1, 6/*MS65*/, 1/*PCGS*/,  1, 1929, 1929, '', '', '', '1929 gaudens pcgs ms 65 -random', null, 0, null, 1)

insert into PriceSource values (1, 6/*MS65*/, 1/*PCGS*/,  1, 1930, 1930, 'S', '', '', '1930 gaudens pcgs ms 65 -random +s', null, 0, null, 1)

insert into PriceSource values (1, 6/*MS65*/, 1/*PCGS*/,  1, 1931, 1931, '', '', '', '1931 gaudens pcgs ms 65 -random -d -s', null, 0, null, 1)
insert into PriceSource values (1, 6/*MS65*/, 1/*PCGS*/,  1, 1931, 1931, 'D', '', '', '1931 gaudens pcgs ms 65 -random +d', null, 0, null, 1)

insert into PriceSource values (1, 6/*MS65*/, 1/*PCGS*/,  1, 1932, 1932, '', '', '', '1932 gaudens pcgs ms 65 -random', null, 0, null, 1)
insert into PriceSource values (1, 6/*MS65*/, 1/*PCGS*/,  1, 1933, 1933, '', '', '', '1933 gaudens pcgs ms 65 -random', null, 0, null, 1)

update PriceSource set eBayQuery = eBayQuery + ' -lot -twenty'

-- Inserts all NGC price sources
insert into PriceSource
select p.ItemId, p.GradeId, 2/*NGC*/, p.SourceId, p.ItemYearFrom, p.ItemYearTo, p.MintMark, p.WebsiteUrl, p.ElementQuery, replace(p.eBayQuery, 'pcgs', 'ngc'), null, 0, null, 1
from PriceSource p
where p.GradingServiceId = 1
  and not exists ( select * from PriceSource p2 where p2.ItemId = p.ItemId and p2.GradingServiceId = 2 and p2.ItemYearFrom = p.ItemYearFrom and p2.MintMark = p.MintMark)

-- Now populate all MS64
insert into PriceSource
select p.ItemId, g.Id as GradeId, p.GradingServiceId, p.SourceId, p.ItemYearFrom, p.ItemYearTo, p.MintMark, p.WebsiteUrl, p.ElementQuery, replace(p.eBayQuery, '65', '64'), null, 0, null, 1
from PriceSource p
  inner join Grade g on g.Score = 64
where not exists ( select * from PriceSource p2 where p2.GradeId = g.Id and p2.ItemId = p.ItemId and p2.ItemYearFrom = p.ItemYearFrom)

-- Now populate all MS66
insert into PriceSource
select p.ItemId, g.Id as GradeId, p.GradingServiceId, p.SourceId, p.ItemYearFrom, p.ItemYearTo, p.MintMark, p.WebsiteUrl, p.ElementQuery, replace(p.eBayQuery, '65', '66'), null, 0, null, 1
from PriceSource p
  inner join Grade g on g.Score = 66
where p.GradeId = 6
  and not exists ( select * from PriceSource p2 where p2.GradeId = g.Id and p2.ItemId = p.ItemId and p2.ItemYearFrom = p.ItemYearFrom)


-- Query current MS64/65/66 prices from both NGC and PCGS
select i.Description as [Item], ps.ItemYearFrom as [Year], ps.MintMark, g.Description as [Grade], gs.Code as [Service], ip.UpdateTime, ip.MinPrice, ip.ItemUrl
from ItemPrice ip 
  inner join PriceSource ps on ip.PriceSourceId = ps.Id
  inner join Item i on ps.ItemId = i.Id
  inner join Grade g on ps.GradeId = g.Id
  inner join GradingService gs on ps.GradingServiceId = gs.Id 
where ip.UpdateTime = ps.LastChecked
order by i.Description

-- Query current MS64/65/66 prices from both NGC and PCGS
select i.Description as [Item]
  ,ps.ItemYearFrom as [Year]
  ,ps.MintMark
  ,min(case when g.Score = 64 then ip.MinPrice else null end) as [MS-64]
  ,min(case when g.Score = 65 then ip.MinPrice else null end) as [MS-65]
  ,min(case when g.Score = 66 then ip.MinPrice else null end) as [MS-66]
from Item i
  inner join PriceSource ps on ps.ItemId = i.Id
  inner join Grade g on ps.GradeId = g.Id
  inner join ItemPrice ip on ip.UpdateTime = ps.LastChecked
group by i.Description, ps.ItemYearFrom, ps.MintMark
--order by [MS-65]
order by [MS-66] --  i.Description, ps.ItemYearFrom, ps.MintMark
