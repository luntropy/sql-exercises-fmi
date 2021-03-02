-- Database 'flights'

CREATE DATABASE flights;

CREATE TABLE airline (
    code CHAR(2) PRIMARY KEY,
    name VARCHAR(255) NOT NULL UNIQUE,
    country VARCHAR(255) NOT NULL
);

CREATE TABLE airport (
    code CHAR(3) PRIMARY KEY,
    name VARCHAR(255) NOT NULL UNIQUE,
    country VARCHAR(255) NOT NULL,
    city VARCHAR(255) NOT NULL
);

CREATE TABLE airplane (
    code CHAR(3) PRIMARY KEY,
    type VARCHAR(255) NOT NULL,
    seats INTEGER NOT NULL CHECK (seats > 0),
    year INTEGER NOT NULL
);

CREATE TABLE flight (
    fnumber CHAR(10) PRIMARY KEY,
    airline_operator CHAR(2) NOT NULL,
    dep_airport CHAR(3) NOT NULL,
    arr_airport CHAR(3) NOT NULL,
    flight_time TIME NOT NULL,
    flight_duration INTEGER NOT NULL,
    airplane CHAR(3) NOT NULL,
    FOREIGN KEY (airline_operator)
        REFERENCES airline (code)
        ON DELETE CASCADE,
    FOREIGN KEY (dep_airport)
        REFERENCES airport (code)
        ON DELETE CASCADE,
    FOREIGN KEY (arr_airport)
        REFERENCES airport (code)
        ON DELETE CASCADE,
    FOREIGN KEY (airplane)
        REFERENCES airplane (code)
        ON DELETE CASCADE
);

CREATE TABLE customer (
    id INTEGER PRIMARY KEY,
    fname VARCHAR(255) NOT NULL,
    lname VARCHAR(255) NOT NULL,
    email VARCHAR(255) CHECK (LENGTH(email) >= 6 AND email LIKE '%@%' AND email LIKE '%.%')
);

CREATE TABLE agency (
    name VARCHAR(255) PRIMARY KEY,
    country VARCHAR(255) NOT NULL,
    city VARCHAR(255) NOT NULL,
    phone VARCHAR(255)
);

CREATE TABLE booking (
    code CHAR(6) PRIMARY KEY,
    agency VARCHAR(255) NOT NULL,
    airline_code CHAR(2) NOT NULL,
    flight_number CHAR(10) NOT NULL,
    customer_id INTEGER NOT NULL,
    booking_date DATE NOT NULL,
    flight_date DATE NOT NULL,
    price DECIMAL(9,2) NOT NULL,
    status INTEGER NOT NULL,
    FOREIGN KEY (airline_code)
        REFERENCES airline (code)
        ON DELETE CASCADE,
    FOREIGN KEY (agency)
        REFERENCES agency (name)
        ON DELETE CASCADE,
    FOREIGN KEY (flight_number)
        REFERENCES flight (fnumber)
        ON DELETE CASCADE,
    FOREIGN KEY (customer_id)
        REFERENCES customer (id)
        ON DELETE CASCADE,
    CHECK (flight_date > booking_date),
    CHECK (status IN (0, 1))
);

-- Data

INSERT INTO airline
  VALUES ('AZ', 'Alitalia', 'Italy');

INSERT INTO airline
  VALUES ('BA', 'British Airways', 'United Kingdom');

INSERT INTO airline
  VALUES ('LH', 'Lufthansa', 'Germany');

INSERT INTO airline
  VALUES ('SR', 'Swissair', 'Switzerland');

INSERT INTO airline
  VALUES ('FB', 'Bulgaria Air', 'Bulgaria');

INSERT INTO airline
  VALUES ('SU', 'Aeroflot', 'Russian Federation');

INSERT INTO airline
  VALUES ('AF', 'Air France', 'France');

INSERT INTO airline
  VALUES ('TK', 'Turkish Airlines', 'Turkey');

