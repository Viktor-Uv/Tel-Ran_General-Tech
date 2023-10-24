CREATE DATABASE uni;

USE uni;

CREATE TABLE Students
(
    id   INTEGER PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(128) NOT NULL,
    age  INTEGER
);

CREATE TABLE Teachers
(
    id   INTEGER PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(128) NOT NULL,
    age  INTEGER
);

CREATE TABLE Competencies
(
    id    INTEGER PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(128) NOT NULL
);

CREATE TABLE Teachers2Competencies
(
    id              INTEGER PRIMARY KEY AUTO_INCREMENT,
    teacher_id      INTEGER,
    competencies_id INTEGER
);

CREATE TABLE Courses
(
    id         INTEGER PRIMARY KEY AUTO_INCREMENT,
    teacher_id INTEGER,
    title      VARCHAR(128) NOT NULL,
    headman_id INTEGER
);

CREATE TABLE Students2Courses
(
    id         INTEGER PRIMARY KEY AUTO_INCREMENT,
    student_id INTEGER,
    course_id  INTEGER
);

INSERT INTO students (name, age)
VALUES ('Анатолий', 29);
INSERT INTO students (name, age)
VALUES ('Олег', 25);
INSERT INTO students (name, age)
VALUES ('Семен', 27);
INSERT INTO students (name, age)
VALUES ('Олеся', 28);
INSERT INTO students (name, age)
VALUES ('Ольга', 31);
INSERT INTO students (name, age)
VALUES ('Иван', 22);

INSERT INTO teachers (name, age)
VALUES ('Петр', 39);
INSERT INTO teachers (name, age)
VALUES ('Максим', 35);
INSERT INTO teachers (name, age)
VALUES ('Антон', 37);
INSERT INTO teachers (name, age)
VALUES ('Всеволод', 38);
INSERT INTO teachers (name, age)
VALUES ('Егор', 41);
INSERT INTO teachers (name, age)
VALUES ('Светлана', 32);

INSERT INTO Competencies (title)
VALUES ('Математика');
INSERT INTO Competencies (title)
VALUES ('Информатика');
INSERT INTO Competencies (title)
VALUES ('Программирование');
INSERT INTO Competencies (title)
VALUES ('Графика');

INSERT INTO Teachers2Competencies (teacher_id, competencies_id)
VALUES (1, 1);
INSERT INTO Teachers2Competencies (teacher_id, competencies_id)
VALUES (2, 1);
INSERT INTO Teachers2Competencies (teacher_id, competencies_id)
VALUES (2, 3);
INSERT INTO Teachers2Competencies (teacher_id, competencies_id)
VALUES (3, 2);
INSERT INTO Teachers2Competencies (teacher_id, competencies_id)
VALUES (4, 1);
INSERT INTO Teachers2Competencies (teacher_id, competencies_id)
VALUES (5, 3);

INSERT INTO courses (teacher_id, title, headman_id)
VALUES (1, 'Алгебра логики', 2);
INSERT INTO courses (teacher_id, title, headman_id)
VALUES (2, 'Математическая статистика', 3);
INSERT INTO courses (teacher_id, title, headman_id)
VALUES (4, 'Высшая математика', 5);
INSERT INTO courses (teacher_id, title, headman_id)
VALUES (5, 'Javascript', 1);
INSERT INTO courses (teacher_id, title, headman_id)
VALUES (5, 'Базовый Python', 1);

INSERT INTO students2courses (student_id, course_id)
VALUES (1, 1);
INSERT INTO students2courses (student_id, course_id)
VALUES (2, 1);
INSERT INTO students2courses (student_id, course_id)
VALUES (3, 2);
INSERT INTO students2courses (student_id, course_id)
VALUES (3, 3);
INSERT INTO students2courses (student_id, course_id)
VALUES (4, 5);
