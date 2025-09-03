-- Индекс для ускорения JOIN по order_id в order_product
CREATE INDEX IF NOT EXISTS order_product_order_id_idx
    ON order_product(order_id);

-- Композитный индекс для фильтрации по статусу и дате в orders
CREATE INDEX IF NOT EXISTS orders_status_date_idx
    ON orders(status, date_created);