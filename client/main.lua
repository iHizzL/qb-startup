local QBCore = exports['qb-core']:GetCoreObject()
local carryPackage = nil
local packageCoords = nil
local onDuty = false

-- zone check


-- job info

jobLevel = 1
erfaring = 1
onJob = false
hasPackage = false

bossAlive = false
bossKilled = false


isInside = false

local entranceTargetID = 'entranceTarget'
local isInsideEntranceZone = false
local entranceZone = nil

local exitTargetID = 'exitTarget'
local isInsideExitZone = false
local exitZone = nil

local deliveryTargetID = 'deliveryTarget'
local isInsideDeliveryZone = false
local deliveryZone = nil

local dutyTargetID = 'dutyTarget'
local isInsideDutyZone = false
local dutyZone = nil

local pickupTargetID = 'pickupTarget'
local isInsidePickupZone = false
local pickupZone = nil

local computer = 'computerHack'

locationNumber = ''
location = nil

pedAlive = false


--KONTOR
local function RegisterEntranceTarget()
    local coords = vector3(Config.OutsideLocation.x, Config.OutsideLocation.y, Config.OutsideLocation.z)
  
    if Config.UseTarget then
      entranceZone = exports['qb-target']:AddBoxZone(entranceTargetID, coords, 1, 4, {
        name = entranceTargetID,
        heading = 44.0,
        minZ = Config.OutsideLocation.z - 1.0,
        maxZ = Config.OutsideLocation.z + 2.0,
        debugPoly = false,
      }, {
        options = {
          {
            type = 'client',
            event = 'invest:client:target:enterLocation',
            item = 'nøkkelkort',
            label = 'Gå inn',
          },
        },
        distance = 1.0
      })
    else
      entranceZone = BoxZone:Create(coords, 1, 4, {
        name = entranceTargetID,
        heading = 44.0,
        minZ = Config.OutsideLocation.z - 1.0,
        maxZ = Config.OutsideLocation.z + 2.0,
        debugPoly = false
      })
  
      entranceZone:onPlayerInOut(function(isPointInside)
        if isPointInside then
          exports['qb-core']:DrawText('[E] Enter Warehouse', 'left')
        else
          exports['qb-core']:HideText()
        end
  
        isInsideEntranceZone = isPointInside
      end)
    end
end


local function RegisterExitTarget()
    if jobLevel == 1 then
      coords = vector3(Config.InsideLocation.x, Config.InsideLocation.y, Config.InsideLocation.z)
    end

    if jobLevel == 2 then
      coords = vector3(Config.InsideLocation2.x, Config.InsideLocation2.y, Config.InsideLocation2.z)
    end

      
    if Config.UseTarget then
      exitZone = exports['qb-target']:AddBoxZone(exitTargetID, coords, 1, 1, {
        name = exitTargetID,
        heading = 270,
        minZ = Config.InsideLocation.z - 1.0,
        maxZ = Config.InsideLocation.z + 2.0,
        debugPoly = false,
      }, {
        options = {
          {
            type = 'client',
            event = 'invest:client:target:exitLocation',
            label = 'Gå ut',
          },
        },
        distance = 3.0
      })
    else
      exitZone = BoxZone:Create(coords, 1, 4, {
        name = exitTargetID,
        heading = 270,
        minZ = Config.InsideLocation.z - 1.0,
        maxZ = Config.InsideLocation.z + 2.0,
        debugPoly = false
      })
  
      exitZone:onPlayerInOut(function(isPointInside)
        if isPointInside then
          exports['qb-core']:DrawText('[E] Exit Warehouse', 'left')
        else
          exports['qb-core']:HideText()
        end
  
        isInsideExitZone = isPointInside
      end)
    end
end

