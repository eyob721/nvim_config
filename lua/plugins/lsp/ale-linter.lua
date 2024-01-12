return {
  "JuanDAC/betty-ale-vim",
  dependencies = {
    "dense-analysis/ale",
  },
  config = function()
    vim.cmd([[
" Define linters (currently I want ale for C)
let g:ale_linters = {'c':['betty-style', 'betty-doc', 'gcc']}

" Define C compiler (gcc) and options
let g:ale_c_cc_executable = "gcc"
let g:ale_c_cc_options = "-Wall -Wextra -Werror -pedantic -std=gnu89 -g"

" Don't show messages when cursor is near a warning or erro
let g:ale_echo_cursor = 0

let g:ale_fix_on_save = 0
let g:ale_sign_column_always = 1

" Git Gutter
let g:gitgutter_realtime = 1
let g:gitgutter_eager = 1

" For more info, search help
    ]])
  end,
}
