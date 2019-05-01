require 'pry'

class Pokemon

attr_accessor :name, :type, :id, :db

def initialize(name:, type:, id:, db:)
  @name = name
  @type = type
  @id = id
  @db = db
end

def self.save(name, type, db)
  db.execute "INSERT INTO pokemon(name, type) values(?, ?)",[name, type]
end

def self.find(id, db)
  new_array = db.execute "SELECT id, name, type FROM pokemon WHERE id = #{id}"
  new_array = new_array.flatten
  new_hash = {:name => new_array[1], :type => new_array[2], :id => new_array[0], :db => db}
  Pokemon.new(new_hash)
end

end
