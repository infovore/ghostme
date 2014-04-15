# ghostme

You, but living in a different place.

Not really design for public consumption: it's a fairly straight Rails app designed for Heroku deployment (so it uses `foreman` for local work). You'll need to set up some environment variables with your Foursquare creds in.

It also expects a running Redis server, for Heroku.

## Dumb notes that I always forget

Scheduling a checkin will just fail if the time it's due to be scheduled at is in the past.


## Long running tasks

`rake ghostme:ingest_all` - about once an hour  
`rake ghostme:repost_checkins` - about once every ten minutes
