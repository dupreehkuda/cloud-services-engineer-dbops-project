-- Удаляем вспомогательную таблицу product_info, если она существует
DROP TABLE IF EXISTS product_info;

-- Удаляем вспомогательную таблицу orders_date, если она существует
DROP TABLE IF EXISTS orders_date;

-- Добавляем новый столбец price (цена) в таблицу product, если он ещё не существует
ALTER TABLE product
    ADD COLUMN IF NOT EXISTS price double precision;

-- Добавляем столбец date_created (дата создания заказа) в таблицу orders, если он ещё не существует.
-- Значение по умолчанию — текущая дата.
ALTER TABLE orders
    ADD COLUMN IF NOT EXISTS date_created date DEFAULT current_date;

-- Добавляем внешний ключ к order_product:
-- поле order_id теперь должно ссылаться на существующий id в таблице orders
ALTER TABLE order_product
    ADD FOREIGN KEY (order_id) REFERENCES orders(id);

-- Добавляем внешний ключ к order_product:
-- поле product_id теперь должно ссылаться на существующий id в таблице product
ALTER TABLE order_product
    ADD FOREIGN KEY (product_id) REFERENCES product(id);