-- widgets TABLE
CREATE TABLE widgets (
	id int auto_increment PRIMARY KEY,
	name varchar(255) NOT NULL DEFAULT '',
	description varchar(255) NOT NULL DEFAULT '',
	image varchar(255) NOT NULL DEFAULT '',
	inventory_level int NOT NULL,
	price int NOT NULL,
	is_recurring boolean NOT NULL DEFAULT 0,
	plan_id varchar(255) NOT NULL DEFAULT '',
    created_at DATETIME default NOW(),
    updated_at DATETIME default NOW()
);
-- transaction_statuses TABLE
CREATE TABLE transaction_statuses (
	id int auto_increment PRIMARY KEY,
	name varchar(255) NOT NULL,
    created_at DATETIME default NOW(),
    updated_at DATETIME default NOW()
);
-- transactions TABLE
CREATE TABLE transactions (
	id int auto_increment PRIMARY KEY,
    transaction_status_id int,
	amount int,
	currency varchar(10),
	last_four varchar(4),
	bank_return_code varchar(255),
	payment_intent varchar(255) NOT NULL DEFAULT '',
	payment_method varchar(255) NOT NULL DEFAULT '',
	expiry_month int NOT NULL,
	expiry_year int NOT NULL,
    created_at DATETIME default NOW(),
    updated_at DATETIME default NOW(),
	FOREIGN KEY (transaction_status_id) REFERENCES transaction_statuses(id)
);
-- statuses TABLE
CREATE TABLE statuses (
	id int auto_increment PRIMARY KEY,
	name varchar(255) NOT NULL,
    created_at DATETIME default NOW(),
    updated_at DATETIME default NOW()
);
-- users TABLE
CREATE TABLE users (
	id int auto_increment PRIMARY KEY,
	first_name varchar(255),
	last_name varchar(255),
	email varchar(255),
	password varchar(60),
    created_at DATETIME default NOW(),
    updated_at DATETIME default NOW()
);
-- customers TABLE
CREATE TABLE customers (
	id int auto_increment PRIMARY KEY,
	first_name varchar(255),
	last_name varchar(255),
	email varchar(255),
    created_at DATETIME default NOW(),
    updated_at DATETIME default NOW()
);
-- orders TABLE
CREATE TABLE orders (
	id int auto_increment PRIMARY KEY,
	widget_id int,
	transaction_id int,
	status_id int,
	customer_id int,
	quantity int,
	amount int,
    created_at DATETIME default NOW(),
    updated_at DATETIME default NOW(),
    FOREIGN KEY (widget_id) REFERENCES widgets(id),
    FOREIGN KEY (transaction_id) REFERENCES transactions(id),
    FOREIGN KEY (status_id) REFERENCES statuses(id),
    FOREIGN KEY (customer_id) REFERENCES customers(id)
);

CREATE TABLE tokens (
	id int auto_increment PRIMARY KEY,
	user_id int,
	name varchar(255),
	email varchar(255),
	token_hash varbinary(255),
	expiry timestamp,
	created_at DATETIME default NOW(),
    updated_at DATETIME default NOW(),	
    FOREIGN KEY (user_id) REFERENCES users(id)
);

CREATE TABLE sessions (
	token CHAR(43) PRIMARY KEY,
	data BLOB NOT NULL,
	expiry TIMESTAMP(6) NOT NULL
);

CREATE INDEX sessions_expiry_idx ON sessions (expiry);

INSERT INTO widgets (name, description, inventory_level, price, image, is_recurring, plan_id, created_at, updated_at) values ('Widget', 'A very nice widget.', 100, 400, '/static/spinner.png', 0, '', NOW(), NOW());

INSERT INTO widgets (name, description, inventory_level, price, is_recurring, plan_id, created_at, updated_at) values ('Bronze', 'Get three widgets for the price of two every month.', 100000, 800, 1, 'price_1MXVSbFigsSjSiagYKSog9Wg' ,NOW(), NOW());

INSERT INTO transaction_statuses (name) values ('Pending');
INSERT INTO transaction_statuses (name) values ('Cleared');
INSERT INTO transaction_statuses (name) values ('Declined');
INSERT INTO transaction_statuses (name) values ('Refunded');
INSERT INTO transaction_statuses (name) values ('Partially refunded');
INSERT INTO statuses (name) values ('Cleared');
INSERT INTO statuses (name) values ('Refunded');
INSERT INTO statuses (name) values ('Cancelled');

INSERT INTO users (first_name, last_name, email, password) values ('Admin','User','admin@example.com', '$2a$12$VR1wDmweaF3ZTVgEHiJrNOSi8VcS4j0eamr96A/7iOe8vlum3O3/q');