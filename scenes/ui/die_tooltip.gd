class_name DieTooltip extends Tooltip


func _ready() -> void:
	Events.die_tooltip_requested.connect(show_tooltip)
	super()
