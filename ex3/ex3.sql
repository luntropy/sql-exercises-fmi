-- Database 'movies'

SELECT ms.name FROM moviestar ms WHERE ms.gender = 'F' AND ms.name IN (SELECT me.name FROM movieexec me WHERE me.networth > 10000000);

SELECT ms.name FROM moviestar ms WHERE ms.name NOT IN (SELECT me.name FROM movieexec me);

SELECT m.title FROM movie m WHERE m.length > ALL(SELECT m.length FROM movie m WHERE m.title = 'Star Wars');

SELECT me.name, m.title FROM movieexec me, movie m WHERE me.certn = m.producercn AND me.networth > ALL(SELECT me.networth FROM movieexec me WHERE me.name = 'Merv Griffin');

-- Database 'pc'

SELECT DISTINCT p.maker FROM product p, pc WHERE p.model = pc.model AND pc.speed > 500;

SELECT pr.code, pr.model, pr.price FROM printer pr WHERE pr.price >= ALL(SELECT pr.price FROM printer pr);

SELECT * FROM laptop l WHERE l.speed < ALL(SELECT pc.speed FROM pc);

SELECT p.model, c.price FROM product p,
((SELECT l.model, l.price FROM laptop l)
UNION
(SELECT pc.model, pc.price FROM pc)
UNION
(SELECT pr.model, pr.price FROM printer pr)) c WHERE p.model = c.model AND c.price > ALL((SELECT l.price FROM laptop l WHERE l.model != c.model)
UNION
(SELECT pc.price FROM pc WHERE pc.model != c.model)
UNION
(SELECT pr.price FROM printer pr WHERE pr.model != c.model));

SELECT p.maker FROM product p, printer pr WHERE p.model = pr.model AND pr.color = 'y' AND pr.price < ALL(SELECT sp.price FROM printer sp WHERE pr.model != sp.model AND sp.color = 'y');

SELECT DISTINCT p.maker FROM product p, pc WHERE p.model = pc.model AND pc.ram < ALL(SELECT sp.ram FROM pc sp WHERE sp.model != pc.model AND sp.speed > ALL(SELECT tp.speed FROM pc tp WHERE tp.model != sp.model));

-- Database 'ships'

SELECT DISTINCT c.country FROM classes c WHERE c.numguns > ALL(SELECT sc.numguns FROM classes sc WHERE c.country != sc.country);

SELECT DISTINCT c.class FROM classes c, ships s WHERE c.class = s.class AND s.name IN (SELECT o.ship FROM outcomes o WHERE result = 'sunk');

SELECT s.name, s.class FROM ships s, classes c WHERE s.class = c.class AND c.bore = 16;

SELECT o.battle FROM outcomes o, ships s WHERE o.ship = s.name AND s.class = 'Kongo';

SELECT s.class, s.name FROM ships s, classes c WHERE s.class = c.class AND c.numguns >= ALL(SELECT sc.numguns FROM classes sc WHERE sc.bore = c.bore AND c.class != sc.class);