local function RegisterCompetitionExit()

    

    
  if Config.UseTarget then
    exitZone = exports['qb-target']:AddBoxZone(exitTargetID, coords, 1, 1, {
      name = exitTargetID,
      heading = 270,
      minZ = coords.z - 1.0,
      maxZ = coords.z + 2.0,
      debugPoly = true,
    }, {
      options = {
        {
          type = 'client',
          event = 'boss:client:target:exitLocationBoss',
          label = 'Gå ut',
        },
      },
      distance = 3.0
    })
  else
    exitZone = BoxZone:Create(coords, 1, 4, {
      name = exitTargetID,
      heading = 270,
      minZ = Config.InsideLocation.z - 1.0,
      maxZ = Config.InsideLocation.z + 2.0,
      debugPoly = true
    })

    exitZone:onPlayerInOut(function(isPointInside)
      if isPointInside then
        exports['qb-core']:DrawText('[E] Exit Warehouse', 'left')
      else
        exports['qb-core']:HideText()
      end

      isInsideExitZone = isPointInside
    end)
  end
end

RegisterCommand("setBossLoc", function()
  RegisterCompetitionEntrance()
end)

local function RegisterCompetitionEntrance()

  local coords = location

  
if Config.UseTarget then
  exitZone = exports['qb-target']:AddBoxZone(exitTargetID, coords, 1, 1, {
    name = exitTargetID,
    heading = 270,
    minZ = coords.z - 1.0,
    maxZ = coords.z + 2.0,
    debugPoly = true,
  }, {
    options = {
      {
        type = 'client',
        event = 'invest:client:target:enterLocation',
        label = 'Gå inn',
      },
    },
    distance = 3.0
  })
else
  exitZone = BoxZone:Create(coords, 1, 4, {
    name = exitTargetID,
    heading = 270,
    minZ = Config.InsideLocation.z - 1.0,
    maxZ = Config.InsideLocation.z + 2.0,
    debugPoly = false
  })

  exitZone:onPlayerInOut(function(isPointInside)
    if isPointInside then
      exports['qb-core']:DrawText('[E] Exit Warehouse', 'left')
    else
      exports['qb-core']:HideText()
    end

    isInsideExitZone = isPointInside
  end)
end
end

local function EnterLocation()
    DoScreenFadeOut(500)
    while not IsScreenFadedOut() do
      Wait(10)
    end
      SetEntityCoords(PlayerPedId(), coords)
    DoScreenFadeIn(500)
  
  
end

local function ExitLocation()
    DoScreenFadeOut(500)
    while not IsScreenFadedOut() do
      Wait(10)
    end
    SetEntityCoords(PlayerPedId(), Config.OutsideLocation.x, Config.OutsideLocation.y, Config.OutsideLocation.z + 1)
    DoScreenFadeIn(500)
  
    isInside = false
  
end

local function ExitLocationBoss()
  DoScreenFadeOut(500)
  while not IsScreenFadedOut() do
    Wait(10)
  end
  SetEntityCoords(PlayerPedId(), location)
  DoScreenFadeIn(500)
  
  bossKilled = true

  isInside = false

end

local function RegisterComputer()

  if jobLevel == 1 then
    coords = vector3(Config.ComputerLocation.x, Config.ComputerLocation.y, Config.ComputerLocation.z)
  end

  if jobLevel == 2 then
    coords = vector3(Config.ComputerLocation2.x, Config.ComputerLocation2.y, Config.ComputerLocation2.z)
  end
  
    if Config.UseTarget then
      entranceZone = exports['qb-target']:AddBoxZone(computer, coords, 1, 1, {
        name = computer,
        heading = 1.0,
        minZ = Config.ComputerLocation.z - 1.0,
        maxZ = Config.ComputerLocation.z + 2.0,
        debugPoly = false,
      }, {
        options = {
          {
            type = 'client',
            event = 'boss:client:target:startJob',
            label = 'Start oppdrag',
          },
          {
            type = 'client',
            event = 'boss:client:target:findCompetition',
            label = 'Spor opp konkurrenter',
          },
        },
        distance = 1.0
      })
    end
end

-- MAIL

RegisterNetEvent('boss:client:target:exitLocationBoss', function()
  ExitLocationBoss()
end)

RegisterNetEvent('invest:client:target:enterLocation', function()
    EnterLocation()
end)
  
RegisterNetEvent('invest:client:target:exitLocation', function()
    ExitLocation()
end)

RegisterNetEvent('invest:client:target:sendMail', function()
end)


