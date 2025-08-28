return {
    {
        "f-person/auto-dark-mode.nvim",
        lazy = false,   -- 不能设置为true
        priority = 1000,
        config = function()
        local auto_dark_mode = require('auto-dark-mode')

        -- 函数：更新 chadrc.lua 中的主题
        local function update_theme(theme_name)
        local config_path = vim.fn.stdpath("config") .. "/lua/chadrc.lua"

        -- 读取当前配置
        local file = io.open(config_path, "r")
        if not file then return end
            local content = file:read("*all")
            file:close()

            -- 替换主题名称
            local new_content = content:gsub('theme = "[^"]*"', 'theme = "' .. theme_name .. '"')

            -- 写回文件
            file = io.open(config_path, "w")
            if file then
                file:write(new_content)
                file:close()
                end

                -- 重新加载 NvChad
                require("nvchad.utils").reload()
                end

                auto_dark_mode.setup({
                    update_interval = 1000,
                    set_dark_mode = function()
                    update_theme("aquarium") -- 你喜欢的暗色主题
                    end,
                    set_light_mode = function()
                    update_theme("default-light") -- 你喜欢的亮色主题
                    end,
                })
                end,
    },
}
