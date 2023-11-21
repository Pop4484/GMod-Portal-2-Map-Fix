function VaultTrapStart()
   for i,v in pairs(ents.GetAll()) do
      if v:GetName() == "@glados" then
         v:PlayScene("scenes/npc/glados/fgbrvtrap02.vcd", 1)
         timer.Simple(v:PlayScene("scenes/npc/glados/fgbrvtrap02.vcd", 1)+3, function()
            v:PlayScene("scenes/npc/glados/fgbrvtrap03.vcd", 1)
            timer.Simple(v:PlayScene("scenes/npc/glados/fgbrvtrap03.vcd", 1), function()
               v:PlayScene("scenes/npc/glados/fgbrvtrap05.vcd", 1)
            end)
         end)
         EntFire("rv_start_moving_trigger", "enable", 0, 0)
      end
    end
end
function VaultTrapStartMoving()
    for i,v in pairs(ents.GetAll()) do
        if v:GetName() == "@glados" then
           v:PlayScene("scenes/npc/glados/fgbturrets01.vcd", 1)
           timer.Simple(v:PlayScene("scenes/npc/glados/fgbturrets01.vcd", 1)+0.5, function()
            v:PlayScene("scenes/npc/glados/fgb_trap01.vcd", 1)
            EntFire("wheatley_body","setanimation","gladosbattle_firstpart")
            timer.Simple(v:PlayScene("scenes/npc/glados/fgb_trap01.vcd", 1), function()
                v:PlayScene("scenes/npc/glados/fgb_trap02.vcd", 1)
                timer.Simple(v:PlayScene("scenes/npc/glados/fgb_trap02.vcd", 1), function()
                    v:PlayScene("scenes/npc/glados/fgb_trap03.vcd", 1)
                    TurretScene()
                 end)
            end)
          end)
        end
    end
end
function TurretScene()
    for i,v in pairs(ents.GetAll()) do
        if v:GetClass() == "func_door" and string.find(v:GetName(), "-turret_claw_01_extender") then
            EntFire(v:GetName(), "Open",0,0)
        end
    end
    timer.Simple(1, function()
        EntFire("turret_01-chamber_npc_turret","Toggle",0,0)
        timer.Simple(1, function()
            EntFire("turret_02-chamber_npc_turret","Toggle",0,0)
            timer.Simple(1, function()
                EntFire("turret_03-chamber_npc_turret","Toggle",0,0)
                timer.Simple(1, function()
                    EntFire("turret_04-chamber_npc_turret","Toggle",0,0)
                    timer.Simple(1, function()
                        EntFire("turret_05-chamber_npc_turret","Toggle",0,0)
                    end)
                end)
            end)
        end)
    end)
    timer.Simple(1, function()
        EntFire("turret_01-chamber_npc_turret","SelfDestruct",0,0)
    end)
end