AddEventHandler('invest:client:target:sendMail', function()
  locationNumber = math.random(1,2)
  location = Config.startLocations[math.random(1,2)]
  Wait(500)

  TriggerServerEvent('qb-phone:server:sendNewMail', {
    sender = ('X'),
    subject = ('Markedet'),
    message = ('Markedet dukker opp her om litt. Vær kjapp.'),
    button = {}
  })

  CreateMarketPed()
  CreateBlip()
end)

RegisterCommand('peddy', function()
  locationNumber = math.random(1,2)
  location = Config.startLocations[locationNumber]
  CreateMarketPed()
  Wait(5000)
  DeleteCreatedPed()

end)


-- Test/Debug

RegisterCommand("testJob", function()
  startJob()
end)

RegisterCommand("testBoss", function()
  CreateCompetitorPed()
  RegisterCompetitionExit()
end)


--PED

function CreateStartPed()


  if(pedAlive == false) then

  local hashKey = `cs_chengsr`

  local pedType = 5

  RequestModel(hashKey)
  while not HasModelLoaded(hashKey) do
      RequestModel(hashKey)
      Citizen.Wait(100)
  end


  deliveryPed = CreatePed(pedType, hashKey, location, 0, 0, true)


  ClearPedTasks(deliveryPed)
  ClearPedSecondaryTask(deliveryPed)
  TaskSetBlockingOfNonTemporaryEvents(deliveryPed, true)
  SetPedFleeAttributes(deliveryPed, 0, 0)
  SetPedCombatAttributes(deliveryPed, 17, 1)

  SetPedSeeingRange(deliveryPed, 0.0)
  SetPedHearingRange(deliveryPed, 0.0)
  SetPedAlertness(deliveryPed, 0)
  SetPedKeepTask(deliveryPed, true)
  
  exports['qb-target']:AddTargetModel(hashKey, {
    options = {
      {
        event = "boss:client:target:getPackage",
        icon = "fas fa-hands",
        label = "Ta imot pakke",
      },
    },
    distance = 2.5,
  })
  pedAlive = true


  end
end

function CreateDeliverPed()


  if(pedAlive == false) then

  local hashKey = `cs_siemonyetarian`

  local pedType = 5

  RequestModel(hashKey)
  while not HasModelLoaded(hashKey) do
      RequestModel(hashKey)
      Citizen.Wait(100)
  end


  deliveryPed = CreatePed(pedType, hashKey, location, 0, 0, true)


  ClearPedTasks(deliveryPed)
  ClearPedSecondaryTask(deliveryPed)
  TaskSetBlockingOfNonTemporaryEvents(deliveryPed, true)
  SetPedFleeAttributes(deliveryPed, 0, 0)
  SetPedCombatAttributes(deliveryPed, 17, 1)

  SetPedSeeingRange(deliveryPed, 0.0)
  SetPedHearingRange(deliveryPed, 0.0)
  SetPedAlertness(deliveryPed, 0)
  SetPedKeepTask(deliveryPed, true)
  
  exports['qb-target']:AddTargetModel(hashKey, {
    options = {
      {
        event = "boss:client:target:deliverPackage",
        icon = "fas fa-hands",
        label = "Lever pakke",
        item = "printerdocument",
      },
    },
    distance = 2.5,
  })
  pedAlive = true


  end
end

function CreateCompetitorPed()


  if(pedAlive == false) then

  local hashKey = `csb_vagspeak`

  local pedType = 5

  RequestModel(hashKey)
  while not HasModelLoaded(hashKey) do
      RequestModel(hashKey)
      Citizen.Wait(100)
  end


  bossPed = CreatePed(pedType, hashKey, -787.8712, -599.5935, 30.2763, 164.277, 0, 0, true)


  --ClearPedTasks(deliveryPed)
  --ClearPedSecondaryTask(deliveryPed)
  --TaskSetBlockingOfNonTemporaryEvents(deliveryPed, true)
  GiveWeaponToPed(bossPed, "weapon_knife", 1, false, true)
  plyCoords = GetEntityCoords(-1)
  dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, -787.8712, -599.5935, 30.2763)
    SetPedSeeingRange(bossPed, 100.0)
    SetPedHearingRange(bossPed, 80.0)
    SetPedCombatAttributes(bossPed, 46, 1)
    SetPedFleeAttributes(bossPed, 0, 0)
    SetPedCombatRange(bossPed,2)
    --TaskStartScenarioInPlace(bossPed, "WORLD_HUMAN_SMOKING", 2, true)
    --TaskCombatPed(bossPed, GetPlayerPed(-1),0,16)

    SetPedCombatMovement(bossPed, 2)
  

  bossAlive = true


  end
