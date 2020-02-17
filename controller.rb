require('sinatra')
require('sinatra/contrib/all')
require('pry-byebug')

require_relative('./models/animal.rb')
require_relative('./models/owner.rb')
also_reload('./models/*')

get '/' do
  erb(:welcome)
end

get '/manager' do
  erb(:"manager/index")
end

#MANAGE ANIMALS

get '/manager/animals' do
  @animals = Animal.all()
  erb(:"manager/index_animals")
end

get '/manager/animals/:id' do
  @animal = Animal.find(params[:id])
  @owners = @animal.owners
  erb(:"manager/show_animals")
end

get '/manager/animal/new' do
  erb(:"manager/new_animal")
end

post '/manager/animal/new' do
  @animal = Animal.new(params)
  @animal.save()
  erb(:"manager/create_animal")
end

post '/manager/animal/:id/edit' do
  @animal = Animal.find(params[:id])
  erb(:"manager/edit_animal")
end

post '/manager/animal/:id' do
  Animal.new(params).update()
  redirect to '/manager/animals'
end

post '/manager/animal/:id/delete' do
  animal = Animal.find(params[:id])
  animal.delete()
  redirect to '/manager/animals'
end

#MANAGE OWNERS

get '/manager/owners' do
  @owners = Owner.all()
  erb(:"manager/index_owners")
end

get '/manager/owners/:id' do
  @owner = Owner.find(params[:id])
  @animals = @owner.animals
  erb(:"manager/show_owners")
end

get '/manager/owner/new' do
    @animals = Animal.all()
  erb(:"manager/new_owner")
end

post '/manager/owner/new' do
  @owner = Owner.new(params)
  @owner.save()
  erb(:"manager/create_owner")
end

get '/manager/owner/:id/edit' do
  @owner = Owner.find(params[:id])
  @animals = Animal.all()
  erb(:"manager/edit_owner")
end

post '/manager/owner/:id' do
  Owner.new(params).update()
  redirect to '/manager/owners'
end

post '/manager/owner/:id/delete' do
  owner = Owner.find(params[:id])
  owner.delete()
  redirect to '/manager/owners'
end

#ANIMALS

get '/animals' do
  @animals = Animal.all()
  erb(:index_animals)
end

get '/animals/:id' do
  @animal = Animal.find(params[:id])
  @owners = @animal.owners
  erb(:show_animals)
end

#OWNERS

get '/owners' do
  @owners = Owner.all()
  @animals = Animal.all()
  erb(:index_owners)
end

get '/owners/:id' do
  @owner = Owner.find(params[:id])
  @animals = @owner.animals()
  erb(:show_owners)
end
