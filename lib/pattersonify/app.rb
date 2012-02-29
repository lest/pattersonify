require 'bundler/setup'
require 'sinatra/base'
require 'slim'
require 'dragonfly'
require 'face'

$:.unshift File.expand_path('../..', __FILE__)
require 'pattersonify'

module Pattersonify
  class App < Sinatra::Base
    set :root, File.expand_path('../../..', __FILE__)

    Dragonfly[:images].configure_with(:imagemagick) do |c|
      c.url_format = '/media/:job'
      c.allow_fetch_url = true
      c.protect_from_dos_attacks = true
      c.secret = settings.session_secret
      c.log_commands = true
      c.log = Logger.new($stdout)
    end

    Dragonfly[:images].processor.register(Processor)

    use Dragonfly::Middleware, :images

    set :face_client, Face.get_client(:api_key => ENV['FACE_API_KEY'],
                                      :api_secret => ENV['FACE_API_SECRET'])

    get '/' do
      if params[:url]
        @image = Dragonfly[:images].fetch_url(params[:url]).process(:pattersonify)
      end
      slim :index
    end
  end
end
