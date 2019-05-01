class Pokemon

  attr_accessor :name, :type, :id, :db, :hp

  def initialize(id:, name:, type:, db:, hp: nil)
    @name = name
    @type = type
    @id = id
    @db = db
    @hp = hp
  end

  def self.save(name, type, db)
    sql = <<-SQL
      INSERT INTO pokemon (name, type) VALUES (?,?)
    SQL
    db.execute(sql, name, type)
  end

  def self.find(id, db)
    sql = <<-SQL
      SELECT * FROM pokemon WHERE id = ?
    SQL
    arr = db.execute(sql, id).flatten
    if arr.length == 3
      self.new(id: arr[0], name: arr[1], type: arr[2], db: db)
    else
      self.new(id: arr[0], name: arr[1], type: arr[2], db: db, hp: arr[3])
    end 
  end

  def alter_hp(hp, db)
    sql = <<-SQL
      UPDATE pokemon SET hp = ? WHERE id = ?
    SQL
    #binding.pry
    db.execute(sql, hp, self.id)
    self.hp = hp
    #binding.pry
  end

end
