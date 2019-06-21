-- Deletes all tables in the database, allowing the user to start fresh
-- Filename: LoanProject-DropTables.sql
DROP TABLE payment CASCADE CONSTRAINTS;
DROP TABLE bill CASCADE CONSTRAINTS;
DROP TABLE collection_management CASCADE CONSTRAINTS;
DROP TABLE other_secured_loan CASCADE CONSTRAINTS;
DROP TABLE boat_loan CASCADE CONSTRAINTS;
DROP TABLE auto_loan CASCADE CONSTRAINTS;
DROP TABLE relationship CASCADE CONSTRAINTS;
DROP TABLE loan CASCADE CONSTRAINTS;
DROP TABLE pre_qualification CASCADE CONSTRAINTS;
DROP TABLE employee CASCADE CONSTRAINTS;
DROP TABLE loan_product CASCADE CONSTRAINTS;
DROP TABLE consumer CASCADE CONSTRAINTS;


-- Creates database tables
-- Filename: LoanProject-CreateTables.sql

-- Create consumer table
CREATE TABLE consumer (
ssn CHAR(9),
first_name VARCHAR(50),
last_name VARCHAR(50),
middle_initial CHAR(1),
dob DATE,
addr_1 VARCHAR(100),
addr_2 VARCHAR(100),
city VARCHAR(100),
state CHAR(2),
ZIP  CHAR(5),
income NUMBER(8,0),
credit_score NUMBER(3,0),
PRIMARY KEY(ssn)
);

-- Create loan_product table
CREATE TABLE loan_product (
loan_type VARCHAR(10),
CHECK (loan_type IN('Auto','Boat','Secured','Unsecured')),
max_term int,
CHECK (max_term <=180),
PRIMARY KEY(loan_type)
);

-- Create employee table
CREATE TABLE employee (
employee_id CHAR(4),
emp_first_name VARCHAR(50),
emp_last_name VARCHAR(50),
date_employed DATE,
job_title VARCHAR(50),
PRIMARY KEY(employee_id)
);

-- Create pre_qualification table
CREATE TABLE pre_qualification (
application_id CHAR(9),
ssn CHAR(9),
credit_score int,
income NUMBER(10,2),
debts NUMBER(10,2),
accept CHAR(1)
   CHECK(accept IN ('Y','N')),
prequal_date DATE,
PRIMARY KEY (application_id),
FOREIGN KEY (ssn) REFERENCES consumer(ssn)
);

-- Create loan table
CREATE TABLE loan (
loan_number CHAR(9),
loan_type VARCHAR(10),
loan_amount DECIMAL(7,2),
interest_rate DECIMAL(5,3),
term_months DECIMAL(3,0),
payment DECIMAL(6,2),
date_created DATE,
first_payment DATE,
maturity DATE,
next_payment_due DATE,
curr_balance DECIMAL(7,2),
curr_due DECIMAL(7,2),
late_fees_due DECIMAL(6,2),
PRIMARY KEY (loan_number),
FOREIGN KEY (loan_type) REFERENCES loan_product(loan_type)
);

-- Create relationship table
CREATE TABLE relationship (
ssn CHAR(9),
loan_number CHAR(9),
role VARCHAR (20),
PRIMARY KEY (ssn, loan_number),
FOREIGN KEY (ssn) REFERENCES consumer(ssn),
FOREIGN KEY(loan_number) REFERENCES loan(loan_number)
);

-- Create auto_loan table
CREATE TABLE auto_loan (
loan_number CHAR(9),
auto_title_no VARCHAR(12),
auto_insurance_pol_no VARCHAR(12),
make VARCHAR(20),
model VARCHAR(20),
model_year CHAR(4),
PRIMARY KEY (loan_number),
FOREIGN KEY (loan_number) REFERENCES loan(loan_number)
);

-- Create boat_loan table
CREATE TABLE boat_loan
(
loan_number CHAR(9),
marine_title_no VARCHAR(12),
boat_insurance_pol_no VARCHAR(12),
PRIMARY KEY (loan_number),
FOREIGN KEY (loan_number) REFERENCES loan(loan_number)
);

-- Create other_secured_loan table
CREATE TABLE other_secured_loan (
loan_number CHAR(9),
collat_desc VARCHAR(50),
ucc_filing_no VARCHAR(10),
PRIMARY KEY (loan_number),
FOREIGN KEY (loan_number) REFERENCES loan(loan_number)
);

