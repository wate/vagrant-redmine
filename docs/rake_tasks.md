Rakeタスク一覧
==========================

about
----------------------------

List versions of all Rails frameworks and the environment

```sh
bundle exec rake about
```

app:template
----------------------------

Applies the template supplied by LOCATION=(/path/to/template) or URL

```sh
bundle exec rake app:template
```

app:update
----------------------------

Update configs and some other initially generated files (or use just update:configs or update:bin)

```sh
bundle exec rake app:update
```

cache_digests:dependencies
----------------------------

Lookup first-level dependencies for TEMPLATE (like messages/show or comments/_comment.html)

```sh
bundle exec rake cache_digests:dependencies
```

cache_digests:nested_dependencies
----------------------------

Lookup nested dependencies for TEMPLATE (like messages/show or comments/_comment.html)

```sh
bundle exec rake cache_digests:nested_dependencies
```

ci
----------------------------

Run the Continuous Integration tests for Redmine

```sh
bundle exec rake ci
```

ci:about
----------------------------

Display info about the build environment

```sh
bundle exec rake ci:about
```

ci:build
----------------------------

Build Redmine

```sh
bundle exec rake ci:build
```

ci:setup
----------------------------

Setup Redmine for a new build

```sh
bundle exec rake ci:setup
```

ci:teardown
----------------------------

Finish the build

```sh
bundle exec rake ci:teardown
```

config/database.yml
----------------------------

Creates database.yml for the CI server

```sh
bundle exec rake config/database.yml
```

config/initializers/secret_token.rb
----------------------------

Generates a secret token for the application

```sh
bundle exec rake config/initializers/secret_token.rb
```

db:create
----------------------------

Creates the database from DATABASE_URL or config/database.yml for the current RAILS_ENV (use db:create:all to create all databases in the config). Without RAILS_ENV or when RAILS_ENV is development, it defaults to creating the development and test databases, except when DATABASE_URL is present

```sh
bundle exec rake db:create
```

db:decrypt
----------------------------

Decrypts SCM and LDAP passwords in the database

```sh
bundle exec rake db:decrypt
```

db:drop
----------------------------

Drops the database from DATABASE_URL or config/database.yml for the current RAILS_ENV (use db:drop:all to drop all databases in the config). Without RAILS_ENV or when RAILS_ENV is development, it defaults to dropping the development and test databases, except when DATABASE_URL is present

```sh
bundle exec rake db:drop
```

db:encrypt
----------------------------

Encrypts SCM and LDAP passwords in the database

```sh
bundle exec rake db:encrypt
```

db:environment:set
----------------------------

Set the environment value for the database

```sh
bundle exec rake db:environment:set
```

db:fixtures:load
----------------------------

Loads fixtures into the current environment's database

```sh
bundle exec rake db:fixtures:load
```

db:migrate
----------------------------

Migrate the database (options: VERSION=x, VERBOSE=false, SCOPE=blog)

```sh
bundle exec rake db:migrate
```

db:migrate:down
----------------------------

Runs the "down" for a given migration VERSION

```sh
bundle exec rake db:migrate:down
```

db:migrate:redo
----------------------------

Rolls back the database one migration and re-migrates up (options: STEP=x, VERSION=x)

```sh
bundle exec rake db:migrate:redo
```

db:migrate:status
----------------------------

Display status of migrations

```sh
bundle exec rake db:migrate:status
```

db:migrate:up
----------------------------

Runs the "up" for a given migration VERSION

```sh
bundle exec rake db:migrate:up
```

db:prepare
----------------------------

Runs setup if database does not exist, or runs migrations if it does

```sh
bundle exec rake db:prepare
```

db:reset
----------------------------

Drops and recreates the database from db/schema.rb for the current environment and loads the seeds

```sh
bundle exec rake db:reset
```

db:rollback
----------------------------

Rolls the schema back to the previous version (specify steps w/ STEP=n)

```sh
bundle exec rake db:rollback
```

db:schema:cache:clear
----------------------------

Clears a db/schema_cache.yml file

```sh
bundle exec rake db:schema:cache:clear
```

db:schema:cache:dump
----------------------------

Creates a db/schema_cache.yml file

```sh
bundle exec rake db:schema:cache:dump
```

db:schema:dump
----------------------------

Creates a database schema file (either db/schema.rb or db/structure.sql, depending on `config.active_record.schema_format`)

```sh
bundle exec rake db:schema:dump
```

db:schema:load
----------------------------

Loads a database schema file (either db/schema.rb or db/structure.sql, depending on `config.active_record.schema_format`) into the database

```sh
bundle exec rake db:schema:load
```

db:seed
----------------------------

Loads the seed data from db/seeds.rb

