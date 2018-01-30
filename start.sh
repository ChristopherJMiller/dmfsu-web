#!/bin/sh
rails assets:precompile
rake db:migrate
puma -C config/puma.rb