-- Create collection_management table
CREATE TABLE collection_management (
collection_tick_number CHAR(9),
loan_number CHAR(9),
employee_id CHAR(4),
ssn CHAR(9),
date_of_contact DATE,
conversation_summary CHAR(500),
Amount_collected DECIMAL(6,2),
PRIMARY KEY (collection_tick_number),
FOREIGN KEY (loan_number) REFERENCES loan(loan_number),
FOREIGN KEY (employee_id) REFERENCES employee(employee_id),
FOREIGN KEY (ssn) REFERENCES consumer(ssn)
);

-- Create bill table
CREATE TABLE bill(
bill_number CHAR(9),
loan_number CHAR(9),
bill_date DATE,
total_due DECIMAL(6,2),
PRIMARY KEY (bill_number),
FOREIGN KEY (loan_number) REFERENCES loan(loan_number)
);

-- Create payment table
CREATE TABLE payment (
paymentid CHAR(9),
bill_number CHAR(9),
ssn CHAR(9),
payment_type CHAR(9),
payment_amount DECIMAL(6,2),
payment_date DATE,
PRIMARY KEY (paymentid),
FOREIGN KEY (bill_number) REFERENCES bill(bill_number),
FOREIGN KEY (ssn) REFERENCES consumer(ssn)
);


-- Deletes all tables in the database, allowing the user to start fresh
-- Filename: LoanProject-FillTables.sql

-- Add data into consumer table
INSERT INTO consumer VALUES('004571073','Aiden','Schroeder','B','31-Aug-1955','6649 N Blue Gum St','','New Orleans','LA','70122',100000,700);
INSERT INTO consumer VALUES('926862928','Lucas','McKinney','J','19-Mar-1963','4B Blue Ridge Blvd','','Brighton','MI','48116',125000,750);
INSERT INTO consumer VALUES('612160290','Ben','Simmons','A','28-Sep-1970','8 W Cerritos Ave','','Bridgeport','NJ','08014',95000,727);
INSERT INTO consumer VALUES('749585360','Khloe','Buchanan','L','24-Mar-1980','639 Main St','Unit #54','Anchorage','AK','99501',80000,699);
INSERT INTO consumer VALUES('002169202','Jordan','Carter','P','15-Dec-1967','34 Center St','','Hamilton','OH','45013',110000,742);
INSERT INTO consumer VALUES('223692959','Desi','Perkins','M','17-Sep-1976','3 Mcauley Dr','','Marlborough','CT','06447',175000,758);
INSERT INTO consumer VALUES('559529231','Tinashe','Kachingwe','E','23-Feb-1970','7 Eads St','Apt 4C','Chicago','IL','60616',60000,740);
INSERT INTO consumer VALUES('308819168','Alexander','McQueen','N','03-Dec-1981','7 W Jackson Blvd','#88','San Jose','CA','95122',78000,722);
INSERT INTO consumer VALUES('247958170','Lisa','Lee','','28-Jul-1977','20 Hammond Pl','','Moraga','CA','94556',95000,738);
INSERT INTO consumer VALUES('409711848','Jackson','Cooper','P','13-May-1997','228 Runamuck Pl ','Unit #2808','Baltimore','MD','21231',53000,777);
INSERT INTO consumer VALUES('071543914','Keira','Beck','S','26-Aug-1970','2371 Jerrold Ave','','Kulpsville','PA','19446',110000,781);
INSERT INTO consumer VALUES('736576599','Daisy','Marquez','W','25-Mar-1989','37275 S Rt 17','Building M','Middle Island','NY','11953',72000,758);
INSERT INTO consumer VALUES('093872951','Gabriel','Zamora','H','10-Mar-1973','6 Greenleaf Ave','','Santa Clara','CA','95111',118000,652);
INSERT INTO consumer VALUES('596261957','Carli','Bybel','O','17-Oct-1980','618 W Yakima Ave','','Dallas','TX','75062',250000,760);
INSERT INTO consumer VALUES('184326908','Ellen','Marchese','J','13-Sep-1975','74 S Westgate St','Building D','Albany','NY','12204',89000,697);
INSERT INTO consumer VALUES('992514512','Brent','Faiyaz','M','19-Sep-1989','3273 State St','','Middlesex','NJ','8846',145000,770);
INSERT INTO consumer VALUES('303261905','Damian','Lillard','','15-Jul-1990','1 Central Ave','','Portage','WI','54481',94000,693);
INSERT INTO consumer VALUES('236367286','Nancy','Cruz','M','12-May-1977','86 Nw 66th St','Unit #8673','Johnson','KS','66218',115000,730);
INSERT INTO consumer VALUES('472300902','Sydney','Lillian','R','24-Nov-1969','2 Cedar Ave','#84','Talbot','MD','21601',82000,710);
INSERT INTO consumer VALUES('633820135','Lily','Duong','T','05-Aug-1989','90991 Thorburn Ave','','New York','NY','10011',164000,732);
INSERT INTO consumer VALUES('170220857','Sophie','McQueen','A','11-Nov-1958','12 Hillside Ave','','Santa Clara','CA','95129',65000,700);
INSERT INTO consumer VALUES('226190841','Tanya','Bradstreet','R','12-Jun-1977','74 S Westgate St','Building D','Albany','NY','12204',84000,697);
INSERT INTO consumer VALUES('842017297','Barbara','McKinney','Q','21-Jan-1969','4B Blue Ridge Boulevard','','Brighton','MI','48116',96000,688);
INSERT INTO consumer VALUES('620787963','Robert','Lillard','J','27-Aug-1965','68 Oak Street','','Baraboo','WI','53913',75000,720);

