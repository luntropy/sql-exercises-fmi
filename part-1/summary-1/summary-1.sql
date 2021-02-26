-- Database 'movies'

SELECT m.title, m.year FROM movie m WHERE m.length > 120 AND m.year < 2000 OR m.length IS NULL;

SELECT ms.name, ms.gender FROM moviestar ms WHERE ms.name LIKE 'J%' AND EXTRACT(YEAR FROM ms.birthdate) > 1948 ORDER BY ms.name DESC;

SELECT s.name, COUNT(DISTINCT si.starname) FROM studio s INNER JOIN movie m ON s.name = m.studioname INNER JOIN starsin si ON m.title = si.movietitle AND m.year = si.movieyear GROUP BY s.name;

SELECT ms.name, COUNT(m.title) FROM moviestar ms INNER JOIN starsin si ON ms.name = si.starname INNER JOIN movie m ON si.movietitle = m.title AND si.movieyear = m.year GROUP BY ms.name;

SELECT s.name, m.title FROM studio s INNER JOIN movie m ON s.name = m.studioname WHERE m.year > ALL(SELECT sm.year FROM movie sm WHERE m.title != sm.title AND m.year != sm.year AND m.studioname = sm.studioname);

SELECT ms.name FROM moviestar ms WHERE ms.gender = 'M' AND ms.birthdate > ALL(SELECT sm.birthdate FROM moviestar sm WHERE ms.name != sm.name AND sm.gender = 'M');

SELECT data.starname, data.studioname FROM (SELECT si.starname, m.studioname, COUNT(m.title) as cnt FROM starsin si INNER JOIN movie m ON si.movietitle = m.title AND si.movieyear = m.year GROUP BY si.starname, m.studioname) data WHERE data.cnt >= ALL(SELECT COUNT(sm.title) FROM starsin ss INNER JOIN movie sm ON ss.movietitle = sm.title AND ss.movieyear = sm.year WHERE data.starname != ss.starname AND data.studioname = sm.studioname);

SELECT m.title, m.year, COUNT(si.starname) FROM movie m INNER JOIN starsin si ON m.title = si.movietitle AND m.year = si.movieyear GROUP BY m.title, m.year HAVING COUNT(si.starname) > 2;

-- Database 'ships'

SELECT DISTINCT s.name FROM ships s INNER JOIN outcomes o ON s.name = o.ship WHERE s.name LIKE 'C%' OR s.name LIKE 'K%';

SELECT DISTINCT s.name, c.country FROM ships s INNER JOIN classes c ON s.class = c.class LEFT OUTER JOIN outcomes o ON s.name = o.ship WHERE o.ship IS NULL OR o.result != 'sunk';

SELECT c.country, COUNT(o.ship) FROM classes c LEFT OUTER JOIN ships s ON c.class = s.class LEFT OUTER JOIN outcomes o ON s.name = o.ship WHERE o.result = 'sunk' OR s.name IS NULL OR o.ship IS NULL GROUP BY c.country;

SELECT o.battle FROM outcomes o GROUP BY o.battle HAVING COUNT(DISTINCT o.ship) > (SELECT COUNT(DISTINCT so.ship) FROM outcomes so WHERE so.battle = 'Guadalcanal');

SELECT o.battle FROM outcomes o GROUP BY o.battle HAVING COUNT(DISTINCT o.ship) > (SELECT COUNT(DISTINCT so.ship) FROM outcomes so WHERE so.battle = 'Surigao Strait');

SELECT s.name, c.displacement, c.numguns FROM classes c INNER JOIN ships s ON c.class = s.class WHERE c.displacement < ALL(SELECT sc.displacement FROM classes sc WHERE c.class != sc.class) AND c.numguns > ALL(SELECT tc.numguns FROM classes tc WHERE c.class != tc.class AND c.displacement < ALL(SELECT fc.displacement FROM classes fc WHERE tc.class != fc.class));

SELECT COUNT(o.ship) FROM outcomes o INNER JOIN battles b ON o.battle = b.name WHERE o.ship IN (SELECT so.ship FROM battles sb INNER JOIN outcomes so ON sb.name = so.battle WHERE so.result = 'damaged') AND o.result = 'ok' AND b.date > ALL(SELECT tb.date FROM battles tb INNER JOIN outcomes oc ON tb.name = oc.battle WHERE oc.result = 'damaged' AND b.name != tb.name);

SELECT DISTINCT o.ship FROM outcomes o WHERE (SELECT b.date FROM outcomes so INNER JOIN battles b ON so.battle = b.name WHERE o.ship = so.ship AND so.result = 'ok') > (SELECT b.date FROM outcomes so INNER JOIN battles b ON so.battle = b.name WHERE o.ship = so.ship AND so.result = 'damaged') GROUP BY o.ship HAVING (SELECT COUNT(so.ship) FROM outcomes so WHERE so.battle = (SELECT oc.battle FROM outcomes oc WHERE o.ship = oc.ship AND oc.result = 'ok')) > (SELECT COUNT(so.ship) FROM outcomes so WHERE so.battle = (SELECT oc.battle FROM outcomes oc WHERE o.ship = oc.ship AND oc.result = 'damaged'));

-- Database 'pc'

SELECT l.model, l.code, l.screen FROM laptop l WHERE l.screen = 15 OR l.screen = 11;

SELECT DISTINCT pc.model FROM pc INNER JOIN product p ON pc.model = p.model WHERE p.maker IN (SELECT sp.maker FROM laptop l INNER JOIN product sp ON l.model = sp.model) AND pc.price < ALL(SELECT sl.price FROM laptop sl INNER JOIN product tp ON sl.model = tp.model WHERE p.maker = tp.maker);

SELECT pc.model, AVG(pc.price) FROM pc INNER JOIN product p ON pc.model = p.model GROUP BY pc.model, p.maker HAVING AVG(pc.price) < (SELECT MIN(l.price) FROM laptop l INNER JOIN product sp ON l.model = sp.model WHERE p.maker = sp.maker GROUP BY sp.maker);

SELECT pc.code, p.maker, (SELECT COUNT(DISTINCT sp.code) FROM pc sp WHERE sp.code != pc.code AND sp.price >= (SELECT tp.price FROM pc tp WHERE tp.code = pc.code)) cnt FROM pc INNER JOIN product p ON pc.model = p.model;
