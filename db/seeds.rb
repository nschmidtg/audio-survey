# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


require 'aws-sdk-s3'

c = Aws::S3::Client.new(
  access_key_id: ENV['access_key_id'],
  secret_access_key: ENV['secret_access_key']
)

songs_count = 0
users = []
c.list_objects_v2(bucket: 'audio-survey').contents.select{ |x| x.size > 0}.each do |x|
  email_obj = x.key.split("/")
  u = User.find_or_create_by(email: email_obj[0])
  users << u
  s = Song.new()
  s.url = "https://audio-survey.s3.eu-west-3.amazonaws.com/#{x.key}"
  s.compleated = false
  s.user = u
  s.save(validate: false)
  songs_count += 1
end
users.each do |u|
  puts "#{u.email}, #{u.token}"
end
puts "songs created: #{songs_count}"
