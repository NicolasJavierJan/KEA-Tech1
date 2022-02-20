#Show the members under the name "Jens S." who were born before 1970 that became members of the library in 2013.
SELECT * FROM tmember WHERE YEAR(dbirth) < 1970 AND cname = "Jens S" AND YEAR(dnewmember) = 2013;
#Show those books that have not been published by the publishing companies with ID 15 and 32, except if they were published before 2000.
SELECT * FROM tbook WHERE npublishingcompanyid NOT IN (15, 32) or npublishingyear < 2000;
#Show the name and surname of the members who have a phone number, but no address.
SELECT cname, csurname FROM tmember WHERE cphoneno IS NOT NULL AND caddress IS NULL;
#Show the authors with surname "Byatt" whose name starts by an "A" (uppercase) and contains an "S" (uppercase).
SELECT * FROM tauthor WHERE csurname = "Byatt" AND cname LIKE ("A%S%");
#Show the number of books published in 2007 by the publishing company with ID 32.
SELECT COUNT(*) FROM tbook WHERE npublishingyear = 2007 AND npublishingcompanyid = 32;
#For each day of the year 2014, show the number of books loaned by the member with CPR "0305393207";
SELECT COUNT(dloan) AS numberOfLoans, dloan AS date FROM tloan WHERE YEAR(dloan) = 2014 AND ccpr = 0305393207 GROUP BY dloan;
#Modify the previous clause so that only those days where the member was loaned more than one book appear.
SELECT COUNT(dloan) AS numberOfLoans, dloan AS date FROM tloan WHERE YEAR(dloan) = 2014 AND ccpr = 0305393207 GROUP BY dloan HAVING numberOfLoans > 1;
#Show all library members from the newest to the oldest. Those who became members on the same day will be sorted alphabetically (by surname and name) within that day.
SELECT * FROM tmember ORDER BY dnewmember DESC, csurname ASC, cname ASC;
#Show the title of all books published by the publishing company with ID 32 along with their theme or themes.
SELECT tbook.ctitle AS title, ttheme.cname AS theme FROM tbook JOIN tbooktheme ON tbook.nbookid = tbooktheme.nbookid JOIN ttheme ON tbooktheme.nthemeid = ttheme.nthemeid WHERE npublishingcompanyid = 32;
#Show the name and surname of every author along with the number of books authored by them, but only for authors who have registered books on the database.
SELECT tauthor.cname AS name, tauthor.csurname AS surname, count(tauthorship.nbookid) AS books FROM tauthor JOIN tauthorship ON tauthor.nauthorid = tauthorship.nauthorid GROUP BY name, surname;
#Show the name and surname of all the authors with published books along with the lowest publishing year for their books.
SELECT tauthor.cname AS name, tauthor.csurname AS surname, MIN(tbook.npublishingyear) AS firstBookPublishedIn FROM tauthor JOIN tauthorship ON tauthor.nauthorid = tauthorship.nauthorid JOIN tbook ON tauthorship.nbookid = tbook.nbookid GROUP BY name, surname;
#For each signature and loan date, show the title of the corresponding books and the name and surname of the member who had them loaned.
SELECT tloan.csignature AS signature, tloan.dloan AS date, tbook.ctitle AS title, tmember.cname AS memberName, tmember.csurname AS memberSurname FROM tloan JOIN tbookcopy ON tloan.csignature = tbookcopy.csignature JOIN tbook ON tbookcopy.nbookid = tbook.nbookid JOIN tmember ON tloan.ccpr = tmember.ccpr ORDER BY signature, date;
#Repeat exercises 9 to 12 using the modern JOIN notation.

