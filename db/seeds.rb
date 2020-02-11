require_relative('../models/animal.rb')
require_relative('../models/owner.rb')
require('pry')

Animal.delete_all()
Owner.delete_all()

animal1 = Animal.new({
  'name' => 'Sooty',
  'type' => 'Cat',
  'species' => 'British Shorthair',
  'admission_date' => '01/02/2020'
  })

animal2 = Animal.new({
  'name' => 'Chewie',
  'type' => 'Dog',
  'species' => 'West Highland Terrier',
  'admission_date' => '28/02/2020'
  })

animal1.save()
animal2.save()

owner1 = Owner.new({
  'name' => 'Nathan Langridge',
  'animal_id' => animal1.id
  })

owner2 = Owner.new({
  'name' => 'Daniel Langridge',
  'animal_id' => animal2.id
  })

owner1.save()
owner2.save()

binding.pry
nil
