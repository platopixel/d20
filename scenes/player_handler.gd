class_name PlayerHandler extends Node

const HAND_DRAW_INTERVAL := 0.25 # delay for each die drawn so they don't all come out at once
const HAND_DISCARD_INTERVAL := 0.25

@export var hand: Hand

var player_stats: PlayerStats


func _ready() -> void:
	Events.die_played.connect(_on_die_played)

func start_battle(new_player_stats: PlayerStats) -> void:
	player_stats = new_player_stats
	player_stats.draw_pile = player_stats.deck.duplicate(true)
	player_stats.draw_pile.shuffle()
	player_stats.discard = DicePile.new() # discard pile is just an empty pile to start
	start_turn()


func start_turn() -> void:
	player_stats.block = 0
	player_stats.reset_energy()
	draw_dice(player_stats.dice_per_turn)


func end_turn() -> void:
	hand.disable_hand()
	discard_dice()


func draw_die() -> void:
	reshuffle_deck_from_discard()
	hand.add_die(player_stats.draw_pile.draw_die())
	reshuffle_deck_from_discard()


func draw_dice(amount: int) -> void:
	var tween := create_tween()
	for i in range(amount):
		tween.tween_callback(draw_die)
		tween.tween_interval(HAND_DRAW_INTERVAL)

	tween.finished.connect(
		func(): Events.player_hand_drawn.emit()
	)


func discard_dice() -> void:
	var tween := create_tween()
	for die in hand.get_children():
		tween.tween_callback(player_stats.discard.add_die.bind(die.die))
		tween.tween_callback(hand.discard_die.bind(die))
		tween.tween_interval(HAND_DISCARD_INTERVAL)

	tween.finished.connect(
		func():
			Events.player_hand_discarded.emit()
	)


func reshuffle_deck_from_discard() -> void:
	if not player_stats.draw_pile.empty():
		return

	while not player_stats.discard.empty():
		player_stats.draw_pile.add_die(player_stats.discard.draw_die())

	player_stats.draw_pile.shuffle()


func _on_die_played(die: DieModel) -> void:
	player_stats.discard.add_die(die)
