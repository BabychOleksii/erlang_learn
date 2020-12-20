{application, 'lesson_6', [
	{description, "New project"},
	{vsn, "0.1.0"},
	{modules, ['cache_server','cache_server_app','cache_server_sup']},
	{registered, []},
	{applications, [kernel,stdlib]},
	{env, []}
]}.