INSERT INTO airline
  VALUES ('AA', 'American Airlines', 'United States');

INSERT INTO airline
  VALUES ('OA', 'Olympic Air', 'Greece');

INSERT INTO airline
  VALUES ('A3', 'Aegean Airlines', 'Greece');

INSERT INTO airline
  VALUES ('ET', 'Ethiopian Airlines', 'Ethiopia');

INSERT INTO airline
  VALUES ('U2', 'EasyJet', 'United Kingdom');

INSERT INTO airline
  VALUES ('DL', 'Delta Air Lines', 'France');

INSERT INTO airport
  VALUES ('SVO', 'Sheremetyevo', 'Russian Federation', 'Moscow');

INSERT INTO airport
  VALUES ('DME', 'Domodedovo', 'Russian Federation', 'Moscow');

INSERT INTO airport
  VALUES ('SOF', 'Sofia International', 'Bulgaria', 'Sofia');

INSERT INTO airport
  VALUES ('BOJ', 'Burgas International', 'Bulgaria', 'Burgas');

INSERT INTO airport
  VALUES ('CDG', 'Charles De Gaulle', 'France', 'Paris');

INSERT INTO airport
  VALUES ('ORY', 'Orly', 'France', 'Paris');

INSERT INTO airport
  VALUES ('LBG', 'Le Bourget', 'France', 'Paris');

INSERT INTO airport
  VALUES ('JFK', 'John F Kennedy International', 'United States',
    'New York');

INSERT INTO airport
  VALUES ('ORD', 'Chicago O''Hare International', 'United States',
    'Chicago');

INSERT INTO airport
  VALUES ('IST', 'Ataturk International', 'Turkey', 'Istanbul');

INSERT INTO airport
  VALUES ('ESB', 'Esenboga International', 'Turkey', 'Ankara');

INSERT INTO airport
  VALUES ('AHN', 'Athens', 'Greece', 'Athens');

INSERT INTO airport
  VALUES ('FKB', 'Karlsruhe', 'Germany', 'Karlsruhe');

INSERT INTO airport
  VALUES ('TXL', 'Tegel', 'Germany', 'Berlin');

INSERT INTO airport
  VALUES ('BER', 'Berlin Metropolitan Area', 'Germany', 'Berlin');

INSERT INTO airport
  VALUES ('MUC', 'Franz Josef Strauss', 'Germany', 'Munich');

INSERT INTO airport
  VALUES ('GVA', 'Geneve-Cointrin', 'Switzerland', 'Geneve');

INSERT INTO airport
  VALUES ('BRN', 'Belp', 'Switzerland', 'Berne');

INSERT INTO airport
  VALUES ('FCO', 'Leonardo da Vinci International', 'Italy', 'Rome');

INSERT INTO airport
  VALUES ('LIN', 'Linate', 'Italy', 'Milan');

INSERT INTO airport
  VALUES ('LHR', 'London Heathrow', 'United Kingdom', 'London');

INSERT INTO airplane
  VALUES ('319', 'Airbus A319', 150, 1993);

INSERT INTO airplane
  VALUES ('320', 'Airbus A320', 280, 1984);

INSERT INTO airplane
  VALUES ('321', 'Airbus A321', 150, 1989);

INSERT INTO airplane
  VALUES ('100', 'Fokker 100', 80, 1991);

INSERT INTO airplane
  VALUES ('738', 'Boeing 737-800', 90, 1997);

INSERT INTO airplane
  VALUES ('735', 'Boeing 737-800', 90, 1995);

INSERT INTO airplane
  VALUES ('AT5', 'ATR 42�0', 50, 1995);

INSERT INTO airplane
  VALUES ('DH4', 'De Havilland DHC-8-400', 70, 1992);

INSERT INTO flight
  VALUES ('FB1363', 'SU', 'SOF', 'SVO', '12:45', 100, '738');

INSERT INTO flight
  VALUES ('FB1364', 'SU', 'SVO', 'SOF', '10:00', 120, '321');

