local Cooldown = CurTime()
local PlayedPart1 = false
local PlayedPart2 = false
function StartClawPickup()  // 45.4
    //EntFire("@glados","RunScriptCode", "sp_a1_wakeup_WheatleyGettingGrabbed()", 1.2)

    for i,v in pairs(player.GetAll()) do
        v:SetNoDraw(true)
    end

    timer.Simple(1.2,function()
        sp_a1_wakeup_WheatleyGettingGrabbed() // do it like this
    end)

    EntFire("glados_cables_hip_03","DisableDraw", "", 1.2)

    EntFire("claw_clang_sound","PlaySound", "", 2.2)

    EntFire("camera_1","Enable", "", 2.2)

    EntFire("trigger_weapon_strip", "Enable", "", 2.6)

    EntFire("camera_1","Disable", "", 3.4)
    EntFire("camera_ghostAnim_2","Enable", "", 3.4)
    
    EntFire("@sphere","SetParent", "ghostAnim", 3.4) // delay this until we aren't looking at wheatley.
    EntFire("@sphere","SetParentAttachment", "attach_2", 3.5) 

    EntFire("gun_shooter", "Shoot", "", 6 )

    timer.Simple(30.6,function()
        for i,v in pairs(player.GetAll()) do
            v:SetNoDraw(false)
        end
    end)
    
    EntFire("relay_incinerator_open","Trigger", "", 30.6)
end
function CatWalkScenes(ent,Scene1, Scene2, Scene3)
    ent:PlayScene("scenes/npc/sphere03/" .. Scene1 .. ".vcd", 1)
    ent:EmitSound("vo/wheatley/".. Scene1 ..".wav", 75, 100, 1, CHAN_VOICE)
    timer.Simple(ent:PlayScene("scenes/npc/sphere03/" .. Scene1 .. ".vcd", 1), function()
        ent:PlayScene("scenes/npc/sphere03/" .. Scene2 .. ".vcd", 1)
        ent:EmitSound("vo/wheatley/".. Scene2 ..".wav", 75, 100, 1, CHAN_VOICE)
        timer.Simple(ent:PlayScene("scenes/npc/sphere03/" .. Scene2 .. ".vcd", 1), function()
            ent:PlayScene("scenes/npc/sphere03/" .. Scene3 .. ".vcd", 3)
            ent:EmitSound("vo/wheatley/".. Scene3 ..".wav", 75, 100, 1, CHAN_VOICE)
        end)
    end)
end
function PlayWheatleyScene(ent,Scene,delay) 
    ent:PlayScene("scenes/npc/sphere03/" .. Scene .. ".vcd", delay)
end   
function sp_a1_wakeup_WheatleyGettingGrabbed()
    EntFire("lcs_wheatley_sphere_crush","Start", "", 0)
