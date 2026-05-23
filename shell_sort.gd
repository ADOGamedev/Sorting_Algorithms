extends Node

var acumulated_delay = 0

func shell_sort(arr : Array, hash : Dictionary, bars_cont : HBoxContainer):
	var gap = len(arr)
	while gap > 0:
		gap /= 2
		
		for i in range(gap, len(arr)):
			owner.owner.array_accesses += 1
			var tmp = arr[i]
			var j = i
			
			while j >= gap and arr[j - gap] > tmp:
				owner.owner.comparisons += 2
				owner.owner.array_accesses += 1

				swap(j, j - gap, arr, hash, bars_cont)
				
				await delay()
				
				hash[arr[j]].unselect()
				hash[arr[j - gap]].unselect()
			
				j -= gap
					
	owner.owner.finish_sorting()

func delay():
	acumulated_delay += owner.owner.delay / 1000.0
	if acumulated_delay > (1.0 / Engine.get_frames_per_second()):
		await get_tree().create_timer(acumulated_delay).timeout
		acumulated_delay = 0
	
func swap(i : int, j : int, arr : Array, hash : Dictionary, bars_cont : HBoxContainer):
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
	
