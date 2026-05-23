extends Node

var acumulated_delay = 0

func quick_sort(arr : Array, start : int, end : int, hash : Dictionary, bars_cont : HBoxContainer):
	if end <= start:
		return
		
	var pivot = await partition(arr, start, end, hash, bars_cont)
	await quick_sort(arr, start, pivot - 1, hash, bars_cont)
	await quick_sort(arr, pivot + 1, end, hash, bars_cont)
	
func partition(arr : Array, start : int, end : int, hash : Dictionary, bars_cont : HBoxContainer):
	var i = start - 1
	owner.owner.array_accesses += 1
	var pivot = arr[end]
	
	for j in range(start, end):
		owner.owner.array_accesses += 1
		owner.owner.comparisons += 1
		if arr[j] < pivot:
			i += 1
			
			swap(i, j, arr, hash, bars_cont)
			await delay()
			
			hash[arr[j]].unselect()
			hash[arr[i]].unselect()
	
	i += 1
	swap(i, end, arr, hash, bars_cont)
	
	await delay()
			
	hash[arr[end]].unselect()
	hash[arr[i]].unselect()
	
	return i

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
				
	
