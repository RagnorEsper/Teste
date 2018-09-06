--//==============//===============================================================
--// MagEquip Lib //===============================================================
--//==============//===============================================================
--[[  magias[spell].sabe  --  magias[spell].XpToLearn  --  magias[spell].learn  --  magias[spell].dano -- magias[spell].tipo
      isInArray(magias[spell].voc, voc)  --  magias[spell].exhaust  --  magias[spell].slot -- magias[spell].mana
]]

  magias = {  --[""] = {sabe = 6000, XpToLearn = 1000, learn = 6000},
  --healing
  ["cure"] = {sabe = 60000, XpToLearn = 1000, learn = 60001, voc = {"1","2","3","4","5","6","7","8","9","10"}, exhaust = 1000000, slot = {}, mana = 20, dano = 10, tipo = "magico"},
  --attack
  ["exori"] = {sabe = 60006, XpToLearn = 1000, learn = 60007, voc = {"1","2","3","4","5","6","7","8","9","10"}, exhaust = 1000001, slot = {}, mana = 20, dano = 10, tipo = "fisico"},
  --suport
  ["haste"] = {sabe = 60002, XpToLearn = 1000, learn = 60003, voc = {}, exhaust = 1000002, slot = {8}, mana = 20, dano = 0, tipo = "fisico"},
  ["steal"] = {sabe = 60004, XpToLearn = 1000, learn = 60005, voc = {"1","2","3","4","5","6","7","8","9","10"}, exhaust = 1000003, slot = {9}, mana = 20, dano = 0, tipo = "magico"},
  --status
  --buff status
  --debuff status
  }

--------------------------------------------------------------------------------
function getSpellDano(cid, sid, spell)
  danomin = 0
  danomax = 0
    
  tipo = magias[spell].tipo
  --cid
  cidatkstat = 0
  cidlevel = 0
  cidskill = 0
  danomagia = magias[spell].dano 
  --sid
  sidskill = 0
  sidlevel = 0
  siddefstat = 0   
    
  if tipo == "fisico" then 
    if isPlayer(cid) then
      cidskill = getEquipedWeaponSkill(cid, 0)
      if cidskill > 0 then
        voc = getVoc(cid)
        cidatkstat = voc[tipo][1]
        cidlevel = getPlayerLevel(cid)
      else
        return doPlayerSendCancel(cid, "Você precisa de uma arma equipada para usar essa magia.")
      end          
    elseif isMonster(cid) then
      local creature = string.up(getCreatureName(cid))
      cidskill = getEquipedWeaponSkill(cid, 0)
      cidatkstat = status[creature].atk
      cidlevel = status[creature].level
    end    
    if isPlayer(sid) then
      sidskill = getEquipedWeaponSkill(0, sid)
      sidvoc = getVoc(sid)
      sidlevel = getPlayerLevel(sid)
      siddefstat = vocinimigo[tipo][2]  
    elseif isMonster(sid) then
      local creature = string.up(getCreatureName(sid))
      sidskilldef = getEquipedWeaponSkill(0, sid)
      sidlevel = status[creature].level
      siddefstat = status[creature].def      
    end
    local dano = (cidskill + danomagia + (cidatkstat * cidlevel)) - ((siddefstat * sidlevel) + sidskill)
    if dano > 5 then 
      danomin = dano
      danomax = dano * 1.1
    else
      danomin = 5
      danomax = 20
    end 
    return danomin, danomax
  elseif tipo == "magico" then
    if isPlayer(cid) then
      cidskill = getMagLevel(cid, 0)
      voc = getVoc(cid)
      cidatkstat = voc[tipo][1]
      cidlevel = getPlayerLevel(cid)      
    elseif isMonster(cid) then
      local creature = string.up(getCreatureName(cid))
      cidskill = getMagLevel(cid, 0)
      cidatkstat = status[creature].magatk
      cidlevel = status[creature].level    
    end
    if isPlayer(sid) then
      sidskill = getMagLevel(0, sid)
      sidvoc = getVoc(sid)
      sidlevel = getPlayerLevel(sid)
      siddefstat = vocinimigo[tipo][2]      
    elseif isMonster(sid) then
      local creature = string.up(getCreatureName(sid))
      sidskill = getMagLevel(0, sid)
      sidlevel = status[creature].level
      siddefstat = status[creature].magdef    
    end
    local dano = (cidskill + danomagia + (cidatkstat * cidlevel)) - ((siddefstat * sidlevel) + sidskill) --magico
    if dano > 0 then 
      danomin = dano
      danomax = dano * 1.1
    else
      danomin = 10
      danomax = 20
    end
    return danomin, danomax    
  end
