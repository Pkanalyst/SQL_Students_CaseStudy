'Created a Database'
Create Database Students;

'Activated Database'
use Students;
'Previously i loaded the ID as Int due to which  i altered ID columns and changed datatype to text'
alter table Bio
modify column ID text;

alter table student
modify column ID text;

'Added a column name NewDOB and convereted the Dob To NewDOB using Str_todate function '
alter table student
add column NewDOB Date;

update student
set NewDOB=str_to_date(dob, "%d-%c-%Y" );

'Table Selection'
Select * from student;
Select * from Bio;
Select * from Chem;
Select * from Phy;
Select * from Client;
Select * from Client_copy;

		  '\Tasks\'

''Consider the following database file to store the information of students:'
'STUDENT'
 'field type width contents'
 'id numeric 4 student id number'
' name character 10 name'
 'dob date 8 date of birth'
 'sex character 1 sex: M / F'
 'class character 2 class'
 'hcode character 1 house code: R, Y, B, G'
 'dcode character 3 district code'
 'mtest numeric 2 Math test score'
 
'1. a) List all the 2A students.'

select * from student
where Class="A2";

 'b) List the names and Math test scores of the 1B boys.'
 Select name,Mtest From Student
 where class="1B";

'2. a) List the classes, names of students whose names contain the letter "e" as the third letter.'

select Class,name from student
where name like "%e%";

 'b) List the classes, names of students whose names start with "T" and do not contain "y".'

select Class,name from student
where name like "e%" and name not like "%y%";

 'c) List the names of 1A students whose Math test score is not 51, 61, 71, 81, or 91.'

select name,mtest from student
where mtest not in(51,61,71,81,91);

 'd) List the students who were born between 22 March 1986 and 21 April 1986.'

select * from student
where Newdob Between "22-03-1986" and "21-04-1986";

'3. a) Find the number of girls living in TST.'

select count(dcode) from student
where sex="f" and Dcode = "tst";

 'b) List the number of pass in the Math test of each class. (passing mark = 50)'

select count(id) from student
where Mtest>=50;

 'c) List the number of girls grouped by each class.'

select class,count(sex) from student
where sex ="f"
group by class;

 'd) List the number of girls grouped by the year of birth.'

select Year(Newdob) as Years,count(sex) from student
where sex ="f"
group by (Years);

' e) Find the average age of boys.'

alter table student
add column Age Int;

Update student
set Age = year(current_date)-year(NewDob);

Select Avg(age) from student
where sex="M";

'4. a) Find the average mark of mtest for each class.'

select Class,avg(mtest) from student
group by Class;

 'b) Find the maximum mark of mtest for each sex.'

Select Sex,max(mtest) from student
group by (Sex);

 'c) Find the average mark of mtest for all students.'

select avg(mtest) from student;

'5. The tables phy, chem, bio are respectively the data files of the Physics Club, Chemistry Club and
Biology Club.
PHY / CHEM / BIO
 field type width contents
 id numeric 4 student id number
 name character 10 name
 sex character 1 sex: M / F
 class character 2 class'

'. a) List the students who are common members of the Physics Club and the Chemistry Club.'

select Id,Fullname from phy
where Id in (select id from chem);

' b) List the students who are common members of the Chemistry Club and Biology Club but not of
the Physics Club.'

select Id,Fullname from chem
where Id in (select id from bio) and id not in (select id from phy);



'6. A machinery company stores the parts information in a table with the following structure:
CLIENT
Field Name Type Width Description
Part_no Integer Unique code for a part
Descript Character 20 Description of the part
Qty Integer Quantity of the part
supplier Character 20 Supplier of the part
Write SQL statements to fulfill the following requests. Whenever the columns are not specified,
you may use SELECT * …'

 'a) Produce a list of parts in ascending order of quantity.'
 
select Part_No,Descript,Qty from client
order by (Qty) asc;

 'b) Produce a list of parts that consist of the keyword ‘Shaft’ in the description.'

select Part_No,Descript from client
where Descript like "%shaft%";

 'c) Produce a list of parts that have a quantity more than 20 and are supplied by ‘China Metals Co.’'

select * from client
where Qty > 20 and Supplier = "China Metals Co.";

'd) List all the suppliers without duplication.'

select distinct(Supplier) From client;

 'e) Increase the quantity by 10 for those parts with quantity less than 10. '

select Qty,Qty+10 as NewQty from client
where qty < 10 ;

 'f) Delete records with part_no equal to 879, 654, 231 and 234.'

Create table Client_copy (select * from client);

Delete from Client_copy
where part_no in (879,654,231,234);

 'g) Add a field “Date_purchase” to record the date of purchase.'
 
 alter table client
 add column Date_Of_Prurchase as date;