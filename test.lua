-- Konfiguration
local tunnelLength = 50  -- Länge des Tunnels

-- Hilfsfunktionen
local function refuel()
  turtle.turnLeft()
  turtle.turnLeft()
  turtle.forward()
  turtle.turnRight()
  turtle.select(1)
  turtle.suckDown(64)  -- Nimm bis zu einem Stack Kohle
  turtle.turnLeft()
  turtle.back()
  turtle.turnLeft()
  turtle.turnLeft()
  
  if turtle.getItemCount(1) > 0 then
    turtle.refuel(64)
    return true
  end
  return false
end

local function depositItems()
  turtle.turnLeft()
  turtle.turnLeft()
  turtle.forward()
  for i = 1, 16 do
    turtle.select(i)
    turtle.drop()  -- In die Doppelkiste ablegen
  end
  turtle.back()
  turtle.turnLeft()
  turtle.turnLeft()
end

-- Hauptfunktion zum Graben
local function dig3x3()
  turtle.digUp()
  turtle.digDown()
  turtle.dig()
  turtle.forward()
  turtle.turnLeft()
  turtle.dig()
  turtle.turnRight()
  turtle.turnRight()
  turtle.dig()
  turtle.turnLeft()
end

-- Inventar-Check
local function inventoryFull()
  for i = 1, 16 do
    if turtle.getItemCount(i) == 0 then
      return false
    end
  end
  return true
end

-- Hauptprogramm
print("Starte 3x3 Tunnelbau")

if not refuel() then
  print("Keine Kohle in der unteren Kiste!")
  return
end

for i = 1, tunnelLength do
  dig3x3()
  
  if inventoryFull() then
    print("Inventar voll. Kehre zurück zum Ablegen.")
    turtle.turnLeft()
    turtle.turnLeft()
    for j = 1, i do
      turtle.forward()
    end
    depositItems()
    for j = 1, i do
      turtle.forward()
    end
    turtle.turnLeft()
    turtle.turnLeft()
  end
  
  if turtle.getFuelLevel() < 100 then
    if not refuel() then
      print("Treibstoff geht zur Neige!")
      break
    end
  end
end

print("Kehre zum Startpunkt zurück")

turtle.turnLeft()
turtle.turnLeft()

for i = 1, tunnelLength do
  turtle.forward()
end

print("Lege Items in der Kiste ab")
depositItems()

print("Tunnelbau abgeschlossen!")
