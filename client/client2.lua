
function setBlockNumber(bnumber)
  SendNUIMessage({event = 'bnumber_app', bnumber = bnumber})
end

RegisterNUICallback('GetBlockNumber', function(data, cb)
  --ESX.TriggerServerCallback('gksphone:blocknumber', function(bnumber) set with ur own
    --setBlockNumber(bnumber)
  end)
end)

RegisterNUICallback('getApps', function(data)
  
    setCrypto()

end)


RegisterNUICallback('getAppGPS', function(data, cb)
  --ESX.TriggerServerCallback('gksphone:getgps', function(gps)
    --GetGPS(gps)
  --end)
end)

RegisterNUICallback('newgps', function(data)
  if data.gps == '%pos%' then
    local myPos = GetCharCoordinates(GetPlayerChar(-1))
    data.gps = 'GPS: ' .. myPos.x .. ', ' .. myPos.y
  end
  TriggerServerEvent('gksphone:newwgps', data.nott, data.gps)
end)

RegisterNetEvent('updategps')
AddEventHandler('updategps', function(gps)
    --ESX.TriggerServerCallback('gksphone:getgps', function(data)
      --GetGPS(data)
    --end)
end)


function GetGPS(gps)
  SendNUIMessage({event = 'gps_app', gps = gps})
end


function setkCrypto(mevcut)
  SendNUIMessage({event = 'yenCrypto', mevcut = mevcut})
end



RegisterNUICallback('getccCrypto', function(data)
  ESX.TriggerServerCallback('gksphone:getsCrypto', function(data)
    setkCrypto(data)
  end)
end)


RegisterNetEvent('yenCrypto')
AddEventHandler('yenCrypto', function(coin)
 --[[ESX.TriggerServerCallback('gksphone:getsCrypto', function(data)
    setkCrypto(data)
  end, coin)]]
end)



RegisterNUICallback('deletegps', function(data)
  TriggerServerEvent('gksphone:delettegps', data.id)
end)

local sayac = 0

RegisterNUICallback('alCrypto', function(data)
  sayac = sayac + 1
  --[[ESX.TriggerServerCallback('gksphone:checkSpam', function(callback)
    sayac = callback
    if sayac == 0 then
      TriggerServerEvent('gksphone:alCrypto', data.islem, data.id, data.adet, data.fiyat)
    else
      TriggerEvent('gksphone:notifi', {title = 'Bourse', message = _U('phone_time'), img= '/html/static/img/icons/bourse1.png' })
    end
end) ]]

end)

RegisterNUICallback('transferCrypto', function(data)
  sayac = sayac + 1
  --[[ESX.TriggerServerCallback('gksphone:checkSpam', function(callback)
    sayac = callback
    if sayac == 0 then
      TriggerServerEvent('gksphone:transferCrypto', data.number, data.adet, data.id)
    else
      TriggerEvent('gksphone:notifi', {title = 'Bourse', message = _U('phone_time'), img= '/html/static/img/icons/bourse1.png' })
    end
end)]]

end)

local useMilitaryTime = false

RegisterNUICallback('saat', function(data)
  hour,minute = GetGameTimer()
	

	if useMilitaryTime == false then
		if hour == 0 or hour == 24 then
			hour = 12
		elseif hour >= 13 then
			hour = hour - 12
		end
	end

	if hour <= 9 then
		hour = "0" .. hour
	end
	if minute <= 9 then
		minute = "0" .. minute
	end
  timeText = hour ..':' ..minute;
  SendNUIMessage({event = 'emuncuk', timeText = timeText})
end)


