-- Database 'furniture-company'

CREATE DATABASE "furniture-company";

CREATE TABLE customer (
    customer_id SERIAL PRIMARY KEY,
    customer_name VARCHAR(255) NOT NULL,
    customer_address VARCHAR(255) NOT NULL,
    customer_city VARCHAR(255) NOT NULL,
    city_code CHAR(4) NOT NULL
);

CREATE TABLE product (
    product_id INTEGER PRIMARY KEY,
    product_description VARCHAR(255) NOT NULL,
    product_finish VARCHAR(255) NOT NULL,
    standard_price DECIMAL(9,2) NOT NULL,
    product_line_id INTEGER NOT NULL,
    CHECK (product_finish IN ('череша', 'естествен ясен', 'бял ясен', 'червен дъб', 'естествен дъб', 'орех'))
);

CREATE TABLE order_t (
    order_id INTEGER PRIMARY KEY,
    order_date DATE NOT NULL,
    customer_id INTEGER NOT NULL,
    FOREIGN KEY (customer_id)
        REFERENCES customer (customer_id)
        ON DELETE CASCADE
);

CREATE TABLE order_line (
    order_id INTEGER NOT NULL,
    product_id INTEGER NOT NULL,
    ordered_quantity INTEGER NOT NULL,
    FOREIGN KEY (order_id)
        REFERENCES order_t (order_id)
        ON DELETE CASCADE,
    FOREIGN KEY (product_id)
        REFERENCES product (product_id)
        ON DELETE CASCADE
);

INSERT INTO customer (customer_name, customer_address, customer_city, city_code) VALUES
('Иван Петров', 'ул. Лавеле 8', 'София', '1000'),
('Камелия Янева', 'ул. Иван Шишман 3', 'Бургас', '8000'),
('Васил Димитров', 'ул. Абаджийска 87', 'Пловдив', '4000'),
('Ани Милева', 'бул. Владислав Варненчик 56', 'Варна','9000');

INSERT INTO product VALUES
(1000, 'офис бюро', 'череша', 195, 10),
(1001, 'директорско бюро', 'червен дъб', 250, 10),
(2000, 'офис стол', 'череша', 75, 20),
(2001, 'директорски стол', 'естествен дъб', 129, 20),
(3000, 'етажерка за книги', 'естествен ясен', 85, 30),
(4000, 'настолна лампа', 'естествен ясен', 35, 40);

INSERT INTO order_t VALUES
(100, '2013-01-05', 1),
(101, '2013-12-07', 2),
(102, '2014-10-03', 3),
(103, '2014-10-08', 2),
(104, '2015-10-05', 1),
(105, '2015-10-05', 4),
(106, '2015-10-06', 2),
(107, '2016-01-06', 1);

INSERT INTO order_line VALUES
(100, 4000, 1),
(101, 1000, 2),
(101, 2000, 2),
(102, 3000, 1),
(102, 2000, 1),
(106, 4000, 1),
(103, 4000, 1),
(104, 4000, 1),
(105, 4000, 1),
(107, 4000, 1);

SELECT DISTINCT p.product_id, p.product_description, c.cnt FROM product p INNER JOIN order_line ol ON p.product_id = ol.product_id INNER JOIN (SELECT sp.product_id, COUNT(sol.order_id) as cnt FROM product sp INNER JOIN order_line sol ON sp.product_id = sol.product_id GROUP BY sp.product_id) c ON p.product_id = c.product_id;

SELECT p.product_id, p.product_description, COALESCE(SUM(ol.ordered_quantity), 0) FROM product p LEFT OUTER JOIN order_line ol ON p.product_id = ol.product_id GROUP BY p.product_id, p.product_description;

SELECT c.customer_name, SUM(data.total_price) FROM customer c INNER JOIN order_t ot ON c.customer_id = ot.customer_id INNER JOIN (SELECT p.product_id, ol.order_id, ol.ordered_quantity, p.standard_price, (ol.ordered_quantity * p.standard_price) as total_price FROM product p INNER JOIN order_line ol ON p.product_id = ol.product_id) data ON ot.order_id = data.order_id GROUP BY c.customer_name;

-- Database 'pc'

SELECT DISTINCT lm.maker FROM (SELECT p.maker FROM product p INNER JOIN laptop l ON p.model = l.model) lm INNER JOIN (SELECT p.maker FROM product p INNER JOIN printer pr ON p.model = pr.model) prm ON lm.maker = prm.maker;

UPDATE pc SET price = price - (price * 5 / 100) WHERE code IN (SELECT pc.code FROM product p INNER JOIN pc ON p.model = pc.model INNER JOIN (SELECT p.maker, ROUND(AVG(pr.price)::numeric,2) as avg_pr FROM product p INNER JOIN printer pr ON p.model = pr.model GROUP BY p.maker) ap ON p.maker = ap.maker WHERE ap.avg_pr > 800);

SELECT DISTINCT pc.hd, pr.min_price FROM pc INNER JOIN (SELECT pc.hd, MIN(pc.price) as min_price FROM pc GROUP BY pc.hd) pr ON pc.hd = pr.hd WHERE pc.hd >= 10 AND pc.hd <= 30;

-- Database 'ships'

CREATE VIEW view_battle_more_ships_guadalcanal
AS
    SELECT o.battle FROM outcomes o GROUP BY o.battle HAVING COUNT(o.ship) > (SELECT COUNT(o.ship) FROM outcomes o WHERE o.battle = 'Guadalcanal' GROUP BY o.battle);

CREATE VIEW view_battle_more_countries_guadalcanal
AS
    SELECT DISTINCT o.battle, c.cnt FROM outcomes o INNER JOIN (SELECT DISTINCT o.battle, COUNT(DISTINCT c.country) as cnt FROM classes c INNER JOIN ships s ON c.class = s.class INNER JOIN outcomes o ON s.name = o.ship GROUP BY o.battle) c ON o.battle = c.battle WHERE c.cnt > (SELECT COUNT(DISTINCT c.country) as cnt FROM classes c INNER JOIN ships s ON c.class = s.class INNER JOIN outcomes o ON s.name = o.ship WHERE o.battle = 'Guadalcanal' GROUP BY o.battle);

DELETE FROM outcomes WHERE battle IN (SELECT o.battle FROM outcomes o LEFT OUTER JOIN ships s ON o.ship = s.name GROUP BY o.battle HAVING COUNT(o.ship) = 1);

INSERT INTO outcomes VALUES
('Missouri','Surigao Strait', 'sunk'),
('Missouri','North Cape', 'sunk'),
('Missouri','North Atlantic', 'ok');

DELETE FROM outcomes WHERE ship IN (SELECT s.name FROM ships s INNER JOIN outcomes o ON s.name = o.ship WHERE o.result = 'sunk' GROUP BY s.name HAVING COUNT(o.result) = 2);

CREATE VIEW view_battles_countries
AS
    SELECT o.battle, c.country FROM classes c INNER JOIN ships s ON c.class = s.class INNER JOIN outcomes o ON s.name = o.ship GROUP BY o.battle, c.country;

SELECT vbc.battle FROM view_battles_countries vbc WHERE vbc.country IN (SELECT country FROM view_battles_countries WHERE battle = 'Guadalcanal') AND vbc.battle != 'Guadalcanal';

SELECT c.country, COUNT(DISTINCT o.battle) FROM classes c LEFT OUTER JOIN ships s ON c.class = s.class LEFT OUTER JOIN outcomes o ON s.name = o.ship GROUP BY c.country;
