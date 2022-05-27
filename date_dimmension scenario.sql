create table date_dimension
(DATE_KEY int ,
ACCURATE_DATE date,
DAY_NUMBER_OF_WEEK int,
DAY_NUMBER_OF_MONTH int,
DAY_NUMBER_OF_YEAR int,
WEEK_NO_OF_MONTH int,
WEEK_NO_YEAR int,
MONTH_NO int,
MONTH_SHORT_NAME varchar(20),
MONTH_FULL_NAME varchar(20),
QTR_NO int,
SEMESTER_NO int,
CALENDER_YEAR int,
FISCAL_MONTH int,
FISCAL_WEEK int,
FISCAL_QTR int,
FISCAL_YEAR varchar(20),
WEEK_DAY_FLAG varchar(10));

select * from date_dimension
create sequence sq_date;
/
create or replace procedure  check_date (p_date date)as
start_date date;
last_date date;
begin
start_date:=trunc(p_date,'yy');
last_date:=add_months(start_date,12)-1;
    while start_date<last_date loop
        insert into date_dimension values(sq_date.nextval,(to_char(p_date,'dd-mm-yy')),
                                (select to_char(start_date,'d')from dual),
                                (select to_char(start_date,'dd')from dual),
                                (select to_char(start_date,'ddd') from dual),
                                (select to_char(start_date,'w')from dual),
                                (select to_char(start_date,'ww') from dual),
                                (select to_char(start_date,'mm')from dual),
                                (select to_char(start_date,'mon')from dual),
                                (select to_char(start_date,'month')from dual),
                                (select to_char(start_date,'q')from dual),
                                (select case when  to_char(start_date,'mm') <=6 then 1 else 2 end from dual),
                                (select to_char(start_date,'yyyy')from dual),
                                (select to_char(add_months(start_date,-3),'mm') from dual),
                                (select to_char(add_months(start_date,-3),'w') from dual),
                                ( select to_char(add_months(start_date,-3),'q') from dual),
                                (select to_char(add_months(start_date,-3),'yy') from dual),
                                (select  case when to_char(start_date,'dy') not in  ('sat','sun')then 'YES' else 'NO' end  from dual));
start_date:=start_date+1;
end loop;
commit;
end;

/
exec check_date('20-9-2022');

select * from date_dimension;
truncate table date_dimension;

