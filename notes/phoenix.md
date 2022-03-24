# Intro to Phoenix
Notes for getting started with Phoenix.

## Getting Started
### Installation
Everything you need can be found here:
https://hexdocs.pm/phoenix/installation.html#content

### Common Dependencies
You'll most likely want to work with a database. Ecto makes that easier, and the default database for Phoenix is PostGres, although you can also use MySQL or SQLite3.

#### Ecto
Install the dependency as described here:
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

**NOTE:** This will be code-heavy, so some notes and comments will be in the code.

## Databases and Ecto
We need a database to store users, topics, etc. The easiest way to manage our persistence layer in Phoenix is by using Ecto, the documentation for which is linked above.

To create a database, run:
`mix.ecto create`

You should see the following in your terminal:
`The database for Discuss.Repo has been created`

OK, what's `Discuss.Repo`?

When we generated our app using Mix, a file for defining our *repository* was created and it looks like this:
```
defmodule Discuss.Repo do
  use Ecto.Repo,
    otp_app: :discuss,
    adapter: Ecto.Adapters.Postgres
end
```

This is all Ecto needed to create a Postgres database for us.

## Running the App
Let's run the server to see what we get "out of the box". From the root-level directory, run `mix phx.new`.

## Server Side Templating
With server side templating/rendering, an application contains a collection of different webpages with distinct URLs a user can visit. Every time a user visits a different URL served by your app, they are served a new, distinct webpage and HTML document, unlike a Single Page Application (SPA). In SPAs, whenever a user initially visits a page, they make an HTTP request and are given a HTML Document. Now, whenever a user naviages to some other part of the app, instead of making another HTTP request to the server for a new page, JavaScript in the initial document will determine how to reconfigure the page according to the user's desire, and replace teh HTML visible to the user.

Phoenix assumes you'll be using server side templating, and has lots of tooling supporting it by default, but that isn't strictly required.

Let's take a first look at Phoenix's templating. Navigate to `/discuss/lib/discuss_web/templates/page/index.html.heex` in your IDE and take a look. Compare what you see to the page rendered in your broswer when the server is runing. Seemspretty straighforward, right? Well, where's that banner coming from? The `index.html` template you're looking at only contains the lower section of the page, the resources and help sections.

Let's think about websites we commonly visit. They tend to have a consistent header whever we navigate. Phoenix does this by default, too, using *layouts*, which describe behavior common to most/all of your app's pages. Take a look at the other directory in `/templates/`, specifcally, `/templates/layouts/`. You'll find the banner we've been looking for in `root.html.heex.`. Aptly named, this forms the root HTML document all our your web pages will be nested in. Note the structure - it includes `<!DOCTYPE html>`, for instance. Now take another look back at `/pages/index.html.heex` - it is composed of merely `<section>` tags, clearly not a full HTML document, but a part that is served along with the root HTML when the corresponding URL is called.

You may have also noticed that the default landing page had some decent styling. Phoenix comes loaded with quite a bit of default styling so your app will look pretty good without much interference if you know your way around CSS. However, if you think it looks a little dated, you can use whatever styling you like. For this particular project we'll use Material Design. You can grab a CDN to install Material Design from their website, and paste it into the `<head>` in `root.html.heex`.

## Phoenix MVC
You're probably already familiar with the "MVC" paradigm, which stands for Model, View, Controller.
- Model: The data behind the content a page presents
- View: A template that makes the data presentable to humans
- Controller: Determines what the user wants, and populates a View from a Model

MVC architecture is not limited to OOP. We don't need *classes*.

## Router and Controller
Whenever someone makes a request to a Phoenix application, that request first hits a Router (`router.ex`). The Router is a module that takes incoming requests, inspects the URL, then routes that request to another part of the application, usually a Controller.
The Controller, if necessary, will build a Model from the database, then pass that Model to a View which is then sent as a response.

## Templates and Views