show databases;
use platzi_db;
create table Clients(
	client_id integer unsigned primary key auto_increment,
    name varchar(100) not null,
    email varchar(100) not null unique,
    phone_number varchar(15),
    created_at timestamp not null default current_timestamp,
    updated_at timestamp not null default current_timestamp on update current_timestamp
);
show warnings;


create table if not exists products (
	`product_id`integer unsigned  primary key auto_increment,
    name varchar(100) not null,
    slug varchar(200) not null unique,
    description text,
    created_at timestamp not null default current_timestamp,
    updated_at timestamp not null default current_timestamp on update current_timestamp
);

show tables;

create table if not exists bills (
	bill_id integer unsigned primary key auto_increment,
    client_id  integer unsigned not null,
    total float,
    status enum('open', 'paid', 'lost') not null default 'open',
    created_at timestamp not null default current_timestamp,
    updated_at timestamp not null default current_timestamp on update current_timestamp,
    foreign key (client_id) references clients(client_id)
		on delete cascade
        on update cascade
);

select * from bills;
select * from clients;


drop table bills;

insert into bills (client_id, total) values (10, 15.00);
insert into clients (client_id, name, email) values (10, 'eduardo', 'eduardo@email.com');




select * from bills;

select * from clients;
update clients set client_id = 12 where client_id = 10;


show create table bills	;

insert into bills (client_id, total) values (10, 10.50);
select * from bills;



create table if not exists bill_products(
    bill_product_id integer unsigned primary key auto_increment,
    bill_id integer unsigned not null,
    product_id integer unsigned not null,
    quantity integer unsigned not null default 1,
    created_at timestamp not null default current_timestamp,
    updated_at timestamp not null default current_timestamp on update current_timestamp,
    foreign key (bill_id) references bills(bill_id)
        on delete cascade
        on update cascade,
    foreign key (product_id) references products(product_id)
        on delete cascade
        on update cascade
)


insert into products(name, slug) values ('cuaderno', 'slug-cuaderno');
insert into bill_products(bill_id, product_id) values (1, 1);


