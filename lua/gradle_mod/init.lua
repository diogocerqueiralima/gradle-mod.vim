local M = {}

function M.setup()

    print("Setting up gradle_mod...")

    local submodule = require("gradle_mod.submodule")

    vim.api.nvim_create_user_command("CreateSubmodule", function()
      submodule.create_submodule()
    end, {})

end

return M