end



function DeleteCreatedPed()
	print("Deleting Ped?")
	if DoesEntityExist(deliveryPed) then 
		SetPedKeepTask(deliveryPed, false)
		TaskSetBlockingOfNonTemporaryEvents(deliveryPed, false)
		ClearPedTasks(deliveryPed)
		TaskWanderStandard(deliveryPed, 10.0, 10)
		SetPedAsNoLongerNeeded(deliveryPed)

		Citizen.Wait(20000)
		DeletePed(deliveryPed)
    pedAlive = false
	end
end

-- Set Location variable

function setStartLocation()
  location = Config.startLocations[math.random(1,2)]
end

function setDeliverLocation()
  location = Config.deliverLocations[math.random(1,2)]
end

function setCompetitionOfficeLocation()
  location = Config.competitionOfficeLocation[math.random(1,2)]
  coords = Config.competitionInteriors[1]
end

-- BLIP/GPS
function DeleteBlip()
	if DoesBlipExist(blip) then
		RemoveBlip(blip)
	end
end

function CreateBlip()
	DeleteBlip()
		blip = AddBlipForCoord(location)

    
    SetBlipSprite(blip, 306)
    SetBlipScale(blip, 1.0)
    SetBlipAsShortRange(blip, false)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("?")
    EndTextCommandSetBlipName(blip)
    SetBlipRoute(blip,  true)
end

-- JOBBER
-- LEVERING
RegisterNetEvent("boss:client:target:startJob")
AddEventHandler("boss:client:target:startJob", function()
  startJob()
end)

function startJob()
  if onJob == false then
    setStartLocation()
    while location == nil do
      Citizen.Wait(100)
      setLocation()
    end
    CreateStartPed()
    CreateBlip()
  end
end

function DeliverPackage()
  setDeliverLocation()
  while location == nil do
    Citizen.Wait(100)
    setLocation()
  end
  CreateDeliverPed()
  CreateBlip()
end

RegisterNetEvent("boss:client:target:getPackage")
AddEventHandler("boss:client:target:getPackage", function()
  TriggerServerEvent("boss:recievePackage")
  DeleteCreatedPed()
  DeleteBlip()
  location = nil
  Wait(math.random(1000,5000))
  hasPackage = true
  DeliverPackage()
end)

RegisterNetEvent("boss:client:target:deliverPackage")
AddEventHandler("boss:client:target:deliverPackage", function()
  TriggerServerEvent("boss:deliverPackage")
  DeleteCreatedPed()
  DeleteBlip()
  location = nil
  hasPackage = false
  onJob = false
end)

-- FINNE KONKURRENTER

RegisterNetEvent("boss:client:target:findCompetition")
AddEventHandler("boss:client:target:findCompetition", function()
  
end)

function BossKilled()
  bossAlive = false
  TriggerServerEvent("boss:killCompetition")
  setCompetitionOfficeLocation()
  CreateBlip()
  RegisterCompetitionEntrance()
  bossKilled = true

end

--THREADS

-- Registrers entrances
CreateThread(function()
    Wait(500)
        RegisterExitTarget()
        RegisterEntranceTarget()
        RegisterComputer()
        if bossKilled then
          RegisterCompetitionEntrance()
          RegisterCompetitionExit()
        end
end)

-- Makes boss aggressive towards player when near enough
CreateThread(function()
  while true do
  Wait(500)
  plyCoords = GetEntityCoords(GetPlayerPed(-1))
  dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, -787.8712, -599.5935, 30.2763)
  if bossAlive == true and dist <= 25.0 then
    TaskCombatPed(bossPed, GetPlayerPed(-1),0,16)
    --break
  end
end
end)

-- Checks when boss is killed
CreateThread(function()
  while true do
    Wait(500)
    if bossAlive == true and IsPedDeadOrDying(bossPed,1) then
      BossKilled()
    end
  end
end)

