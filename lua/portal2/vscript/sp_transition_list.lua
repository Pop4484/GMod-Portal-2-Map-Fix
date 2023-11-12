// The code here is HEAVILY referenced from the Portal 2 VScript "sp_transition_list.nut"

// This is the order to play the maps
local MapPlayOrder = {

    // ===================================================
    // ====================== ACT 1 ======================
    // ===================================================
    
    // ---------------------------------------------------
    // 	Intro
    // ---------------------------------------------------
    "sp_a1_intro1",				// motel to box-on-button
    "sp_a1_intro2",				// portal carousel
    "sp_a1_intro3",				// fall-through-floor, dioramas, portal gun
    "sp_a1_intro4",				// box-in-hole for placing on button
    "sp_a1_intro5",				// fling hinting
    "sp_a1_intro6",				// fling training
    "sp_a1_intro7",				// wheatley meetup
    "sp_a1_wakeup",				// glados 
        "@incinerator",
    
    // ===================================================
    // ====================== ACT 2 ======================
    // ===================================================
    
    "sp_a2_intro", 		// upgraded portal gun track
    
    // ---------------------------------------------------
    //	Lasers
    // ---------------------------------------------------
    "sp_a2_laser_intro",
    "sp_a2_laser_stairs",
    "sp_a2_dual_lasers",
    "sp_a2_laser_over_goo",
    
    // ---------------------------------------------------
    // 	Catapult
    // ---------------------------------------------------
    "sp_a2_catapult_intro",
    "sp_a2_trust_fling",
    
    // ---------------------------------------------------
    //	More Lasers
    // ---------------------------------------------------
    "sp_a2_pit_flings",
    "sp_a2_fizzler_intro",
    
    // ---------------------------------------------------
    //	Lasers + Catapult
    // ---------------------------------------------------
    "sp_a2_sphere_peek",
    "sp_a2_ricochet",
    
    // ---------------------------------------------------
    // 	Bridges
    // ---------------------------------------------------
    "sp_a2_bridge_intro",
    "sp_a2_bridge_the_gap",
    
    // ---------------------------------------------------
    // 	Turrets
    // ---------------------------------------------------
    "sp_a2_turret_intro",
    "sp_a2_laser_relays", // breather
    "sp_a2_turret_blocker",
    "sp_a2_laser_vs_turret", // Elevator Glados Chat - Should be removed?
    
    // ---------------------------------------------------
    // 	Graduation
    // ---------------------------------------------------
    "sp_a2_pull_the_rug",
    "sp_a2_column_blocker",		// Elevator_vista
    "sp_a2_laser_chaining",
    //"sp_a2_turret_tower",
    "sp_a2_triple_laser",
    
    // ---------------------------------------------------
    // 	Sabotage
    // ---------------------------------------------------
    
    "sp_a2_bts1",
    "sp_a2_bts2",
    "sp_a2_bts3",
    "sp_a2_bts4",
    "sp_a2_bts5",
    "sp_a2_bts6",
    
    // ---------------------------------------------------
    // 	Glados Chamber Sequence
    // ---------------------------------------------------
    "sp_a2_core",
    
    
    // ===================================================
    // ====================== ACT 3 ======================
    // ===================================================
    
    // ---------------------------------------------------
    // 	Underground
    // ---------------------------------------------------
    
        "@bottomless_pit",
    "sp_a3_00",
    "sp_a3_01",
    "sp_a3_03",
        "@test_dome_lift",
    "sp_a3_jump_intro",
        "@test_dome_lift",
    "sp_a3_bomb_flings",
        "@test_dome_lift",
    "sp_a3_crazy_box",
        "@test_dome_lift",
    "sp_a3_transition01",
        "@test_dome_lift",
    "sp_a3_speed_ramp",
        "@test_dome_lift",
    "sp_a3_speed_flings",
        "@test_dome_lift",
    "sp_a3_portal_intro",
        "@hallway",
    "sp_a3_end",
    
    // ===================================================
    // ====================== ACT 4 ======================
    // ===================================================
    
    // ---------------------------------------------------
    // 	Recapture
    // ---------------------------------------------------
    "sp_a4_intro",
    
    // ---------------------------------------------------
    // 	Tractor beam
    // ---------------------------------------------------
    "sp_a4_tb_intro",
    "sp_a4_tb_trust_drop",	
    //	"@hallway",
    "sp_a4_tb_wall_button",
    //	"@hallway",
    "sp_a4_tb_polarity",
    //	"@hallway",
    "sp_a4_tb_catch",	// GRAD
    
    // ---------------------------------------------------
    // 	Crushers
    // ---------------------------------------------------
    
    // ---------------------------------------------------
    // 	Graduation Combos
    // ---------------------------------------------------
    "sp_a4_stop_the_box",	// Grad?
    //	"@hallway",
    "sp_a4_laser_catapult", // Grad
    //	"@hallway",
    //"sp_catapult_course"
    //	"@hallway",
    //"sp_box_over_goo", // Grad
    //	"@hallway",
    "sp_a4_laser_platform",
    
    // ---------------------------------------------------
    // Tbeam + Paint
    // ---------------------------------------------------
    //"sp_paint_jump_tbeam",
    //	"@hallway",
    "sp_a4_speed_tb_catch",
    //	"@hallway",
    "sp_a4_jump_polarity",	// GRAD
    //	"@hallway",
    //"sp_paint_portal_tbeams",
    
    // ---------------------------------------------------
    // Wheatley Escape
    // ---------------------------------------------------
    
    "sp_a4_finale1",
        "@hallway",
    "sp_a4_finale2",
        "@hallway",
    "sp_a4_finale3",
        "@hallway",
    
    // ---------------------------------------------------
    // 	FIXME: WHEATLEY BATTLE
    // ---------------------------------------------------
    
    "sp_a4_finale4",
    
    // ---------------------------------------------------
    // 	Demo files
    // ---------------------------------------------------
    "demo_intro",
    "demo_underground",
    "demo_paint",
}
    
