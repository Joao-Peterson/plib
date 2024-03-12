create table person(
	id serial primary key,
	name varchar(32) not null,
	age integer,
	height float,
	verified boolean not null default false
);