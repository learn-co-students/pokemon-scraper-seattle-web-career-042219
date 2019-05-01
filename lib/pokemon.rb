class Pokemon
  attr_accessor :name, :type, :db, :hp
  attr_reader :id

  @@all = []

  def initialize(name:, type:, id:, db:)
    @id = id
    @db = db
    @name = name
    @type = type
    #@hp = 60
    @@all << self
  end

  def self.save(name, type, db)
    sql = <<-SQL
      INSERT INTO pokemon (name, type)
      VALUES (?, ?);
    SQL
    db.execute(sql, name, type)
  end

  def self.find(id, db)
    sql = "SELECT * FROM pokemon WHERE pokemon.id = #{id};"
    array = db.execute(sql).flatten
    self.new(id:array[0], name:array[1], type:array[2], db:db)
  end

  #def alter_hp(hp, db)
    #sql = "UPDATE pokemon SET pokemon.hp=#{hp} WHERE pokemon.id =#{self.id}"

 #db.execute(sql)
  #end

end
