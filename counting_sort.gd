extends Node

var acumulated_delay = 0

func counting_sort(arr : Array, hash : Dictionary, bars_cont : HBoxContainer):
	var org = []
	var count = []
	
	for i in range(len(arr) + 1):
		count.append(0)
		
	for n in arr:
		hash[n].select()
		owner.owner.play_pop(hash[n].num)
		await delay()
		hash[n].unselect()
		owner.owner.array_accesses += 2
		
		org.append(n)
		count[n] += 1
		
	for i in range(1, len(count)):
		hash[i].select()
		owner.owner.play_pop(hash[i].num)
		await delay()
		hash[i].unselect()
		owner.owner.array_accesses += 2
		
		count[i] += count[i - 1]
	
	for n in org:
		hash[n].select()
		owner.owner.play_pop(hash[n].num)
		await delay()
		hash[n].unselect()
		owner.owner.array_accesses += 4
		
		arr[count[n] - 1] = n
		count[n] -= 1
		
		for j in range(len(arr)):
			bars_cont.get_child(j).update_num(arr[j], len(arr))
		
	owner.owner.finish_sorting()

func delay():
	acumulated_delay += owner.owner.delay / 1000.0
	if acumulated_delay > (1.0 / Engine.get_frames_per_second()):
		await get_tree().create_timer(acumulated_delay).timeout
		acumulated_delay = 0
