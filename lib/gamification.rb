#takes user's current points and assigns them a title
def titles(user)
  if user.points.between?(1, 500)
    "Heating Up!"
  elsif user.points.between?(501, 1000)
    "Helping the Fam Find Those Parking Spots"
  elsif user.points.between?(1001, 1500)
    "Going Above and Beyond"
  elsif user.points.between?(1501, 2000)
    "Single-Handedly Changing the Game"
  elsif user.points > 2000
    "Community Hero"
  end
end

#assigns badges based on score + user activity
#doesn't work completely, needs refactoring
def badges(user)
  badges = ["trophy", "map-pin", "signpost", "bullhorn", "map-icon", "cancel", "steering-wheel", "car", "fire", "star", "cash", "check", "rocket"]
  users_badges = []
  if user.points > 2000
    users_badges.push("rocket")
  elsif user.parkits.count == 0
    users_badges.push("fire")
  end
  users_badges
end
