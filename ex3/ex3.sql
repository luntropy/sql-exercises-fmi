-- Database 'movies'

SELECT ms.name FROM moviestar ms WHERE ms.gender = 'F' AND ms.name IN (SELECT me.name FROM movieexec me WHERE me.networth > 10000000);

SELECT ms.name FROM moviestar ms WHERE ms.name NOT IN (SELECT me.name FROM movieexec me);

SELECT m.title FROM movie m WHERE m.length > ALL(SELECT m.length FROM movie m WHERE m.title = 'Star Wars');

SELECT me.name, m.title FROM movieexec me, movie m WHERE me.certn = m.producercn AND me.networth > ALL(SELECT me.networth FROM movieexec me WHERE me.name = 'Merv Griffin');

-- Database 'pc'

SELECT DISTINCT p.maker FROM product p, pc WHERE p.model = pc.model AND pc.speed > 500;

SELECT pr.code, pr.model, pr.price FROM printer pr WHERE pr.price >= ALL(SELECT pr.price FROM printer pr);
