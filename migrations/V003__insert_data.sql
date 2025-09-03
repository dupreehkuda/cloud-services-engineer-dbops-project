-- Вставка 6 фиксированных товаров в таблицу product с заданными id, названиями, ссылками на изображения и ценами
INSERT INTO product (id, name, picture_url, price)
VALUES (1, 'Сливочная', 'https://res.cloudinary.com/sugrobov/image/upload/v1623323635/repos/sausages/6.jpg', 320.00);

INSERT INTO product (id, name, picture_url, price)
VALUES (2, 'Особая', 'https://res.cloudinary.com/sugrobov/image/upload/v1623323635/repos/sausages/5.jpg', 179.00);

INSERT INTO product (id, name, picture_url, price)
VALUES (3, 'Молочная', 'https://res.cloudinary.com/sugrobov/image/upload/v1623323635/repos/sausages/4.jpg', 225.00);

INSERT INTO product (id, name, picture_url, price)
VALUES (4, 'Нюренбергская', 'https://res.cloudinary.com/sugrobov/image/upload/v1623323635/repos/sausages/3.jpg', 315.00);

INSERT INTO product (id, name, picture_url, price)
VALUES (5, 'Мюнхенская', 'https://res.cloudinary.com/sugrobov/image/upload/v1623323635/repos/sausages/2.jpg', 330.00);

INSERT INTO product (id, name, picture_url, price)
VALUES (6, 'Русская', 'https://res.cloudinary.com/sugrobov/image/upload/v1623323635/repos/sausages/1.jpg', 189.00);


-- Массовая генерация 10 миллионов заказов в таблицу orders:
-- каждому заказу присваивается случайный статус из массива: 'pending', 'shipped', 'cancelled'
INSERT INTO orders (id, status)
SELECT
    i,
    (array['pending', 'shipped', 'cancelled'])[floor(random() * 3 + 1)]
FROM
    generate_series(1, 10000000) s(i);


-- Массовая генерация 10 миллионов записей в таблицу order_product:
-- случайное количество товаров от 1 до 50 (quantity),
-- каждый заказ ссылается на order_id = i,
-- каждому заказу присваивается случайный product_id от 1 до 6
INSERT INTO order_product (quantity, order_id, product_id)
SELECT
    floor(1 + random() * 50)::int,           -- случайное количество сосисок
    i,                                       -- order_id = номер заказа
    1 + floor(random() * 6)::int % 6         -- случайный product_id от 1 до 6
FROM
    generate_series(1, 10000000) s(i);