local M = {}
local uv = vim.loop

function M.find_settings_gradle()

    local path = vim.fn.getcwd()
    if not path then
        return nil
    end

    while path do

        local settings_path = path .. '/settings.gradle.kts'
        if uv.fs_stat(settings_path) then
            return settings_path
        end

        local parent_path = uv.fs_realpath(path .. '/../')
        if not parent_path or parent_path == path then
            break
        end

        path = parent_path
    end

end

return M
