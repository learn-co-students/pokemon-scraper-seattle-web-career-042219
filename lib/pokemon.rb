
class Pokemon
  attr_accessor :name, :type
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


end
