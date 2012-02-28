require 'bundler/setup'
require 'sinatra/base'
require 'slim'

module Pattersonify
  class App < Sinatra::Base
    set :root, File.expand_path('../../..', __FILE__)

    get '/' do
      slim :index
    end
  end
end
