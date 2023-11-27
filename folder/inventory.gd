extends Resource

class_name Inv

signal update

@export var slots: Array[InvSlot]
var slot_count

func insert(item: InvItem,enemy_hp,file_size,enemy_name):
	#var itemslots = slots.filter(func(slot): return slot.item == item)
	#if !itemslots.is_empty():
		#itemslots[0].slot_num += 1
		#itemslots[0].amount += 1
	#else:
	var emptyslots = slots.filter(func(slot): return slot.item == null)
	if !emptyslots.is_empty():
		slot_count = slots.find(emptyslots[0],0)
		emptyslots[0].item = item
		emptyslots[0].ehp = enemy_hp
		emptyslots[0].ename = enemy_name
		emptyslots[0].slot_num = slot_count
		emptyslots[0].file_size = file_size
	update.emit()
	
func removed(slot_num):
	#update.emit()
	slots[slot_num].item = null
	#if !itemslots.is_empty():
		#itemslots.pop_front()
		#print(itemslots)
		
func allremoved():
	for i in range(12):
		slots[i].item = null
