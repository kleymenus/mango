require 'mongo'

@con = Mongo::Connection.new
@db = @con['tutorial']
@users = @db['users']

smith = {"last_name" => "smith", "age" => 30}
jones = {"last_name" => "jones", "age" => 40}

smith_id = @users.insert(smith)
jones_id = @users.insert(jones)

puts "Smith ID: #{smith_id}"
puts "Jones ID #{jones_id}"



puts @users.find_one({"_id" => smith_id})
puts @users.find({"last_name" => "smith" })
puts @users.find({"age" => {"$gt" => 20}})

cursor = @users.find({"age" => {"$gt" => 20}})

cursor.each do |doc|
  puts doc["last_name"]
end
