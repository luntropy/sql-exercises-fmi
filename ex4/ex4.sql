-- Database 'movies'

SELECT me.name, m.title FROM movieexec me INNER JOIN movie m ON me.certn = m.producercn WHERE me.certn IN (SELECT sm.producercn FROM movie sm WHERE sm.title = 'Star Wars');

SELECT DISTINCT me.name FROM movie m INNER JOIN starsin si ON m.title = si.movietitle INNER JOIN movieexec me ON m.producercn = me.certn WHERE si.starname = 'Harrison Ford';

SELECT DISTINCT s.name, si.starname FROM studio s INNER JOIN movie m ON s.name = m.studioname INNER JOIN starsin si ON si.movietitle = m.title AND si.movieyear = m.year ORDER BY s.name;

SELECT si.starname FROM starsin si INNER JOIN movie m ON si.movietitle = m.title AND si.movieyear = m.year INNER JOIN movieexec me ON m.producercn = me.certn WHERE me.networth > ALL(SELECT sme.networth FROM movieexec sme WHERE me.certn != sme.certn);

SELECT ms.name FROM moviestar ms LEFT OUTER JOIN starsin si ON si.starname = ms.name WHERE si.movietitle IS NULL;

-- Database 'pc'

SELECT p.maker, p.model, p.type FROM product p LEFT OUTER JOIN pc ON p.model = pc.model LEFT OUTER JOIN laptop l ON p.model = l.model LEFT OUTER JOIN printer pr ON p.model = pr.model WHERE (p.type = 'PC' AND pc.model IS NULL) OR (p.type = 'Laptop' AND l.model IS NULL) OR (p.type = 'Printer' AND pr.model IS NULL);

SELECT DISTINCT p.maker FROM product p INNER JOIN laptop l ON p.model = l.model WHERE p.maker IN (SELECT sp.maker FROM product sp INNER JOIN printer pr ON sp.model = pr.model);

SELECT DISTINCT l.hd FROM laptop l WHERE l.hd IN (SELECT sl.hd FROM laptop sl WHERE l.code != sl.code);

SELECT DISTINCT pc.model FROM pc LEFT OUTER JOIN product p ON p.model = pc.model WHERE p.type = 'PC' AND p.model IS NULL;

-- Database 'ships'

SELECT * FROM ships s INNER JOIN classes c ON s.class = c.class;

SELECT * FROM ships s RIGHT OUTER JOIN classes c ON c.class = s.class WHERE s.class IS NOT NULL OR c.class IN (SELECT ss.name FROM ships ss);

SELECT c.country, s.name FROM classes c INNER JOIN ships s ON c.class = s.class WHERE s.name NOT IN (SELECT ss.name FROM ships ss INNER JOIN outcomes o ON ss.name = o.ship);

SELECT s.name as "Ship Name" FROM ships s INNER JOIN classes c ON s.class = c.class WHERE c.numguns >= 7 AND launched = 1916;

SELECT s.name, b.name, b.date FROM ships s INNER JOIN outcomes o ON s.name = o.ship INNER JOIN battles b ON o.battle = b.name WHERE o.result = 'sunk' ORDER BY b.name;

SELECT s.name, c.displacement, s.launched FROM ships s INNER JOIN classes c ON s.class = c.class WHERE s.name = c.class;

SELECT c.class FROM classes c LEFT OUTER JOIN ships s ON c.class = s.class WHERE s.class IS NULL;

SELECT s.name, c.displacement, c.numguns, o.result FROM ships s INNER JOIN classes c ON s.class = c.class INNER JOIN outcomes o ON s.name = o.ship WHERE o.battle = 'North Atlantic';
