return {
  table_has_value = function(table, val)
    for _, value in ipairs(table) do
      if value == val then
        return true
      end
    end
    return false
  end,
  scan_directory_for_directories_in_windows = function(directory)
    local i, t, popen = 0, {}, io.popen
    local pdir = popen('dir "' .. directory .. '" /b /ad')
    if pdir == nil then
      return t
    end
    for dir in pdir:lines() do
      i = i + 1
      t[i] = dir
    end
    pdir:close()
    return t
  end,
  scan_directory_for_directories_in_linux = function(directory)
    local i, t, popen = 0, {}, io.popen
    local pdir = popen('ls -pa ' .. directory)
    if pdir == nil then
      return t
    end
    for dir in pdir:lines() do
      i = i + 1
      t[i] = dir
    end
    pdir:close()
    return t
  end,
}
