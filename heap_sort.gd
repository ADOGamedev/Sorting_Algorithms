extends Node

var acumulated_delay = 0

func heap_sort(arr : Array, hash : Dictionary, bars_cont : HBoxContainer):
	var n = len(arr)
	await build_max_heap(arr, n, hash, bars_cont)
	for i in range(n - 1, -1, -1):
		await swap(0, i, arr, hash, bars_cont)
		n -= 1
		await heapify(arr, 0, i, hash, bars_cont)
		hash[arr[n]].select()
		await delay()
		hash[arr[n]].unselect()
	
	owner.owner.finish_sorting()
	
func build_max_heap(arr : Array, n : int, hash : Dictionary, bars_cont : HBoxContainer):
	for i in range(floor(n / 2) - 1, -1, -1):
		await heapify(arr, i, n, hash, bars_cont)
		hash[arr[i]].select()
		await delay()
		hash[arr[i]].unselect()
		
func heapify(arr : Array, i : int, n : int, hash : Dictionary, bars_cont : HBoxContainer):
	var l = i * 2 + 1
	var r = i * 2 + 2
	var max = i
	
	await delay()
	
	if l < n:
		owner.owner.comparisons += 1
		owner.owner.array_accesses += 2
		if arr[l] > arr[i]:
			max = l
	if r < n:
		owner.owner.comparisons += 1
		owner.owner.array_accesses += 2
		if arr[r] > arr[max]:
			max = r
			
	owner.owner.comparisons += 1
	if max != i:
		await swap(i, max, arr, hash, bars_cont)
		await heapify(arr, max, n, hash, bars_cont)

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
	
	await delay()
	
	hash[arr[i]].unselect()
	hash[arr[j]].unselect()
	
	
	
	
