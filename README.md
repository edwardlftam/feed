# Feed

A Feed Reader system.

## Objective
- We want to make a feed reading system that allows user to do the following:
- Subscribe/Unsubscribe a User to a Feed
- Add Articles to a Feed
- Get all Feeds a Subscriber is following
- Get Articles from the set of Feeds a Subscriber is following

## Setup
This project relies on Ruby 2.3.2 and MySQL 5.6+.

Simply clone the project:
```
git clone git@github.com:edwardlftam/feed.git
```
Run bundle:
```
bundle install
```
Then run the database migrations:
```
bin/rake db:create
bin/rake db:migrate
```
To run the specs:
```
bundle exec rspec
```
To setup the server:
```
RAILS_ENV=development bin/rails s
```


## Database
In this example, MySQL is chosen for the following reasons:
- Relational to enforce data integrity
- Well documented
- Popular and good community support
- Tools available

## Server
In this example, Rails 5 API is chosen for the following reasons:
- Popular and good community support
- Already available, very good candidate for rapid development
- Well thought initialization process, and with a long history brings stability
- Light weight, as API mode has cut down unecessary modules from Rails for rendering pages

## Architecture
The following is the workflow of this example:
Controllers -> Actions -> Services -> Models -> Database

Note that an extra *Action* layer is added here. The reason is that it provides an abstract to allow parameters handling of each controller action to stay together with the actual functioning method, achieving the purpose of separation of concern, better unit testing and provide a better context for Developers to read through the code. It also allows thinner *Controller* layer which helps when a project grows bigger.

## Models
There are 4 models in this example: **User**, **Subscription**, **Feed** and **Article**

**User** and **Feed** has a many-to-many relationship through the crosstable **Subscription**
**Article** belongs to **Feed**

## Services
There is only 1 service in this example: the *ArticleFetcher*
This service uses raw SQL in attempt to speed up the fetch process by reducing the number of queries made.

## Actions
The *Actions* layer is an extension of each of the controller actions into its separate class. An *Action* takes in the context of the controller and has serval key controller delegations defined.

Each *Action* has a #perform method defined and should be doing the following in order:
1. Validate parameters
2. Carry out operations
3. Delegate a result payload back to the controller.

## Controllers
The controllers layer in this example solely act as a bridge between the routers and the core application.


## Endpoints
The following endpoints are available in order to address the objectives:

| TYPE          | PATH                                     | Params | Remarks|
| ------------- |:----------------------------------------:| ------:| ------:|
| POST          | /users/:user_id/feeds/:feed_id/subscribe | user_id(int), feed_id(int) | Subscribe a user to a feed |
| DELETE        | /users/:user_id/feeds/:feed_id/unsubscribe | user_id(int), feed_id(int) | Unsubscribe a user to a feed |
| POST          | /feeds/:feed_id/articles | feed_id(int), article(Hash: author(str), title(str) subtitle(str), content(str)) | Add an article to a Feed |
| GET | /users/:user_id/feeds | user_id(int) | Get all feeds of the given user |
| GET | /users/:user_id/articles | user_id(int) | Get all articles of the given user |

## Testing
**RSpec**, **Factory Gril** and **Database Cleaner** are chosen in this example for setting up automated testing.
**SimpleCov** is used to generate coverage report.


## Roadmap
As the feed system is read-heavily, the focus should be on the optimization based on this fact. 

The following is a list of possible improvements:

- Pagination. (Page/Cursor style depending on the business requirement of the product)
- Data Store (Aggregate and Prepare a set of data ready to be query in a regular basis, assuming existing articles are not frequently updated)
- Caching (Take advantage of memory store such as Redis to cache requently accessed queries to reduce the number of reads from the database)
- Search Engine (If text search is important, we can probably take advantage of integrating a search engine such as Elasticsearch)
- Better Serialization (E.g. integration of GraphQL to allow users to query just enough data has they need)
- Real-time update (E.g. take advantage of Rails 5's ActionCable to achieve real-time update through TCP connections
