-- Table Schemata
CREATE TABLE "departments" (
    "dept_no" VARCHAR(30 NOT NULL,
    "dept_name" VARCHAR(30  NOT NULL,
    CONSTRAINT "pk_departments" PRIMARY KEY (
        "dept_no"
     )
);

CREATE TABLE "dept_emp" (
    "emp_no" INT   NOT NULL,
    "dept_no" VARCHAR(30)   NOT NULL
);

CREATE TABLE "dept_manager" (
    "dept_no" VARCHAR(30)   NOT NULL,
    "emp_no" INT   NOT NULL
);

CREATE TABLE "employees" (
    "emp_no" INT   NOT NULL,
    "emp_title" VARCHAR(30)   NOT NULL,
    "birth_date" VARCHAR(30)   NOT NULL,
    "first_name" VARCHAR(30)   NOT NULL,
    "last_name" VARCHAR(30)   NOT NULL,
    "sex" VARCHAR(30)   NOT NULL,
    "hire_date" DATE   NOT NULL,
    CONSTRAINT "pk_employees" PRIMARY KEY (
        "emp_no"
     )
);

CREATE TABLE "salaries" (
    "emp_no" INT   NOT NULL,
    "salary" INT   NOT NULL
);

CREATE TABLE "titles" (
    "title_id" VARCHAR(30)   NOT NULL,
    "title" VARCHAR(30)   NOT NULL,
    CONSTRAINT "pk_titles" PRIMARY KEY (
        "title_id"
     )
);

ALTER TABLE "dept_emp" ADD CONSTRAINT "fk_dept_emp_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

ALTER TABLE "dept_emp" ADD CONSTRAINT "fk_dept_emp_dept_no" FOREIGN KEY("dept_no")
REFERENCES "departments" ("dept_no");

ALTER TABLE "dept_manager" ADD CONSTRAINT "fk_dept_manager_dept_no" FOREIGN KEY("dept_no")
REFERENCES "departments" ("dept_no");

ALTER TABLE "dept_manager" ADD CONSTRAINT "fk_dept_manager_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

ALTER TABLE "employees" ADD CONSTRAINT "fk_employees_emp_title" FOREIGN KEY("emp_title")
REFERENCES "titles" ("title_id");

ALTER TABLE "salaries" ADD CONSTRAINT "fk_salaries_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

-- Data Analysis
-- 1)
select 
	e.emp_no, 
	e.last_name, 
	e.first_name, 
	e.sex,
	s.salary
from employees as e
inner join salaries as s
on e.emp_no = s.emp_no

-- 2) 
select
	last_name, 
	first_name, 
	hire_date
from employees
where hire_date > '1/01/1986'
and hire_date < '12/31/1986'
order by 3 

-- 3)
select 
	dm.dept_no,
	d.dept_name,
	dm.emp_no,
	e.last_name,
	e.first_name
from dept_manager as dm
inner join departments as d
on dm.dept_no = d.dept_no
inner join employees as e
on dm.emp_no = e.emp_no

-- 4)
select 
	de.dept_no,
	de.emp_no,
	e.last_name,
	e.first_name,
	d.dept_name
from dept_emp as de
inner join employees as e
on de.emp_no = e.emp_no
inner join departments as d
on de.dept_no = d.dept_no

--5)
select first_name, last_name, sex
from employees
where first_name = 'Hercules'
and last_name like 'B%'

--6)
select
	de.emp_no,
	e.last_name,
	e.first_name
from dept_emp as de
inner join employees as e
on de.emp_no = e.emp_no
where dept_no = 'd007'

--7)
select
	de.emp_no,
	de.dept_no,
	e.last_name,
	e.first_name,
	d.dept_name
from dept_emp as de
inner join employees as e
on de.emp_no = e.emp_no
inner join departments as d
on de.dept_no = d.dept_no
where de.dept_no in ('d007','d005')

--8)
select last_name, count(last_name)
as "Last Name Freq"
from employees
group by last_name
order by "Last Name Freq" desc
