function onMoveItem(cid, item, formPosition, toPosition, fromItem, toItem, fromGround, toGround, status)   
  local unique = searchIfItemHasAttribute(item, "unique") -- true, attr
  local dual = getItemAttribute(item.uid, "dual")
  local stor4sword = getStor(cid, 150000) 
  local twohandconfig = {
  ["all"] = {7418, 2390},
  [7418] = {lv = {10}, voc = {}},
  [2390] = {lv = {200}, voc = {}},
  }

  if item.actionid > 0 then --bloquiar mexer qulquer coisa soh por 65535 de actionid
    return false
    
-- unique item --	
  elseif ((status.inInv == 0 and status.inInvBag == 3 and status.inDepot == 3) or 
  --[[]] (status.inDepot == 0 and status.inInv == 3 and status.inInvBag == 3) or
  --[[]] (status.inInvBag == 0 and status.inDepot == 3 and status.inInv == 3)) then
    if not isContainer(item.uid) and unique == true then
	  doPlayerSendCancel(cid,"You can't drop a special item on ground.")
	  return false
	elseif isContainer(item.uid) and (searchContainerIfHasAttribute(item.uid, "unique") == true) then
	  doPlayerSendCancel(cid,"You can't throw this bag that contains special item[s] on ground")
	  return false
    else
      return true
	end 
-- fim unique item --
-- broquiar equip de item --
  elseif isEquip(item.uid) and status.slot == 10 then
    doPlayerSendCancel(cid,"You can't put equips here.")

  elseif (((isNumber(getPlayerSlotItem(cid, 5).itemid) and getPlayerSlotItem(cid, 5).itemid > 0 and isWeapon(getPlayerSlotItem(cid, 5).uid) and status.slot == 6 and status.inInv ~= 2) or 
          (isNumber(getPlayerSlotItem(cid, 6).itemid) and getPlayerSlotItem(cid, 6).itemid > 0 and isWeapon(getPlayerSlotItem(cid, 6).uid) and status.slot == 5 and status.inInv ~= 2)) and
           isWeapon(item.uid) and dual == "dual") then          
        if stor4sword == 1 then
          if getPlayerLevel(cid) >= twohandconfig[item.itemid].lv[1] then
            return true
          else
            doPlayerSendCancel(cid,"You don't have level to equip this {`TwoSword Item´}.")
            return false
          end
        else
          doPlayerSendCancel(cid,"You don't have {`TwoSword Abillity´} to equip this item.")
          return false
        end
  elseif ((getPlayerSlotItem(cid, 5).itemid ~= item.itemid and getPlayerSlotItem(cid, 5).itemid > 0 and status.slot == 6) or 
          (getPlayerSlotItem(cid, 6).itemid ~= item.itemid and getPlayerSlotItem(cid, 6).itemid > 0 and status.slot == 5)) 
          and isWeapon(item.uid) and dual ~= "dual" then
    doPlayerSendCancel(cid,"You need an {`TwoSword Item´} to equip in both hands.")
    return false
  --elseif ((isNumber(getPlayerSlotItem(cid, 5).itemid) and 
          -- getPlayerSlotItem(cid, 5).itemid > 0 and status.slot == 6) or 
          --(isNumber(getPlayerSlotItem(cid, 6).itemid) and getPlayerSlotItem(cid, 6).itemid > 0 and 
         --  status.slot == 5)) and isWeapon(item.uid) and dual ~= "dual" then
   -- doPlayerSendCancel(cid,"You need an {`TwoSword Item´} to equip in both hands.")
   -- return false
  else
    return true
  end
end 
