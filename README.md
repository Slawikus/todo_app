# TODO app

Here I'll add some comments along making this small TODO 
API-only app. I use RubyMine from JetBrains as IDE, and 
Ubuntu 14.04.4 LTS as dev environment.

Versioning of APIs is skipped for simplicity.

Start a new API-only Rails 5.0 project:

`rails new todo_app --api`

Add few gems to Gemfile:

`gem 'rspec-rails' # for testing with RSpec - TODO`

`gem 'bcrypt' # password hashing`

`gem 'active_model_serializers' # model serializer`

I decided to go for a version with authentication, but 
without categories handling. This means I will have two 
models - `User` and `Task`.

`User` model I made without email field for simplicity. 
Authentication  will be handled via token field assigned ONLY
once randomly to each user during the creation of the user and stored 
in the database. Better practice would be to generate this token
each time the user logs in, and remove it on logout + add expiration time.
Here I made a simple implementation by myself, but one can use 
already made libraries like Knock, Diverse, Authlogic and others for 
JWT based authentication. Probably a smart idea would be to cache the
token in the Redis so that server will not call database on
each request checking if token is correct and/or to which user
it is assigned.

`rails generate scaffold User username:string password:digest token:string`

`rails generate migration add_index_to_users_token`

`Task` model is simple with just few fields and reference to User model.

`rails generate scaffold Task title:string done:boolean user:references`

Create user:

`curl -X POST -H "Content-Type: application/json" -d '{"user": {"username": USERNAME,"password": PASSWORD } } ' "http://localhost:3000/users/"`

Login user:

`curl -X POST -H "Content-Type: application/json" -d '{"user": {"username": USERNAME,"password": PASSWORD } } ' "http://localhost:3000/login"`

Get all users:

`curl -H "Authorization: Token token=TOKEN" http://localhost:3000/users`

Still TODO (ironically), just for fun:
* testing with RSpec
* deploy to Heroku and test the production mode
* make a simple client in VueJS
* implement categories