-- Add data into loan_product table
INSERT INTO loan_product VALUES('Auto',60);
INSERT INTO loan_product VALUES('Boat',60);
INSERT INTO loan_product VALUES('Secured',48);
INSERT INTO loan_product VALUES('Unsecured',36);

-- Add data into employee table
INSERT INTO employee VALUES('0001','Maribel','Cox','09-Jul-1990', 'President');
INSERT INTO employee VALUES('0002','Sydnee','Abbott','04-Nov-1999', 'Controller');
INSERT INTO employee VALUES('0003','Ali','Wong','11-Aug-2012', 'Originator');
INSERT INTO employee VALUES('0004','Skylar','Hughes','10-Nov-2004', 'Servicer');
INSERT INTO employee VALUES('0005','Jacquelyn','Pace','07-Feb-2006', 'Collector');
INSERT INTO employee VALUES('0006','Joel','Embiid','25-Mar-2015', 'Collector');
INSERT INTO employee VALUES('0007','Ernest','Clouter','05-Jun-2014', 'Underwriter');
INSERT INTO employee VALUES('0008','Ugo','Etudo','09-Jul-2010', 'Vice President');
INSERT INTO employee VALUES('0009','Jennifer','Eigo','24-Apr-2005', 'Controller');
INSERT INTO employee VALUES('0010','Chris','Field','16-Oct-2017', 'Underwriter');

-- Add data into pre_qualification table
INSERT INTO pre_qualification VALUES('000000357','926862928',750,125000, 1354.16,'Y','03-Mar-2017');
INSERT INTO pre_qualification VALUES('000000630','612160290',727,95000, 2612.5,'N','20-Jun-2017');
INSERT INTO pre_qualification VALUES('000001459','749585360',699,80000, 1680,'N','20-Apr-2018');
INSERT INTO pre_qualification VALUES('000001505','223692959',758,175000, 4375,'N','20-Apr-2018');
INSERT INTO pre_qualification VALUES('000001943','559529231',740,60000, 1750,'Y','01-May-2018');
INSERT INTO pre_qualification VALUES('000002077','247958170',738,95000, 2770.83,'N','01-May-2018');
INSERT INTO pre_qualification VALUES('000002089','409711848',777,53000, 1502.68,'N','01-May-2018');
INSERT INTO pre_qualification VALUES('000002161','071543914',781,110000, 2200,'Y','01-May-2018');

