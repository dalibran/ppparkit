# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'csv'
Spot.destroy_all
User.destroy_all
ParkIt.destroy_all
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
	User.create!(email: sub[0], password: "pppassword", password_confirmation: "pppassword", username: sub[1], points: 0)
end

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
		latitude: row["nPositionCentreLatitude"],
		longitude: row["nPositionCentreLongitude"],
		kind: row["sGenre"],
		bike_head: row["nSupVelo"].to_i,
		pay_type: pay,
		hour_rate: row["nTarifHoraire"].to_i,
		max_rate: rate,
		status: "taken",
		bike_head_status: avail
		)
end

kinds = ["park", "leave", "see"]
times = [Time.now - 1.hour, Time.now, Time.now + 1. hour, Time.now + 2.hours, Time.now + 3.hours]

def calc_points(kind, time)
	if kind == "park" || kind == "see"
		return 100
	elsif (time - Time.now)/60 > 120 # if expiration time is more than 120 minutes (2 hours) from now
		return 800
	elsif (time - Time.now)/60 < 30 # if expiration time is less than 30 min
		return 200
	else # time left is somewhere between 30 minutes and 3 hours
		return 400
	end
end

i = 1
100.times do
	one = ParkIt.create!(kind: "park", paid_until: times.sample, points: 100, user: User.find(1), spot: Spot.find(i))
	one.user.points += one.points # update user points
	one.user.save! # save user points
	one.spot.update!(status: "taken")
	i += 1
end

j = 1000
100.times do
	one = ParkIt.create!(kind: "see", points: 100, user: User.find(3), spot: Spot.find(j))
	one.user.points += one.points # update user points
	one.user.save! # save user points
	one.spot.update!(status: "avail")
	i += 1
end


k = 2000
100.times do
	one = ParkIt.create!(kind: "leave", paid_until: times.sample, user: User.find(6), spot: Spot.find(k))
	new_p = calc_points(one.kind, one.paid_until)
	one.update!(points: new_p) # find point as funciton of kind and time
	one.user.points += one.points # update user points
	one.user.save! # save user points
	one.spot.update!(status: "avail")
	i += 1
end
