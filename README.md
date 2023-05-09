# SQLQueries

--How many unbillable hours were recorded per month for the current year  

Select SUM(a.recordedtimehours) recordedhours, c.calendarmonthname, c.calendaryear from [dbo].[factactual] a
inner join [dbo].[dimtask] b on a.taskkey=b.taskkey 
inner join [dbo].[dimdate] c on a.datekey=c.datekey
where b.Billable ='Unbillable'
Group by c.calendarmonthname, c.calendaryear



-- the total hours from the start of the year until the end of each month

Select SUM(a.recordedtimehours) recordedhours, b.Clientname, c.calendarmonthname,  c.calendarmonthstart,c.calendarmonthend  from [dbo].[factactual] a
inner join [dbo].[dimtask] b on a.taskkey=b.taskkey 
inner join [dbo].[dimdate] c on a.datekey=c.datekey
where b.Billable ='billable'
Group by c.calendarmonthname, b.Clientname, c.calendarmonthstart,c.calendarmonthend 
order by b.Clientname, c.calendarmonthstart 
