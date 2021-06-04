#!/usr/bin/env zsh

export NVM_DIR=$HOME/.nvm;
source $NVM_DIR/nvm.sh;

if systemctl status redis.service &> /dev/null
then
   echo "✅ redis is running";
else
   echo "❌ redis isn't running, start it to continue";
fi

if systemctl status postgresql.service &> /dev/null
then
   echo "✅ postgresql is running";
else
   echo "❌ postgresql isn't running, start it to continue";
fi

fb="/home/peter/projects/department-for-education/current/govuk-design-system-formbuilder"
target="/tmp/apply"

echo '🧹 tidying up previous runs...'
rm -rf $target

echo '🧳 cloning apply-for-teacher-training...'
git clone git@github.com:DFE-Digital/apply-for-teacher-training.git $target

echo '🔧 switching to local gem'
ambr --skip-gitignore=true --no-interactive --regex "gem 'govuk_design_system_formbuilder', '~> \d+\.\d+\.\d+'" "gem 'govuk_design_system_formbuilder', path: '$fb'" $target/Gemfile

echo '🏗️ setting up prerequisites'
( cd $target ; bundle install )
( cd $target ; RAILS_ENV=test bundle exec rails db:{drop,setup})
( cd $target ; nvm use 12.18.0 && yarn)
( cd $target ; bin/webpack)
echo '🤖 finally running the tests'
( cd $target ; RAILS_ENV=test bundle exec rspec)
