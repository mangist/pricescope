

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
