class Pokemon
	attr_accessor :id, :name, :type, :hp, :db

	def initialize(atts)
		atts.each {|key, value| self.send(("#{key}="), value)}
	end

	def alter_hp(new_hp, db)
		sql = <<-SQL 
		UPDATE pokemon 
		SET hp = ?
		SQL

		db.execute(sql, new_hp)
	end

	def self.save(name, type, db)
		sql = <<-SQL 
		INSERT INTO pokemon (name, type) 
		VALUES (?, ?) 
		SQL

		db.execute(sql, name, type)
	end

	def self.find(id, db)

		sql = <<-SQL 
		SELECT *
		FROM pokemon
		WHERE id=?
		SQL
		poke = db.execute(sql, id)
		f_poke = Pokemon.new({id: poke[0][0], name: poke[0][1], type:poke[0][2], hp:poke[0][3]})
	end
end
