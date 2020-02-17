require_relative('../db/sql_runner.rb')

class Animal

  attr_reader :id
  attr_accessor :name, :type, :species, :admission_date, :available, :image_url

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @type = options['type']
    @species = options['species']
    @admission_date = options['admission_date']
    @available = options['available']
    @image_url = options['image_url']
  end

  def save()
    sql = "INSERT INTO animals(name, type, species, admission_date, available, image_url)
    VALUES($1, $2, $3, $4, $5, $6)
    RETURNING id"
    values = [@name, @type, @species, @admission_date, @available, @image_url]
    result = SqlRunner.run(sql, values)
    id = result.first['id']
    @id = id
  end

  def update()
    sql = "UPDATE animals SET (name, type, species, admission_date, available, image_url)
    = ($1, $2, $3, $4, $5, $6)
    WHERE id = $7"
    values = [@name, @type, @species, @admission_date, @available, @image_url, @id]
    SqlRunner.run(sql, values)
  end

  def delete()
    sql = "DELETE FROM animals WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def owners()
    sql = "SELECT * FROM owners WHERE animal_id = $1"
    values = [@id]
    owners = SqlRunner.run(sql, values)
    result = owners.map { |owner| Owner.new(owner) }
    return result
  end

  def self.delete_all()
    sql = "DELETE FROM animals"
    SqlRunner.run(sql)
  end

  def self.all()
    sql = "SELECT * FROM animals"
    animal = SqlRunner.run(sql)
    return Animal.map_items(animal)
  end

  def self.map_items(animal)
    result = animal.map { |animal| Animal.new(animal) }
    return result
  end

  def self.find(id)
    sql = "SELECT * FROM animals WHERE id = $1"
    values = [id]
    result = SqlRunner.run(sql, values)
    animal = self.new(result.first)
    return animal
  end

end
