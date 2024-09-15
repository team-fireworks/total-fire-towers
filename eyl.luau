local DISTANCE_LOW = 2
local DISTANCE_HIGH = 5
local PACE_LOW = 7
local PACE_HIGH = 10

for _ = 1, 4 do
  local distance = math.random(DISTANCE_LOW * 100, DISTANCE_HIGH * 100) / 100
  local pace = math.random(PACE_LOW * 100, PACE_HIGH * 100) / 100
  local time = distance / pace * 60 * math.random(8, 12) / 10

  print("Used Matrix stationary bike")
  print(`{distance}km`, "distance")
  print("Pace", `{pace}km/h`)
  print(time)
  print()
end
