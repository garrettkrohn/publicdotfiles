require("dbee.sources").MemorySource:new({
	{
		name = "kipsuLocal",
		type = "mysql",
		url = "mysql://root:123@127.0.0.1/kipsu_stage_v4?sslmode=disable",
	},
	-- ...
})
