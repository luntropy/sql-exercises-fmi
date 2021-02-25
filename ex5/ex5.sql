-- Database 'pc'

SELECT ROUND(AVG(pc.speed)::numeric,2) FROM pc;

SELECT p.maker, ROUND(AVG(l.screen)) FROM laptop l INNER JOIN product p ON l.model = p.model GROUP BY p.maker;

SELECT ROUND(AVG(l.speed)::numeric,2) FROM laptop l WHERE l.price > 1000;

SELECT ROUND(AVG(pc.price)::numeric,2) FROM pc INNER JOIN product p ON pc.model = p.model WHERE p.maker = 'A';

SELECT p.maker, ((SUM(pc.price) + SUM(l.price)) / COUNT(p.maker)) FROM product p LEFT OUTER JOIN pc ON p.model = pc.model LEFT OUTER JOIN laptop l ON p.model = l.model WHERE p.maker = 'B' GROUP BY p.maker;

SELECT pc.speed, AVG(pc.price) FROM pc GROUP BY pc.speed;

SELECT p.maker, COUNT(pc.code) FROM product p INNER JOIN pc ON p.model = pc.model GROUP BY p.maker HAVING COUNT(pc.code) >= 3;

SELECT p.maker, pc.price FROM product p INNER JOIN pc ON p.model = pc.model WHERE pc.price > ALL(SELECT sp.price FROM pc sp WHERE pc.code != sp.code);

SELECT pc.speed, AVG(pc.price) FROM pc WHERE pc.speed > 800 GROUP BY pc.speed;

SELECT p.maker, ROUND(AVG(pc.hd)::numeric,2) FROM product p INNER JOIN pc ON p.model = pc.model WHERE p.maker IN (SELECT p.maker FROM product p INNER JOIN printer pr ON p.model = pr.model) GROUP BY p.maker;

-- Database 'ships'

SELECT COUNT(DISTINCT c.class) FROM classes c WHERE c.type = 'bb';

SELECT c.class, ROUND(AVG(c.numguns)) FROM classes c WHERE c.type = 'bb' GROUP BY c.class;

SELECT ROUND(AVG(c.numguns)::numeric,2) FROM classes c WHERE c.type = 'bb';

SELECT c.class, MIN(s.launched), MAX(s.launched) FROM ships s INNER JOIN classes c ON s.class = c.class GROUP BY c.class;

SELECT c.class, COUNT(o.ship) FROM classes c INNER JOIN ships s ON c.class = s.class INNER JOIN outcomes o ON s.name = o.ship WHERE o.result = 'sunk' GROUP BY c.class;

SELECT c.class, COUNT(o.ship) FROM classes c INNER JOIN ships s ON c.class = s.class INNER JOIN outcomes o ON s.name = o.ship WHERE o.result = 'sunk' AND c.class IN (SELECT c.class FROM classes c INNER JOIN ships s ON c.class = s.class GROUP BY c.class HAVING COUNT(DISTINCT s.name) > 2) GROUP BY c.class;

SELECT c.country, ROUND(AVG(c.bore)::numeric,2) FROM classes c INNER JOIN ships s ON c.class = s.class GROUP BY c.country;
