require 'bundler/setup'
require 'sinatra/base'
require 'slim'

module Pattersonify
  class App < Sinatra::Base
    get '/' do
      slim :index
    end
  end
end
