/*
 * General Tech. Homework #3
 * Viktor Uvarchev
 * 24 Sep 2023
 */

USE learn;

SELECT *
FROM staff;

SELECT *
FROM v_staff_worker;

SELECT *
FROM v_staff_security;

SELECT *
FROM v_staff_administration;

SELECT *
FROM staff_selection;


# 1) Создайте таблицу staff (
#   id, целое число
#   name, строка
#   surname, строка
#   age, целое число
#   position, строка
CREATE TABLE staff
(
    id       INTEGER,
    name     VARCHAR(64),
    surname  VARCHAR(64),
    age      INTEGER,
    position VARCHAR(64)
);

# 2) Заполните таблицу значениями из 10 строк по примеру :
#   1,'Alex','Alexeev',24,'worker'
#   2,'Oleg','Olegov',36,'administration'
#   и так далее.
#   В качестве возможных значений в поле position используйте
#   worker,administration, security
INSERT INTO staff
VALUES (1, 'Alex', 'Alexeev', 24, 'worker'),
       (2, 'Oleg', 'Olegov', 36, 'administration'),
       (3, 'Irina', 'Smirnova', 23, 'worker'),
       (4, 'Svetlana', 'Petrova', 27, 'security'),
       (5, 'Nikolay', 'Sidorov', 31, 'administration'),
       (6, 'Vladimir', 'Ivanov', 29, 'worker'),
       (7, 'Elena', 'Kuznetsova', 25, 'security'),
       (8, 'Andrey', 'Popov', 50, 'administration'),
       (9, 'Olga', 'Novikova', 26, 'worker'),
       (10, 'Dmitry', 'Zaitsev', 28, 'worker');

# 3) Добавьте в уже готовую и заполненную таблицу поле salary - целое число.
ALTER TABLE staff
    ADD COLUMN salary INTEGER;

# 4) Проставьте значение поля salary следующим образом :
#   если сотрудник категории worker - 1000
#   если сотрудник категории administration - 5000
#   если сотрудник категории security - 2000
UPDATE staff
SET salary =
        CASE
            WHEN position = 'worker'
                THEN 1000
            WHEN position = 'administration'
                THEN 5000
            WHEN position = 'security'
                THEN 2000
            END
WHERE position IN ('worker', 'administration', 'security');

# 5) Увеличьте всем сотрудникам зарплату в два раза.
UPDATE staff
SET salary = salary * 2
WHERE position IN ('worker', 'administration', 'security');

# 6) Удалите из таблицы сотрудников, чей возраст больше чем 45.
DELETE
FROM staff
WHERE age > 45;

# 7) Создайте три представления :
#   первое - хранит только сотрудников типа worker,
#   второй - security,
#   третье - administration
CREATE VIEW v_staff_worker AS
SELECT *
FROM staff
WHERE position = 'worker';

CREATE VIEW v_staff_security AS
SELECT *
FROM staff
WHERE position = 'security';

CREATE VIEW v_staff_administration AS
SELECT *
FROM staff
WHERE position = 'administration';

# 8) Создайте новую таблицу на основе выборки из таблицы staff,
#   которая будет хранить только name,surname,position
#   сотрудников , которые относятся к administration
CREATE TABLE staff_selection AS
SELECT name,
       surname,
       position
FROM staff
WHERE position = 'administration';

# 9) Удалите колонку position из новой таблицы.
ALTER TABLE staff_selection
DROP COLUMN position;
