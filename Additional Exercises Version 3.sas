Libname rutu "C:\Users\rmokashi\Documents\BusinessReportingTools-master\Extra_dataset";
run;

*/question1 - Give the description and number sold for all tracks that the customers served
 by employee number 3 have ever purchased.;
proc sql;
select D.name as Description , count(quantity) as numbersold
from rutu.customers A,rutu.invoices B, rutu.invoice_items C,rutu.Tracks D
where A.customerid = B.customerid
AND B.invoiceid = C.invoiceid
AND C.Trackid = D.Trackid
AND supportrepid = 3
group by 1;
quit;
*/Question2 - Give the genres (in text) that are sold most (more than 100 times;
proc sql;
select C.Name as Genres, count(*) as timessold
from rutu.Tracks A,rutu.Invoice_Items B,rutu.Genres C
where A.TRackid = B.trackid
AND A.Genreid = C.Genreid
group by 1
having count(*) > 100;
quit;
*/question3 -Give a list of the employees (employee nbr, firstname and lastname) with their total 
sales & order by sales (descending). Only take into account US customers and have sold more than 150 $;
proc sql;
select EmployeeId ,A.FirstName,A.LastName,Sum(Total) as Totalsales
from rutu.Employees A,rutu.Customers B,rutu.Invoices C
Where A.EmployeeId = B.SupportRepId
AND B.CustomerId = C.CustomerId
AND B.Country = 'USA'
Group by 1,2,3
having sum(Total) > 150;
quit;
*/question4 -Give a list of the supervisors (employee nbr, firstname and lastname) with the total sales of their employees & order by sales. 
Do this only for the most recent customers (customernr > 25;
proc sql;
select D.EmployeeId as SupervisorId ,D.FirstName,D.LastName,Sum(Total) as Totalsales
from rutu.Employees A,rutu.Customers B,rutu.Invoices C, rutu.Employees D
Where A.EmployeeId = B.SupportRepId
AND B.CustomerId = C.CustomerId
AND A.ReportsTo = put(D.EmployeeId,1.)
Group by 1,2,3;
quit;
*/question 5 - List the different genres (in text) in playlists that start with ‘Classical’. ;
proc sql;
select Distinct D.Name as Genres
from rutu.Playlist_track A,rutu.playlists B,rutu.Tracks C,rutu.Genres D
where A.Playlistid = B.playlistid
AND A.trackid = C.trackid
AND C.genreid = D.genreid
AND B.Name like '%Classical'
group by 1;
quit;
*/question 6 - Display the playlists that do contain rock tracks, but not pop tracks;
proc sql;
select Distinct B.Name as playlists
from rutu.Playlist_track A,rutu.playlists B,rutu.Tracks C,rutu.Genres D
where A.Playlistid = B.playlistid
AND A.trackid = C.trackid
AND C.genreid = D.genreid
Except
select name
from rutu.playlists
where Name = 'Pop';
quit;
*/question 7 - Give a list of employees (employeeid, name and city) , together with the number of customers they are serving 
(only the ones who are serving customers should be included);
proc sql;
select employeeid, A.Firstname, A.City,count(customerid) as customersserved
from rutu.Employees A,rutu.Customers B
where A.EmployeeID = B.SupportRepId
group by 1,2,3 ;
quit;
*/question8 - Give a list that contains the artists names bought by both customerID 1 and 2;
proc sql;
select distinct F.name as artistsname
from rutu.Customers A,rutu.Invoices B,rutu.Invoice_items C,rutu.Tracks D,rutu.Albums E,
rutu.Artists F
where A.Customerid = B.customerid
AND B.invoiceid = C.invoiceid
AND C.Trackid = D.Trackid
AND D.Albumid = E.Albumid
AND E.Artistid = F.Artistid
AND A.customerid = 1
intersect
select distinct F.name as artistsname
from rutu.Customers A,rutu.Invoices B,rutu.Invoice_items C,rutu.Tracks D,rutu.Albums E,
rutu.Artists F
where A.Customerid = B.customerid
AND B.invoiceid = C.invoiceid
AND C.Trackid = D.Trackid
AND D.Albumid = E.Albumid
AND E.Artistid = F.Artistid
AND A.customerid = 2;
quit;
*/question 9 - Give all the tracks with their sales. Each track should be shown, 
whether or not they have sales.;
proc sql;
select Distinct Name,sum(quantity) as sales
from rutu.Tracks as A LEFT OUTER JOIN rutu.Invoice_Items as B
ON (A.Trackid = B.Trackid)
group by 1;
quit;
*/question 10 - Give media type names of all tracks that generated more than 1$ in sales 
and that were also purchased by customer with customerID 33.;
proc sql;
select D.Name as mediatypenames
from rutu.Invoices A,rutu.Invoice_items B,rutu.Tracks C,rutu.media_types D
where A.invoiceid = B.invoiceid
AND B.Trackid = C.Trackid
AND C.mediaTypeid = D.mediatypeid
AND Total > 1
intersect
select D.Name as mediatypenames
from rutu.Invoices A,rutu.Invoice_items B,rutu.Tracks C,rutu.media_types D
where A.invoiceid = B.invoiceid
AND B.Trackid = C.Trackid
AND C.mediaTypeid = D.mediatypeid
AND customerid = 33;
quit;
