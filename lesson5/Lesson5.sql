-- INNER JOIN --> only lines that matched linking condition will show up

USE learn;

CREATE TABLE stud
(
    id      INTEGER PRIMARY KEY AUTO_INCREMENT,
    name    VARCHAR(128) NOT NULL,
    surname VARCHAR(128) NOT NULL
);

CREATE TABLE ages
(
    student_id INTEGER UNIQUE,
    age        INTEGER
);

INSERT INTO stud (name, surname)
VALUES ('Alex', 'Alexeev'),
       ('Oleg', 'Olegov'),
       ('Maxim', 'Maximov');

SELECT *
FROM stud;

/*
    Alex    Alexeev     20  id 1
    Oleg    Olegov      34  id 2
    Maxim   Maximov     25  id 3
 */

INSERT INTO ages (student_id, age)
VALUES (1, 20),
       (2, 34),
       (3, 25);

SELECT *
FROM ages;

INSERT INTO stud (name, surname)
    VALUE ('Petr', 'Petrov');

INSERT INTO ages (student_id, age)
    VALUE (5, 54);

SELECT t1.*,
       t2.age
FROM stud t1 # ---------------  t1 - alias for stud
         INNER JOIN ages t2 --  t2 - alias for ages
                    ON t1.id = t2.student_id; -- only lines that matched this condition will show up

CREATE TABLE courses
(
    id   INTEGER PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(128)
);

INSERT INTO courses (name)
VALUES ('Java'),
       ('Algo'),
       ('SQL');

INSERT INTO courses (name)
VALUES ('JS');

SELECT *
FROM courses;

CREATE TABLE course2student -- link between tables 'stud' and 'courses'
(
    student_id INTEGER,
    course_id  INTEGER
);

/*
    id 1 - Java, Algo
    id 2 - Algo
    id 3 - SQL, Algo
 */

INSERT INTO course2student (student_id, course_id)
VALUES (1, 1),
       (1, 2),
       (2, 2),
       (3, 3),
       (3, 2);

INSERT INTO course2student (student_id, course_id)
VALUES (6, 4);

SELECT *
FROM course2student;

SELECT t1.*,
       t3.name course_name
FROM stud t1
         INNER JOIN course2student t2
                    ON t1.id = t2.student_id
         INNER JOIN courses t3
                    ON t2.course_id = t3.id;


/*
    Task: Create table contacts with student's phone numbers
            add two numbers for one student, and one number for another
            list students with their phone numbers
 */

CREATE TABLE contacts
(
    student_id   INTEGER,
    phone_number VARCHAR(128) UNIQUE NOT NULL
);

INSERT INTO contacts (student_id, phone_number)
VALUES (1, '123 456 789'),
       (1, '123 123 790'),
       (3, '654 456 800');

SELECT t1.name,
       t1.surname,
       t2.phone_number
FROM stud t1
         INNER JOIN contacts t2
                    ON t1.id = t2.student_id;


-- LEFT JOIN --> retain all data from first table

SELECT t1.*,
       t2.phone_number
FROM stud t1
         LEFT JOIN contacts t2
                   ON t1.id = t2.student_id;


-- RIGHT JOIN --> retain all data from last table

SELECT t1.*,
       t2.age
FROM stud t1
         RIGHT JOIN ages t2
                    ON t1.id = t2.student_id;


-- ================= --

USE hr;

SELECT *
FROM employees
LIMIT 50;

SELECT *
FROM departments
LIMIT 5;

/*
    Task 1. print name, surname of employees and department name where he works
 */
SELECT t1.first_name,
       t1.last_name,
       t2.department_name
FROM employees t1
         INNER JOIN departments t2
                    ON t1.department_id = t2.department_id;

/*
    Task 2. print name, surname of employees and department name where he works,
            but department must be IT, Treasury, IT Support
 */
SELECT t1.first_name,
       t1.last_name,
       t2.department_name
FROM employees t1
         INNER JOIN departments t2
                    ON t1.department_id = t2.department_id
WHERE t2.department_name IN ('IT', 'Treasury', 'IT Support');

# second option:
SELECT t1.first_name,
       t1.last_name,
       t2.department_name
FROM employees t1
         INNER JOIN departments t2
                    ON t1.department_id = t2.department_id
                        AND t2.department_name IN ('IT', 'Treasury', 'IT Support');

# --> option with 'AND' may lead to an improved productivity, but carefully with LEFT JOIN:
SELECT t1.first_name,
       t1.last_name,
       t2.department_name
FROM employees t1
         LEFT JOIN departments t2
                   ON t1.department_id = t2.department_id
                       AND t2.department_name IN ('IT', 'Treasury', 'IT Support');

/*
    Task 3. print name, surname of employees and name, surname of of his manager
 */
-- 'SELF' JOIN --
SELECT t1.first_name AS empl_name,
       t1.last_name AS empl_surname,
       t2.first_name AS manag_name,
       t2.last_name AS manag_name
FROM employees t1
         INNER JOIN employees t2
                    ON t1.manager_id = t2.employee_id;

