vim.api.nvim_create_autocmd('FileType', {
    pattern = 'pmc',
    callback = function()
        vim.treesitter.start()
    end
})

vim.filetype.add {
  extension = {
    pmc = "pmc",
  },
}

local buffname = debug.getinfo(1, 'S').source:sub(2)
local root = vim.fs.root(buffname, { "grammar.js" })
local parser_path = vim.fs.joinpath(root, "libtree-sitter-pmc.so")

if vim.fn.filereadable(parser_path) == 0 then
    vim.notify("Building PMC parser...", vim.log.levels.INFO)

    vim.system({ "tree-sitter", "generate" }, { cwd = root }):wait()
    vim.system({ "make", "all" }, { cwd = root }, function(obj)
        vim.schedule(function()
            if obj.code == 0 then
                vim.notify("PMC Parser built successfully", vim.log.levels.INFO)
                vim.treesitter.language.add('pmc', { path = parser_path })
            else
                vim.notify("PMC build failed", vim.log.levels.ERROR)
            end
        end)
    end)
else
    vim.treesitter.language.add('pmc', { path = parser_path })
end
