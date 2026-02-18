

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


select p.product_id as pid, p.name, p.price, i.investment, round(i.investment / p.price) as inv_calculated,
p.stock, if(round(i.investment / p.price) = p.stock, 'perfecto','error') as status
from investments as i
left join products as p on p.product_id = i.product_id 
 where investment > 100000 and investment_id % 10 = 0;


update products set stock = 90 where product_id=181;

desc bills;

select b.bill_id, b.status, c.name, count(bp.bill_product_id) as number_of_products, round(sum(bp.quantity * p.price * (1 - bp.discount / 100))) as total;

select concat('El cliente', c.name , 'tiene una cuenta', b.status, 'con', count(bp.bill_product_id),
'productos y suma $', round(sum(bp.quantity * p.price * (1 - bp.discount / 100))) ) as resyultado
  from bills as b
	left join clients as c
	on b.client_id = c.client_id
    left join bill_products as bp
    on bp.bill_id = b.bill_id
    left join products as p
    on p.product_id = bp.product_id
group by b.bill_id;
    
    
