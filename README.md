# Paste

A simple (and tiny) Pastie clone written on Sinatra with DataMapper. 
Originally created by Nick Plante with contributions from Dave Everitt.
See original project at https://github.com/zapnap/toopaste

This Pastie app was written to fill a need for a secure, internal paste service
in the enterprise.  This like GitHub Gist and Paste Bin are not appropriate
for sensitive information, logs, etc.

It currently stores data in Sqlite with future plans to support MySQL.

## Installation

Clone this repo:
`git clone https://github.com/drewblessing/paste.git`

Change to the paste directory
`cd paste`

Install bundler if you don't already have it
`gem install bundler`

Install paste
`bundle install`

Run paste
`ruby paste.rb`

Open in your browser at localhost:4567

## More robust installations

I would recommend using something like Unicorn to run Paste in a more robust manner. 
Passenger is another option.  

## Technologies at use in Paste

* Sinatra
* Sqlite
* Twitter Bootstrap
* Highlight.js
