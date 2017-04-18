# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first) 
require 'csv'
Spot.destroy_all
ParkIt.destroy_all
User.destroy_all
puts "done throwing everything in the trash can"

emails = [["mengzhou.li@gmail.com", "meng"],
	["mengzhouli@gmail.com", "mz"],
	["vonture@gmail.com", "vonture"],
	["geoff@vonture.net", "geoff"],
	["ashraf.caspian@gmail.com", "ashraf"],
	["d.alibran@gmail.com", "dana"],
	["dana.alibran@gmail.com", "dan"],
	["dalibran@gmail.com", "dana69"],
	["montreal@lewagon.org", "mtl"],
	["mg.ayoub@lewagon.org", "mg"],
	["antoine.ayoub@lewagon.org", "antoine"]]


emails.each do |sub|
	User.create!(email: sub[0], password: "pppassword", password_confirmation: "pppassword", username: sub[1] )
end

byebug

filepath    = 'db/places.csv'
csv_options = { col_sep: ',', headers: true, row_sep: :auto, encoding:'iso-8859-1:utf-8' }
CSV.foreach(filepath, csv_options) do |row|
	pay = ""

	if row["sTypeExploitation"].nil?
		pay = "reg" 
	elsif row["sTypeExploitation"].include? "Parcojour"
		pay = "day"
	else
		pay ="reg"
	end

	rate = ""
	if row["nTarifMax"].blank?
		rate = nil
	else
		rate = row["nTarifMax"].to_i
	end

	avail = ""
	if row["nSupVelo"].to_i.zero?
		avail = "none"
	else
		avail = "available"
	end

	Spot.create!(place_no: row["sNoPlace"],
		lat: row["nPositionCentreLatitude"],
		lng: row["nPositionCentreLongitude"],
		kind: row["sGenre"],
		bike_head: row["nSupVelo"].to_i,
		pay_type: pay,
		hour_rate: row["nTarifHoraire"].to_i,
		max_rate: rate,
		status: "taken",
		bike_head_status: avail
		)
end