-- Add data into loan table
INSERT INTO loan VALUES('000958757','Auto',7500,4.75,36,223.94,'11-Sep-2015','11-Oct-2015','11-Sep-2018','11-Oct-2018',0,0,0);
INSERT INTO loan VALUES('001830745','Auto',10000,4.125,60,184.73,'30-Oct-2016','30-Nov-2016','30-Oct-2021','30-Apr-2019',4293.24,184.73,0);
INSERT INTO loan VALUES('003402184','Auto',30000,4.25,60,555.89,'07-May-2017','07-Jun-2017','07-May-2022','07-May-2019',18268.1,555.89,0);
INSERT INTO loan VALUES('006817077','Auto',12000,5.625,48,276.76,'16-Aug-2018','16-Sep-2018','16-Aug-2022','16-May-2019',9716.68,0,0);
INSERT INTO loan VALUES('008728142','Auto',8000,5.375,60,152.35,'01-Nov-2018','01-Dec-2018','01-Nov-2023','01-May-2019',7293.44,152.35,0);
INSERT INTO loan VALUES('009061384','Auto',17800,5.25,60,337.95,'13-Jan-2019','13-Feb-2019','13-Jan-2025','13-Feb-2019',17278.86,1013.85,50.69);
INSERT INTO loan VALUES('181736352','Boat',75000,5.875,144,727.05,'05-Dec-2011','05-Jan-2012','05-Dec-2023','05-Mar-2019',34981.79,1454.1,72.71);
INSERT INTO loan VALUES('390903722','Boat',40000,6.625,120,456.74,'20-Jul-2013','20-Aug-2013','20-Jul-2023','20-May-2019',19562.06,0,0);
INSERT INTO loan VALUES('582327841','Boat',62000,6.75,144,629.36,'07-Oct-2014','07-Nov-2014','07-Oct-2026','07-May-2019',44350.42,629.36,0);
INSERT INTO loan VALUES('649891495','Boat',56000,7.125,144,579.63,'21-May-2017','21-Jun-2017','21-May-2029','21-May-2019',49361.5,0,0);
INSERT INTO loan VALUES('685099491','Boat',40000,7.25,120,469.6,'02-Jul-2017','02-Aug-2017','02-Jul-2027','02-May-2019',34393.81,0,0);
INSERT INTO loan VALUES('928635275','Boat',25000,6.875,96,339.29,'02-Apr-2019','02-May-2019','02-Apr-2027','02-May-2019',25000,0,0);
INSERT INTO loan VALUES('082267982','Secured',40000,6.75,48,953.22,'02-Jun-2015','02-Jul-2015','02-Jun-2019','02-May-2019',948.25,0,0);
INSERT INTO loan VALUES('205166892','Secured',10000,6.25,24,444.33,'14-Dec-2016','14-Jan-2017','14-Dec-2018','14-Jan-2019',0,0,0);
INSERT INTO loan VALUES('222528863','Secured',14000,10,36,451.74,'18-Feb-2017','18-Mar-2017','18-Feb-2020','18-Apr-2019',4317.34,451.74,22.59);
INSERT INTO loan VALUES('521761793','Secured',36000,8.25,48,883.1,'22-May-2018','22-Jun-2018','22-May-2022','22-Mar-2019',28762.84,1766.2,44.16);
INSERT INTO loan VALUES('524316780','Secured',18000,7.625,48,436.27,'22-Apr-2019','22-May-2019','22-Apr-2023','22-May-2019',18000,0,0);
INSERT INTO loan VALUES('488087360','Unsecured',15000,15.25,36,521.84,'13-Sep-2016','13-Oct-2016','13-Sep-2019','13-May-2019',1526.26,0,0);
INSERT INTO loan VALUES('582327842','Unsecured',14000,14.5,36,481.89,'10-Apr-2017','10-May-2017','10-Apr-2020','10-Apr-2019',4513.69,481.89,24.09);
INSERT INTO loan VALUES('685099492','Unsecured',7000,10.125,24,323.42,'06-Jul-2018','06-Aug-2018','06-Jul-2020','06-May-2019',3966.37,0,0);
INSERT INTO loan VALUES('805000796','Unsecured',20000,15.75,36,700.67,'06-Jan-2019','06-Feb-2019','06-Jan-2022','06-May-2019',17751.11,0,0);

