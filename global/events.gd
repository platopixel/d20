extends Node

# Card-related events
signal die_drag_started(die: Die)
signal die_drag_ended(die: Die)
signal die_aim_started(die: Die)
signal die_aim_ended(die: Die)
signal die_played(die: DieModel)
signal die_tooltip_requested(die: DieModel)
signal tooltip_hide_requested

# Player-related events
signal player_hand_drawn
signal player_hand_discarded
signal player_turn_ended

# Enemy-related events
signal enemy_action_completed(enemy: Enemy)
signal enemy_turn_ended
