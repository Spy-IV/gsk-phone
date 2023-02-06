Keys = {
  ["ESC"]       = 1,  ["F1"]        = 59,  ["F2"]        = 60,  ["F3"]        = 61,  ["F5"]  = 63,  ["F6"]  = 64,  ["F7"]  = 65,  ["F8"]  = 66,  ["F9"]  = 67,   ["F10"]   = 68, 
  ["~"]         = 41,  ["1"]         = 2,  ["2"]         = 3,  ["3"]         = 4,  ["4"]   = 5,  ["5"]   = 6,  ["6"]   = 7,  ["7"]   = 8,  ["8"]   = 9,  ["9"]     = 10,  ["-"]   = 12,   ["="]     = 13,   ["BACKSPACE"]   = 14, 
  ["TAB"]       = 37,   ["Q"]         = 16,   ["W"]         = 17,   ["E"]         = 18,   ["R"]   = 19,   ["T"]   = 20,  ["Y"]   = 21,  ["U"]   = 22,  ["P"]   = 25,  ["["]     = 26,  ["]"]   = 27,   ["ENTER"]   = 28,
  ["CAPS"]      = 137,  ["A"]         = 30,   ["S"]         = 31,    ["D"]         = 32,    ["F"]   = 33,   ["G"]   = 34,   ["H"]   = 35,   ["K"]   = 37,  ["L"]   = 38,
  ["LEFTSHIFT"] = 42,   ["Z"]         = 44,   ["X"]         = 45,   ["C"]         = 46,   ["V"]   = 47,    ["B"]   = 48,   ["N"]   = 49,  ["M"]   = 50,  [","]   = 51,   ["."]     = 52,
  ["LEFTCTRL"]  = 29,   ["LEFTALT"]   = 56,   ["SPACE"]     = 57,   ["RIGHTCTRL"] = 157, 
  ["HOME"]      = 213,  ["PAGEUP"]    = 10,   ["PAGEDOWN"]  = 11,   ["DELETE"]    = 211,
  ["LEFT"]      = 203,  ["RIGHT"]     = 205,  ["UP"]        = 200,   ["DOWN"]      = 208,
  ["NENTER"]    = 156,  ["N4"]        = 75,  ["N5"]        = 76,   ["N6"]        = 77,  ["N+"]  = 78,   ["N-"]  = 74,   ["N7"]  = 71,  ["N8"]  = 72,   ["N9"]  = 73
}

local menuIsOpen = false
local contacts = {}
local messages = {}
local gmessages = {}
local groups = {}
local myPhoneNumber = ''
local ignoreFocus = false
local takePhoto = false
local TokoVoipID = nil
local CameraO = false
local flas = false
local PhoneInCall = {}
local disableKeys = false
local flightmode = false

--====================================================================================

--[[Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(100)
	end

	ESX.PlayerData = ESX.GetPlayerData()

end)]]



local job = nil
RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(datajob)
	datajob = job
end)




--====================================================================================
--  
--====================================================================================


--RegisterKeyMapping('TooglePhone', 'Open Phone', 'keyboard', Config.OpenPhone);--dont have this feature in citizen

--[[RegisterCommand("TooglePhone",function()
	TooglePhone()
end)]] --no need of this



RegisterNetEvent('gks:use')
AddEventHandler('gks:use', function()
  TooglePhone() 
end)



CreateThread(function()
  while true do
      if disableKeys then
          Wait(0)
          SetPlayerControl(GetPlayerId())
      else
          Wait(200)
      end
  end
end)

RegisterNetEvent('gksphone:disableControlActions') -- added
AddEventHandler('gksphone:disableControlActions', function(bool)
  disableKeys = bool
end)

RegisterNUICallback('focusphone', function(data, cb)
  if menuIsOpen then
    SetNuiFocus(data.focusphone)
  end
end)



