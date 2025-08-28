return {
    "CRAG666/code_runner.nvim",
    cmd = { "RunCode", "RunFile", "RunProject", "RunClose" },
    config = function()
    require("code_runner").setup({
        -- 选择运行模式 'term' 或 'float'
    mode = "float",
    -- 焦点设置
    focus = true,
    -- 启动前保存文件
    startinsert = false,
    term = {
        position = "bot",
        size = 10,
    },
    float = {
        border = "rounded",
        height = 0.8,
        width = 0.8,
        x = 0.5,
        y = 0.5,
        border_hl = "FloatBorder",
        float_hl = "Normal",
        blend = 0,
    },
    filetype = {
        c = {
            -- 使用 clang 编译并运行
            "cd $dir &&",
            "clang -Wall -Wextra -O2 -o $fileNameWithoutExt $fileName &&",
            "$dir/$fileNameWithoutExt"
        },
    },
    })

    -- 创建自动命令组，确保运行前保存
    vim.api.nvim_create_autocmd("FileType", {
        pattern = { "c", "cpp", "python", "java", "javascript", "typescript", "lua" },
        callback = function()
        vim.api.nvim_buf_set_keymap(
            0,
            "n",
            "<F5>",
            "<cmd>w<CR><cmd>RunCode<CR>",
            { noremap = true, silent = true, desc = "Save and Run Code" }
        )
        end,
    })
    end,
    keys = {
        -- F5 运行代码（自动保存）
        {
            "<F5>",
            "<cmd>w<CR><cmd>RunCode<CR>",
            desc = "Save and Run Code"
        },
        -- Shift+F5 停止运行
        {
            "<S-F5>",
            "<cmd>RunClose<CR>",
            desc = "Stop Running"
        },
        -- Ctrl+F5 运行但不调试（对于支持调试的语言）
        {
            "<C-F5>",
            "<cmd>w<CR><cmd>RunFile<CR>",
            desc = "Save and Run File"
        },
        -- 保留 leader 键映射
        { "<leader>rc", "<cmd>w<CR><cmd>RunCode<CR>", desc = "Save and Run Code" },
        { "<leader>rf", "<cmd>w<CR><cmd>RunFile<CR>", desc = "Save and Run File" },
        { "<leader>rp", "<cmd>RunProject<CR>", desc = "Run Project" },
        { "<leader>rx", "<cmd>RunClose<CR>", desc = "Close Runner" },
    },
}
