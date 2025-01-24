class_name IntentUI extends HBoxContainer

@onready var icon: TextureRect = $Icon
@onready var amount_label: Label = $Amount


func update_intent(intent: Intent) -> void:
	if not intent:
		hide()
		return

	icon.texture = intent.icon
	icon.visible = icon.texture != null
	amount_label.text = str(intent.number)
	amount_label.visible = intent.number.length() > 0
	show()
