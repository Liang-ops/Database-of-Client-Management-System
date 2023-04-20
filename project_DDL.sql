drop table Address cascade constraints;
drop table Account_info cascade constraints;
drop table Account_executive cascade constraints;
drop table Sales_representative cascade constraints;
drop table Prospect cascade constraints;
drop table Opportunity cascade constraints;
drop table Meeting_opportunity cascade constraints;
drop table Meeting cascade constraints;
drop table Task cascade constraints;

-- table Prospect
create table Prospect(
Prospect_ID number (10) primary key,
Prospect_name varchar (40) not null,
Company_name varchar(40) not null,
Email_address varchar (40),
Phone_number varchar(12),
Company_type varchar(40),
SDR_ID number(10),
Address_ID number(10),
AE_ID number(10)
);

comment on column Prospect.Prospect_id is 'primary key of prospect table.' ;
comment on column Prospect.prospect_name is 'prospected customer name' ;
comment on column Prospect.company_name is 'company name of prospected customer';
comment on column Prospect.email_address is 'email address of prospected customer';
comment on column Prospect.phone_number is 'phone number of prospected customer';
comment on column Prospect.company_type is 'company type of prospected ccustomer';
comment on column Prospect.SDR_ID is 'foreign key to SDR_ID column of Sales representative table';
comment on column Prospect.Address_ID is 'foreign key to Address_ID column of Address table';
comment on column Prospect.AE_ID is 'foreign key to AE_ID column of Account Executive table';

-- table Sales_representative
create table Sales_representative(
SDR_ID number (10) primary key,
SDR_name varchar (20) not null,
Territory varchar(20)
);

comment on column Sales_representative.SDR_ID is 'primary key of Sales_representative table';
comment on column Sales_representative.SDR_name is 'name of sales representative';
comment on column Sales_representative.Territory is 'the area where the sales representative is responsible';

-- table Address
create table Address(
Address_ID number(10) primary key,
Street_address varchar(30) not null,
City varchar(20) not null,
State_suffix varchar(5) not null,
Postal_code varchar(6)
);

comment on column Address.Address_ID is 'primary key of Address table';
comment on column Address.Street_address is 'street name';
comment on column Address.City is 'city name of the address';
comment on column Address.State_suffix is 'State name of the address';
comment on column Address.Postal_code is 'postal code of the address';


-- table Account_info
create table Account_info(
Account_ID number(10) primary key,
Company_name varchar(20) not null,
Address_ID number(10)
);

comment on column Account_info.Account_ID is 'primary key of Account_info table';
comment on column Account_info.Company_name is 'company name of the customer';
comment on column Account_info.Address_ID is 'foreign key to Address_ID column of Address table';

-- table Task
create table Task(
Task_ID number(10) primary key,
Task_type varchar(10) not null,
Date_scheduled date not null,
Date_completed date not null,
SDR_ID number(10),
AE_ID number(10)
);

comment on column Task.Task_ID is 'primary key of Task table';
comment on column Task.Task_type is 'type of the task';
comment on column Task.Date_scheduled is 'scheduled date of the task';
comment on column Task.Date_completed is 'expected completion date of the task';
comment on column Task.SDR_ID is 'foreign key to SDR_ID column of Sales_representative table';
comment on column Task.AE_ID is 'foreign key to AE_ID column of Account Executive table';


-- table Meeting
create table Meeting(
Meeting_ID number(10) primary key,
Meeting_type varchar(20) not null,
Date_scheduled date not null,
Next_step_date date,
SDR_ID number(10),
AE_ID number(10)
);

comment on column Meeting.Meeting_ID is 'primary key of Meeting table';
comment on column Meeting.Date_scheduled is 'date of scheduled meeting';
comment on column Meeting.Meeting_type is 'type of scheduled meeting';
comment on column Meeting.Next_step_date is 'date of next scheduled meeting';
comment on column Meeting.SDR_ID is 'foreign key to SDR_ID column of Sales_representative table';
comment on column Meeting.AE_ID is 'foreign key to AE_ID column of Account Executive table';


-- table Meeting_Opportunity
create table Meeting_Opportunity(
MeetingOpp_ID number(10) primary key,
Opportunity_ID number(10),
Meeting_ID number(10)
);

comment on column Meeting_Opportunity.MeetingOpp_ID is 'primary key of Meeting Opportunity table';
comment on column Meeting_Opportunity.Opportunity_ID is 'foreign key to Opportunity_ID column of Account_info table';
comment on column Meeting_Opportunity.Meeting_ID is 'foreign key to Meeting_ID column of Meeting table';

-- table Account_Executive
create table Account_Executive(
AE_id number(10) primary key,
User_name varchar(20) not null,
Territory varchar(20)
);

comment on column Account_Executive.AE_id is 'primary key of Account Executive table';
comment on column Account_Executive.User_name is 'name of the account executor';
comment on column Account_Executive.Territory is 'the area where the account executor is responsible';

-- table Oppoetunity 
create table Opportunity(
Opportunity_id number(10) primary key,
Solution_type varchar(20) not null,
Date_opened date not null,
Account_ID number(10)
);

comment on column Opportunity.Opportunity_id is 'primary key of Opportunity table';
comment on column Opportunity.Solution_type is 'solution type of prospected customer';
comment on column Opportunity.Date_opened is 'date that the opportunity is opened';
comment on column Opportunity.Account_ID is 'foreign key to Account_ID column of Account_info table';

-- add foreign keys of each table

alter table Prospect 
add constraint fk_prospect_sdr
foreign key (SDR_id)
references Sales_representative(SDR_id)
on delete cascade
NOT DEFERRABLE ;

alter table Prospect 
add constraint fk_prospect_address
foreign key (address_id)
references Address(address_id)
on delete cascade
NOT DEFERRABLE ;

alter table Prospect 
add constraint fk_prospect_AE
foreign key (AE_id)
references Account_Executive(AE_id)
on delete cascade
NOT DEFERRABLE ;

alter table Meeting 
add constraint fk_meeting_sdr
foreign key (SDR_id)
references Sales_representative(SDR_id)
on delete cascade;

alter table Meeting 
add constraint fk_meeting_AE
foreign key (AE_id)
references Account_Executive(AE_id)
on delete cascade
NOT DEFERRABLE ;

alter table Task
add constraint fk_task_AE
foreign key (AE_id)
references Account_Executive(AE_id)
on delete cascade
NOT DEFERRABLE ;

alter table Task
add constraint fk_task_sdr
foreign key (sdr_id)
references Sales_representative(SDR_id)
on delete cascade
NOT DEFERRABLE ;


alter table account_info
add constraint fk_account_address
foreign key (address_id)
references Address(address_id)
on delete cascade
NOT DEFERRABLE ;


alter table opportunity
add constraint fk_op_account
foreign key (account_id)
references account_info(account_id)
on delete cascade
NOT DEFERRABLE ;

alter table Meeting_opportunity
add constraint fk_mtop_opportunity
foreign key (opportunity_id)
references opportunity(opportunity_id)
on delete cascade
NOT DEFERRABLE ;

alter table Meeting_opportunity
add constraint fk_mtop_meeting
foreign key (meeting_id)
references meeting(meeting_id)
on delete cascade
NOT DEFERRABLE ;