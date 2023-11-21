local AnnouncerVoice = nil
function ScanStockTurret()
   if IsValid(AnnouncerVoice) then
    AnnouncerVoice:PlayScene("scenes/npc/announcer/sp_sabotage_factory_response02.vcd", 1)
    AnnouncerVoice:EmitSound("vo/announcer/sp_sabotage_factory_line02.wav")
    timer.Simple(1, function()
        EntFire( "accept_turret_relay", "trigger", 0)
        for i,v in pairs(ents.GetAll()) do
            if v:GetClass() == "func_tracktrain" and string.find(v:GetName(), "turret_conveyor_1_train_1&") and v.IgnoreTrain == false then
                EntFire(v:GetName(),"Toggle",1)
                v.IgnoreTrain = true
            end 
        end 
    end)
   end
end
function GladosPlayVcd(vcd)
end
function ResetScannerDisplays()
end
function GetEntFireEntity(name)
    for i,v in pairs(ents.GetAll()) do
        if v:GetName() == name then
            print(v:GetClass())
            --return v
        end
        break
    end    
end
function FunctioningTurretReachedDummyShootPosition()
   
end 
function ScanMasterTurret()
   if !IsValid(AnnouncerVoice) then -- Pretty impractical but its the only way I could think of doing this. -- Miney
    AnnouncerVoice = GetEntFireEntity("npc_scanner_speaker")
   end
   --AnnouncerVoice:PlayScene("scenes/npc/announcer/sp_sabotage_factory_template01.vcd", 1)
   --AnnouncerVoice:EmitSound("vo/announcer/sp_sabotage_factory_line01.wav")
end
function FactoryWheatleyHey()
    for i,v in pairs(ents.GetAll()) do
        if v:GetName() == "@sphere" then
            timer.Simple(1, function()
                v:PlayScene("scenes/npc/sphere03/sp_sabotage_factory01.vcd", 4)
            end)
        end
    end
end
function FactoryFollowMe()
    for i,v in pairs(ents.GetAll()) do
        if v:GetName() == "@sphere" then
            timer.Simple(1, function()
                v:PlayScene("scenes/npc/sphere03/sp_sabotage_factory02.vcd", 4)
            end)
        end
    end
end
function FactoryAlmostThere()
    for i,v in pairs(ents.GetAll()) do
        if v:GetName() == "@sphere" then
            timer.Simple(1, function()
                v:PlayScene("scenes/npc/sphere03/sp_sabotage_factory24.vcd", 4)
            end)
        end
    end
end
function FactoryTahDah()
    for i,v in pairs(ents.GetAll()) do
        if v:GetName() == "@sphere" then
            timer.Simple(1, function()
                v:PlayScene("scenes/npc/sphere03/sp_sabotage_factory04.vcd", 4)
            end)
        end
    end
end
function FactoryScannerIntro()
    for i,v in pairs(ents.GetAll()) do
        if v:GetName() == "@sphere" then
            timer.Simple(1, function()
                v:PlayScene("scenes/npc/sphere03/sp_sabotage_factory05.vcd", 1)
                timer.Simple(v:PlayScene("scenes/npc/sphere03/sp_sabotage_factory05.vcd", 1), function()
                    v:PlayScene("scenes/npc/sphere03/sp_sabotage_factory06.vcd", 1)
                    timer.Simple(v:PlayScene("scenes/npc/sphere03/sp_sabotage_factory06.vcd", 1), function()
                        v:PlayScene("scenes/npc/sphere03/sp_sabotage_factory07.vcd", 1)
                    end)
                end)
            end)
        end
    end
end
function FactoryControlRoomHackSuccess()
    for i,v in pairs(ents.GetAll()) do
        if v:GetName() == "@sphere" then
            timer.Simple(1, function()
                v:PlayScene("scenes/npc/sphere03/sp_sabotage_factory08.vcd", 4)
            end)
        end
    end
end
function FunctioningTurretReachedDummyShootPosition()
end
function FactoryComputerControlRoomInsertNewTurret()
end
function HackFixSaveLoad()
end
function bts4_redemption_line_turret_safe()
    --EntFire("dummyshoot_conveyor_1_spawn_rl", "trigger", 0, totsecs)
	--EntFire("dummyshoot_conveyor_1_advance_train_relay", "trigger", 0, totsecs)
end