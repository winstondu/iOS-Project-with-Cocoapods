ROOT_DIR:=$(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))

system-install:
	sudo gem install bundler
	brew install mint ## For developer tools

install:
	mint bootstrap
	bundle install
	bundle exec pod install

fmt:
	mint run nicklockwood/SwiftFormat .

fmt-check:
	mint run nicklockwood/SwiftFormat . --lint --verbose
