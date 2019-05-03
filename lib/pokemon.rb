require "pry"

class Pokemon

  attr_accessor :name, :type, :db, :hp
  attr_reader :id

  @@all = []

  def initialize(name:, type:, id:, db:)
    @name = name
    @type = type
    @id = id
    @db = db
    @hp = hp
    @@all << self
  end

  def self.save(name, type, db)
    sql = <<-SQL
    INSERT INTO pokemon (name, type)
    VALUES (?, ?)
    SQL
    db.execute(sql, name, type)
  end

  def self.find (id, db)

    sql = <<-SQL
    SELECT *
    FROM pokemon
    WHERE id = ?;
    SQL
    db.execute(sql, id)

    arr = db.execute(sql, id).flatten
    if arr.length == 3
      self.new(id: arr[0], name: arr[1], type: arr[2], db: db)
    else
      self.new(id: arr[0], name: arr[1], type: arr[2], db: db, hp: arr[3])
    end
    # array = db.execute(sql, id)
    # new_id = array[0][0]
    # new_name = array[0][1]
    # new_type = array[0][2]
    #
    # newinstance = Pokemon.new(id:new_id,name:new_name,type:new_type)
    # newinstance
  end

  # def alter_hp(hp, db)
  #   sql = <<-SQL
  #     UPDATE pokemon SET hp = ? WHERE id = ?
  #   SQL
  #
  #   db.execute(sql, hp, self.id)
  #   self.hp = hp
  # end

end