-- Add data into relationship table
INSERT INTO relationship VALUES('303261905','001830745','Borrower');
INSERT INTO relationship VALUES('620787963','001830745','Guarantor');
INSERT INTO relationship VALUES('926862928','003402184','Borrower');
INSERT INTO relationship VALUES('093872951','006817077','Borrower');
INSERT INTO relationship VALUES('559529231','009061384','Borrower');
INSERT INTO relationship VALUES('071543914','008728142','Borrower');
INSERT INTO relationship VALUES('596261957','000958757','Borrower');
INSERT INTO relationship VALUES('236367286','685099491','Borrower');
INSERT INTO relationship VALUES('736576599','390903722','Borrower');
INSERT INTO relationship VALUES('472300902','181736352','Borrower');
INSERT INTO relationship VALUES('926862928','582327841','Borrower');
INSERT INTO relationship VALUES('842017297','582327841','Co-Borrower');
INSERT INTO relationship VALUES('004571073','928635275','Borrower');
INSERT INTO relationship VALUES('308819168','649891495','Borrower');
INSERT INTO relationship VALUES('559529231','205166892','Borrower');
INSERT INTO relationship VALUES('633820135','082267982','Borrower');
INSERT INTO relationship VALUES('184326908','521761793','Borrower');
INSERT INTO relationship VALUES('226190841','521761793','Co-Borrower');
INSERT INTO relationship VALUES('992514512','524316780','Borrower');
INSERT INTO relationship VALUES('633820135','222528863','Borrower');
INSERT INTO relationship VALUES('093872951','488087360','Borrower');
INSERT INTO relationship VALUES('004571073','685099492','Borrower');
INSERT INTO relationship VALUES('308819168','805000796','Borrower');
INSERT INTO relationship VALUES('170220857','805000796','Guarantor');
INSERT INTO relationship VALUES('002169202','582327842','Borrower');

-- Add data into auto_loan table
INSERT INTO auto_loan VALUES('000958757','TX014551041','12796993','Subaru','Legacy','2015');
INSERT INTO auto_loan VALUES('001830745','WI26313306','04781665','Chevrolet','Camaro','2016');
INSERT INTO auto_loan VALUES('003402184','MI2666276A','6963502148','BMW','Series Sedan','2017');
INSERT INTO auto_loan VALUES('006817077','CA0052420219','32201247','Lexus','ES','2018');
INSERT INTO auto_loan VALUES('008728142','PA77237417','2778541369','Toyota','Avalon','2018');
INSERT INTO auto_loan VALUES('009061384','IL078973719','81794470','Audi','A4','2019');

-- Add data into boat_loan table
INSERT INTO boat_loan VALUES('181736352','MD0148735316','163464023');
INSERT INTO boat_loan VALUES('390903722','NY0865943021','743049774');
INSERT INTO boat_loan VALUES('582327841','MI311869384','410157561');
INSERT INTO boat_loan VALUES('649891495','CA0782935027','665788024');
INSERT INTO boat_loan VALUES('685099491','KS0031532','972259339');
INSERT INTO boat_loan VALUES('928635275','LA767694532','927168568');

-- Add data into other_secured_loan table
INSERT INTO other_secured_loan VALUES('082267982','Stock certificate','39639120');
INSERT INTO other_secured_loan VALUES('205166892','Inventory','34827909');
INSERT INTO other_secured_loan VALUES('222528863','Personal watercraft','91085016');
INSERT INTO other_secured_loan VALUES('521761793','Backhoe','3591447');
INSERT INTO other_secured_loan VALUES('524316780','Home equity','5476499');

-- Add data into collection_management table
INSERT INTO collection_management VALUES('000001263','009061384','0005','559529231','28-May-2012','Confirmed identity of customer and customer contact infomation. Confirmed with customer that debt has not been paid. Customer stated that he was short on cash due to a big purchase he had made earlier in the month but could pay $55 today. Customer paid via credit card over the phone','55');
INSERT INTO collection_management VALUES('000002912','390903722','0006','736576599','05-May-2014','Confirmed identity of customer and customer contact infomation. Confirmed with customer that debt has not been paid. Customer stated she could not pay today due to other financial obligations but could pay the following week. Will follow up with customer via a call next week',0);
INSERT INTO collection_management VALUES('000004312','649891495','0005','308819168','02-Jul-2018','Confirmed identity of customer and customer contact infomation. Confirmed with customer that debt has not been paid. Customer stated he could pay $125 today. Customer paid via credit card over the phone',125);
INSERT INTO collection_management VALUES('000007334','521761793','0004','226190841','23-Feb-2019','Confirmed identity of customer and customer contact infomation. Confirmed with customer that debt has not been paid. Customer stated she could not pay today due to other financial obligations but could pay the following week. Will follow up with customer via a call next week',0);
INSERT INTO collection_management VALUES('000003245','390903722','0006','736576599','12-May-2014','Confirmed identity of customer and customer contact information. Confirmed with customer that debt has not yet been paid. Customer paid 25% of the general amount via credit card in person. ',2000);
INSERT INTO collection_management VALUES('000007335','521761793','0004','226190841','02-Mar-2019','Confirmed identity of customer and customer contact infomation. Confirmed with customer that debt has not been paid. Customer stated she could not pay today due to other financial obligations but could pay the following week. Will follow up with customer via a call next week',0);
INSERT INTO collection_management VALUES('000007336','521761793','0004','226190841','09-Mar-2019','Confirmed identity of customer and customer contact infomation. Confirmed with customer that debt has not been paid. Customer said she could pay $80 towards the loan today. Customer paid via credit card.',80);

