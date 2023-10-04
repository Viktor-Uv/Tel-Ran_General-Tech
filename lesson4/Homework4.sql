/*
 * General Tech. Homework #4
 * Viktor Uvarchev
 * 04 Oct 2023
 */

USE learn;

SELECT *
FROM students;

# пункты 1 - 3 сделаны на уроке

# Задача 4. Поменять тип у gender на char(1)(вспоминаем modify)
ALTER TABLE students
    MODIFY COLUMN gender CHAR(1);

# Задача 5. переименовать поле name на firstname
ALTER TABLE students
    RENAME COLUMN name TO firstname;

# Задача 6. Выборки
# * найти учеников, у которых оценка больше 4
SELECT *
FROM students
WHERE avg_mark > 4;
# * найти учеников, у которых не входит в диапазон от 3 до 4
SELECT *
FROM students
WHERE avg_mark NOT BETWEEN 3 AND 4;
# * найти учеников, у которых имя начинается на И
SELECT *
FROM students
WHERE firstname LIKE 'I%';
# * найти учеников, у которых оценка 2.2 или 3.1 или 4.7
SELECT *
FROM students
WHERE avg_mark IN (2.2, 3.1, 4.7);

# Задача 7. Создать представление, которое содержит всех мужчин
CREATE VIEW v_students_men AS
SELECT *
FROM students
WHERE gender = 'M';

# Задача 8. Создать представление, которое содержит всех женщин
CREATE VIEW v_students_women AS
SELECT *
FROM students
WHERE gender = 'F';

# Задача 9. Найти набор уникальных оценок
SELECT DISTINCT avg_mark
FROM students;

# Задача 10. Увеличить всем учащимся оценку в 10 раз
# (предварительно нужно сделать drop check на колонке с оценками,
# а так же изменить тип колонки на более большой numeric(3,1))
SHOW CREATE TABLE students;

ALTER TABLE students
    DROP CHECK students_chk_1,
    MODIFY COLUMN avg_mark NUMERIC(3, 1);

UPDATE students
SET avg_mark = avg_mark * 10;

# Задача 11. Поменяйте у Олега Петрова фамилию на Сидоров
UPDATE students
SET lastname = 'Sidorov'
WHERE firstname = 'Oleg'
  AND lastname = 'Petrov';

# Задача 12. Для всех учеников, у которых оценка не больше 31, увеличить на 10
UPDATE students
SET avg_mark = avg_mark + 10
WHERE NOT avg_mark > 31;