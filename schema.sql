drop schema if exists gql cascade;
create schema gql;


create table if not exists public.bar (
  id  serial primary key,
  name text
);

create table if not exists public.baz (
  id  serial primary key,
  name text
);

create table if not exists public.foo (
  id serial primary key,
  bar_id int references bar (id) unique,
  baz_id int references baz (id) unique
);

create view gql.bar as
  select id, name
  from public.bar;

create view gql.baz as
  select id, name
  from public.baz;

create view gql.foo as
  select id, bar_id, baz_id
  from public.foo;

comment on view gql.bar is '@primaryKey id';
comment on view gql.baz is '@primaryKey id';
comment on view gql.foo is '@primaryKey id
@foreignKey (bar_id) references bar (id)
@foreignKey (baz_id) references baz (id)';
