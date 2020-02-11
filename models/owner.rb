require_relative('../db/sql_runner.rb')

class Owner

  attr_reader :id
  attr_accessor :name, :animal_id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @animal_id = options['animal_id'].to_i
  end

  def save()
    sql = "INSERT INTO owners (name, animal_id)
    VALUES($1, $2)
    RETURNING id"
    values = [@name, @animal_id]
    result = SqlRunner.run(sql, values)
    id = result.first['id']
    @id = id
  end

  def update()
    sql = "UPDATE owners SET (name, animal_id)
    = ($1, $2)
    WHERE id = $3"
    values = [@name, @animal_id, @id]
    SqlRunner.run(sql, values)
  end

  def delete()
    sql = "DELETE FROM owners WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def animals()
    sql = "SELECT * FROM animals WHERE id = $1"
    values = [@animal_id]
    animals = SqlRunner.run(sql, values)
    result = animals.map { |animal| Animal.new(animal) }
    return result
  end

  def self.delete_all()
    sql = "DELETE FROM owners"
    SqlRunner.run(sql)
  end

  def self.all()
    sql = "SELECT * FROM owners"
    owner = SqlRunner.run(sql)
    return Owner.map_items(owner)
  end

  def self.map_items(owner)
    result = owner.map { |owner| Owner.new(owner) }
    return result
  end

  def self.find(id)
    sql = "SELECT * FROM owners WHERE id = $1"
    values = [id]
    result = SqlRunner.run(sql, values)
    owner = self.new(result.first)
    return owner
  end

end
