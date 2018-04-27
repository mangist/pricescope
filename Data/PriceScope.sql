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
go
  
create table Item (
  Id int not null identity (1,1),
  Description nvarchar(100) not null,
  MetalId int not null,
  EBayCategoryId int null,
  FirstYear int null,
  LastYear int null,
  Active bit not null,
  DateCreated datetime not null,
  DateUpdated datetime null,
  constraint PK_Item primary key (Id),
  constraint FK_Item_Metal foreign key (MetalId) references Metal (Id),
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
insert into Source values (7, 'Provident', 1)
go

create table Mint (
  Id int not null identity (1,1),
  Description nvarchar(100) not null,
  Active bit not null,
  constraint PK_Mint primary key (Id),
  constraint UK_Mint unique (Description)
)
go

insert into Mint values ('US Mint', 1)
insert into Mint values ('Perth Mint', 1)
insert into Mint values ('Mexico', 1)
insert into Mint values ('KOMSCO', 1)

create table ItemPrice (
  Id int not null identity (1,1),
  ItemId int not null,
  ItemYear int not null,
  MintId int not null,
  GradingServiceId int not null,
  GradeId int not null,
  SourceId int not null,
  Price money not null,
  LastUpdated datetime not null,
  constraint PK_ItemPrice primary key (Id),
  constraint FK_ItemPrice_Item foreign key (ItemId) references Item (Id),
  constraint FK_ItemPrice_Item foreign key (MintId) references Mint (Id),
  constraint FK_ItemPrice_GradingService foreign key (GradingServiceId) references GradingService (Id),
  constraint FK_ItemPrice_Grade foreign key (GradeId) references Grade (Id),
  constraint FK_ItemPrice_Source foreign key (SourceId) references Source (Id)
)
go
