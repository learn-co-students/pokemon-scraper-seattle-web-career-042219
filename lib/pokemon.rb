class Pokemon
 attr_accessor :id, :name, :type, :db

 def initialize(args)
   args.each do |k,v|
     instance_variable_set("@#{k}", v) unless v.nil?
   end
 end


 def self.save(pokemon_name, pokemon_type, db)
  # binding.pry
  sql = "INSERT INTO pokemon (name, type)
     VALUES (?, ?);"
   db.execute(sql, pokemon_name, pokemon_type)
 end

 def self.find(id, db)
   sql = "SELECT * FROM pokemon WHERE pokemon.id = #{id};"
   # binding.pry
   info = db.execute(sql).first
   Pokemon.new({:id => info[0], :name => info[1], :type => info[2] })
   # db.map {|id| self.new(id)}
 end


end
