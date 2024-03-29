## Screenshot

![gif](/images/desc.gif)

## How to install

Just run command `gem install huqua` or add `gem 'huqua'` to `Gemfile`

Requitment: 
1. platform: macOS/Linux
2. database: PostgreSQL

**Note**  
On `Linux`, make sure you config database.yml like this:  

```yaml
development:
  adapter: postgresql
  host: localhost
  encoding: unicode
  database: your_database_name
  pool: 5
  username: your_username_in_database
  password: your_password
```

## How to use

### 1. To see how many tables you have

Run `huqua`

Result like: 

```
Congrats, you have good connection to database !

You have 5 tables in your database:
- admins (2)
- comic_photo_ens (0)
- comic_photos (0)
- comics (6)
- infomations (0)
```

### 2. To see the first record in table `table_name` (table name **NOT** model name)

Run `huqua table_name`

Ex: `huqua users`

Result like: 

```
Congrats, you have good connection to database !

The first record:{"id"=>"1", "created_at"=>"2019-05-07 06:16:17.272652", "updated_at"=>"2019-05-07 06:16:17.272652", "email"=>"hduychinh@gmail.com", "encrypted_password"=>"$2a$11$PrsExR3x5HrqK5n3d/RCDeQNDbVKqRmdLsB58ZdBv/fV4x2hJU0OK", "reset_password_token"=>nil, "reset_password_sent_at"=>nil, "remember_created_at"=>nil}
```

### 3. To see the record `n`

Run `huqua users n`

Ex: `huqua users 1`
> to return users have id = 1

Result like: 

```ruby
Congrats, you have good connection to database !

The first record:{"id"=>"1", "created_at"=>"2019-05-07 06:16:17.272652", "updated_at"=>"2019-05-07 06:16:17.272652", "email"=>"hduychinh@gmail.com", "encrypted_password"=>"$2a$11$PrsExR3x5HrqK5n3d/RCDeQNDbVKqRmdLsB58ZdBv/fV4x2hJU0OK", "reset_password_token"=>nil, "reset_password_sent_at"=>nil, "remember_created_at"=>nil}
```

## How to remove

Just run: `gem uninstall huqua` and press `enter`

## why it fun?

If you are a newbie in ruby on rails development, so many times, you can test your database on the local environment to make sure your connection to the database is successful or success to import data (from SQL or CSV...)

You have 2 choices.

1: You can open an administrator platform for PostgreSQL like **pgadmin** 
- need to install a tool (not good for a weak computer).
- open the tool and checking (wasting time and not good for a weak computer again :D)

2: You can access the database from the terminal.
- step 1: type command `rails c`
- step 2: try to remember the model name and typing like `Cat.first` to see the first record.
- step 3: need to `exit` to back terminal.
- do again when you need to check something or open a new terminal window.
...

So I think I can make it simple, when I need to check structure simple, like check new record can save in DB or check number records of a table. 

So I build a simple tool. At this time, it work only with `PostgreSQL`. :neutral_face:
