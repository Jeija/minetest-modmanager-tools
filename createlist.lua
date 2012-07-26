dofile ("table.lua")

local s = ""
local list = {}
local filename = "mods.list"
local command

while command ~="quit" do
	print("command: ")
	command = io.read()
	if command == "help" then
		print("Modlist Creation Utility for Minetest")
		print("Available commands:")
		print("filename : Enter another filename for the modlist (default:mod.list)")
		print("load     : Load the old mods.list (to change it)")
		print("add      : Add a mod")
		print("list     : List all mods")
		print("update   : Update a mod [WIP]")
		print("remove   : Remove a mod")
	elseif command == "filename" then
		print("Enter filename: ")
		filename = io.read()
	elseif command == "load" then
		list, err = table.load(filename)
		if err ~= nil then
			list = {}
			print("Table could not be loaded. Make sure the file exists. Error: "..err.."  Filename: "..filename)
		else
			print("Success!")
		end
	elseif command == "add" then
		print("name: ")
		local name = io.read()
		print("url: ")
		local url = io.read()
		print("description")
		local description = io.read()
		print("version")
		local version = io.read()
		local modspec = {name=name, url=url, description=description, version=version}
		table.insert(list, modspec)
	elseif command == "list" then
		local i = 1
		while (list[i]~=nil) do
			print("name       : "..list[i].name       )
			print("url        : "..list[i].url        )
			print("description: "..list[i].description)
			print("version    : "..list[i].version    )
			print("")
			i = i + 1
		end
	elseif command == "remove" then
		print("name: ")
		local name = io.read()
		local i = 1
		while (list[i]~=nil) do
			if list[i].name == name then
				list[i] = nil
				j = i + 1
				while (list[j]~=nil) do
					if list[j]~=nil then
						list[j-1] = list[j]
						list[j] = nil
					end
				end
			end
			i = i + 1
		end
	elseif command == "update" then
		print("name: ")
		local name = io.read()
		local i = 1
		local found = false
		while (list[i]~=nil) do
			if list[i].name == name then
				print("Enter nothing to keep old info")
				print("url")
				local url = io.read()
				if url~="" then list[i].url = url end
				print("description")
				local description = io.read()
				if description~="" then list[i].description = description end
				print("version")
				local version = io.read()
				if version~="" then list[i].version = version end
				found = true
			end
			i = i + 1
		end
		if not found then print("Error: Mod not found.") end
	else
		print("Command not found. Enter 'help' for more information.")
	end
end

print("Saving to "..filename)
table.save(list, filename)
print("Done!")