#Show all theme names along with the titles of their associated books. All themes must appear (even if there are no books for some particular themes). Sort by theme name.
SELECT ttheme.cname AS themeName, tbook.ctitle AS bookTitle FROM ttheme LEFT JOIN tbooktheme ON ttheme.nthemeid = tbooktheme.nthemeid LEFT JOIN tbook ON tbooktheme.nbookid = tbook.nbookid ORDER BY themeName;
#Show the name and surname of all members who joined the library in 2013 along with the title of the books they took on loan during that same year. All members must be shown, even if they did not take any book on loan during 2013. Sort by member surname and name.
SELECT tmember.cname AS name, tmember.csurname AS surname, tbook.ctitle AS bookTitle, YEAR(tloan.dloan) AS loanYear FROM tmember LEFT JOIN tloan ON tmember.ccpr = tloan.ccpr AND YEAR(tloan.dloan) = 2013 LEFT JOIN tbookcopy ON tloan.csignature = tbookcopy.csignature LEFT JOIN tbook ON tbookcopy.nbookid = tbook.nbookid WHERE year(tmember.dnewmember) = 2013 ORDER BY name, surname;
#Show the name and surname of all authors along with their nationality or nationalities and the titles of their books. Every author must be shown, even though s/he has no registered books. Sort by author name and surname.
SELECT tauthor.cname AS name, tauthor.csurname AS surname, tcountry.cname AS nationality, tbook.ctitle AS title FROM tauthor LEFT JOIN tnationality ON tauthor.nauthorid = tnationality.nauthorid LEFT JOIN tcountry ON tnationality.ncountryid = tcountry.ncountryid LEFT JOIN tauthorship ON tauthor.nauthorid = tauthorship.nauthorid LEFT JOIN tbook ON tauthorship.nbookid = tbook.nbookid ORDER BY name, surname;
#Show the title of those books which have had different editions published in both 1970 and 1989.
SELECT ctitle, COUNT(*) FROM tbook WHERE npublishingyear IN (1970, 1989) GROUP BY ctitle HAVING count(*) > 1;
#Show the surname and name of all members who joined the library in December 2013 followed by the surname and name of those authors whose name is “William”.
SELECT cname, csurname FROM tmember WHERE month(dnewmember) = 12 AND year(dnewmember) = 2013 UNION SELECT cname, csurname FROM tauthor WHERE cname = "william";
#Show the name and surname of the first chronological member of the library using subqueries.
SELECT cname, csurname FROM tmember WHERE ccpr = (SELECT ccpr FROM tmember ORDER BY dnewmember ASC LIMIT 1);
#For each publishing year, show the number of book titles published by publishing companies from countries that constitute the nationality for at least three authors. Use subqueries.
SELECT DISTINCT(npublishingyear), COUNT(npublishingyear) AS numberOfBook FROM tbook WHERE npublishingcompanyid IN (SELECT npublishingcompanyid FROM tpublishingcompany WHERE ncountryid IN (SELECT ncountryid FROM tnationality WHERE nauthorid IN (SELECT nauthorid FROM tauthor) GROUP BY ncountryid HAVING count(*) > 3)) GROUP BY npublishingyear ORDER BY npublishingyear;
#Show the name and country of all publishing companies with the headings "Name" and "Country".
SELECT tpublishingcompany.cname AS Name, tcountry.cname AS Country FROM tpublishingcompany JOIN tcountry ON tcountry.ncountryid = tpublishingcompany.ncountryid;
#Show the titles of the books published between 1926 and 1978 that were not published by the publishing company with ID 32.
SELECT ctitle FROM tbook WHERE npublishingyear BETWEEN 1926 AND 1978 AND npublishingcompanyid NOT IN (32);
#Show the name and surname of the members who joined the library after 2016 and have no address.
SELECT cname, csurname FROM tmember WHERE year(dnewmember) > 2016 AND caddress IS NULL;
#Show the country codes for countries with publishing companies. Exclude repeated values.
SELECT DISTINCT(ncountryid) FROM tcountry WHERE ncountryid IN (SELECT ncountryid FROM tpublishingcompany WHERE ncountryid IS NOT NULL);
#Show the titles of books whose title starts by "The Tale" and that are not published by "Lynch Inc".
SELECT ctitle FROM tbook WHERE ctitle LIKE ("The tale%") AND npublishingcompanyid IN (SELECT npublishingcompanyid FROM tpublishingcompany WHERE cname NOT IN ("Lynch Inc"));
#Show the list of themes for which the publishing company "Lynch Inc" has published books, excluding repeated values.
SELECT cname FROM ttheme WHERE nthemeid IN (SELECT nthemeid FROM tbooktheme WHERE nbookid IN (SELECT nbookid FROM tbook WHERE npublishingcompanyid IN (SELECT npublishingcompanyid FROM tpublishingcompany WHERE cname = "Lynch Inc")));
#Show the titles of those books which have never been loaned.
SELECT ctitle FROM tbook WHERE nbookid NOT IN (SELECT nbookid FROM tbookcopy WHERE csignature IN (SELECT csignature FROM tloan));
#For each publishing company, show its number of existing books under the heading "No. of Books".
SELECT DISTINCT(npublishingcompanyid), COUNT(ctitle) AS "No. of books" FROM tbook GROUP BY npublishingcompanyid ORDER BY npublishingcompanyid;
#Show the number of members who took some book on a loan during 2013.
SELECT COUNT(DISTINCT(ccpr)) FROM tloan WHERE year(dloan) = 2013;
#For each book that has at least two authors, show its title and number of authors under the heading "No. of Authors".
SELECT tbook.ctitle, COUNT(tauthorship.nauthorid) AS "No. Of Authors" FROM tbook JOIN tauthorship ON tbook.nbookid = tauthorship.nbookid WHERE tbook.nbookid IN (SELECT nbookid FROM tauthorship GROUP BY nbookid HAVING count(nauthorid) > 1) GROUP BY ctitle;