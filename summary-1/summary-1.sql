-- Database 'movies'

SELECT m.title, m.year FROM movie m WHERE m.length > 120 AND m.year < 2000 OR m.length IS NULL;

SELECT ms.name, ms.gender FROM moviestar ms WHERE ms.name LIKE 'J%' AND EXTRACT(YEAR FROM ms.birthdate) > 1948 ORDER BY ms.name DESC;

SELECT s.name, COUNT(DISTINCT si.starname) FROM studio s INNER JOIN movie m ON s.name = m.studioname INNER JOIN starsin si ON m.title = si.movietitle AND m.year = si.movieyear GROUP BY s.name;

SELECT ms.name, COUNT(m.title) FROM moviestar ms INNER JOIN starsin si ON ms.name = si.starname INNER JOIN movie m ON si.movietitle = m.title AND si.movieyear = m.year GROUP BY ms.name;

SELECT s.name, m.title FROM studio s INNER JOIN movie m ON s.name = m.studioname WHERE m.year > ALL(SELECT sm.year FROM movie sm WHERE m.title != sm.title AND m.year != sm.year AND m.studioname = sm.studioname);

SELECT ms.name FROM moviestar ms WHERE ms.gender = 'M' AND ms.birthdate > ALL(SELECT sm.birthdate FROM moviestar sm WHERE ms.name != sm.name AND sm.gender = 'M');