```sh
bundle exec rake db:seed
```

db:seed:replant
----------------------------

Truncates tables of each database for current environment and loads the seeds

```sh
bundle exec rake db:seed:replant
```

db:setup
----------------------------

Creates the database, loads the schema, and initializes with the seed data (use db:reset to also drop the database first)

```sh
bundle exec rake db:setup
```

db:structure:dump
----------------------------

Dumps the database structure to db/structure.sql

```sh
bundle exec rake db:structure:dump
```

db:structure:load
----------------------------

Recreates the databases from the structure.sql file

```sh
bundle exec rake db:structure:load
```

db:version
----------------------------

Retrieves the current schema version number

```sh
bundle exec rake db:version
```

extract_fixtures
----------------------------

Create YAML test fixtures from data in an existing database

```sh
bundle exec rake extract_fixtures
```

generate_secret_token
----------------------------

Generates a secret token for the application

```sh
bundle exec rake generate_secret_token
```

locales
----------------------------

Updates and checks locales against en.yml

```sh
bundle exec rake locales
```

locales:add_key
----------------------------

Adds a new top-level translation string to all locale file (only works for childless keys, probably doesn't work on windows, doesn't check for duplicates)

```sh
bundle exec rake locales:add_key
```

locales:check_interpolation
----------------------------

Checks interpolation arguments in locals against en.yml

```sh
bundle exec rake locales:check_interpolation
```

locales:dup
----------------------------

Duplicates a key

```sh
bundle exec rake locales:dup
```

locales:remove_key
----------------------------

