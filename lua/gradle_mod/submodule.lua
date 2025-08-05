local finder = require("gradle_mod.finder")

local M = {}

local uv = vim.loop

local function create_directories(base)
    vim.fn.mkdir(base .. "/src", "p")
    vim.fn.mkdir(base .. "/src/main", "p")
    vim.fn.mkdir(base .. "/src/main/java", "p")
    vim.fn.mkdir(base .. "/src/main/resources", "p")
end

local function write_build_gradle(path, group, version)
  local content = [[
plugins {
    id("java")
}

group = "]] .. group .. [["
version = "]] .. version .. [["

repositories {
    mavenCentral()
}

dependencies {
    testImplementation(platform("org.junit:junit-bom:5.10.0"))
    testImplementation("org.junit.jupiter:junit-jupiter")
}

tasks.test {
    useJUnitPlatform()
}

]]

  local fd = assert(io.open(path, "w"))
  fd:write(content)
  fd:close()
end

function M.create_submodule()
    local settings_path = finder.find_settings_gradle()
    if not settings_path then
        print("No settings.gradle.kts found in the project root.")
        return
    end

    local mod_name = vim.fn.input("Module name: ")
    local group = vim.fn.input("Group (default: com.example): ", "com.example")
    local version = vim.fn.input("Version (default: 1.0-SNAPSHOT): ", "1.0-SNAPSHOT")

    local lines = {}
    for line in io.lines(settings_path) do
    
        table.insert(lines, line)
        
        if line:match('include%(%s*"' .. mod_name .. '"%s*%)') then
            print("Module already included.")
            return
        end

    end

    table.insert(lines, 'include("' .. mod_name .. '")')

    local wfile = assert(io.open(settings_path, "w"))
    
    for _, line in ipairs(lines) do
        wfile:write(line .. "\n")
    end
    
    wfile:close()

    local base_dir = vim.fn.fnamemodify(settings_path, ":h") .. "/" .. mod_name
    create_directories(base_dir)
    write_build_gradle(base_dir .. "/build.gradle.kts", group, version)

    print("Submodule '" .. mod_name .. "' created successfully.")
end

return M
