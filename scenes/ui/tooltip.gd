class_name Tooltip extends PanelContainer

@export var fade_seconds := 0.2

@onready var tooltip_icon: TextureRect = %TooltipIcon
@onready var tooltip_text_label: RichTextLabel = %TooltipText
@onready var timer: Timer = $Timer

var tween: Tween
var is_visible: bool = false


func _ready() -> void:
	Events.die_tooltip_requested.connect(show_tooltip)
	Events.tooltip_hide_requested.connect(hide_tooltip)
	modulate = Color.TRANSPARENT
	hide()
	timer.start(randf_range(0.5, 1.0))
	timer.timeout.connect(_on_timer)


func _on_timer() -> void:
	if tween:
		tween.kill()

	tween = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_CUBIC)
	tween.tween_callback(show)
	tween.tween_property(self, "modulate", Color.WHITE, fade_seconds)


func show_tooltip(icon: Texture, text: String) -> void:
	is_visible = true
	if tween:
		tween.kill()

	tooltip_icon.texture = icon
	tooltip_text_label.text = text
	tween = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_CUBIC)
	tween.tween_callback(show)
	tween.tween_property(self, "modulate", Color.WHITE, fade_seconds)


func hide_tooltip() -> void:
	pass
	# is_visible = false
	# if tween:
	# 	tween.kill()

	# get_tree().create_timer(fade_seconds, false).timeout.connect(hide_animation)


func hide_animation() -> void:
	if not is_visible:
		tween = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_CUBIC)
		tween.tween_property(self, "modulate", Color.TRANSPARENT, fade_seconds)
		tween.tween_callback(hide)