end
function sp_a1_wakeup_inside_observation()
    if CurTime() < Cooldown then return end
    if !PlayedPart1 then
    for i,v in pairs(ents.GetAll()) do
        if v:GetName() == "@sphere" and CurTime() > Cooldown then
            PlayedPart1 = true
            Cooldown = CurTime() + (v:PlayScene("scenes/npc/sphere03/gladosgantry20.vcd", 1) + v:PlayScene("scenes/npc/sphere03/gladosgantry21.vcd", 1) + v:PlayScene("scenes/npc/sphere03/gladosgantry22.vcd", 1)) + 8
            v:PlayScene("scenes/npc/sphere03/gladosgantry20.vcd", 1)
            v:EmitSound("vo/wheatley/gladosgantry20.wav", 75, 100, 1, CHAN_VOICE)
            timer.Simple(v:PlayScene("scenes/npc/sphere03/gladosgantry20.vcd", 1),function()
                v:PlayScene("scenes/npc/sphere03/gladosgantry21.vcd", 1)
                v:EmitSound("vo/wheatley/gladosgantry21.wav", 75, 100, 1, CHAN_VOICE)
                timer.Simple(v:PlayScene("scenes/npc/sphere03/gladosgantry21.vcd", 1),function()
                    v:PlayScene("scenes/npc/sphere03/gladosgantry22.vcd", 1)
                    v:EmitSound("vo/wheatley/gladosgantry22.wav", 75, 100, 1, CHAN_VOICE)
                end)
            end)        
        end
      end
    elseif !PlayedPart2 and PlayedPart1 and CurTime() > Cooldown then
        for i,v in pairs(ents.GetAll()) do
            if v:GetName() == "@sphere" then
                Cooldown = CurTime() + (v:PlayScene("scenes/npc/sphere03/gladosgantry15.vcd", 1) + v:PlayScene("scenes/npc/sphere03/gladosgantry05.vcd", 1) + v:PlayScene("scenes/npc/sphere03/gladosgantry06.vcd", 1) + v:PlayScene("scenes/npc/sphere03/gladosgantry08.vcd", 1) ) + 8
                v:PlayScene("scenes/npc/sphere03/gladosgantry15.wav", 1)
                v:EmitSound("vo/wheatley/gladosgantry15.wav", 75, 100, 1, CHAN_VOICE)
                timer.Simple(v:PlayScene("scenes/npc/sphere03/gladosgantry15.vcd", 1),function()
                    v:PlayScene("scenes/npc/sphere03/gladosgantry05.vcd", 1)
                    v:EmitSound("vo/wheatley/gladosgantry05.wav", 75, 100, 1, CHAN_VOICE)
                    timer.Simple(v:PlayScene("scenes/npc/sphere03/gladosgantry05.vcd", 1),function()
                        v:PlayScene("scenes/npc/sphere03/gladosgantry06.vcd", 1)
                        v:EmitSound("vo/wheatley/gladosgantry06.wav", 75, 100, 1, CHAN_VOICE)
                        timer.Simple(v:PlayScene("scenes/npc/sphere03/gladosgantry06.vcd", 1),function()
                            v:PlayScene("scenes/npc/sphere03/gladosgantry08.vcd", 1)
                            v:EmitSound("vo/wheatley/gladosgantry08.wav", 75, 100, 1, CHAN_VOICE)
                            PlayedPart2 = true
                        end)
                    end)
                end)
            end
        end
    end
end
function sp_a1_wakeup_gantry_door_open()
   for i,v in pairs(ents.GetAll()) do
       if v:GetClass() == "npc_personality_core" then
           v:PlayScene("scenes/npc/sphere03/sp_a1_wakeup_gantry01.vcd", 1)
           v:EmitSound("vo/wheatley/sp_a1_wakeup_gantry01.wav", 75, 100, 1, CHAN_VOICE)
       end
    end
end
function sp_a1_wakeup_there_she_is()
    for i,v in pairs(ents.GetAll()) do
        if v:GetClass() == "npc_personality_core" then
            v:PlayScene("scenes/npc/sphere03/demospheregladoschamber01.wav")
            v:EmitSound("vo/wheatley/demospheregladoschamber01.wav", 75, 100, 1, CHAN_VOICE)
            timer.Simple(v:PlayScene("scenes/npc/sphere03/demospheregladoschamber01.vcd", 1),function()
                v:PlayScene("scenes/npc/sphere03/demospheregladoschamber06.vcd", 1)
                v:EmitSound("vo/wheatley/demospheregladoschamber06.wav", 75, 100, 1, CHAN_VOICE)
                timer.Simple(v:PlayScene("scenes/npc/sphere03/demospheregladoschamber06.vcd", 1),function()
                    v:PlayScene("scenes/npc/sphere03/demospheregladoschamber07.vcd", 1)
                    v:EmitSound("vo/wheatley/demospheregladoschamber07.wav", 75, 100, 1, CHAN_VOICE)
                    timer.Simple(v:PlayScene("scenes/npc/sphere03/demospheregladoschamber07.vcd", 1),function()
                        v:PlayScene("scenes/npc/sphere03/demospheregladoschamber08.vcd", 1)
                        v:EmitSound("vo/wheatley/demospheregladoschamber08.wav", 75, 100, 1, CHAN_VOICE)
                        timer.Simple(v:PlayScene("scenes/npc/sphere03/demospheregladoschamber08.vcd", 1),function()
                            v:PlayScene("scenes/npc/sphere03/demospheregladoschamber09.vcd", 1)
                            v:EmitSound("vo/wheatley/demospheregladoschamber09.wav", 75, 100, 1, CHAN_VOICE)
                            timer.Simple(v:PlayScene("scenes/npc/sphere03/demospheregladoschamber09.vcd", 1),function()
                                v:PlayScene("scenes/npc/sphere03/demospheregladoschamber11.vcd", 1)
                                v:EmitSound("vo/wheatley/demospheregladoschamber11.wav", 75, 100, 1, CHAN_VOICE)
                            end)
                        end)
                    end)
                end)
            end)
        end
     end
