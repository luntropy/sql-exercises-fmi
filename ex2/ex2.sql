-- Database 'movies'

SELECT ms.name FROM moviestar ms, starsin si WHERE ms.name = si.starname AND ms.gender = 'M' AND movietitle = 'The Usual Suspects';

SELECT si.starname FROM starsin si, studio s WHERE s.name = 'MGM' AND si.movieyear = 1995;

SELECT DISTINCT me.name FROM movieexec me, movie m WHERE m.producercn = me.certn AND m.studioname = 'MGM';

SELECT m.title FROM movie m, movie sw WHERE sw.title = 'Star Wars' AND m.length > sw.length;

SELECT DISTINCT me.name FROM movieexec me, movieexec ss WHERE ss.name = 'Stephen Spielberg' AND me.networth > ss.networth;

SELECT m.title FROM movie m, movieexec me, movieexec ss WHERE ss.name = 'Stephen Spielberg' AND me.networth > ss.networth AND m.producercn = me.certn;

-- Database 'pc'

SELECT p.maker, l.speed FROM laptop l, product p WHERE l.model = p.model AND p.type = 'Laptop' AND l.hd >= 9;

(SELECT l.model, l.price FROM product p, laptop l WHERE p.maker = 'B' and p.model = l.model)
UNION
(SELECT pc.model, pc.price FROM product p, pc WHERE p.maker = 'B' AND p.model = pc.model)
UNION
(SELECT pr.model, pr.price FROM product p, printer pr WHERE p.maker = 'B' AND p.model = pr.model);

(SELECT p.maker FROM product p, laptop l WHERE p.model = l.model)
EXCEPT
(SELECT p.maker FROM product p, pc WHERE p.model = pc.model);

SELECT DISTINCT pc.hd FROM pc, pc p WHERE pc.hd = p.hd AND pc.code != p.code;

SELECT pc.model, p.model FROM pc, pc p WHERE pc.speed = p.speed AND pc.ram = p.ram AND pc.model < p.model;

SELECT DISTINCT p.maker FROM product p, pc, pc sp WHERE pc.speed >= 400 and p.model = pc.model AND p.model = sp.model AND pc.code != sp.code;

-- Database 'ships'

SELECT s.name FROM ships s, classes c WHERE c.class = s.class AND c.displacement > 50000;

SELECT s.name, c.displacement, c.numguns FROM classes c, ships s, outcomes o WHERE c.class = s.class AND s.name = o.ship AND o.battle = 'Guadalcanal';

SELECT c.country FROM classes c, classes sc WHERE c.country = sc.country AND c.type = 'bb' AND sc.type = 'bc';

SELECT DISTINCT o.ship FROM outcomes o, outcomes so WHERE o.result = 'damaged' AND o.ship = so.ship AND o.battle != so.battle;