function TooglePhone() 
  ESX.TriggerServerCallback('gksphone:phone-check', function(durum)
    if durum ~= nil then
      changePhoneType(durum)
      menuIsOpen = not menuIsOpen
      SendNUIMessage({show = menuIsOpen})
      if menuIsOpen == true then 
        PhonePlayIn()
        SetCursorLocation(0.9, 0.922)
        SetNuiFocus(true, true)
        --SetNuiFocusKeepInput(true)
        TriggerEvent('gksphone:disableControlActions', true)
  
      else
        flas = false
        ignoreFocus = false
        PhonePlayOut()
        SetNuiFocus(false, false)
        --SetNuiFocusKeepInput(false)
        TriggerEvent('camera:stop', false)
        TriggerEvent('gksphone:disableControlActions', false)
        TriggerEvent('gksphone:faketakestop')
        SendNUIMessage({event = 'imageclose'})
      end
    else
      PrintStringWithLiteralStringNow("STRING", (_U('no_item')), 1000, 1)
      --ESX.ShowNotification(_U('no_item'))
    end
  end)
end

RegisterNUICallback('closePhone', function(data, cb)
  menuIsOpen = false
  ignoreFocus = false
  SendNUIMessage({show = false})
  flas = false
  PhonePlayOut()
  SetNuiFocus(false, false)
  --SetNuiFocusKeepInput(false)
  TriggerEvent('camera:stop', false)
  TriggerEvent('gksphone:disableControlActions', false)
  cb()
end)




--====================================================================================
--  Gestion des appels fixe
--====================================================================================


RegisterNetEvent("gksphone:notifyFixePhoneChange")
AddEventHandler("gksphone:notifyFixePhoneChange", function(_PhoneInCall)
  PhoneInCall = _PhoneInCall
end)

 
--====================================================================================
--  Events
--====================================================================================
RegisterNetEvent('gksphone:loadingphone')
AddEventHandler('gksphone:loadingphone', function(_myPhoneNumber,  _contacts, allmessages, allgroup, allgmessage)
  myPhoneNumber = _myPhoneNumber
  SendNUIMessage({event = 'updateMyPhoneNumber', myPhoneNumber = myPhoneNumber})

  contacts = _contacts
  SendNUIMessage({event = 'updateContacts', contacts = contacts})
  
  messages = allmessages
  
  SendNUIMessage({event = 'updateMessages', messages = messages})

  groups = allgroup

  SendNUIMessage({event = 'updateGroups', groupss = groups})

  gmessages = allgmessage

  SendNUIMessage({event = 'updateMessageG', gmessages = gmessages})
  
end)

RegisterNetEvent("gksphone:contactList")
AddEventHandler("gksphone:contactList", function(_contacts)
  SendNUIMessage({event = 'updateContacts', contacts = _contacts})
  contacts = _contacts
end)


RegisterNetEvent("gksphone:allMessage")
AddEventHandler("gksphone:allMessage", function(allmessages)
  messages = allmessages
  SendNUIMessage({event = 'updateMessages', messages = allmessages})
end)

RegisterNetEvent("gksphone:receiveMessage")
AddEventHandler("gksphone:receiveMessage", function(message)
  SendNUIMessage({event = 'newMessage', message = message})
  table.insert(messages, message)
  if message.owner == 0 then
      if durum ~= nil then
        local text = _U('new_one_message')

          text = message.transmitter .. _U('new_message_normal')
          for _,contact in pairs(contacts) do
            if contact.number == message.transmitter then
              text = contact.display .. _U('new_message_normal')
              break
            end
          end

        TriggerEvent('gksphone:notifi', {title = 'Messages', message = text, img= '/html/static/img/icons/messages.png', appinfo = message.transmitter })

        PlaySound(-1, "Menu_Accept", "Phone_SoundSet_Default", 0, 0, 1)
        Citizen.Wait(300)
        PlaySound(-1, "Menu_Accept", "Phone_SoundSet_Default", 0, 0, 1)
        Citizen.Wait(300)
        PlaySound(-1, "Menu_Accept", "Phone_SoundSet_Default", 0, 0, 1)
      end
  end
end)


--====================================================================================
--  Function client | Contacts
--====================================================================================
function addContact(display, num, avatar) 
    TriggerServerEvent('gksphone:addContact', display, num, avatar)
end

function deleteContact(num) 
    TriggerServerEvent('gksphone:deleteContact', num)
