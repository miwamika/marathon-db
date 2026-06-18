-- DQL: аналитические запросы
-- Marathon Training Planner


-- Запрос 1: список спортсменов, отсортированный по дате регистрации
-- Цель: анализ активности новых пользователей
SELECT first_name, last_name, email, registration_date
FROM athletes
ORDER BY registration_date DESC;

-- Запрос 2: активные цели с именами спортсменов
-- Цель: выгрузка текущих задач для тренерского модуля
SELECT g.goal_id, a.first_name, g.distance_name
FROM goals g
JOIN athletes a ON g.athlete_id = a.athlete_id
WHERE g.goal_status = 'active';

-- Запрос 3: общее количество тренировок в системе
-- Цель: общая статистика активности
SELECT COUNT(*) AS total_workouts
FROM workouts;

-- Запрос 4: средняя длительность выполненных тренировок
-- Цель: анализ средней нагрузки на спортсмена
SELECT AVG(actual_duration_min) AS avg_duration
FROM workout_logs
WHERE actual_duration_min IS NOT NULL;

-- Запрос 5: суммарный пробег по каждому спортсмену
-- Цель: рейтинг спортсменов по общему километражу
SELECT a.first_name, a.last_name,
    SUM(wl.actual_distance_km) AS total_distance
FROM athletes a
JOIN workout_logs wl ON a.athlete_id = wl.athlete_id
GROUP BY a.athlete_id;

-- Запрос 6: спортсмены без поставленных целей
-- Цель: найти неактивных пользователей для напоминания
SELECT a.first_name, a.last_name, g.goal_status
FROM athletes a
LEFT JOIN goals g ON a.athlete_id = g.athlete_id;

-- Запрос 7: достижения с названием типа награды
-- Цель: отображение наград в профиле пользователя
SELECT aa.awarded_date, at.type_name
FROM athlete_achievement aa
JOIN achievements ac ON aa.achievement_id = ac.achievement_id
JOIN ach_types at ON ac.ach_type_id = at.ach_type_id
WHERE aa.athlete_id = 1;

-- Запрос 8: количество тренировок по статусам
-- Цель: анализ дисциплины — сколько выполнено, сколько пропущено
SELECT w.workout_status AS status_name,
    COUNT(w.workout_id) AS workout_count
FROM workouts w
GROUP BY w.workout_status;

-- Запрос 9: спортсмены с суммарным пробегом более 10 км
-- Цель: выделение активных пользователей
SELECT a.first_name,
    SUM(wl.actual_distance_km) AS total_distance
FROM athletes a
JOIN workout_logs wl ON a.athlete_id = wl.athlete_id
GROUP BY a.athlete_id
HAVING SUM(wl.actual_distance_km) > 10;

-- Запрос 10: диапазон пульса по каждому спортсмену
-- Цель: контроль пульсовых зон на основе выполненных тренировок
SELECT a.first_name,
    MIN(w.avg_heart_rate_bpm) AS min_hr,
    MAX(w.avg_heart_rate_bpm) AS max_hr
FROM athletes a
JOIN workouts w ON a.athlete_id = w.athlete_id
WHERE w.avg_heart_rate_bpm IS NOT NULL
GROUP BY a.athlete_id;
