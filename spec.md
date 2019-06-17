# Specifications for the Sinatra Assessment

Specs:
- [x] Use Sinatra to build the app
  - I used the Corneal gem to build the basic structure for the Sinatra app.
- [x] Use ActiveRecord for storing information in a database
  - I used ActiveRecord to CRUD objects in my database. I also used it to create my associations between models and validate attributes.
- [x] Include more than one model class (e.g. User, Post, Category)
  - My app has User, Album, and Review models
- [x] Include at least one has_many relationship on your User model (e.g. User has_many Posts)
  - My user model has a has_many reviews relationship
  - My user model has a has_many :albums, through :reviews relationship
- [x] Include at least one belongs_to relationship on another model (e.g. Post belongs_to User)
  - My Review model has a belongs_to :albums relationship
  - My Review model has a belongs_to :users relationship
- [x] Include user accounts with unique login attribute (username or email)
  - I used ActiveRecord validations to validate the uniqueness of usernames for my User model
- [x] Ensure that the belongs_to resource has routes for Creating, Reading, Updating and Destroying
  - Reviews can be created, viewed, updated, and deleted
- [x] Ensure that users can't modify content created by other users
  - Users can only edit and delete their own reviews. If they attempt to edit or delete another user's reviews, they will be redirected and a flash message is displayed explaining the error.
- [x] Include user input validations
  - Users have to have unique usernames and must input a username and password
  - Albums must have a unique album name and users must input the album name, artist, and release_date
  - Reviews must have inputted content and ratings. The review form uses a drop-down for the album, so it is not possible for a user to not select an album.
- [x] BONUS - not required - Display validation failures to user with error message (example form URL e.g. /posts/new)
  - I used rack flash to display error messages when users failed to fill out all fields or validations failed.
- [x] Your README.md includes a short description, install instructions, a contributors guide and a link to the license for your code
  - My readme has a description and installation instructions
  - [ ] Need to add license info

Confirm
- [x] You have a large number of small Git commits
- [x] Your commit messages are meaningful
- [x] You made the changes in a commit that relate to the commit message
  - Some commits were larger than they should have been due to being forgetful about committing in a timely manner.
- [x] You don't include changes in a commit that aren't related to the commit message
  - This is mostly true, although sometimes I forgot to commit for each change.
