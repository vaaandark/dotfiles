require'nvim-treesitter.configs'.setup {
  -- 安装 language parser
  -- :TSInstallInfo 命令查看支持的语言
  ensure_installed = { 'c', 'cpp', 'cuda', 'markdown_inline', 'python', 'rust', 'bash', 'lua' },
  -- 启用代码高亮功能
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false
  },
}