local letSleepd = true
local letSleed = true
CreateThread(function()
  while true do
    Citizen.Wait(500)
    local faruk, deea, waadad = GetCurrentWeather()
      if 0.98 < waadad or letSleed then
        letSleed = false
        local denmee = "bruh"
        local agasdwa = " bruhu"
          
          --[[if (faruk == -1750463879) then
            denmee = 'ExtraSunny' 
          elseif (faruk == 916995460) then
            denmee = 'Clear' 
          elseif (faruk == -1530260698) then
            denmee = 'Neutral' 
          elseif (faruk == 282916021) then
            denmee = 'Smog' 
          elseif (faruk == -1368164796) then
            denmee = 'Foggy' 
          elseif (faruk == 821931868) then
            denmee = 'Clouds' 
          elseif (faruk == -1148613331) then
            denmee = 'Overcast'
          elseif (faruk == 1840358669) then
            denmee = 'Clearing'
          elseif (faruk == 1420204096) then
            denmee = 'Raining'
          elseif (faruk == -1233681761) then
            denmee = 'ThunderStorm'
          elseif (faruk == 669657108) then
            denmee = 'Blizzard'
          elseif (faruk == -273223690) then
            denmee = 'Snowing'
          elseif (faruk == 603685163) then
            denmee = 'Snowlight'
          elseif (faruk == -1429616491) then
            denmee = 'Christmas'
          elseif (faruk == -921030142) then
            denmee = 'Halloween'
          end

          if (deea == -1750463879) then
            agasdwa = 'ExtraSunny' 
          elseif (deea == 916995460) then
            agasdwa = 'Clear' 
          elseif (deea == -1530260698) then
            agasdwa = 'Neutral' 
          elseif (deea == 282916021) then
            agasdwa = 'Smog' 
          elseif (deea == -1368164796) then
            agasdwa = 'Foggy' 
          elseif (deea == 821931868) then
            agasdwa = 'Clouds' 
          elseif (deea == -1148613331) then
            agasdwa = 'Overcast'
          elseif (deea == 1840358669) then
            agasdwa = 'Clearing'
          elseif (deea == 1420204096) then
            agasdwa = 'Raining'
          elseif (deea == -1233681761) then
            agasdwa = 'ThunderStorm'
          elseif (deea == 669657108) then
            agasdwa = 'Blizzard'
          elseif (deea == -273223690) then
            agasdwa = 'Snowing'
          elseif (deea == 603685163) then
            agasdwa = 'Snowlight'
          elseif (deea == -1429616491) then
            agasdwa = 'Christmas'
          elseif (deea == -921030142) then
            agasdwa = 'Halloween'
          end]]

          TriggerServerEvent('gksphone:weathercontrol', denmee, agasdwa)
  
      else
        letSleepd = true	
      end
      if letSleepd then Citizen.Wait(9000) end
  end
end)


RegisterNetEvent('gksphone:weathers')
AddEventHandler('gksphone:weathers', function(weatherg)
  SendNUIMessage({event = 'weatherx', weathers = weatherg})
end)

RegisterNUICallback('deleteNumber', function(data)
  TriggerServerEvent('gksphone:deltblknumber', data.id, data.number)
end)

RegisterNUICallback('alNumber', function(data)
  TriggerServerEvent('gksphone:alNumber', data.number)
end)

RegisterNetEvent('yenNumber')
AddEventHandler('yenNumber', function()
  --[[ESX.TriggerServerCallback('gksphone:blocknumber', function(data)
    setBlockNumber(data)
  end)]]
end)

-- Haber

RegisterNUICallback('getNewsForHaber', function(data, cb)
  --[[ESX.TriggerServerCallback('haberci:getNewsForHaber', function(news)
    SendNUIMessage({event = 'news_haberciNews', habercinews = news})
  end)]]
end)

RegisterNUICallback('news_haberciPost', function(data, cb)
  TriggerServerEvent('haberci:news_postWzn', data.haber, data.baslik, data.resim, data.video)
end)

RegisterNetEvent("haberci:news_newBildirim")
AddEventHandler("haberci:news_newBildirim", function(newsh)
  --[[ESX.TriggerServerCallback('haberci:getNewsForHaber', function(news)
    SendNUIMessage({event = 'news_haberciNews', habercinews = news})
  end)]]
end)