end
--====================================================================================
--  Function client | Messages
--====================================================================================

function deleteMessage(msgId)
  TriggerServerEvent('gksphone:deleteMessage', msgId)
  for k, v in ipairs(messages) do 
    if v.id == msgId then
      table.remove(messages, k)
      SendNUIMessage({event = 'updateMessages', messages = messages})
      return
    end
  end
end

function deleteMessageContact(num)
  TriggerServerEvent('gksphone:deleteMessageNumber', num)
end

function deleteAllMessage()
  TriggerServerEvent('gksphone:deleteAllMessage')
end

function setReadMessageNumber(num)
  TriggerServerEvent('gksphone:setReadMessageNumber', num)
  for k, v in ipairs(messages) do 
    if v.transmitter == num then
      v.isRead = 1
    end
  end
end

function requestAllMessages()
  TriggerServerEvent('gksphone:requestAllMessages')
end

function requestAllContact()
  TriggerServerEvent('gksphone:requestAllContact')
end



--====================================================================================
--  Function client | Appels
--====================================================================================
local aminCall = false
local inCall = false
local dnemeasd = nil

RegisterCommand("pacc", function(source, args, rawCommand)
  if aminCall then
	  SendNUIMessage({ event = "autoAcceptCall", infoCall = dnemeasd, initiator = false, who = 'logdneme'})
  end
end)

RegisterCommand("prej", function(source, args, rawCommand)
  TriggerServerEvent('gksphone:rejectCall', dnemeasd)
  aminCall = false
  dnemeasd = nil
  PhonePlayOut()
end)

RegisterNetEvent("gksphone:waitingCall")
AddEventHandler("gksphone:waitingCall", function(infoCall, initiator, who)
  ESX.TriggerServerCallback('gksphone:phone-check', function(durum)
    if durum ~= nil and flightmode == false then
      SendNUIMessage({event = 'waitingCall', infoCall = infoCall, initiator = initiator, who = who})
      if initiator == true then
        PhonePlayCall()
        if menuIsOpen == false then
          TooglePhone()
        end
      end
    end
  end)
end)

RegisterNetEvent("gksphone:waitingCallto")
AddEventHandler("gksphone:waitingCallto", function(infoCall, initiator, who)
  ESX.TriggerServerCallback('gksphone:phone-check', function(durum)
    if durum ~= nil and flightmode == false then
      if who == 'call' then
        aminCall = true
        dnemeasd = infoCall
      end
      SendNUIMessage({event = 'waitingCall', infoCall = infoCall, initiator = initiator, who = who})
      TriggerEvent('gksphone:notifi', {title = 'Call', message = _U('phone_ring'), img= '/html/static/img/icons/call.png' })
    end
  end)
end)

RegisterNetEvent("gksphone:acceptCall")
AddEventHandler("gksphone:acceptCall", function(infoCall, initiator)
  if inCall == false then
    inCall = true
    --[[if Config.UseMumbleVoIP then
      exports["mumble-voip"]:SetCallChannel(infoCall.id+1)
    elseif Config.PMAVoice then
      exports["pma-voice"]:setCallChannel(infoCall.id+1)
    elseif Config.UseTokoVoIP then
      exports.tokovoip_script:addPlayerToRadio(infoCall.id + 1000)
      TokoVoipID = infoCall.id + 1000
    else
      NetworkSetVoiceChannel(infoCall.id + 1)
      NetworkSetTalkerProximity(0.0)
    end]] -- NOT IN CITIZEN ( YOU CAN CONVERT IT WITH LIBERTYCITRY VC)
  end
  PhonePlayCall()
  SendNUIMessage({event = 'acceptCall', infoCall = infoCall, initiator = initiator})
end)

