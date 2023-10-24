-- Date 20.10.2023
-- Time 19:06
-- Year 2023
-- DateTime date+time
-- Timestamp

USE shop;

SELECT CURDATE(); -- only date

SELECT NOW(); -- date+time at program runtime

SELECT SYSDATE();
-- date+time at function runtime

-- convert string to date

SELECT STR_TO_DATE('2023-10-20 19:20:55', '%Y-%m-%d %H:%i:%s');

SELECT STR_TO_DATE('2023-10-20 19:20:55', '%Y-%m-%d');

SELECT STR_TO_DATE('20-10-23 19:20:55', '%d-%m-%Y');

-- extract data from date

SELECT EXTRACT(HOUR FROM '2023-10-20 19:20:55');
SELECT EXTRACT(YEAR FROM '2023-10-20 19:20:55');
SELECT EXTRACT(MONTH FROM '2023-10-20 19:20:55');

SELECT EXTRACT(MONTH FROM '2023-10-20');

SELECT DATE_ADD('2023-10-20 19:20:55', INTERVAL 5 DAY); -- add some interval to date

SELECT DATE_ADD('2023-10-20 19:20:55', INTERVAL -5 DAY); -- subtract some interval from date

SELECT DATE_ADD('2023-10-20 19:20:55', INTERVAL 5 MONTH);

SELECT DATEDIFF('2023-10-20', '2023-10-05');
-- difference in days

/*
	1. print all orders in March
 */
SELECT *
FROM orders
WHERE MONTH(odate) = 3;

/*
	2. print all orders from 10.04.2022 to 10.05.2022
 */
SELECT *
FROM orders
WHERE odate BETWEEN '2022-04-10' AND '2022-05-10';

/*
	3. print count of orders in June

    COUNT() -- count number of rows
 */
SELECT COUNT(*) -- counts number of all rows, including null values
FROM orders
WHERE MONTH(odate) = 6;

/*
	4. print average amount for orders in March

    AVG() -- count average for rows
 */
SELECT AVG(AMT)
FROM ORDERS
WHERE MONTH(odate) = 3;

/*
    5. print all orders on tuesday

    WEEKDAY() - weekdays in mysql start from 0
 */
SELECT *
FROM orders
WHERE WEEKDAY(ODATE) = 1;


-- ==================== --

USE uni;

SELECT *
FROM students;

SELECT *
FROM teachers;

SELECT *
FROM courses;

SELECT *
FROM students2courses;

SELECT *
FROM teachers2competencies;

/*
    1. print students name and their courses
 */
SELECT t1.name,
       t3.title
FROM students t1
         INNER JOIN students2courses t2
                    ON t1.id = t2.student_id
         INNER JOIN courses t3
                    ON t3.id = t2.course_id;

/*
    2. print all teachers name with their competency
 */
SELECT t1.name,
       t3.title
FROM teachers t1
         LEFT JOIN teachers2competencies t2
                   ON t1.id = t2.teacher_id
         LEFT JOIN competencies t3
                   ON t2.competencies_id = t3.id;

/*
    3. print all teachers without competency
 */
SELECT t1.name
FROM teachers t1
         LEFT JOIN teachers2competencies t2
                   ON t1.id = t2.teacher_id
WHERE t2.competencies_id IS NULL;

/*
    4. print students name without any courses
 */
SELECT t1.name
FROM students t1
         LEFT JOIN students2courses t2
                   ON t1.id = t2.course_id
WHERE t2.course_id IS NULL;

/*
    5. print courses without any students
 */
SELECT t1.title
FROM courses t1
LEFT JOIN students2courses t2
ON t1.id = t2.course_id
WHERE t2.student_id IS NULL;

/*
    6. print competencies without any teachers
 */
SELECT t1.title
FROM competencies t1
         LEFT JOIN teachers2competencies t2
                   ON t1.id = t2.competencies_id
WHERE t2.competencies_id IS NULL;

/*
    7. print course name and headman name
 */
SELECT t1.title AS course,
       t2.name AS headman
FROM courses t1
INNER JOIN students t2
ON t1.headman_id = t2.id;
