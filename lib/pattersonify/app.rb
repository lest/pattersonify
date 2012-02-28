require 'bundler/setup'
require 'sinatra/base'
require 'slim'
require 'dragonfly'

module Pattersonify
  class App < Sinatra::Base
    set :root, File.expand_path('../../..', __FILE__)

    Dragonfly[:images].configure_with(:imagemagick) do |c|
      c.url_format = '/media/:job'
      c.allow_fetch_url = true
      c.protect_from_dos_attacks = true
      c.secret = settings.session_secret
    end

    use Dragonfly::Middleware, :images

    get '/' do
      slim :index
    end
  end
end