end
function sp_a1_wakeup_Falling()
    for i,v in pairs(ents.GetAll()) do
        if v:GetClass() == "npc_personality_core" then
            v:PlayScene("scenes/npc/sphere03/sp_a1_wakeup_panic01.vcd", 1)
            v:EmitSound("vo/wheatley/sp_a1_wakeup_panic01.wav", 75, 100, 1, CHAN_VOICE)
        end
     end
end
function sp_a1_wakeup_Landed()
    for i,v in pairs(ents.GetAll()) do
        if v:GetClass() == "npc_personality_core" then
            v:PlayScene("scenes/npc/sphere03/sp_a1_wakeupLanded01.vcd", 1)
        end
    end
end
function sp_a1_wakeup_Do_Not_Look_Down()
    for i,v in pairs(ents.GetAll()) do
        if v:GetClass() == "npc_personality_core" then
            CatWalkScenes(v,"sp_a1_wakeup_catwalk01", "sp_a1_wakeup_catwalk02", "sp_a1_wakeup_catwalk03")
        end
    end
end
function sp_a1_wakeup_This_Is_Breaker_Room()
    for i,v in pairs(ents.GetAll()) do
        if v:GetClass() == "npc_personality_core" then
            PlayWheatleyScene(v,"demosphereswitchroom04",1)
            v:EmitSound("vo/wheatley/demosphereswitchroom04.wav", 75, 100, 1, CHAN_VOICE)
            timer.Simple(v:PlayScene("scenes/npc/sphere03/demosphereswitchroom04.vcd", 1),function()
                v:PlayScene("scenes/npc/sphere03/demosphereswitchroom09.vcd", 1)
                v:EmitSound("vo/wheatley/demosphereswitchroom09.wav", 75, 100, 1, CHAN_VOICE)
                timer.Simple(v:PlayScene("scenes/npc/sphere03/demosphereswitchroom09.vcd", 1),function()
                    v:PlayScene("scenes/npc/sphere03/demosphereswitchroom05.vcd", 1)
                    v:EmitSound("vo/wheatley/demosphereswitchroom05.wav", 75, 100, 1, CHAN_VOICE)
                    timer.Simple(v:PlayScene("scenes/npc/sphere03/demosphereswitchroom05.vcd", 1)+1,function()
                        v:PlayScene("scenes/npc/sphere03/demosphereswitchroom06.vcd", 1)
                        v:EmitSound("vo/wheatley/demosphereswitchroom06.wav", 75, 100, 1, CHAN_VOICE)
                        timer.Simple(v:PlayScene("scenes/npc/sphere03/demosphereswitchroom06.vcd", 1),function()
                            EntFire("basement_breakers_socket_relay", "trigger","",1)
                        end)
                    end)
                end)
            end)
        end
    end
end
function sp_a1_wakeup_Do_Not_Touch()

end
function sp_a1_wakeup_Lights_On()
   for i,v in pairs(ents.GetAll()) do
        if v:GetClass() == "npc_personality_core" then
            v:PlayScene("scenes/npc/sphere03/demosphereswitchroom08.vcd", 1)
            v:EmitSound("vo/wheatley/demosphereswitchroom08.wav", 75, 100, 1, CHAN_VOICE)
        end
    end
end
function sp_a1_wakeup_Oops()
   for i,v in pairs(ents.GetAll()) do
        if v:GetClass() == "npc_personality_core" then
            v:PlayScene("scenes/npc/sphere03/sp_a1_wakeup_breakerroom_turn03.vcd", 1)
            v:EmitSound("vo/wheatley/sp_a1_wakeup_breakerroom_turn03.wav", 75, 100, 1, CHAN_VOICE)
        end
    end
end
function sp_a1_wakeup_ElevatorBreakerRideFinished()
   
end
function FactoryWheatleyHey()
    print("called")
 end
 function FactoryFollowMe()
    print("called")
 end