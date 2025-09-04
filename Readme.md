### [DBOps Project] Sausage Store Analytics

Проект представляет собой аналитическую систему, моделирующую базу данных виртуального магазина. Она автоматизирует:

- Миграцию и настройку PostgreSQL через Flyway;
- Массовую генерацию данных (10 млн заказов и связей);
- Запуск CI/CD пайплайна с автотестами через GitHub Actions;
- Построение аналитических запросов к БД (например, подсчёт проданных сосисок за последние 7 дней).

### [Tech]

PostgreSQL, Flyway 9.22, CI/CD, GitHub Actions, Docker Compose, Docker

Структура проекта
```
.
├── .github/workflows/main.yml        # CI-пайплайн
├── docker-compose.yml                # Конфигурация запуска PostgreSQL
├── insert-data.sh                    # Bash-скрипт для ручной инициализации БД
├── migrations/
│   ├── V001__create_tables.sql       # Создание базовых таблиц
│   ├── V002__change_schema.sql       # Рефакторинг схемы и добавление внешних ключей
│   ├── V003__insert_data.sql         # Генерация данных
│   └── V004__create_index.sql        # Создание индексов для ускорения
├── Readme.md                         # Документация проекта

```

### [Setup]

1. Склонировать репозиторий

```sh
git clone https://github.com/dupreehkuda/cloud-services-engineer-dbops-project.git
cd cloud-services-engineer-dbops-project
```

2. Запустить PostgreSQL через Docker Compose

```sh
docker-compose up -d
```

3. Запустить миграции Flyway

```sh
flyway -url=jdbc:postgresql://localhost:5432/store \
-user=user -password=password \
-locations=filesystem:migrations migrate
```

4. Проверить содержимое БД

```sh
psql -U user -d store -h localhost -c '\dt'
```

### [CI/CD]

Файл `.github/workflows/main.yml` автоматически запускает:
- PostgreSQL в контейнере;
- Установку Flyway и прогон миграций;
- Скачивание и запуск автотестов (dbopstest);
- Проверку структуры и содержимого БД.

Пайплайн запускается при пуше в main.

### [Analytics]
Пример запроса: сколько сосисок было продано за каждый день предыдущей недели:
```sql
SELECT
    o.date_created,
    SUM(op.quantity) AS total_sold
FROM
    orders AS o
    JOIN
        order_product AS op ON o.id = op.order_id
WHERE
    o.status = 'shipped' AND 
    o.date_created > NOW() - INTERVAL '7 DAY'
GROUP BY
    o.date_created
ORDER BY
    o.date_created;
```


### [Migrations]

- V001__create_tables.sql: базовые таблицы product, orders, order_product.
- V002__change_schema.sql: удаление избыточных таблиц, добавление полей price, date_created, внешние ключи.
- V003__insert_data.sql: добавление 10M записей с generate_series и random().
- V004__create_index.sql: индексация по order_id, status, date_created для ускорения аналитики.

### [Done by]

Данила Курач

oraculmorgl@yandex.ru