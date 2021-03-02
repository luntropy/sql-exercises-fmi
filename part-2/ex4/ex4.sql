-- Database 'flights'

CREATE VIEW view_passengers_count
AS
    SELECT a.name, bk.flight_number, c.cnt FROM booking bk INNER JOIN (SELECT COUNT(b.status) as cnt, b.flight_number FROM booking b WHERE b.status = 1 GROUP BY b.flight_number) c ON c.flight_number = bk.flight_number INNER JOIN airline a ON bk.airline_code = a.code;

SELECT * FROM view_passengers_count ORDER BY name ASC;

CREATE VIEW view_max_reservations_cust
AS
    SELECT DISTINCT cn.customer_id, cn.agency, cn.cnt FROM booking sb INNER JOIN (SELECT b.customer_id, b.agency, COUNT(b.code) as cnt FROM booking b GROUP BY b.customer_id, b.agency) cn ON sb.customer_id = cn.customer_id AND sb.agency = cn.agency WHERE cn.cnt = (SELECT MAX(c.cnt) FROM booking bk INNER JOIN (SELECT b.customer_id, b.agency, COUNT(b.code) as cnt FROM booking b GROUP BY b.customer_id, b.agency) c ON bk.customer_id = c.customer_id AND bk.agency = c.agency WHERE bk.agency = sb.agency GROUP BY bk.agency);

SELECT * FROM view_max_reservations_cust ORDER BY agency;

CREATE VIEW view_agency_inf_sofia
AS
    SELECT * FROM agency a WHERE a.city = 'Sofia'
WITH CHECK OPTION;

SELECT * FROM view_agency_inf_sofia;

CREATE VIEW view_agency_no_phone
AS
    SELECT * FROM agency a WHERE a.phone IS NULL
WITH CHECK OPTION;

SELECT * FROM view_agency_no_phone;

INSERT INTO view_agency_inf_sofia VALUES ('T1 Tour', 'Bulgaria', 'Sofia','+359');

INSERT INTO view_agency_no_phone VALUES ('T2 Tour', 'Bulgaria', 'Sofia',null);

-- The row violates check option for the view 'view_agency_inf_sofia':
INSERT INTO view_agency_inf_sofia VALUES ('T3 Tour', 'Bulgaria', 'Varna','+359');

INSERT INTO view_agency_no_phone VALUES ('T4 Tour', 'Bulgaria', 'Varna',null);

-- The row violates check option for the view 'view_agency_no_phone' and duplicate key value violates unique constraint "agency_pkey":
INSERT INTO view_agency_no_phone VALUES ('T4 Tour', 'Bulgaria', 'Sofia','+359');

-- Database 'movies'

CREATE VIEW RichExec
AS
    SELECT me.name, me.address, me.certn, me.networth FROM movieexec me WHERE me.networth >= 10000000;

SELECT * FROM RichExec;

CREATE VIEW ExecutiveStar
AS
    SELECT ms.name, ms.address, ms.gender, ms.birthdate, me.certn, me.networth FROM movieexec me INNER JOIN moviestar ms ON me.name = ms.name;

SELECT * FROM ExecutiveStar;

SELECT es.name FROM ExecutiveStar es WHERE es.gender = 'F';

SELECT es.name FROM ExecutiveStar es WHERE es.networth > 50000000;

DROP VIEW RichExec;

DROP VIEW ExecutiveStar;

-- Database 'pc'

CREATE INDEX index_product_model
ON product (model);

DROP INDEX index_product_model;

-- Database 'ships'

CREATE INDEX index_battle
ON battles (name, date);

CREATE INDEX index_outcome_battle_result
ON outcomes (battle, result);

CREATE INDEX index_outcome_ship_result
ON outcomes (ship, result);

CREATE INDEX index_ship_class
ON ships (name, class);

CREATE INDEX index_ship_launched
ON ships (name, launched);

CREATE INDEX index_class_inf
ON classes (class, type, country, numguns, bore, displacement);

DROP INDEX index_battle;

DROP INDEX index_outcome_battle_result;

DROP INDEX index_outcome_ship_result;

DROP INDEX index_ship_class;

DROP INDEX index_ship_launched;

DROP INDEX index_class_inf;
