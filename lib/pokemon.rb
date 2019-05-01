class Pokemon

    attr_accessor :id, :name, :type, :db, :hp

    # def initialize(keywords)
    #     @id=keywords[:id]
    #     @name=keywords[:name]
    #     @type=keywords[:type]
    #     @db=keywords[:db]
    #     @hp=keywords[:hp]
    # end

    def initialize(id:, name:, type:, db:, hp: nil)
        @id = id
        @name = name
        @type = type
        @db = db
        @hp = hp
    end

    def self.save(name, type, db)
        # db.execute("INSERT INTO pokemon (name, type) VALUES (?, ?)", name, type)
        sql = <<-SQL 
            INSERT INTO pokemon (name, type)
            VALUES (?, ?)
        SQL
        db.execute(sql, name, type)
    end

    def self.find(id, db)
        # new_pokemon = db.execute("SELECT * FROM pokemon WHERE id=?", id)
        # Pokemon.new(id: new_pokemon[0][0], name: new_pokemon[0][1], type: new_pokemon[0][2], hp: new_pokemon[0][3])

        # or via heredoc
        # sql = <<-SQL 
        #     SELECT * FROM pokemon
        #     WHERE id=?
        # SQL
        # response = db.execute(sql, id)
        # Pokemon.new(id: response[0][0], name: response[0][1], type: response[0][2], hp: response[0][3])

        # or via heredoc and .flatten
        sql = <<-SQL 
            SELECT * FROM pokemon
            WHERE id=?
        SQL
        response = db.execute(sql, id).flatten
        Pokemon.new(id: response[0], name: response[1], type: response[2], hp: response[3], db: db)
    end

    def alter_hp(hp, db)
        db.execute("UPDATE pokemon SET hp= ? WHERE id=? ", hp, self.id)
    end
end
