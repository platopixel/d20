class_name PlayerStats extends Stats

@export var starting_deck: DicePile
@export var dice_per_turn: int
@export var max_energy: int

var energy: int : set = set_energy
var deck: DicePile
var discard: DicePile
var draw_pile: DicePile


func set_energy(value: int) -> void:
	print('set starting energy:', value)
	energy = value
	stats_changed.emit()


func reset_energy() -> void:
	self.energy = max_energy


func can_play_die(die: DieModel) -> bool:
	return energy >= die.cost


func create_instance() -> Resource:
	var instance: PlayerStats = self.duplicate()
	instance.hp = max_hp
	instance.block = 0
	instance.reset_energy()
	instance.deck = instance.starting_deck.duplicate()
	instance.draw_pile = DicePile.new()
	instance.discard = DicePile.new()
	return instance
