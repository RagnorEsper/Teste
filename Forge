-- Tables
forge1 = { 
-- table.concat(forge1[nome].matmsg) --forge1[nome].matid --forge1[nome].matquant --forge1[ome].itemid
  ["tipo"] = {
              ["all"] = {"sword", "club", "axe", "bow", "shield", "helmet", "armor", "legs", "boots"}, 
              ["sword"] = {"{Dagger}"},
              ["club"] = {"{Smasher}"}, 
              ["axe"] = {"{Axer}"}, 
              ["bow"] = {"{Reforced Bow}"}, 
              ["shield"] = {"{Reforced Shield}"}, 
              ["helmet"] = {"{Reforced Helmet}"}, 
              ["armor"] = {"{Reforced Armor}"}, 
              ["legs"] = {"{Reforced Legs}"}, 
              ["boots"] = {"{Reforced Boots}"}
  },

  ["nome"] = {"dagger", "smasher", "axer", "aimer", "reforced shield", "reforced helmet", "reforced armor", "reforced legs", "reforced boots"},
  
  ["dagger"] = {
    matmsg = {"Para forjar uma boa {Dagger}, preciso de {1 Knife}, {3 pieces of iron}, {2 brown piece of cloth} and {100 gold coins} pelo meu trabalho, ok?"}, 
    matid = {2403, 2225, 5913}, 
    matquant = {1, 3, 2, 100}, 
    itemid = {2379},
  },

  ["smasher"] = {
    matmsg = {"Para forjar um bom {Smasher}, preciso de {1 small club}, {3 pieces of iron}, {1 withe piece of cloth} and {100 gold coins} pelo meu trabalho, ok?"}, 
    matid = {2382, 2225, 2222},
    matquant = {1, 3, 3, 100}, 
    itemid = {}               
  },
  ["axer"] = {
    matmsg = {"Para forjar um bom {Axer}, preciso de {1 small axe}, {3 pieces of iron}, {3 some woods} and {100 gold coins} pelo meu trabalho, ok?"}, 
    matid = {2559, 2225, 5909},
    matquant = {1, 3, 1, 100}, 
    itemid = {}               
  },
  ["reforced bow"] = {
    matmsg = {"Para forjar um bom {Aimer}, preciso de {1 bow}, {6 some woods}, {3 pieces of iron}, {3 brown piece of cloth} and {150 gold coins} pelo meu trabalho, ok?"}, 
    matid = {2456, 2222, 2225, 5913},
    matquant = {1, 6, 3, 3, 150}, 
    itemid = {}               
  },
  ["reforced shield"] = {
    matmsg = {"Para forjar um bom {Reforced Shield}, preciso de {1 wooden shield}, {10 some woods}, {5 pieces of iron} and {150 gold coins} pelo meu trabalho, ok?"}, 
    matid = {2512, 2222, 2225},
    matquant = {1, 10, 5, 150}, 
    itemid = {}               
  },

  ["reforced helmet"] = {
    matmsg = {"Para forjar um bom {Reforced helmet}, preciso de {1 leather helmet}, {6 brown piece of cloth}, {2 pieces of iron}, {1 honeycomb} and {150 gold coins} pelo meu trabalho, ok?"}, 
    matid = {2461, 5913, 2225, 5902},
    matquant = {1, 6, 2, 1, 150}, 
    itemid = {}               
  },

  ["reforced armor"] = {
    matmsg = {"Para forjar um bom {Reforced armor}, preciso de {1 leather armor}, {10 pieces of iron}, {5 brown piece of cloth}, {2 withe pice of cloth} and {150 gold coins} pelo meu trabalho, ok?"}, 
    matid = {2467, 2225, 5913, 5909},
    matquant = {1, 10, 5, 2, 150}, 
    itemid = {}               
  },

  ["reforced legs"] = {
    matmsg = {"Para forjar uma boa {Reforced legs}, preciso de {1 leather legs}, {10 brown piece of cloth}, {3 pieces of iron} and {150 gold coins} pelo meu trabalho, ok?"}, 
    matid = {2649, 5913, 2225},
    matquant = {1, 10, 3, 150}, 
    itemid = {}               
  },  

  ["reforced boots"] = {
    matmsg = {"Para forjar uma boa {Reforced boots}, preciso de {1 leather boots}, {3 brown piece of cloth}, {2 pig foots} and {150 gold coins} pelo meu trabalho, ok?"}, 
    matid = {2643, 5913, 10609},
    matquant = {1, 3, 2, 150}, 
    itemid = {}               
  }
}

  forge2 = {["nome"] = {}}
  forge3 = {["nome"] = {}}
  forge4 = {["nome"] = {}}
  forge5 = {["nome"] = {}}
  forge6 = {["nome"] = {}} -- epic
  forge7 = {["nome"] = {}} -- custom