RegisterNetEvent("gksphone:rejectCall")
AddEventHandler("gksphone:rejectCall", function(infoCall)
  if inCall == true then
    inCall = false
    --[[if Config.UseMumbleVoIP then
      exports["mumble-voip"]:SetCallChannel(0)
    elseif Config.PMAVoice then
      exports["pma-voice"]:removePlayerFromCall(0)
    elseif Config.UseTokoVoIP then
      exports.tokovoip_script:removePlayerFromRadio(TokoVoipID)
      TokoVoipID = nil
    else
      Citizen.InvokeNative(0xE036A705F989E049)
      NetworkSetTalkerProximity(2.5)
    end]] -- NOT IN CITIZEN ( YOU CAN CONVERT IT WITH LIBERTYCITRY VC)
  end
  aminCall = false
  dnemeasd = nil
  PhonePlayText()
  SendNUIMessage({event = 'rejectCall', infoCall = infoCall})
end)


RegisterNetEvent("gksphone:historiqueCall")
AddEventHandler("gksphone:historiqueCall", function(historique)
  SendNUIMessage({event = 'historiqueCall', historique = historique})
end)


function startCall (phone_number, who, extraData)
  TriggerServerEvent('gksphone:startCall', phone_number, who, extraData)
end

function acceptCall (infoCall, rtcAnswer)
  TriggerServerEvent('gksphone:acceptCall', infoCall, rtcAnswer)
end

function rejectCall(infoCall)
  TriggerServerEvent('gksphone:rejectCall', infoCall)
end

function ignoreCall(infoCall)
  TriggerServerEvent('gksphone:ignoreCall', infoCall)
end

function requestHistoriqueCall() 
  TriggerServerEvent('gksphone:getHistoriqueCall')
end

function appelsDeleteHistorique (num)
  TriggerServerEvent('gksphone:appelsDeleteHistorique', num)
end

function appelsDeleteAllHistorique ()
  TriggerServerEvent('gksphone:appelsDeleteAllHistorique')
end
  

--====================================================================================
--  Event NUI - Appels
--====================================================================================

RegisterNUICallback('startCall', function (data, cb)
  startCall(data.numero, data.who, data.extraData)
  cb()
end)

RegisterNUICallback('acceptCall', function (data, cb)
  acceptCall(data.infoCall, data.rtcAnswer)
  cb()
end)
RegisterNUICallback('rejectCall', function (data, cb)
  rejectCall(data.infoCall)
  cb()
end)

RegisterNUICallback('ignoreCall', function (data, cb)
  ignoreCall(data.infoCall)
  cb()
end)



--====================================================================================
--  Gestion des evenements NUI
--==================================================================================== 
RegisterNUICallback('log', function(data, cb)
  --print(data)
  cb()
end)
RegisterNUICallback('focus', function(data, cb)
  cb()
end)
RegisterNUICallback('blur', function(data, cb)
  cb()
end)

--====================================================================================
--  Event - Messages
--====================================================================================
RegisterNUICallback('getMessages', function(data, cb)
  cb(json.encode(messages))
end)
RegisterNUICallback('sendMessages', function(data, cb)
  if data.message == '%pos%' then
    local myPos = GetCharCoordinates(GetPlayerChar(-1))
    data.message = 'GPS: ' .. myPos.x .. ', ' .. myPos.y
  end
  TriggerServerEvent('gksphone:sendMessages', data.phoneNumber, data.message)
end)
RegisterNUICallback('deleteMessage', function(data, cb)
  deleteMessage(data.id)
  cb()
end)
RegisterNUICallback('deleteMessageNumber', function (data, cb)
  deleteMessageContact(data.number)
  cb()
end)
RegisterNUICallback('deleteAllMessage', function (data, cb)
  deleteAllMessage()
  cb()
end)
RegisterNUICallback('setReadMessageNumber', function (data, cb)
  setReadMessageNumber(data.number)
  cb()
end)

--====================================================================================
--  Group - Messages
--====================================================================================

RegisterNUICallback('createGroupMessage', function(data, cb)
  TriggerServerEvent('gksphone:creategroup', data.groupname, data.gimage, data.contacts, data.number)
end)

RegisterNUICallback('updategroup', function(data, cb)
  TriggerServerEvent('gksphone:updategroup', data.id, data.contacts, data.number)
end)

RegisterNUICallback('deletegrup', function(data, cb)
  TriggerServerEvent('gksphone:deletegroup', data.id, data.contacts)
end)

