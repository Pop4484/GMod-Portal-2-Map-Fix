local ElevatorMotifs =
{
	{ map = "sp_a1_intro1", speed = 200 },
	{ map = "sp_a1_intro2", speed = 200 },	// this is what we do for continual elevator shafts
	{ map = "sp_a1_intro3", speed = 200 },	// this is what we do for continual elevator shafts
	{ map = "sp_a1_intro5", speed = 200 },	// this is what we do for continual elevator shafts
	{ map = "sp_a1_intro6", speed = 200 },	// this is what we do for continual elevator shafts
	{ map = "sp_a2_bridge_intro", speed = 200  },
//	{ map = "sp_a2_laser_over_goo", speed = 300, motifs = [ "@shaft_stoppage_1", "transition", ] },
	{ map = "sp_a2_column_blocker", speed = 200 },
	{ map = "sp_a2_trust_fling", speed = 300 },


	{ map = "sp_a2_intro", speed = 125 },	
	{ map = "sp_a2_laser_intro", speed = 200 },
	{ map = "sp_a2_laser_stairs", speed = 200 },
	{ map = "sp_a2_dual_lasers", speed = 200 },
	{ map = "sp_a2_catapult_intro", speed = 200 },
	{ map = "sp_a2_pit_flings", speed = 200 },
//	{ map = "sp_a2_fizzler_intro", speed = 200 },
	{ map = "sp_a2_sphere_peek", speed = 200 },
	{ map = "sp_a2_ricochet", speed = 200 },
	{ map = "sp_a2_bridge_the_gap", speed = 200},
	{ map = "sp_a2_turret_intro", speed = 200 },
	{ map = "sp_a2_laser_relays", speed = 200 },
	{ map = "sp_a2_turret_blocker", speed = 200 },
	{ map = "sp_a2_laser_vs_turret", speed = 200 },
	{ map = "sp_a2_pull_the_rug", speed = 200 },
	{ map = "sp_a2_ring_around_turrets", speed = 200 },
	{ map = "sp_a2_laser_chaining", speed = 200 },
	{ map = "sp_a2_triple_laser", speed = 200 },
	{ map = "sp_a3_jump_intro", speed = 120 },
	{ map = "sp_a3_bomb_flings", speed = 120 },
	{ map = "sp_a3_crazy_box", speed = 120 },
	{ map = "sp_a3_speed_ramp", speed = 120 },
	{ map = "sp_a3_speed_flings", speed = 120 },
	{ map = "sp_a4_intro", speed = 200 },
	{ map = "sp_a4_tb_intro", speed = 200 },
	{ map = "sp_a4_tb_trust_drop", speed = 200 },
	{ map = "sp_a4_tb_wall_button", speed = 200 },
	{ map = "sp_a4_tb_polarity", speed = 200 },
	{ map = "sp_a4_tb_catch", speed = 100 },
	{ map = "sp_a4_stop_the_box", speed = 200 },
	{ map = "sp_a4_laser_catapult", speed = 200 },
	{ map = "sp_a4_speed_tb_catch", speed = 200 },
	{ map = "sp_a4_jump_polarity", speed = 200 },
}

function ReadyForTransition()
    // see if we need to teleport to somewhere else or 
    PrepareTeleport()
end

function PrepareTeleport()
    EntFire("@transition_from_map","Trigger","",0.0)
    EntFire("@transition_with_survey","Trigger","",0.0)
end