end
--------------------------------------------------------------------------------
function canUseSpell(cid, spell)
  local tipo = false
  if isInArray(magias[spell].voc, getPlayerVocation(cid)) or isGod(cid) then  
    if (#magias[spell].slot > 0 and getIfEquipedSlotSpell(cid, spell)) or getStor(cid, magias[spell].sabe) == 1 then
      tipo = true
    elseif getStor(cid, magias[spell].sabe) == 1 or getIfEquipedSpell(cid, spell) > 0 then 
      tipo = true
    else
      doPlayerSendCancel(cid, "Você não conhece esse Spell ou não possui um objeto magico equipado.")
    end
  else
    doPlayerSendCancel(cid, "Sua vocação não usa essa magia.")
  end  
  return tipo
end  

function doLearnSpell(cid, spell)
  for i,x in pairs(magias) do 
    if spell == i then
      if getStor(cid, magias[i].sabe) == 1 then
        return false
      else
        setStor(cid, magias[i].sabe, 1)
        doSendMagicEffect(getThingPos(cid), 40)
        doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_ORANGE, "You Learn the Spell {"..string.upper(i).."}, Check a Spellbook for more information.")      
        return true
      end
    end
  end
end

function setEquipMagic(item, spell)
  doItemSetAttribute(item, spell, spell)
end

function getEquipMagic(item)
  local magic = {}
  if item.itemid > 0 then
    for i,x in pairs(magias) do 
      local itemMagic = getItemAttribute(item.uid, i)
      if itemMagic == i and not isInArray(magic, itemMagic) then
        table.insert(magic, itemMagic)
      end
    end
  end
  return magic
end  

function getIfEquipedSlotSpell(cid, spell)
  local tipo = false
  local slots = magias[spell].slot
  if #slots > 0 then
    for mag = 1, #slots do
      local item = getPlayerSlotItem(cid, magias[spell].slot[mag])
      if item.itemid > 0 and getItemAttribute(item.uid, spell) == spell then
        tipo = true
      end
    end
  end
  return tipo
end    

function getIfEquipedSpell(cid, spell)
  local quant = 0
  for slot = 1, 10 do
    local item = getPlayerSlotItem(cid, slot)
    if isNumber(item.itemid) and item.itemid > 0 then
      local magic = getEquipMagic(item)
      if #magic > 0 then
        if isInArray(magic, spell) then
          local quantantes = quant
          quant = quantantes + 1            
        end
      end
    end
  end
  return quant
end

function setXpToSpell(cid, monster)
  for slot = 1, 10 do
    local items = getPlayerSlotItem(cid, slot)
    if items.itemid > 0 then
      local magics = getEquipMagic(items) -- tabela com as magias
      if #magics > 0 then
        for i,x in pairs(magias) do
          if isInArray(magics, i) then
            local magia = magias[i]-- array com tudo sobre a magia
            if getStor(cid, magia.sabe) ~= 1 then                      
              local Xp = monstro[monster].xp
              if getStor(cid, magia.learn) > 0 then 
                setStor(cid, magia.learn, Xp + getStor(cid, magia.learn))             
              else
                setStor(cid, magia.learn, Xp)
              end             
              if getStor(cid, magia.learn) >= magia.XpToLearn then
                setStor(cid, magia.sabe, 1)
                doSendMagicEffect(getThingPos(cid), 40)
                doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_ORANGE, "You Learn the Spell {"..string.upper(i).."}, Check a Spellbook for more information.")      
              end
            end  
          end
        end
      end
    end
  end
end
--//==================//===============================================================
--// Fim MagEquip Lib //===============================================================
--//==================//===============================================================
