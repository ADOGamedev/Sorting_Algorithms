extends Node2D

func bubble_sort(arr : Array, hash : Dictionary, bar_cont : HBoxContainer):
	$bubble_sort.bubble_sort(arr, hash, bar_cont)
	
func selection_sort(arr : Array, hash : Dictionary, bar_cont : HBoxContainer):
	$selection_sort.selection_sort(arr, hash, bar_cont)

func insertion_sort(arr : Array, hash : Dictionary, bar_cont : HBoxContainer):
	$insertion_sort.insertion_sort(arr, hash, bar_cont)

func merge_sort(arr : Array, hash : Dictionary, bar_cont : HBoxContainer):
	await $merge_sort.merge_sort(arr, 0, hash, bar_cont)
	owner.finish_sorting()

func quick_sort(arr : Array, hash : Dictionary, bar_cont : HBoxContainer):
	await $quick_sort.quick_sort(arr, 0, len(arr) - 1, hash, bar_cont)
	owner.finish_sorting()
	
func heap_sort(arr : Array, hash : Dictionary, bar_cont : HBoxContainer):
	$heap_sort.heap_sort(arr, hash, bar_cont)
	
func counting_sort(arr : Array, hash : Dictionary, bar_cont : HBoxContainer):
	$counting_sort.counting_sort(arr, hash, bar_cont)
	
func shell_sort(arr : Array, hash : Dictionary, bar_cont : HBoxContainer):
	$shell_sort.shell_sort(arr, hash, bar_cont)
	
func tim_sort(arr : Array, hash : Dictionary, bar_cont : HBoxContainer):
	$tim_sort.tim_sort(arr, hash, bar_cont)
	
func radix_sort(arr : Array, hash : Dictionary, bar_cont : HBoxContainer):
	$radix_sort.radix_sort(arr, hash, bar_cont)

func bogo_sort(arr : Array, hash : Dictionary):
	$bogo_sort.bogo_sort(arr, hash)
