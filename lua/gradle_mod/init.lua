function setup()

    local submodule = require("gradle_mod.submodule")

    vim.api.nvim_create_user_command("CreateSubmodule", function()
      submodule.create_submodule()
    end, {})

end

setup()

return {}
