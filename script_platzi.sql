

create database if not exists platzisql;

use platzisql;
create table if not exists clients (
  client_id integer primary key auto_increment,
  name varchar(100) not null,
  email varchar(100) not null unique,
  phone_number varchar(15),
  created_at timestamp not null default CURRENT_TIMESTAMP,
  updated_at timestamp not null default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP
);

create table if not exists products (
  `product_id` integer unsigned primary key auto_increment,
  name varchar(100) not null,
  sku varchar(20) not null,
  slug varchar(200) not null unique,
  description text,
  price float not null default 0,
  created_at timestamp not null default CURRENT_TIMESTAMP,
  updated_at timestamp not null default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP
);

create table if not exists bills (
  bill_id integer unsigned primary key auto_increment,
  client_id integer not null,
  total float,
  status enum('open', 'paid', 'lost') not null default 'open',
  created_at timestamp not null default CURRENT_TIMESTAMP,
  updated_at timestamp not null default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP
);


create table if not exists bill_products (
  bill_product_id integer unsigned primary key auto_increment,
  bill_id integer unsigned not null,
  product_id integer unsigned not null,
  quantity integer not null default 1,
  price float not null,
  discount integer not null default 0,
  date_added datetime,
  created_at timestamp not null default CURRENT_TIMESTAMP,
  updated_at timestamp not null default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP
);


alter table products add column stock integer unsigned not null default 0 after price;

SET SQL_SAFE_UPDATES = 1;

update  products set stock = round(100 * rand());

select * from products limit 10;
alter table clients add column active tinyint not null default 1 after phone_number;

select * from clients limit 10;

update clients set active=0 where client_id = 3680;

select * from clients where client_id=3680;

create table if not exists investments(
	investment_id integer unsigned primary key auto_increment,
    product_id integer unsigned not null,
    investment integer not null default 0
);

select * from investments;

insert into investments(product_id, investment) 
select product_id, stock*price from products;