RegisterNUICallback('newpeople', function(data, cb)
  TriggerServerEvent('gksphone:newpeople', data.id, data.contacts)
end)

RegisterNetEvent('gksphone:creategroup')
AddEventHandler('gksphone:creategroup', function(allgroup, group)

  groups = allgroup
 
  SendNUIMessage({ event = "createGroup", groups = groups})

  TriggerEvent('gksphone:notifi', {title = 'Messages', message = group .._U('group_created'), img= '/html/static/img/icons/messages.png' })
  
end)

RegisterNetEvent('gksphone:creategroupsrc')
AddEventHandler('gksphone:creategroupsrc', function(allgroup)

  groups = allgroup
 
  SendNUIMessage({ event = "createGroup", groups = groups})
  
end)

RegisterNetEvent('gksphone:updatenewpeoppel')
AddEventHandler('gksphone:updatenewpeoppel', function(allgroup, allgmessage)

  groups = allgroup

  SendNUIMessage({event = 'updateGroups', groupss = groups})

  gmessages = allgmessage

  SendNUIMessage({event = 'updateMessageG', gmessages = gmessages})
  
end)

RegisterNetEvent('gksphone:updategroup')
AddEventHandler('gksphone:updategroup', function(allgroup, allgmessage)

  groups = allgroup

  SendNUIMessage({event = 'updateGroups', groupss = groups})

  gmessages = allgmessage

  SendNUIMessage({event = 'updateMessageG', gmessages = gmessages})
  
end)

RegisterNetEvent('gksphone:deletegroup')
AddEventHandler('gksphone:deletegroup', function(allgroup, allgmessage)

  groups = allgroup

  SendNUIMessage({event = 'updateGroups', groupss = groups})

  gmessages = allgmessage

  SendNUIMessage({event = 'updateMessageG', gmessages = gmessages})
  TriggerEvent('gksphone:notifi', {title = 'Messages', message = _U('group_deleted'), img= '/html/static/img/icons/messages.png' })
end)

RegisterNUICallback('sendGMessage', function(data, cb)
  if data.messages == '%pos%' then
    local myPos = GetCharCoordinates(GetPlayerChar(-1))
    data.message = 'GPS: ' .. myPos.x .. ', ' .. myPos.y
  end
  TriggerServerEvent('gksphone:sendgroupmessage', data.groupid, data.groupname, data.messages, data.contacts, data.number)
end)

RegisterNetEvent('gksphone:csendgroupmessage')
AddEventHandler('gksphone:csendgroupmessage', function(allgmessage)
  


  table.insert(gmessages, allgmessage)

  SendNUIMessage({event = 'updateMessageG', gmessages = gmessages})


end)

RegisterNetEvent('gksphone:csendgroupmessagesrc')
AddEventHandler('gksphone:csendgroupmessagesrc', function(allgmessage)


  table.insert(gmessages, allgmessage)
  SendNUIMessage({event = 'updateMessageG', gmessages = gmessages})

end)
--====================================================================================
--  Event - Contacts
--====================================================================================
RegisterNUICallback('addContact', function(data, cb) 
  TriggerServerEvent('gksphone:addContact', data.display, data.phoneNumber, data.avatar)
end)
RegisterNUICallback('updateContact', function(data, cb)
  TriggerServerEvent('gksphone:updateContact', data.id, data.display, data.phoneNumber, data.avatar)
end)
RegisterNUICallback('avatarChange', function(data, cb)
  TriggerServerEvent('gksphone:avatarChange', data.avatar_url)
end)
RegisterNUICallback('deleteContact', function(data, cb)
  TriggerServerEvent('gksphone:deleteContact', data.id)
end)
RegisterNUICallback('getContacts', function(data, cb)
  cb(json.encode(contacts))
end)
RegisterNUICallback('setGPS', function(data, cb)
  AddBlipForCoord(tonumber(data.x), tonumber(data.y), 1.0)
  TriggerEvent('gksphone:notifi', {title = 'GPS', message = 'GPS Location has been set', img= '/html/static/img/icons/maps.png' })
  cb()
end)
RegisterNUICallback('getPhoneAvatar', function(data, cb)
  --[[ESX.TriggerServerCallback('gksphone:getAvatar', function(avatarr)
    SendNUIMessage({event = 'phone_avatar', avatarr = avatarr})
  end)]] -- not in citizen
end)


