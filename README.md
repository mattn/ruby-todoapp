# ruby-todoapp

Sinatra todoapp. This application is a personal use todo app that uses prisma-generated tables from Ruby.

## Installation

```sql
CREATE TABLE IF NOT EXISTS "Task" (
  id integer NOT NULL,
  text text,
  completed boolean,
  primary key (id)
);

CREATE SEQUENCE IF NOT EXISTS Task_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER SEQUENCE Task_id_seq OWNED BY "Task".id;
```

```
$ bundle exec ruby main.rb
```

Or run on your docker

```
$ docker run -it --rm 
```

## License

MIT

## Author

Yasuhiro Matsumoto (a.k.a. mattn)
