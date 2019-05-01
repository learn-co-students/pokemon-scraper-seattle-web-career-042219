
require 'pry'
class Pokemon
  attr_accessor :name, :type, :hp
  attr_reader :db, :id

  @@all= []

  def initialize(id:, name:, type:, db:)
    @id = id
    @name = name
    @type = type
    @db = db
    @@all<< self
  end

  def self.save(name, type, db)
    sql = <<-SQL
    INSERT INTO pokemon (name, type)
    VALUES(?,?)
    SQL
    db.execute(sql, name, type)
  end

  def self.find(id, db)
    sql = "SELECT * FROM pokemon WHERE pokemon.id = #{id}"
    array = db.execute(sql).flatten
    self.new(id:array[0], name:array[1], type:array[2], db:db)
end

def alter_hp(new_hp, db)

  sql = "UPDATE pokemon SET hp=#{new_hp} WHERE pokemon.id =#{self.id}"

  db.execute(sql)

end
end
0
