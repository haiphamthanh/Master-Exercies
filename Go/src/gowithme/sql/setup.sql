/* Executing Command line */
    -- create usr   : createuser -P -d <usr>
    -- create db    : createdb <db name>
    -- file         : psql -U <usr> -f <path> -d <db name>

/* Sample statement and explain */
    -- Create user      : createuser -P -d gwp                      --> User name       : gwp
    -- Create database  : createdb gwp                              --> Database name   : gwp
    -- Execute file     : psql -U gwp -f ./sql/setup.sql -d gwp     --> -U(user) -d(database) -f(file-location)

/* Data base informations */
-- usr          : gwp
-- db name      : gwp
-- password     : gwp

/* Create database */
drop table posts cascade;
drop table comments;

create table posts (
    id serial primary key,
    content text,
    author varchar(255)
);

create table comments (
    id serial primary key,
    content text,
    author varchar(255),
    post_id integer references posts(id)
);

/* Make some dummy data */
insert into posts (content, author) values ('dummy first data', 'me')

/* Recheck dummy data */
select * from posts