-- Add data into bill table
INSERT INTO bill VALUES('689400001','000958757','11-Sep-2018',223.94);
INSERT INTO bill VALUES('689400002','205166892','14-Dec-2018',444.33);
INSERT INTO bill VALUES('689500001','008728142','01-Apr-2019',152.35);
INSERT INTO bill VALUES('689500002','685099491','02-Apr-2019',469.6);
INSERT INTO bill VALUES('689500003','082267982','02-Apr-2019',948.25);
INSERT INTO bill VALUES('689500004','181736352','05-Apr-2019',1526.81);
INSERT INTO bill VALUES('689500005','685099492','06-Apr-2019',323.42);
INSERT INTO bill VALUES('689500006','805000796','06-Apr-2019',700.67);
INSERT INTO bill VALUES('689500007','003402184','07-Apr-2019',555.89);
INSERT INTO bill VALUES('689500008','582327841','07-Apr-2019',629.36);
INSERT INTO bill VALUES('689500009','582327842','10-Apr-2019',481.89);
INSERT INTO bill VALUES('689500010','009061384','13-Apr-2019',1064.54);
INSERT INTO bill VALUES('689500011','488087360','13-Apr-2019',521.84);
INSERT INTO bill VALUES('689500012','006817077','16-Apr-2019',276.76);
INSERT INTO bill VALUES('689500013','222528863','18-Apr-2019',451.74);
INSERT INTO bill VALUES('689500014','390903722','20-Apr-2019',456.74);
INSERT INTO bill VALUES('689500015','649891495','21-Apr-2019',579.63);
INSERT INTO bill VALUES('689500016','521761793','22-Apr-2019',1810.36);
INSERT INTO bill VALUES('689500017','524316780','22-Apr-2019',436.27);
INSERT INTO bill VALUES('689500018','001830745','30-Apr-2019',184.73);

-- Add data into payment table
INSERT INTO payment VALUES('701980001','689400001','596261957','Credit',223.94,'15-Sep-2018');
INSERT INTO payment VALUES('701980002','689400002','559529231','Credit',444.33,'21-Dec-2018');
INSERT INTO payment VALUES('701990001','689500001','071543914','Credit',152.35,'10-Apr-2019');
INSERT INTO payment VALUES('701990002','689500002','236367286','Credit',469.6,'03-Apr-2019');
INSERT INTO payment VALUES('701990003','689500003','633820135','Check',953.22,'12-Apr-2019');
INSERT INTO payment VALUES('701990004','689500004','472300902','Credit',727.05,'08-Mar-2019');
INSERT INTO payment VALUES('701990005','689500005','004571073','Credit',323.42,'10-Apr-2019');
INSERT INTO payment VALUES('701990006','689500006','308819168','Credit',700.67,'10-Apr-2019');
INSERT INTO payment VALUES('701990007','689500007','926862928','Credit',555.89,'09-Apr-2019');
INSERT INTO payment VALUES('701990008','689500008','926862928','Check',629.36,'13-Apr-2019');
INSERT INTO payment VALUES('701990009','689500009','002169202','Credit',481.89,'15-Apr-2019');
INSERT INTO payment VALUES('701990010','689500010','559529231','Credit',337.95,'17-Feb-2019');
INSERT INTO payment VALUES('701990011','689500011','093872951','Credit',521.84,'23-Apr-2019');
INSERT INTO payment VALUES('701990012','689500012','093872951','Credit',276.76,'23-Apr-2019');
INSERT INTO payment VALUES('701990013','689500013','633820135','Check',451.74,'24-Mar-2019');
INSERT INTO payment VALUES('701990014','689500014','736576599','Credit',456.74,'25-Apr-2019');
INSERT INTO payment VALUES('701990015','689500015','308819168','Check',579.63,'22-Apr-2019');
INSERT INTO payment VALUES('701990016','689500016','184326908','Credit',883.1,'27-Mar-2019');
INSERT INTO payment VALUES('701990017','689500017','992514512','Credit',436.27,'29-Apr-2019');
INSERT INTO payment VALUES('701990018','689500018','303261905','Credit',184.73,'09-May-2019');
