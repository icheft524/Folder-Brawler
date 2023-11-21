extends Resource

class_name Inv

signal update

@export var slots: Array[InvSlot]

func insert(item: InvItem,enemy_hp,enemy_name):
	var itemslots = slots.filter(func(slot): return slot.item == item)
	#if !itemslots.is_empty():
		#itemslots[0].amount += 1
	#else:
	var emptyslots = slots.filter(func(slot): return slot.item == null)
	if !emptyslots.is_empty():
		emptyslots[0].item = item
		emptyslots[0].ehp = enemy_hp
		emptyslots[0].ename = enemy_name
	update.emit()
