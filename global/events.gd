extends Node

# Card-related events
signal die_drag_started(die: Die)
signal die_drag_ended(die: Die)
signal die_aim_started(die: Die)
signal die_aim_ended(die: Die)
signal die_played(die: DieModel)
signal die_tooltip_requested(text: String)
signal tooltip_hide_requested

# Player-related events
signal player_hand_drawn
signal player_hand_discarded
signal player_turn_ended
signal player_hit
signal player_died

# Enemy-related events
signal enemy_tooltip_requested(stats: EnemyStats)
signal enemy_action_completed(enemy: Enemy)
signal enemy_turn_ended
