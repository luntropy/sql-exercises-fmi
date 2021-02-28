-- Database 'movies'

INSERT INTO moviestar (name, birthdate) VALUES ('Nicole Kidman', '20.06.1967');

DELETE FROM movieexec WHERE networth < 30000000;

DELETE FROM moviestar WHERE address IS NULL;

-- Database 'pc'

INSERT INTO product (model, maker, type) VALUES ('1100', 'C', 'PC');

INSERT INTO pc (code, model, speed, ram, hd, cd, price) VALUES (12, '1100', 2400, 2048, 500, '52x', 299);

DELETE FROM pc WHERE model = '1100';

DELETE FROM laptop lp WHERE lp.model IN (SELECT l.model FROM laptop l INNER JOIN product p ON l.model = p.model WHERE p.maker NOT IN (SELECT sp.maker FROM product sp WHERE sp.type = 'Printer'));

UPDATE product SET maker = 'A' WHERE maker = 'B';

UPDATE pc SET price = price / 2, hd = hd + 20;

UPDATE laptop SET screen = screen + 1 WHERE model IN (SELECT l.model FROM laptop l INNER JOIN product p ON l.model = p.model WHERE p.maker = 'B');

-- Database 'ships'

INSERT INTO classes (class, type, country, numguns, bore, displacement) VALUES ('Nelson', 'bb', 'Gt.Britain', 9, 16, 34000);

INSERT INTO ships (name, class, launched) VALUES ('Nelson', 'Nelson', 1927);

INSERT INTO ships (name, class, launched) VALUES ('Rodney', 'Nelson', 1927);

DELETE FROM ships s WHERE s.name IN (SELECT ss.name FROM ships ss INNER JOIN outcomes o ON ss.name = o.ship WHERE result = 'sunk');

UPDATE classes SET bore = bore * 2.5, displacement = displacement / 1.1;
