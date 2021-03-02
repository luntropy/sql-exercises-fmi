-- Database 'flights'

ALTER TABLE flight
ADD COLUMN num_pass INTEGER NOT NULL DEFAULT 0;

ALTER TABLE agency
ADD COLUMN num_book INTEGER NOT NULL DEFAULT 0;

CREATE OR REPLACE FUNCTION fn_new_reservation()
    RETURNS trigger
AS
$$
BEGIN
    IF NEW.status THEN
        UPDATE flight SET num_pass = num_pass + 1 WHERE fnumber = NEW.flight_number;
    END IF;

    UPDATE agency SET num_book = num_book + 1 WHERE name = NEW.agency;

RETURN NULL;
END
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_new_reservation
AFTER INSERT ON booking
FOR EACH ROW
EXECUTE PROCEDURE fn_new_reservation();

-- Test trigger
INSERT INTO booking VALUES ('YN308P', 'Travel One', 'FB', 'FB1363', 1, '2013-11-18', '2013-12-25', 300, 1);

INSERT INTO booking VALUES ('YN318P', 'Travel One', 'FB', 'FB1363', 1, '2013-11-18', '2013-12-25', 300, 0);

SELECT name, num_book FROM agency;

SELECT fnumber, num_pass FROM flight;
-- END

CREATE OR REPLACE FUNCTION fn_canceled_reservation()
    RETURNS trigger
AS
$$
BEGIN
    IF OLD.status THEN
        UPDATE flight SET num_pass = num_pass - 1 WHERE fnumber = OLD.flight_number;
    END IF;

    UPDATE agency SET num_book = num_book - 1 WHERE name = OLD.agency;

RETURN NULL;
END
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_canceled_reservation
AFTER DELETE ON booking
FOR EACH ROW
EXECUTE PROCEDURE fn_canceled_reservation();

-- Test trigger
DELETE FROM booking WHERE code = 'YN308P';

DELETE FROM booking WHERE code = 'YN318P';

SELECT name, num_book FROM agency;

SELECT fnumber, num_pass FROM flight;
-- END

CREATE OR REPLACE FUNCTION fn_updated_reservation()
    RETURNS trigger
AS
$$
BEGIN
    IF OLD.status = 0 AND NEW.status = 1 THEN
        UPDATE flight SET num_pass = num_pass + 1 WHERE fnumber = OLD.flight_number;
    ELSIF OLD.status = 1 AND NEW.status = 0 THEN
        UPDATE flight SET num_pass = num_pass - 1 WHERE fnumber = OLD.flight_number;
    END IF;

RETURN NULL;
END
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_updated_reservation
AFTER UPDATE ON booking
FOR EACH ROW
EXECUTE PROCEDURE fn_updated_reservation();

-- Test trigger
INSERT INTO booking VALUES ('YN308P', 'Travel One', 'FB', 'FB1363', 1, '2013-11-18', '2013-12-25', 300, 1);

INSERT INTO booking VALUES ('YN318P', 'Travel One', 'FB', 'FB1363', 1, '2013-11-18', '2013-12-25', 300, 0);

UPDATE booking SET status = 1 WHERE code = 'YN318P';

UPDATE booking SET status = 0 WHERE code = 'YN308P';

UPDATE booking SET status = 0 WHERE code = 'YN308P';

SELECT name, num_book FROM agency;

SELECT fnumber, num_pass FROM flight;
-- END
