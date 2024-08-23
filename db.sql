create table
  public."Tasks" (
    id serial not null,
    name text not null,
    description text not null default ''::text,
    status integer not null default 0,
    created_at timestamp without time zone not null default current_timestamp,
    workers text[] null,
    head_count integer null,
    location text not null default 'Versenyhelyszín'::text,
    due_date integer[] null default array[9, 0],
    "pinnedNote" integer not null default 0,
    notes text[] null,
    constraint Tasks_pkey primary key (id)
  ) tablespace pg_default;
