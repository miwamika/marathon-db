-- ============================================================
-- DDL: структура базы данных Marathon Training Planner
-- MySQL 8.0
-- ============================================================

-- Оператор 1: ограничение на максимальный пульс спортсмена
-- Исключает некорректные физиологические данные (0 и выше 250 уд/мин)
ALTER TABLE athlete_fitness
ADD CONSTRAINT chk_max_heart_rate
CHECK (max_heart_rate > 0 AND max_heart_rate < 250);

-- Оператор 2: индекс на поле email для ускорения аутентификации
-- Email используется как логин — быстрый поиск критичен
CREATE INDEX idx_athletes_email ON athletes(email);

-- Оператор 3: расширение поля notes до TEXT
-- VARCHAR может не вместить подробные комментарии спортсмена о самочувствии
ALTER TABLE workout_logs
MODIFY COLUMN notes TEXT;

-- Оператор 4: ограничение на даты цели
-- Дата достижения цели не может быть раньше даты начала подготовки
ALTER TABLE goals
ADD CONSTRAINT chk_goal_dates
CHECK (target_date >= start_date);

-- Оператор 5: добавление столбца даты регистрации
-- Нужен для отслеживания активности пользователей и формирования статистики
ALTER TABLE athletes
ADD COLUMN registration_date DATETIME DEFAULT CURRENT_TIMESTAMP;

-- Оператор 6: индекс на статус цели для ускорения фильтрации
-- Частая операция в отчётах: выборка active / achieved / cancelled
CREATE INDEX idx_goals_status ON goals(goal_status);
