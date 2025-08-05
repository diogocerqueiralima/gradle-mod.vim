local finder = require("finder")

local M = {}

function M.create_submodule()

    local settings_path = finder.find_settings_gradle()

    if not settings_path then
        print("No settings.gradle found in the project root.")
        return
    end



end

return M
