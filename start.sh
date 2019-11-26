#!/bin/sh
set +x

export PGPASSWORD=`cat $PGPASSWORD_FILE`
export JWT_SIGNING_SECRET=`cat $JWT_SIGNING_SECRET_FILE`
export SMTP_PASSWORD=`cat $SMTP_PASSWORD_FILE`

bundle exec rails db:create
bundle exec rails db:migrate
bundle exec rails server -b "0.0.0.0"
