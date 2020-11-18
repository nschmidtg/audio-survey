# README

## Dependencies:
* ruby 2.5.8
* Rails 6.0.3.4
* postgresql 13

## Install:

After cloning the code a file called '.env.development' should be created in the root of the project with the AWS environment variables:

```
AWS_ACCESS_KEY_ID=...
AWS_SECRET_ACCESS_KEY=...
AWS_REGION=...
```

rvm, ruby and ruby on rails installation:
http://installfest.railsbridge.org/installfest/linux. 

Postgres:

https://www.godaddy.com/garage/how-to-install-postgresql-on-ubuntu-14-04/

> If you have problems: Habilitar Postgres para que cualquier usuario pueda modificar la DB. Buscar el archivo pg_hba.conf. en la carpeta de /postgres. Abrirlo con: sudo nano pg_hba.conf, poner todos los valores en trust. Se debe hacer restart de postgres

Bundle:

```
gem install bundle
bundle install
```

Create the database:
```
rails db:create
rails db:migrate
```
To populate the database with the users and songs of the AWS repo:

```
rails db:seed
```
Turn on the local server:

```
rails s
```

