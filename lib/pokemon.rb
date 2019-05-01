require "pry"

class Pokemon

    attr_accessor :id, :name, :type, :db

    def initialize(id:, name:, type:, db:)
        @id = id
        @name = name
        @type = type
        @db = db
    end

    def self.save(name, type, db)
        # binding.pry
        sql = <<-SQL
            INSERT INTO pokemon (name, type)
            VALUES (?, ?)
        SQL
        db.execute(sql, name, type)
    end

    def self.find(id, db)
        # binding.pry
        sql = <<-SQL
            SELECT id,name,type FROM Pokemon
            WHERE Pokemon.id = ?
        SQL
        new_array = db.execute(sql, id).flatten.push(db)
        hash = {:id => new_array[0], :name => new_array[1], :type => new_array[2], :db => new_array[3]}
        Pokemon.new(hash)
    end

end