Removes a translation string from all locale file (only works for top-level childless non-multiline keys, probably doesn't work on windows)

```sh
bundle exec rake locales:remove_key
```

locales:update
----------------------------

Updates language files based on en.yml content (only works for new top level keys)

```sh
bundle exec rake locales:update
```

log:clear
----------------------------

Truncates all/specified *.log files in log/ to zero bytes (specify which logs with LOGS=test,development)

```sh
bundle exec rake log:clear
```

middleware
----------------------------

Prints out your Rack middleware stack

```sh
bundle exec rake middleware
```

redmine:attachments:move_to_subdirectories
----------------------------

Moves attachments stored at the root of the file directory (ie

```sh
bundle exec rake redmine:attachments:move_to_subdirectories
```

redmine:attachments:prune
----------------------------

Removes uploaded files left unattached after one day

```sh
bundle exec rake redmine:attachments:prune
```

redmine:attachments:update_digests
----------------------------

Updates attachment digests to SHA256

```sh
bundle exec rake redmine:attachments:update_digests
```

redmine:email:read
----------------------------

Read an email from standard input

```sh
bundle exec rake redmine:email:read
```

redmine:email:receive_imap
----------------------------

Read emails from an IMAP server

```sh
bundle exec rake redmine:email:receive_imap
```

redmine:email:receive_pop3
----------------------------

Read emails from an POP3 server

```sh
bundle exec rake redmine:email:receive_pop3
```

redmine:email:test[login]
----------------------------

Send a test email to the user with the provided login name

```sh
bundle exec rake redmine:email:test[login]
```

redmine:fetch_changesets
----------------------------

Fetch changesets from the repositories

```sh
bundle exec rake redmine:fetch_changesets
```

redmine:load_default_data
----------------------------

Load Redmine default configuration data

```sh
bundle exec rake redmine:load_default_data
```

redmine:migrate_dbms
----------------------------

FOR EXPERIMENTAL USE ONLY, Moves Redmine data from production database to the development database

```sh
bundle exec rake redmine:migrate_dbms
```

redmine:migrate_from_mantis
----------------------------

Mantis migration script

```sh
bundle exec rake redmine:migrate_from_mantis
```

redmine:migrate_from_trac
----------------------------

Trac migration script

```sh
bundle exec rake redmine:migrate_from_trac
```

redmine:permissions
----------------------------

List all permissions and the actions registered with them

```sh
bundle exec rake redmine:permissions
```

redmine:plugins
----------------------------

Migrates and copies plugins assets

```sh
bundle exec rake redmine:plugins
```

redmine:plugins:assets
----------------------------

Copies plugins assets into the public directory

```sh
bundle exec rake redmine:plugins:assets
```

redmine:plugins:migrate
----------------------------

Migrates installed plugins

```sh
bundle exec rake redmine:plugins:migrate
```

redmine:plugins:test
----------------------------

Runs the plugins tests

```sh
bundle exec rake redmine:plugins:test
```

redmine:plugins:test:functionals
----------------------------

Runs the plugins functional tests

```sh
bundle exec rake redmine:plugins:test:functionals
```

redmine:plugins:test:integration
----------------------------

Runs the plugins integration tests

```sh
bundle exec rake redmine:plugins:test:integration
```

redmine:plugins:test:system
----------------------------

Runs the plugins system tests

```sh
bundle exec rake redmine:plugins:test:system
```

redmine:plugins:test:ui
----------------------------

Runs the plugins ui tests

```sh
bundle exec rake redmine:plugins:test:ui
```

redmine:plugins:test:units
----------------------------

Runs the plugins unit tests

```sh
bundle exec rake redmine:plugins:test:units
```

redmine:send_reminders
----------------------------

Send reminders about issues due in the next days

```sh
bundle exec rake redmine:send_reminders
```

redmine:tokens:prune
----------------------------

Removes expired tokens

```sh
bundle exec rake redmine:tokens:prune
```

redmine:users:prune
----------------------------

Removes registered users that have not been activated after a number of days

```sh
bundle exec rake redmine:users:prune
```

redmine:watchers:prune
----------------------------

Removes watchers from what they can no longer view

```sh
bundle exec rake redmine:watchers:prune
```

restart
----------------------------

Restart app by touching tmp/restart.txt

```sh
bundle exec rake restart
```

secret
----------------------------

Generate a cryptographically secure secret key (this is typically used to generate a secret for cookie sessions)

```sh
bundle exec rake secret
```

stats
----------------------------

Report code statistics (KLOCs, etc) from the application or engine

```sh
bundle exec rake stats
```

test
----------------------------

Runs all tests in test folder except system ones

```sh
bundle exec rake test
```

test:all
----------------------------

Runs all tests, including system tests

```sh
bundle exec rake test:all
```

test:coverage
----------------------------

Measures test coverage

```sh
bundle exec rake test:coverage
```

test:db
----------------------------

Run tests quickly, but also reset db

```sh
bundle exec rake test:db
```

test:routing
----------------------------

Run the routing tests

```sh
bundle exec rake test:routing
```

test:scm
----------------------------

Run unit and functional scm tests

```sh
bundle exec rake test:scm
```

test:scm:functionals
----------------------------

Run the scm functional tests

```sh
bundle exec rake test:scm:functionals
```

test:scm:setup:all
----------------------------

Creates all test repositories

```sh
bundle exec rake test:scm:setup:all
```

test:scm:setup:bazaar
----------------------------

Creates a test bazaar repository

```sh
bundle exec rake test:scm:setup:bazaar
```

test:scm:setup:create_dir
----------------------------

Creates directory for test repositories

```sh
bundle exec rake test:scm:setup:create_dir
```

test:scm:setup:cvs
----------------------------

Creates a test cvs repository

```sh
bundle exec rake test:scm:setup:cvs
```

test:scm:setup:filesystem
----------------------------

Creates a test filesystem repository

```sh
bundle exec rake test:scm:setup:filesystem
```

test:scm:setup:git
----------------------------

Creates a test git repository

```sh
bundle exec rake test:scm:setup:git
```

test:scm:setup:git_utf8
----------------------------

Creates a test git_utf8 repository

```sh
bundle exec rake test:scm:setup:git_utf8
```

test:scm:setup:mercurial
----------------------------

Creates a test mercurial repository

```sh
bundle exec rake test:scm:setup:mercurial
```

test:scm:setup:subversion
----------------------------

Creates a test subversion repository

```sh
bundle exec rake test:scm:setup:subversion
```

test:scm:units
----------------------------

Run the scm unit tests

```sh
bundle exec rake test:scm:units
```

test:scm:update
----------------------------

Updates installed test repositories

```sh
bundle exec rake test:scm:update
```

test:system
----------------------------

Run system tests only

```sh
bundle exec rake test:system
```

time:zones[country_or_offset]
----------------------------

List all time zones, list by two-letter country code (`bin/rails time:zones[US]`), or list by UTC offset (`bin/rails time:zones[-8]`)

```sh
bundle exec rake time:zones[country_or_offset]
```

tmp:clear
----------------------------

Clear cache, socket and screenshot files from tmp/ (narrow w/ tmp:cache:clear, tmp:sockets:clear, tmp:screenshots:clear)

```sh
bundle exec rake tmp:clear
```

tmp:create
----------------------------

Creates tmp directories for cache, sockets, and pids

```sh
bundle exec rake tmp:create
```

yard
----------------------------

Generate YARD Documentation

```sh
bundle exec rake yard
```

yarn:install
----------------------------

Install all JavaScript dependencies as specified via Yarn

```sh
bundle exec rake yarn:install
```

zeitwerk:check
----------------------------

Checks project structure for Zeitwerk compatibility

```sh
bundle exec rake zeitwerk:check
```
