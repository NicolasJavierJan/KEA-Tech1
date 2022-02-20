#How many songs are there in the playlist “Grunge”?
SELECT COUNT(*) FROM playlisttrack WHERE playlistid = (SELECT playlistid FROM playlist WHERE name = 'grunge');
#Show information about artists whose name includes the text “Jack” and about artists whose name includes the text “John”, but not the text “Martin”.
SELECT * FROM artist WHERE name NOT LIKE "%martin%" AND name LIKE "%john%" OR name LIKE "%jack%";
#For each country where some invoice has been issued, show the total invoice monetary amount, but only for countries where at least $100 have been invoiced. Sort the information from higher to lower monetary amount.
SELECT billingcountry, SUM(total) AS total FROM invoice GROUP BY billingcountry HAVING SUM(total) > 100 ORDER BY TOTAL DESC;
#Get the phone number of the boss of those employees who have given support to clients who have bought some song composed by “Miles Davis” in “MPEG Audio File” format.
SELECT phone FROM employee WHERE employeeid IN (SELECT reportsto FROM employee WHERE employeeid IN (SELECT supportrepid FROM customer WHERE customerid IN (SELECT customerid FROM invoice WHERE invoiceid IN (SELECT invoiceid FROM invoiceline WHERE trackid IN (SELECT trackid FROM track WHERE composer = "miles davis" and mediatypeid = (SELECT mediatypeid FROM mediatype WHERE name = "mpeg audio file"))))));
#Show the information, without repeated records, of all albums that feature songs of the “Bossa Nova” genre whose title starts by the word “Samba”.
SELECT * FROM album WHERE albumid IN (SELECT albumid FROM track WHERE trackid IN (SELECT trackid FROM track WHERE name LIKE "samba %" AND genreid = (SELECT genreid FROM genre WHERE name = "Bossa Nova")));
#For each genre, show the average length of its songs in minutes (without indicating seconds). Use the headers “Genre” and “Minutes”, and include only genres that have any song longer than half an hour.
SELECT genre.name As Genre, FORMAT(AVG(track.milliseconds) / 60000, 0) AS Minutes FROM genre JOIN track ON genre.genreid = track.genreid WHERE genre.genreid IN (SELECT DISTINCT genreid FROM track WHERE milliseconds > 1800000) GROUP BY genre.name;
#How many client companies have no state?
SELECT COUNT(*) FROM clients WHERE COMPANY IS NOT NULL AND STATE IS NULL;
#For each employee with clients in the “USA”, “Canada” and “Mexico” show the number of clients from these countries s/he has given support, only when this number is higher than 6. Sort the query by number of clients. Regarding the employee, show his/her first name and surname separated by a space. Use “Employee” and “Clients” as headers.
SELECT CONCAT(employee.firstname, " ", employee.lastname) AS Employee, count (*) AS Client FROM customer JOIN employee ON customer.supportrepid = employee.employeeid WHERE customer.country = "USA" OR customer.country = "Mexico" OR customer.country = "Canada" GROUP BY employeeid HAVING client > 6;
#For each client from the “USA”, show his/her surname and name (concatenated and separated by a comma) and their fax number. If they do not have a fax number, show the text “S/he has no fax”. Sort by surname and first name.
SELECT CONCAT(lastname, ", ", firstname), IF (fax IS NULL, "S/he has no fax", fax) FROM customer WHERE country = "USA";
#For each employee, show his/her first name, last name, and their age at the time they were hired.
SELECT firstname, lastname, TIMESTAMPDIFF(year, birthdate, hiredate) AS AgeWhenHired FROM employee;