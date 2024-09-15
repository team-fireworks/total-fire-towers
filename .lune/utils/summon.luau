local process = require("@lune/process")

local SPAWN_OPTIONS = {
	shell = true,
} :: process.SpawnOptions

local function summon(program: string, ...: string)
	local arguments = { ... }
	local result = process.spawn(program, arguments, SPAWN_OPTIONS)

	print(result.stdout)
	print(result.stderr)

	if not result.ok then
		return error("Process exited with code", result.code)
	end

	return result
end

return summon