INSERT INTO flight
  VALUES ('SU2060', 'SU', 'SVO', 'SOF', '11:10', 110, '738');

INSERT INTO flight
  VALUES ('SU2061', 'SU', 'SOF', 'SVO', '13:00', 110, '320');

INSERT INTO flight
  VALUES ('FB363', 'FB', 'SOF', 'SVO', '15:10', 110, '738');

INSERT INTO flight
  VALUES ('FB364', 'FB', 'SVO', 'SOF', '21:05', 120, '738');

INSERT INTO flight
  VALUES ('FB437', 'FB', 'SOF', 'MUC', '09:10', 120, '319');

INSERT INTO flight
  VALUES ('FB438', 'FB', 'MUC', 'SOF', '12:10', 90, '738');

INSERT INTO flight
  VALUES ('TK1027', 'TK', 'IST', 'SOF', '07:00', 100, '738');

INSERT INTO flight
  VALUES ('TK1028', 'TK', 'SOF', 'IST', '10:00', 100, 'AT5');

INSERT INTO flight
  VALUES ('OA307', 'OA', 'AHN', 'SOF', '09:25', 40, '738');

INSERT INTO flight
  VALUES ('OA308', 'OA', 'SOF', 'AHN', '10:25', 40, '738');

INSERT INTO flight
  VALUES ('EZY3159', 'U2', 'LHR', 'SOF', '10:05', 90, '738');

INSERT INTO flight
  VALUES ('EZY3160', 'U2', 'SOF', 'LHR', '12:45', 90, '738');

INSERT INTO flight
  VALUES ('EZY1931', 'U2', 'LHR', 'SOF', '10:15', 90, '738');

INSERT INTO flight
  VALUES ('EZY1932', 'U2', 'SOF', 'LHR', '13:05', 90, '738');

INSERT INTO flight
  VALUES ('LH1702', 'LH', 'MUC', 'SOF', '10:10', 100, '738');

INSERT INTO flight
  VALUES ('LH1703', 'LH', 'SOF', 'MUC', '13:10', 100, '738');

INSERT INTO flight
  VALUES ('FB851', 'FB', 'SOF', 'LHR', '13:30', 100, '738');

INSERT INTO flight
  VALUES ('FB852', 'FB', 'LHR', 'SOF', '16:30', 100, '100');

INSERT INTO flight
  VALUES ('LH1426', 'LH', 'FKB', 'SOF', '11:05', 120, '738');

INSERT INTO flight
  VALUES ('LH1427', 'LH', 'SOF', 'FKB', '13:45', 120, '735');

INSERT INTO flight
  VALUES ('FB457', 'FB', 'SOF', 'CDG', '09:10', 100, '319');

INSERT INTO flight
  VALUES ('FB458', 'FB', 'ORY', 'SOF', '12:10', 100, '738');

INSERT INTO flight
  VALUES ('TK1037', 'TK', 'ESB', 'SOF', '07:00', 90, '738');

INSERT INTO flight
  VALUES ('TK1038', 'TK', 'SOF', 'ESB', '10:00', 90, 'AT5');

INSERT INTO customer (ID, FNAME, LNAME, EMAIL)
  VALUES (1, 'Petar', 'Milenov', 'petter@mail.com');

INSERT INTO customer (ID, FNAME, LNAME, EMAIL)
  VALUES (2, 'Dimitar', 'Petrov', 'petrov@mail.com');

INSERT INTO customer (ID, FNAME, LNAME, EMAIL)
  VALUES (3, 'Ivan', 'Ivanov', 'ivanov@mail.com');

INSERT INTO customer (ID, FNAME, LNAME, EMAIL)
  VALUES (4, 'Petar', 'Slavov', 'slavov@mail.com');

INSERT INTO customer (ID, FNAME, LNAME, EMAIL)
  VALUES (5, 'Bogdan', 'Bobov', 'bobov@mail.com');

