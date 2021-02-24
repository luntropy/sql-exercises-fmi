-- Database 'movies'

SELECT address FROM studio WHERE name = 'Disney';

SELECT birthdate FROM moviestar WHERE name = 'Jack Nicholson';

SELECT starname FROM starsin WHERE movieyear = 1980 OR movietitle LIKE '%Knight%';

SELECT name FROM movieexec WHERE networth > 10000000;

SELECT name FROM moviestar WHERE gender = 'M' or address LIKE '%Perfect Rd.%';

-- Database 'pc'

SELECT model, speed as MHz, hd as GB FROM pc WHERE price < 1200;

SELECT DISTINCT maker FROM product WHERE type = 'Printer';

SELECT model, ram, screen FROM laptop WHERE price > 1000;

SELECT * FROM printer WHERE color = 'y';

SELECT model, speed, hd FROM pc WHERE cd = '12x' OR cd = '16x' AND price < 2000;

-- Database 'ships'

SELECT class, country FROM classes WHERE numguns < 10;

SELECT name as shipName FROM ships WHERE launched < 1918;

SELECT ship, battle FROM outcomes WHERE result = 'sunk';

SELECT name FROM ships WHERE name = class;

SELECT name FROM ships WHERE name LIKE 'R%';

SELECT name FROM ships WHERE name LIKE '% %';
