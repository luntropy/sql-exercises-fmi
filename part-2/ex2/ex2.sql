-- Database 'pc'

CREATE TABLE product_new (
    model CHAR(4) PRIMARY KEY,
    maker CHAR(1),
    type VARCHAR(7)
);

CREATE TABLE printer_new (
    code INTEGER,
    model CHAR(4) NOT NULL,
    price NUMERIC(6,2),
    FOREIGN KEY (model)
        REFERENCES product_new (model)
        ON DELETE CASCADE
);

INSERT INTO product_new VALUES ('1276', 'A', 'Printer');
INSERT INTO product_new VALUES ('1288', 'D', 'Printer');
INSERT INTO product_new VALUES ('1401', 'A', 'Printer');

INSERT INTO printer_new VALUES (1, '1276', 400);
INSERT INTO printer_new VALUES (6, '1288', 400);
INSERT INTO printer_new VALUES (4, '1401', 150);

ALTER TABLE printer_new ADD COLUMN type VARCHAR(6) CHECK (type = 'laser' OR type = 'matrix' OR type = 'jet');

ALTER TABLE printer_new ADD COLUMN color CHAR(1) CHECK (color = 'y' OR color = 'n');

ALTER TABLE printer_new DROP COLUMN price;

DROP TABLE IF EXISTS printer_new;

DROP TABLE IF EXISTS product_new;

-- Database 'facebook'

CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    email VARCHAR(255) NOT NULL,
    password VARCHAR(255) NOT NULL,
    registration_date TIMESTAMP NOT NULL
);

CREATE TABLE friends (
    user_id INTEGER NOT NULL,
    friend_id INTEGER NOT NULL,
    FOREIGN KEY (user_id)
        REFERENCES users (id)
        ON DELETE CASCADE,
    FOREIGN KEY (friend_id)
        REFERENCES users (id)
        ON DELETE CASCADE
);

CREATE TABLE walls (
    user_id INTEGER NOT NULL,
    author_id INTEGER NOT NULL,
    message TEXT NOT NULL,
    msg_date TIMESTAMP NOT NULL,
    FOREIGN KEY (user_id)
        REFERENCES users (id)
        ON DELETE CASCADE,
    FOREIGN KEY (author_id)
        REFERENCES users (id)
        ON DELETE CASCADE
);

CREATE TABLE groups (
    group_id SERIAL PRIMARY KEY,
    group_name VARCHAR(255) NOT NULL,
    description TEXT DEFAULT ''
);

CREATE TABLE group_members (
    group_id INTEGER NOT NULL,
    user_id INTEGER NOT NULL,
    FOREIGN KEY (group_id)
        REFERENCES groups (group_id)
        ON DELETE CASCADE,
    FOREIGN KEY (user_id)
        REFERENCES users (id)
        ON DELETE CASCADE
);

INSERT INTO users (email, password, registration_date) VALUES ('first_user@gmail.com', 'password1', current_timestamp);
INSERT INTO users (email, password, registration_date) VALUES ('second_user@gmail.com', 'password2', current_timestamp);
INSERT INTO users (email, password, registration_date) VALUES ('third_user@gmail.com', 'password3', current_timestamp);

INSERT INTO friends VALUES (1, 2);
INSERT INTO friends VALUES (1, 3);
INSERT INTO friends VALUES (2, 1);
INSERT INTO friends VALUES (3, 1);

INSERT INTO walls VALUES (1, 2, 'Hello!', current_timestamp);
INSERT INTO walls VALUES (2, 1, 'Hello!', current_timestamp);
INSERT INTO walls VALUES (3, 1, 'Hello!', current_timestamp);

INSERT INTO groups (group_name, description) VALUES ('Group1', 'This is the first group!');
INSERT INTO groups (group_name) VALUES ('Group2');
INSERT INTO groups (group_name) VALUES ('Group3');

INSERT INTO group_members VALUES (1, 1);
INSERT INTO group_members VALUES (2, 2);
INSERT INTO group_members VALUES (3, 3);
INSERT INTO group_members VALUES (1, 3);