INSERT INTO customer (ID, FNAME, LNAME, EMAIL)
  VALUES (6, 'Petar', 'Kirov', 'pr_kirov@mail.com');

INSERT INTO customer (ID, FNAME, LNAME, EMAIL)
  VALUES (7, 'Vladimir', 'Petrov', 'vladov@mail.com');

INSERT INTO agency
  VALUES ('Travel One', 'Bulgaria', 'Sofia', '0783482233');

INSERT INTO agency
  VALUES ('Travel Two', 'Bulgaria', 'Plovdiv', '02882234');

INSERT INTO agency
  VALUES ('Travel Tour', 'Bulgaria', 'Sofia', NULL);

INSERT INTO agency
  VALUES ('Aerotravel', 'Bulgaria', 'Varna', '02884233');

INSERT INTO agency
  VALUES ('Aerofly', 'Bulgaria', 'Sofia', '02882533');

INSERT INTO agency
  VALUES ('Fly Tour', 'Bulgaria', 'Sofia', '02881233');

INSERT INTO booking
  VALUES ('YN298P', 'Travel One', 'FB', 'FB1363', 1, '2013-11-18',
    '2013-12-25', 300, 0);

INSERT INTO booking
  VALUES ('YA298P', 'Travel Two', 'TK', 'TK1038', 2, '2013-12-18',
    '2013-12-25', 300, 1);

INSERT INTO booking
  VALUES ('YB298P', 'Travel Tour', 'TK', 'TK1037', 3, '2014-01-18',
    '2014-02-25', 400, 0);

INSERT INTO booking
  VALUES ('YC298P', 'Travel One', 'TK', 'TK1028', 4, '2014-11-11',
    '2014-11-25', 350, 0);

INSERT INTO booking
  VALUES ('YD298P', 'Travel Tour', 'TK', 'TK1028', 1, '2013-11-03',
    '2013-12-20', 250, 1);

INSERT INTO booking
  VALUES ('YE298P', 'Aerofly', 'TK', 'TK1027', 2, '2013-11-07',
    '2013-12-21', 150, 0);

INSERT INTO booking
  VALUES ('YJ298P', 'Aerofly', 'SU', 'SU2061', 3, '2013-11-05',
    '2013-12-05', 500, 1);

INSERT INTO booking
  VALUES ('YS298P', 'Aerofly', 'SU', 'SU2061', 4, '2014-10-04',
    '2014-11-15', 400, 0);

INSERT INTO booking
  VALUES ('YK298P', 'Aerofly', 'SU', 'SU2060', 1, '2014-07-07',
    '2014-08-08', 350, 0);

INSERT INTO booking
  VALUES ('YM298P', 'Aerotravel', 'OA', 'OA308', 2, '2014-06-09',
    '2014-07-10', 350, 1);

INSERT INTO booking
  VALUES ('YN198P', 'Aerotravel', 'OA', 'OA307', 3, '2014-10-18',
    '2014-11-25', 450, 0);

INSERT INTO booking
  VALUES ('YN498P', 'Aerofly', 'LH', 'LH1703', 1, '2014-01-05',
    '2014-02-25', 300, 1);

INSERT INTO booking
  VALUES ('YN598P', 'Aerotravel', 'FB', 'FB1363', 5, '2014-03-03',
    '2014-06-25', 300, 0);

INSERT INTO booking
  VALUES ('YN698P', 'Fly Tour', 'FB', 'FB852', 6, '2014-06-16',
    '2014-07-25', 330, 1);

INSERT INTO booking
  VALUES ('YL298P', 'Fly Tour', 'FB', 'FB851', 7, '2014-04-28',
    '2014-05-25', 360, 0);

INSERT INTO booking
  VALUES ('YZ298P', 'Fly Tour', 'FB', 'FB458', 1, '2014-03-15',
    '2014-06-25', 380, 1);

INSERT INTO booking
  VALUES ('YN268P', 'Fly Tour', 'FB', 'FB457', 2, '2014-02-08',
    '2014-12-21', 390, 0);