RegisterNUICallback('callEvent', function(data, cb)
  local eventName = data.eventName or ''
  if string.match(eventName, 'gksphone') then
    if data.data ~= nil then 
      TriggerEvent(data.eventName, data.data)
    else
      TriggerEvent(data.eventName)
    end
  else
    print('Event not allowed')
  end
  cb()
end)

RegisterNUICallback('deleteALL', function(data, cb)
  TriggerServerEvent('gksphone:deleteALL')
  cb()
end)

RegisterNUICallback('faketakestop', function(data, cb)
  takePhoto = false
  SetNuiFocus(true, true)
  TriggerEvent('gksphone:disableControlActions', true)
	DestroyMobilePhone()
	CellCamActivate(false, false)
  TriggerEvent('camera:stop', false)
  PhonePlayIn()
end)

RegisterNetEvent('gksphone:faketakestop')
AddEventHandler('gksphone:faketakestop', function()

  takePhoto = false
	DestroyMobilePhone()
	CellCamActivate(false, false)
  TriggerEvent('camera:stop', false)

end)

RegisterNUICallback('faketakePhoto', function(data, cb)
  takePhoto = true
  TriggerEvent('gksphone:disableControlActions', false)
  SetNuiFocus(true, false)
  TriggerEvent('camera:open')
end)



----------------------------------
---------- GESTION APPEL ---------
----------------------------------
RegisterNUICallback('appelsDeleteHistorique', function (data, cb)
  appelsDeleteHistorique(data.numero)
  cb()
end)
RegisterNUICallback('appelsDeleteAllHistorique', function (data, cb)
  appelsDeleteAllHistorique(data.infoCall)
  cb()
end)


----------------------------------
---------- GESTION VIA WEBRTC ----
----------------------------------


RegisterNUICallback('setIgnoreFocus', function (data, cb)
  ignoreFocus = data.ignoreFocus
  if ignoreFocus == true then
    TriggerEvent('gksphone:disableControlActions', false)
  end
  if ignoreFocus == false then
    TriggerEvent('gksphone:disableControlActions', true)
  end
  cb()
end)



--## FLIGHT MODE ## --

RegisterNUICallback("flightmode", function(data, cb)
	if data then
		flightmode = true
	else
		flightmode = false
	end
	
end)


--## FLASHLIGHT ## --
RegisterNUICallback('FlashLighttt', function(data)

  if data then
    flas = true
    TriggerEvent('gksphone:disableControlActions', false)
  else
    flas = false
    TriggerEvent('gksphone:disableControlActions', true)
  end

end)

CreateThread(function()
  while true do
      if flas or ignoreFocus then
          Wait(0)
          SetPlayerControl(GetPlayerId(), false)
      else
          Wait(200)
      end
  end
end)

function RotAnglesToVec(rot)
	local z = math.rad(rot.z)
	local x = math.rad(rot.x)
	local num = math.abs(math.cos(x))
	return vector3(-math.sin(z)*num, math.cos(z)*num, math.sin(x))
end

local letSleep = true
CreateThread(function()
	while true do
		Citizen.Wait(5)
		if flas then
      letSleep = false
      local coords = GetCharCoordinates(GetPlayerChar(-1))
      local kierunek = GetCharHeading(GetPlayerChar(-1))
      local vec = RotAnglesToVec(kierunek)
      DrawLightWithRange(coords.x,coords.y,coords.z,vec.x,vec.y,vec.z,255,255,255,20.0,8.0,10.0,15.0,50.0)	
    else
      letSleep = true	
		end
		if letSleep then Citizen.Wait(1000) end
	end
end)

AddEventHandler('onClientResourceStart', function(res)
  DoScreenFadeIn(300)
  if res == "gksphone" then
    Citizen.Wait(2000)
    TriggerServerEvent('gksphone:playerLoad', GetPlayerServerId(PlayerId()))
  end
end)



