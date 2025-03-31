CREATE DATABASE retail_data;
USE retail_data;


CREATE TABLE product (
	product_id     INT              NOT NULL,
    description    VARCHAR(40)      NOT NULL,
    price          FLOAT            NOT NULL,
    category       VARCHAR(40)      NOT NULL,
    max_qty        INT              NOT NULL,
    PRIMARY KEY (product_id)
);
-- DROP TABLE product ;


CREATE TABLE member (
	member_id      INT              NOT NULL,
    first_name     VARCHAR(20)      NOT NULL,
    last_name      VARCHAR(20)      NOT NULL,
    store_id       INT              NOT NUll,
    reg_date       VARCHAR(20)      NOT NULL,
    PRIMARY KEY (member_id)
);


CREATE TABLE tran_dtl (
	tran_id       VARCHAR(70)      NOT NULL,
    product_id    INT              NOT NULL,
    qty           INT              NOT NULL,
    amt           FLOAT            NOT NULL,
    tran_dt       VARCHAR(20)      NOT NULL,
    FOREIGN KEY (tran_id) REFERENCES tran_hdr(tran_id)
);
-- DROP TABLE tran_dtl;


CREATE TABLE tran_hdr (
	tran_id      VARCHAR(70)      NOT NULL,
    member_id    INT              NOT NULL,
    store_id     INT              NOT NULL,
    tran_dt      VARCHAR(20)      NOT NULL,
    PRIMARY KEY (tran_id)
);
-- DROP TABLE tran_hdr;  


SELECT * FROM product;
SELECT * FROM member;
SELECT * FROM tran_dtl;
SELECT * FROM tran_hdr;
SELECT * FROM tran_dtl ORDER BY tran_dt DESC;
SELECT * FROM tran_hdr ORDER BY tran_dt DESC;
SELECT * FROM tran_dtl WHERE tran_dt = CURRENT_DATE();
SELECT * FROM tran_hdr WHERE tran_dt = CURRENT_DATE();



-- DELETE FROM tran_hdr WHERE tran_dt = '2025-03-23';
-- DELETE FROM tran_dtl WHERE tran_dt = '2025-03-23';

SHOW CREATE TABLE tran_dtl;
SHOW TABLES;

DESC tran_dtl;
 