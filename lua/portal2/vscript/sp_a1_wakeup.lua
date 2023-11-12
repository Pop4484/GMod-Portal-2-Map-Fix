
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
    
function sp_a1_wakeup_WheatleyGettingGrabbed()
    EntFire("lcs_wheatley_sphere_crush","Start", "", 0)
end