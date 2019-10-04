#!/bin/sh

export JWT_SIGNING_SECRET=`cat $JWT_SIGNING_SECRET_FILE`

bundle exec rails db:create
bundle exec rails db:migrate
bundle exec rails server -b "0.0.0.0"
