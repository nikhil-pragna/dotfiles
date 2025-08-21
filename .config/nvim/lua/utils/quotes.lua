local M = {}

local function wrap_text(text, line_length)
  local words = string.gmatch(text, "%S+")
  local lines = {}
  local current_line = ""

  for word in words do
    if #current_line == 0 then
      current_line = word
    elseif #current_line + #word + 1 <= line_length then
      current_line = current_line .. " " .. word
    else
      table.insert(lines, current_line)
      current_line = word
    end
  end

  if #current_line > 0 then
    table.insert(lines, current_line)
  end

  return table.concat(lines, "\n")
end

local function read_quote_db(filename)
  local raw = vim.fn.readfile(filename)
  local decoded_data = vim.fn.json_decode(raw)
  local data = {}
  for _, item in ipairs(decoded_data) do
    table.insert(data, { quote = item.quote, author = item.author })
  end
  return data
end

local function get_random_quote()
  local path = vim.fn.stdpath("config") .. "/assets/quotes.json"
  local quotes = read_quote_db(path)

  math.randomseed(os.time())

  local random_quote = quotes[math.random(#quotes)]
  local dashboard_header = random_quote.quote .. "\n\n- " .. random_quote.author
  dashboard_header = wrap_text(dashboard_header, 60)
  return dashboard_header
end

M.get_random_quote = get_random_quote

return M
