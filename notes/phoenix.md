# Intro to Phoenix
Notes for getting started with Phoenix.

## Getting Started
### Installation
Everything you need can be found here:
https://hexdocs.pm/phoenix/installation.html#content

### Common Dependencies
You'll most likely want to work with a database. Ecto makes that easier, and the default database for Phoenix is PostGres, although you can also use MySQL or SQLite3.

#### Ecto
Install teh dependency as described here:
https://github.com/elixir-ecto/ecto

#### Postgres
https://help.ubuntu.com/community/PostgreSQL

## General
Phoenix is a web framework for Elixir. You can read more on the official site, so we'll keep things fairly basic up front.

### What does it do?
*Very* generally, Phoenix operates as a web server users can interact with via HTML, JSON, and Websockets.

Phoenix commonly employs a database to persist user data. Everything in Phoenix is essentially a layer that takes user requests in the form of HTML, JSON, or websockets, looks into a database, and responds via HTML, JSON, or Websockets.

Phoenix is LARGE, and covers loads of web functionality. To that end, this section of notes will contain some refresher/recursing over doing things in the web in general.

## Example Project: Discuss
Discuss shall be a sort of forum, where users log in and create topics and comment on the comments of others.

### Planning
Requirements:
Authentication: OAuth via Github
Users shall see a list of topics upon login, and also a button to create a new topic.
Clicking the Create button takes th euser to a view where they can create a topic.
If a user created a topic, they have functionality to edit or delete that topic.
Users can only create topics/comments when signed in.

**NOTE:** This will be code-heavy, so further notes and comments will be in the code.

