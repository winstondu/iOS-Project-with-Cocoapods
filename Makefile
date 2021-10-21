ROOT_DIR:=$(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))

system-install:
	sudo gem install bundler

install:
	bundle install
	bundle exec pod install