# Paste

A simple (and tiny) Pastie clone written on Sinatra with DataMapper. 
Originally created by Nick Plante with contributions from Dave Everitt.
See original project at https://github.com/zapnap/toopaste

This Pastie app was written to fill a need for a secure, internal paste service
in the enterprise.  Services like GitHub Gist and Paste Bin are not appropriate
for sensitive information, logs, etc.

It currently stores data in Sqlite with future plans to support MySQL.

## Demo

You can see a demo at [http://paste.drewblessing.com:8080/](http://paste.drewblessing.com:8080/)

NOTE: Date is purged every 10 minutes.  This is not meant to be used as a public service for real
pastes - it's a demo only.  Also, I do not monitor this service to make sure it's up.  If you 
find that you cannot access the demo please let me know - @drewblessing on Twitter.

## Installation

Install a few packages.  You'll need ruby-devel, make, gcc, gcc-c++, kernel-devel 
and sqlite-devel or the gem installations below will fail.

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
