# Book Recommender App

A dynamic web app that helps you find book recommendations based on your
user profile.

For development, I have the Gemfile set to use SQLite3 (Postgresql in production). 
The database can be created with a simple `rails db:migrate` call with 
no prior setup. There is no database seeding required, as the only data 
necessary is created by each user as they use the webapp.

Tests also require no setup and can be executed with just `rails t`.

Deploying consists of pushing to the master branch of the heroku remote.


## Author

* [Liam Niehus-Staab](https://github.com/niehusst)

## Acknowledgements
* Background image from [Subtle Patterns](https://www.toptal.com/designers/subtlepatterns/triangle-mosaic-pattern/).
* Books image from Nino Caré on [Pixabay](https://pixabay.com/photos/books-door-entrance-culture-1655783/).
* Google Books for its reasonably convenient API.

