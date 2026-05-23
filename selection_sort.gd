extends Node

var acumulated_delay = 0

func selection_sort(arr : Array, hash : Dictionary, bars_cont : HBoxContainer):
	for i in range(len(arr)):
		var min_i = i
		
		for j in range(i, len(arr)):
			# Find min
			owner.owner.comparisons += 1
			owner.owner.array_accesses += 2
			if arr[j] < arr[min_i]:
				min_i = j
				owner.owner.play_pop(hash[arr[min_i]].num)
				
			hash[arr[j]].select()
			hash[arr[min_i]].select()
			
			owner.owner.play_pop(hash[arr[j]].num)
			
			await delay()
			
			hash[arr[min_i]].unselect()
			hash[arr[j]].unselect()
			
		owner.owner.array_accesses += 4
			
		# Swap min
		var tmp = arr[i]
				
		bars_cont.move_child(hash[arr[min_i]], i)
		arr[i] = arr[min_i]
				
		bars_cont.move_child(hash[tmp], min_i)
		arr[min_i] = tmp

	owner.owner.finish_sorting()
		
func delay():
	acumulated_delay += owner.owner.delay / 1000.0
	if acumulated_delay > (1.0 / Engine.get_frames_per_second()):
		await get_tree().create_timer(acumulated_delay).timeout
		acumulated_delay = 0
	
func swap(i : int, j : int, arr : Array, hash : Dictionary, bars_cont : HBoxContainer, acumulated_delay : float):
	hash[arr[i]].select()
	
	owner.owner.play_pop(hash[arr[i]].num)
	owner.owner.play_pop(hash[arr[j]].num)
	owner.owner.array_accesses += 4
			
	var tmp = arr[i]
				
	bars_cont.move_child(hash[arr[j]], i)
	hash[arr[j]].select()
	arr[i] = arr[j]
				
	bars_cont.move_child(hash[tmp], j)
	hash[tmp].select()
	arr[j] = tmp