RegisterNUICallback('haberiisil', function(data, cb) 
  TriggerServerEvent('haberci:haberisil', data.id)
end)


-- İkinci EL Satış

RegisterNetEvent("gksphone:notifi")
AddEventHandler("gksphone:notifi", function(data)
      SendNUIMessage({event = 'Notifi_Show', data = data})
end)

RegisterNUICallback('newaracsale', function(data, cb) 
  TriggerServerEvent('gksphone:newaracsale', data.ownerphone, data.plate, data.model, data.price, data.image)
end)

local timing = 0

RegisterNUICallback('aracisatt', function(data, cb) 
  --[[timing = timing + 1
  ESX.TriggerServerCallback('gksphone:vehiclecheckSpam', function(callback)
    timing = callback
    if timing == 0 then
      TriggerServerEvent('gksphone:aracisatt', data.owner, data.plate, data.price)
    else
      TriggerEvent('gksphone:notifi', {title = 'Car Sallers', message = _U('phone_time'), img= '/html/static/img/icons/carsales.png' })
    end
  end)]]
end)

RegisterNUICallback('carsellers', function(data, cb) 
  --[[ESX.TriggerServerCallback('gksphone:carsellers', function(data)

    SendNUIMessage({event = 'sale_vehicles', vehicles = data})

  end)]]
end)

RegisterNUICallback('carsellerdel', function(data, cb)
 
  TriggerServerEvent('gksphone:cardel', data.id.id, data.id.plate)
end)


RegisterNetEvent("gksphone:vehiclearac")
AddEventHandler("gksphone:vehiclearac", function(vehiclee)
  --[[ESX.TriggerServerCallback('gksphone:getCars', function(data)
    for i = 1, #data do
        model = GetDisplayNameFromVehicleModel(data[i]["props"].model)
        data[i]["props"].model = model
    end
    setCars(data)
end)]]
    SendNUIMessage({event = 'sale_vehicles', vehicles = vehiclee})
  
end)

RegisterNetEvent("gksphone:cardel")
AddEventHandler("gksphone:cardel", function(plate)

	local gameVehicles = ESX.Game.GetVehicles()

	for i = 1, #gameVehicles do
		local vehicle = gameVehicles[i]

        if DoesVehicleExist(vehicle) then
           
            DeleteCar(vehicle)

              
				      TriggerEvent('gksphone:notifi', {title = 'Vale', message = _U('car_seller'), img= '/html/static/img/icons/vale.png' })
				return

		end
		
	end

  
end)

-- Götür


RegisterNUICallback('urunler', function(getirsatis)
  --[[ESX.TriggerServerCallback('gks_gotur:depoitemgotur', function(goturr)
    SendNUIMessage({event = 'Getir_Urunler', getirr = goturr})
  end)]]
end)

RegisterNUICallback('getirsatis', function(data)
  local valcik = {}
  for i=1, #data.getirsatis, 1 do
    table.insert(valcik, {item = data.getirsatis[i].adet ..'x ' ..data.getirsatis[i].label}) 
  end
  TriggerServerEvent('gks_gotur:siparis', valcik, data.getirsatis[1].isim, data.getirsatis[1].phoneNumber, data.tutar, data.getirsatis[1].durum)
end)



RegisterNetEvent('gksphone:sipariss')
AddEventHandler('gksphone:sipariss', function(gelens)

  SendNUIMessage({event = 'Gelen_Siparis', gelens = gelens})
end)


RegisterNUICallback('urunyenile', function(data)

  TriggerServerEvent('gks_gotur:syold', data.degisik, data.tel)
end)

RegisterNUICallback('teslimonay', function(data)

  TriggerServerEvent('gks_gotur:teslimyapildi', data.degisik, data.tel)
end)

--- JOB

RegisterNUICallback('JobMessages', function(data, cb) 
  local myPos = GetCharCoordinates(GetPlayerChar(-1))
  local GPS = 'GPS: ' .. myPos.x .. ', ' .. myPos.y
  TriggerServerEvent('gksphone:jbmessage', data.name, data.number, data.message, data.photo, GPS, data.jobm)
end)