-- Functions
function getSkillOfForge(nomeitem)
  local tab = {forge1, forge2, forge3, forge4, forge5, forge6, forge7}
  local nivel = {}
  for x = 1, 7 do
    local z = tab[x]["nome"]
    if isInArray(z, nomeitem) then
      nivel = tab[x]
      break
    end
  end
  return nivel
end

function checkItensRecipe(cid, namerecipe, quantidade)
  forge = getSkillOfForge(namerecipe)
  x = quantidade or 1
  recipeitensid = forge[namerecipe].matid -- tabela com os itens da receita
  printTable(recipeitensid)
  quantitens = forge[namerecipe].matquant -- tabela com a quantidade dos itens da receita
  ok = true
  for tabpos = 1, #recipeitensid do
    local item = forge[namerecipe].matid[tabpos] -- busca o id do item
    local quantiten = forge[namerecipe].matquant[tabpos] -- busca a quantidade necessaria
    if getPlayerItemCount(cid, item) < (quantiten * x) then -- se o player tiver menos que o necessario
      ok = false
      break
    end
  end
  return ok
end

function takeRecipeItens(cid, namerecipe, quantidade)
  forge = getSkillOfForge(namerecipe)
  x = quantidade or 1
  recipeitensid = forge[namerecipe].matid -- tabela com os itens da receita
  quantitens = forge[namerecipe].matquant -- tabela com a quantidade dos itens da receita
  ok = false
  for tabpos = 1, #recipeitensid do
    local item = forge[namerecipe].matid[tabpos] -- busca o id do item
    local quantiten = forge[namerecipe].matquant[tabpos] -- busca a quantidade necessaria
    local quantiten2 = quantiten * x
    if doPlayerRemoveItem(cid, item, quantiten2) then -- se o player tiver menos que o necessario
      ok = true
    else
      ok = false
      break
    end
  end
  return ok
end

function doForgeItem(cid, namerecipe, quantidade)
  forge = getSkillOfForge(namerecipe)
  quant = quantidade or 1
  money = getPlayerMoney(cid)
  pos = forge[namerecipe].matquant 
  moneyneed = forge[namerecipe].matquant[#pos]
  if checkItensRecipe(cid, namerecipe, quant) == true then
    if getCountPlayerBagSlotFree(cid) >= quantidade then
      if money >= moneyneed then
        if takeRecipeItens(cid, namerecipe, quant) and doPlayerRemoveMoney(cid, moneyneed) then
          local item = table.concat(forge[namerecipe].itemid)
          local items1 = doCreateItemEx(item, quant)                
          doPlayerAddItemEx(cid, items1, true)
          doPlayerSendTextMessage(cid, 18, "Parabéns. Você forjou {".. string.upper(namerecipe) .."}.")
        end
      else
        doPlayerSendTextMessage(cid, 20, "Você não tem dinheiro suficiente.")
      end
    else
      doPlayerSendTextMessage(cid, 20, "Você não tem espaço na sua mochila.")
    end
  else
    doPlayerSendTextMessage(cid, 20, "Você não tem todos os item necessários.")
  end
end
