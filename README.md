####**Welcome to Post It!**

Post It is a Reddit-style forum built from scratch during the 2nd course of [Tealeaf Academy](http://gotealeaf.com), Rapid Prototyping with Ruby on Rails.


Features:

    *Built with Ruby 2 and Rails 4
    *Create and edit posts
    *Organize posts by category
    *View and edit user profiles
    *Authentication
    *Comment and vote on posts
    *Tracks who created every comment, vote, and post
    *Uses roles to allow admins to edit all posts
    *Display time based on user specified time zone
    *Uses ajax to vote
    *Slugs as URLs
    *Uses gems to extract common logic
    *Deployed to Heroku
    *2-factor authentication
      --2-factor is considered turned-on if user provided phone number.


Twilio Integration:
    
    Remove config/twilio.yml from .gitignore
    Enter your twilio credentials in config/twilio.yml
      If left blank and 2-factor authentication is turned on, 
      the user will be prompted to contact an administrator.


_The application can be found here:_ https://gems-postit.herokuapp.com/
