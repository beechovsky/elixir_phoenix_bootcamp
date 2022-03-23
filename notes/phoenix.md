# Intro to Phoenix
Notes for getting started with Phoenix.

## Getting Started
### Installation
Everything you need can be found here:
https://hexdocs.pm/phoenix/installation.html#content

### Common Dependencies
You'll most likely want to work with a database. Ecto makes that easier, and the default database for Phoenix is PostGres, although you can also use MySQL adn SQLite3.

#### Ecto
Install teh dependency as described here:
https://github.com/elixir-ecto/ecto

#### Postgres
https://help.ubuntu.com/community/PostgreSQL

## General
Phoenix is a web framework for Elixir. You can read more on the official site, so we'll keep things fairly basic up front.

### What does it do?
Very generally, Phoenix operates as a web server users can interact with via HTML, JSON, and Websockets.

Phoenix commonly employs a database to persist user data. Everything in Phoenix is essentially a layer that takes user requests in the form of HTML, JSON, or websockets, looks into a database, and responds via HTML, JSON, or Websockets.

