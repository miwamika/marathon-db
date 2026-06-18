-- ============================================================
-- DML: тестовые данные и операции с ними
-- Marathon Training Planner
-- ============================================================

-- Оператор 7: добавление нового спортсмена
-- Создаём тестового пользователя Иван Петров для проверки системы
INSERT INTO athletes (first_name, last_name, email, password_hash,
    date_of_birth, gender, registration_date)
VALUES ('Иван', 'Петров', 'ivan.petrov@example.com',
    'hash_string_123', '1995-05-20', 'M', NOW());

-- Оператор 8: добавление спортивной цели для спортсмена
-- Иван ставит цель пробежать марафон (42.2 км), статус — активна
INSERT INTO goals (athlete_id, distance_km, distance_name, goal_status,
    start_date)
VALUES (1, 42.2, 'Марафон', 'active', NOW());

-- Оператор 9: внесение факта выполнения тренировки
-- Фиксируем реальные показатели: 10.5 км за 55 минут, пульс 145
INSERT INTO workout_logs (workout_id, athlete_id, log_date,
    actual_distance_km, actual_duration_min, avg_heart_rate_bpm, notes)
VALUES (10, 1, '2026-02-15', 10.5, 55, 145,
    'Самочувствие хорошее, погода ясная');

-- Оператор 10: обновление контактного телефона спортсмена
UPDATE athletes
SET phone = '+79990000000'
WHERE athlete_id = 1;

-- Оператор 11: изменение статуса цели на "достигнута"
-- Спортсмен завершил подготовку и пробежал марафон
UPDATE goals
SET goal_status = 'achieved'
WHERE goal_id = 1;

-- Оператор 12: удаление ошибочной записи из журнала тренировок
-- Запись была добавлена по ошибке
DELETE FROM workout_logs
WHERE log_id = 999;

-- Оператор 13: обновление фитнес-показателей спортсмена
-- После медицинского обследования обновляем пульс и уровень подготовки
UPDATE athletes
SET max_heart_rate = 185, fitness_level = 2
WHERE athlete_id = 1;
