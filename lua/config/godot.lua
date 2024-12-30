if vim.fn.filereadable(vim.fn.getcwd() .. '/project.godot') == 1 then
  local addr = './godot.pipe'
  if vim.fn.has 'win32' == 1 then
    addr = '127.0.0.1:6004'
  end
  vim.fn.serverstart(addr)
end
