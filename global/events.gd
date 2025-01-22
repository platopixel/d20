extends Node

# Card-related events
signal die_drag_started(die: Die)
signal die_drag_ended(die: Die)
signal die_aim_started(die: Die)
signal die_aim_ended(die: Die)
signal die_played(die: DieModel)
signal die_tooltip_requested(die: DieModel)
signal tooltip_hide_requested
