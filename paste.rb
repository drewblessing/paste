#!/usr/local/bin/ruby -rubygems

require 'sinatra'
require 'dm-core'
require 'dm-validations'
require 'dm-timestamps'
require 'dm-migrations'
require 'htmlentities'

DataMapper.setup(:default, "sqlite3://#{Dir.pwd}/paste.sqlite3")
 
configure do
  set :public_folder, Proc.new { File.join(root, "static") }
end

class Snippet
  include DataMapper::Resource

  property :id,         Serial # primary serial key
  property :title,      String, :required => true, :length => 64 
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
  erb :edit
end

# create/update
post '/' do
  title = HTMLEntities.new.encode params[:snippet_title]
  body = HTMLEntities.new.encode params[:snippet_body]

  @error = "Title must be 64 characters or less." if title.length > 64
  
  if !@error
    if params[:id].nil? || params[:id] == ""
      @snippet = Snippet.new(:title => title,:body  => body)
      result = @snippet.save
    else 
      @snippet = Snippet.get(params[:id])
      result = @snippet.update(:title => title, :body => body)
    end
  end

  if result
    redirect "/#{@snippet.id}"
  else
    erb :edit
  end
end

# show
get '/:id' do
  @snippet = Snippet.get(params[:id])
  if @snippet
    erb :show
  else
    @error = "Sorry. That snippet does not exist."
    erb :edit 
  end
end

# show/save with specific language
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
    erb :edit 
  end
end

# show raw
get '/raw/:id' do 
  @snippet = Snippet.get(params[:id])
  if @snippet
    erb :show_raw, :layout => false
  else
    @error = "Sorry. That snippet does not exist."
    erb :edit
  end
end

# edit
get '/edit/:id' do
  @snippet = Snippet.get(params[:id])
  if !@snippet
    @error = "Sorry. That snippet does not exist."
  end
  erb :edit
end

# delete
get '/delete/:id' do
  @snippet = Snippet.get(params[:id])
  if @snippet
    result = @snippet.destroy
    if result
      @success = "Success! Snippet #{@snippet.id} has been deleted."
      @snippet = nil
    else
      @error = "Sorry.  The snippet could not be deleted." 
    end
  else
    @error = "Sorry. That snippet does not exist."
  end
  erb :edit
end
