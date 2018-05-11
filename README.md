# TA2 Mock GRPC server

I made a Mock GPRC server based on the [TA2-TA3 API](https://gitlab.com/datadrivendiscovery/ta3ta2-api).

## OSX Dev Setup (From Scratch)

### Install Homebrew
```sh
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
```
Note: if homebrew is already install, run `brew update`

### Install rbenv and ruby-build
```sh
brew install rbenv ruby-build
```
Run `rbenv init` and follow instructions for updating your PATH

### Install Ruby 2.4.2 and set global ruby
```sh
rbenv install 2.4.2
rbenv global 2.4.2
rbenv version
```

### Clone this repo
```sh
git clone git@github.com:uwgraphics/mock-ta2.git
cd mock-ta2
```

### Install Bundler and Bundle
```sh
gem install bundler
bundle
```

### Start the server

```sh
bundle exec gruf
```

## Notes

The port is set in `config/initializers/gruf.rb` if you need to change it.

The magic happens in `app/rpc/core_controller.rb`. 
