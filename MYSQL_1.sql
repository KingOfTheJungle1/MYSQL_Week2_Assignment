C:\Users\bobvi>mysql -u root -p
Enter password: *************
Welcome to the MySQL monitor.  Commands end with ; or \g.
Your MySQL connection id is 15
Server version: 8.0.27 MySQL Community Server - GPL

Copyright (c) 2000, 2021, Oracle and/or its affiliates.

Oracle is a registered trademark of Oracle Corporation and/or its
affiliates. Other names may be trademarks of their respective
owners.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

mysql> show databases;
+--------------------+
| Database           |
+--------------------+
| employees          |
| information_schema |
| mysql              |
| performance_schema |
| sakila             |
| sys                |
| world              |
+--------------------+
7 rows in set (0.01 sec)

mysql> use employees;
Database changed
mysql> desc employees;
+------------+---------------+------+-----+---------+-------+
| Field      | Type          | Null | Key | Default | Extra |
+------------+---------------+------+-----+---------+-------+
| emp_no     | int           | NO   | PRI | NULL    |       |
| birth_date | date          | NO   |     | NULL    |       |
| first_name | varchar(14)   | NO   |     | NULL    |       |
| last_name  | varchar(16)   | NO   |     | NULL    |       |
| gender     | enum('M','F') | NO   |     | NULL    |       |
| hire_date  | date          | NO   |     | NULL    |       |
+------------+---------------+------+-----+---------+-------+
6 rows in set (0.10 sec)

mysql> desc titles;
+-----------+-------------+------+-----+---------+-------+
| Field     | Type        | Null | Key | Default | Extra |
+-----------+-------------+------+-----+---------+-------+
| emp_no    | int         | NO   | PRI | NULL    |       |
| title     | varchar(50) | NO   | PRI | NULL    |       |
| from_date | date        | NO   | PRI | NULL    |       |
| to_date   | date        | YES  |     | NULL    |       |
+-----------+-------------+------+-----+---------+-------+
4 rows in set (0.00 sec)

mysql> SELECT t.title, COUNT(*) AS "Number of Employees" FROM titles AS t JOIN employees AS e ON e.emp_no = t.emp_no WHERE e.birth_date > '1965-01-01' GROUP BY t.title;
+--------------------+---------------------+
| title              | Number of Employees |
+--------------------+---------------------+
| Senior Staff       |                 612 |
| Staff              |                 703 |
| Technique Leader   |                  95 |
| Senior Engineer    |                 589 |
| Engineer           |                 657 |
| Assistant Engineer |                  97 |
+--------------------+---------------------+
6 rows in set (0.57 sec)

mysql> desc salaries;
+-----------+------+------+-----+---------+-------+
| Field     | Type | Null | Key | Default | Extra |
+-----------+------+------+-----+---------+-------+
| emp_no    | int  | NO   | PRI | NULL    |       |
| salary    | int  | NO   |     | NULL    |       |
| from_date | date | NO   | PRI | NULL    |       |
| to_date   | date | NO   |     | NULL    |       |
+-----------+------+------+-----+---------+-------+
4 rows in set (0.10 sec)

mysql> desc titles;
+-----------+-------------+------+-----+---------+-------+
| Field     | Type        | Null | Key | Default | Extra |
+-----------+-------------+------+-----+---------+-------+
| emp_no    | int         | NO   | PRI | NULL    |       |
| title     | varchar(50) | NO   | PRI | NULL    |       |
| from_date | date        | NO   | PRI | NULL    |       |
| to_date   | date        | YES  |     | NULL    |       |
+-----------+-------------+------+-----+---------+-------+
4 rows in set (0.00 sec)

mysql> desc departments;
+-----------+-------------+------+-----+---------+-------+
| Field     | Type        | Null | Key | Default | Extra |
+-----------+-------------+------+-----+---------+-------+
| dept_no   | char(4)     | NO   | PRI | NULL    |       |
| dept_name | varchar(40) | NO   | UNI | NULL    |       |
+-----------+-------------+------+-----+---------+-------+
2 rows in set (0.00 sec)

mysql> desc dept_emp;
+-----------+---------+------+-----+---------+-------+
| Field     | Type    | Null | Key | Default | Extra |
+-----------+---------+------+-----+---------+-------+
| emp_no    | int     | NO   | PRI | NULL    |       |
| dept_no   | char(4) | NO   | PRI | NULL    |       |
| from_date | date    | NO   |     | NULL    |       |
| to_date   | date    | NO   |     | NULL    |       |
+-----------+---------+------+-----+---------+-------+
4 rows in set (0.00 sec)

mysql> SELECT t.title, avg(s.salary) AS "Average Salary" FROM titles t INNER JOIN salaries s ON s.emp_no = t.emp_no GROUP BY t.title;
+--------------------+----------------+
| title              | Average Salary |
+--------------------+----------------+
| Senior Engineer    |     60543.2191 |
| Staff              |     69308.7124 |
| Engineer           |     59508.0751 |
| Senior Staff       |     70470.5013 |
| Assistant Engineer |     59304.9863 |
| Technique Leader   |     59294.3742 |
| Manager            |     66924.2706 |
+--------------------+----------------+
7 rows in set (5.05 sec)

mysql> SELECT sum(s.salary), d.dept_name FROM salaries s INNER JOIN dept_emp de ON de.emp_no = s.emp_no INNER JOIN departments d ON d.dept_no = de.dept_no WHERE dept_name = "Marketing" AND de.from_date >= '1990-01-01' AND de.to_date <= '1992-12-31' GROUP BY d.dept_name;
+---------------+-----------+
| sum(s.salary) | dept_name |
+---------------+-----------+
|      54989098 | Marketing |
+---------------+-----------+
1 row in set (1.31 sec)