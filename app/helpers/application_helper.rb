module ApplicationHelper
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
    if user.points.between?(500, 999)
      users_badges.push("car")
    elsif user.points.between?(1000, 1499)
      users_badges.push("star")
    elsif user.points.between?(1500, 1999)
      users_badges.push("trophy")
    elsif user.points >= 2000
      users_badges.push("rocket")
    elsif user.parkits.count == 0
      users_badges.push("fire")
    end
    users_badges
  end

# matching description for badge
  def award_description(user)
    if user.points.between?(500, 999)
      "A car is more than just a vehicle. You have earned this one!"
    elsif user.points.between?(1000, 1499)
      "Generosity is giving more than you can and pride is taking less than you need!"
    elsif user.points.between?(1500, 1999)
      "Trophies evoke emotions of victory. You are victorious!"
    elsif user.points >= 2000
      "Because you rock... like a rocket. And as such, you are out of this world!"
    elsif user.parkits.count == 0
      "Come on, now. Help us out!"
    end
  end
end