RegisterNUICallback('jobmfinish', function(data, cb) 
 
  TriggerServerEvent('gksphone:jobmfinish', data.id, data.jobm)
end)

RegisterNUICallback('jobgetmessage', function(data, cb) 

  TriggerServerEvent('gksphone:jobgetmessage', data.job)
end)

RegisterNetEvent('gksphone:mesajjgetir')
AddEventHandler('gksphone:mesajjgetir', function(aba)

  TriggerServerEvent('gksphone:jobgetmessage', aba)
end)


RegisterNetEvent('gksphone:jobnotisound')
AddEventHandler('gksphone:jobnotisound', function(aba)
  SendNUIMessage({event = 'jobnotifff'})
end)

RegisterNetEvent('gksphone:jobmesaae')
AddEventHandler('gksphone:jobmesaae', function(jobnotify)
  SendNUIMessage({event = 'job_notify', jobnotify = jobnotify})
end)


-- Taxi JOB


RegisterNUICallback('taxibilgi', function() 
  local deneme = {}
  local ped = GetPlayerChar(-1)
  local playerPos = GetCharCoordinates(GetPlayerChar(-1))
  local x,y,z = table.unpack(GetCharCoordinates(ped))
  local street = FindStreetNameAtPosition(x, y, z)
  street = GetDirectionText(GetCharHeading(ped))
  table.insert(deneme, {street = street})

  local WaypointHandle = GetFirstBlipInfoId(8)

  if DoesBlipExist(WaypointHandle) then

    dx, dy, dz = table.unpack(Citizen.InvokeNative(0xFA7C7F0AADF25D09, GetFirstBlipInfoId(8), Citizen.ResultAsVector()))

    local GPStogo = {x = dx, y = dy}

    --local street2 = GetStreetNameAtCoord(dx, dy, dz)
    --street2 = GetStreetNameFromHashKey(street2)

    local waypointCoords = FindStreetNameAtPosition(WaypointHandle)

    route = CalculateTravelDistanceBetweenNodes(playerPos, waypointCoords)
    distance = route/1000
    price = (route/1000) * Config.TaxiPrice

    table.insert(deneme, {price = price, street2 = street2, GPStogo = GPStogo, distance = distance, src = GetPlayerChar(-1)})

    SendNUIMessage({event = 'taxi_myloc', mylock = deneme})

  else
      SendNUIMessage({event = 'taxi_myloc', mylock = deneme})
  end
end)

function GetDirectionText(heading)
  if ((heading >= 0 and heading < 45) or (heading >= 315 and heading < 360)) then
      return 'North'
  elseif (heading >= 45 and heading < 135) then
      return 'South'
  elseif (heading >=135 and heading < 225) then
      return 'East'
  elseif (heading >= 225 and heading < 315) then
      return 'West'
  end
end


RegisterNUICallback('taxicall', function(data) 
  local myPos = GetCharCoordinates(GetPlayerChar(-1))
  local GPS =  {x = myPos.x, y = myPos.y}
  TriggerServerEvent('gksphone:taxicall', data.price, data.loca, data.curloca, data.phone, GPS, data.GPStogo, data.distance, data.csrc)
end)

RegisterNetEvent('gksphone:taxijob')
AddEventHandler('gksphone:taxijob', function(taxijob)
  SendNUIMessage({event = 'taxi_call', taxijob = taxijob})
end)

RegisterNetEvent('gksphone:taxiuser')
AddEventHandler('gksphone:taxiuser', function(taxiuser)
  SendNUIMessage({event = 'taxi_user', taxiuser = taxiuser})
end)

RegisterNUICallback('taxiaccpet', function(data) 
  local playerPed = GetPlayerPed(PlayerId())
  local vehicle = GetVehicleNumberPlateText(GetVehiclePedIsIn(playerPed, false))
  if (vehicle ~= nil) then
    --SetNewWaypoint(tonumber(data.gps.x), tonumber(data.gps.y))
    TriggerServerEvent('gksphone:taxiaccept', data.phone)
  else
    TriggerEvent('gksphone:notifi', {title = 'Taxi', message = _U('taxi_customercar'), img= '/html/static/img/icons/taxijob.png' })
  end
end)