function OnPostTransition()
    local foundMap = false

    for ind,map in pairs(MapPlayOrder) do
        if game.GetMap() == MapPlayOrder[ind] then
            foundMap = true
            //ply:PrintMessage(HUD_PRINTCONSOLE,"Hey! "..MapPlayOrder[ind].." is a Portal 2 map!!! THIS WORKS!!!")
            IsPortal2Map = true
            // hook up our entry elevator
            if ind - 1 >= 0 then
                /*
                    EntFire( "@arrival_teleport", "Teleport", 0, 0 )
                */
                local arrival_teleport = ents.FindByName("@arrival_teleport") // sp_a2_trust_fling uses this so ill assume every other map uses it too
                if IsValid(arrival_teleport[1]) then
                    arrival_teleport[1]:Fire("teleport")
                    local arrival_elevator_elevator_1 = ents.FindByName("arrival_elevator-elevator_1")
                    if (IsValid(arrival_elevator_elevator_1[1])) then
                        arrival_elevator_elevator_1[1]:Fire("startforward")
                    end
                else
                    //ply:PrintMessage(HUD_PRINTCENTER,"Oopsies! @arrival_teleport was not found!")
                end
            end

            break
        end
    end


end



///////////////////////////
// sp_transition_list.nut//
///////////////////////////

local CHAPTER_TITLES = {
    { map = "sp_a1_intro1", title_text = "#portal2_Chapter1_Title", subtitle_text = "#portal2_Chapter1_Subtitle", displayOnSpawn = false,		displaydelay = 1.0 },
    { map = "sp_a2_laser_intro", title_text = "#portal2_Chapter2_Title", subtitle_text = "#portal2_Chapter2_Subtitle", displayOnSpawn = true,	displaydelay = 2.5 },
    { map = "sp_a2_sphere_peek", title_text = "#portal2_Chapter3_Title", subtitle_text = "#portal2_Chapter3_Subtitle", displayOnSpawn = true,	displaydelay = 2.5 },
    { map = "sp_a2_column_blocker", title_text = "#portal2_Chapter4_Title", subtitle_text = "#portal2_Chapter4_Subtitle", displayOnSpawn = true, displaydelay = 2.5 },
    { map = "sp_a2_bts3", title_text = "#portal2_Chapter5_Title", subtitle_text = "#portal2_Chapter5_Subtitle", displayOnSpawn = true,			displaydelay = 1.0 },
    { map = "sp_a3_00", title_text = "#portal2_Chapter6_Title", subtitle_text = "#portal2_Chapter6_Subtitle", displayOnSpawn = true,			displaydelay = 1.5 },
    { map = "sp_a3_speed_ramp", title_text = "#portal2_Chapter7_Title", subtitle_text = "#portal2_Chapter7_Subtitle", displayOnSpawn = true,	displaydelay = 1.0 },
    { map = "sp_a4_intro", title_text = "#portal2_Chapter8_Title", subtitle_text = "#portal2_Chapter8_Subtitle", displayOnSpawn = true,			displaydelay = 2.5 },
    { map = "sp_a4_finale1", title_text = "#portal2_Chapter9_Title", subtitle_text = "#portal2_Chapter9_Subtitle", displayOnSpawn = false,		displaydelay = 1.0 },
}

// Display the chapter title (portal 2 vscript code lol)
/*function DisplayChapterTitle()
{
    foreach (index, level in CHAPTER_TITLES)
    {
        if (level.map == GetMapName() )
        {
            EntFire( "@chapter_title_text", "SetTextColor", "210 210 210 128", 0.0 )
            EntFire( "@chapter_title_text", "SetTextColor2", "50 90 116 128", 0.0 )
            EntFire( "@chapter_title_text", "SetPosY", "0.32", 0.0 )
            EntFire( "@chapter_title_text", "SetText", level.title_text, 0.0 )
            EntFire( "@chapter_title_text", "display", "", level.displaydelay )
            
            EntFire( "@chapter_subtitle_text", "SetTextColor", "210 210 210 128", 0.0 )
            EntFire( "@chapter_subtitle_text", "SetTextColor2", "50 90 116 128", 0.0 )
            EntFire( "@chapter_subtitle_text", "SetPosY", "0.35", 0.0 )
            EntFire( "@chapter_subtitle_text", "settext", level.subtitle_text, 0.0 )
            EntFire( "@chapter_subtitle_text", "display", "", level.displaydelay )
        }
    }
}*/

function DisplayChapterTitle()
    for index,level in pairs(CHAPTER_TITLES) do
        if level.map == game.GetMap() then
            local chapter_title_text = ents.FindByName("@chapter_title_text")[0]
            chapter_title_text:Fire("SetTextColor", "210 210 210 128")
            chapter_title_text:Fire("SetTextColor2", "50 90 116 128")
            chapter_title_text:Fire("SetPosY", "0.32")
            chapter_title_text:Fire("SetText", level.TitleText)
            chapter_title_text:Fire("Display", "" ,level.displaydelay)

            local chapter_subtitle_text = ents.FindByName("@chapter_subtitle_text")[0]
            chapter_title_text:Fire("SetTextColor", "210 210 210 128")
            chapter_title_text:Fire("SetTextColor2", "50 90 116 128")
            chapter_title_text:Fire("SetPosY", "0.35")
            chapter_title_text:Fire("SetText", level.subtitle_text)
            chapter_title_text:Fire("Display", "" ,level.displaydelay)
        end
    end
end