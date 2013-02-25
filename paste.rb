#!/usr/local/bin/ruby -rubygems

require 'sinatra'
require 'dm-core'
require 'dm-validations'
require 'dm-timestamps'
require 'dm-migrations'

DataMapper.setup(:default, "sqlite3://#{Dir.pwd}/paste.sqlite3")
 
configure do
  set :public_folder, Proc.new { File.join(root, "static") }
end

class Snippet
  include DataMapper::Resource

  property :id,         Serial # primary serial key
  property :title,      String, :required => true, :length => 32
  property :body,       Text,   :required => true
  property :lang,       String, :length => 12
  property :created_at, DateTime
  property :updated_at, DateTime

  # validates_present :body
  # validates_length :body, :minimum => 1

end

DataMapper.auto_upgrade!

# new
get '/' do
  erb :new
end

# create
post '/' do
  @snippet = Snippet.new(:title => params[:snippet_title],
                         :body  => params[:snippet_body])
  if @snippet.save
    redirect "/#{@snippet.id}"
  else
    erb :new
  end
end

# show
get '/:id' do
  @snippet = Snippet.get(params[:id])
  if @snippet
    erb :show
  else
    @error = "Sorry. That snippet does not exist."
    erb :new 
  end
end

# show w/ specific language
post '/:id' do
  @snippet = Snippet.get(params[:id])
  @lang = params[:lang]
  save = params[:save] == 'true' ? true : false
  if @snippet
    result = @snippet.update(:lang => params[:lang]) if save
    if !result && save
      @error = "Sorry. Could not save the snippet language."
    elsif save 
      @success = "Success! The snippet was saved."
    end
    erb :show
  else
    @error = "Sorry. That snippet does not exist."
    erb :new 
  end
end

# delete
get '/delete/:id' do
  @snippet = Snippet.get(params[:id])
  if @snippet
    result = @snippet.destroy
    if result
      @success = "Success! Snippet #{@snippet.id} has been deleted."
    else
      @error = "Sorry.  The snippet could not be deleted." 
    end
  else
    @error = "Sorry. That snippet does not exist."
  end
  erb :new
end