RegisterNUICallback('taximusteri', function(data) 
  --[[local playerPed = GetPlayerPed(PlayerId())
	local vehicle = GetVehicleNumberPlateText(GetVehiclePedIsIn(playerPed, false))


  local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
  if closestPlayer ~= -1 and closestDistance <= 0.5 then
 
    TriggerServerEvent('gksphone:taximusteri', data.phone, data.GPStogo, vehicle, GetPlayerServerId(closestPlayer))

  else
    TriggerEvent('gksphone:notifi',  {title = 'Taxi', message = _U('taxi_customernotveh2'), img= '/html/static/img/icons/taxijob.png' })
  end]]

  
end)

RegisterNetEvent('gksphone:taximusteri')
AddEventHandler('gksphone:taximusteri', function(a,b,c,d)
  local playerPed = GetPlayerChar(-1)
  local vehicle = nil

  TriggerServerEvent('gksphone:taximusteria', a, b, c, vehicle, d)

end)

RegisterNetEvent('gksphone:taximusterigps')
AddEventHandler('gksphone:taximusterigps', function(GPStogo)
  --SetNewWaypoint(tonumber(GPStogo.x), tonumber(GPStogo.y))
end)

RegisterNUICallback('taxickonum', function(data) 
  TriggerServerEvent('gksphone:taxikonum', data.phone, data.price)
end)

RegisterNUICallback('taxiiptal', function(data) 
  TriggerServerEvent('gksphone:taxiiptal', data.phone)
end)



-- Facetime

RegisterNUICallback('facetimejoin', function(data) 
  TriggerServerEvent('gksphone:facetimejoin', data.id.id, data.id.xid, data.id.yid)
end)

RegisterNetEvent('gksphone:sendRTCOffer')
AddEventHandler('gksphone:sendRTCOffer', function(data)
  SendNUIMessage({event = 'sendRTC', sendRTC = data})
end)

RegisterNUICallback('startStreaming', function ()
  TriggerEvent('camera:open')
end)

RegisterNUICallback('stopStream', function ()
  takePhoto = false
  TriggerEvent('gksphone:disableControlActions', false)
	DestroyMobilePhone()
	CellCamActivate(false, false)
  TriggerEvent('camera:stop', false)
  PhonePlayOut()
  Citizen.Wait(200)
  PhonePlayIn()

end)


-

-- MAIL


RegisterNUICallback('MailDelete', function(data) 
  TriggerServerEvent('gksphone:MailDelete', data.id)
end)

RegisterNUICallback('mailfetch', function() 
  TriggerServerEvent('gksphone:mailallfetch', GetPlayerServerId(PlayerId()))
end)

RegisterNetEvent("gksphone:UpdateMails")
AddEventHandler("gksphone:UpdateMails", function(mails)
  SendNUIMessage({event = 'updateMail', mail = mails})
end)

-- Gallery

RegisterNUICallback('getAppGallery', function(data, cb)
   --[[ESX.TriggerServerCallback('gksphone:getphonegallery', function(gallery)
    GalleryImage(gallery)
  end)]]
end)

function GalleryImage(gallery)
  SendNUIMessage({event = 'gallery_app', gallery = gallery})
end

RegisterNetEvent('updategallery')
AddEventHandler('updategallery', function()
  --[[ESX.TriggerServerCallback('gksphone:getphonegallery', function(data)
      GalleryImage(data)
    end)]]
end)

RegisterNUICallback('GalleryFoto', function(data)
  TriggerServerEvent('gksphone:gallerimage', data.image)
end)


RegisterNUICallback('GalleryDelete', function(data)
  TriggerServerEvent('gksphone:imagedelete', data.id)
end)