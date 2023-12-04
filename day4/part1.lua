local function string_split(inputstr, sep)
    if sep == nil then
        sep = "%s"
    end
    local t = {}
    for str in string.gmatch(inputstr, "([^" .. sep .. "]+)") do
        table.insert(t, str)
    end
    return t
end



local function solve(input_path)
    local file, err = io.open(input_path, "r")
    if file == nil then
        print("error opening file ", err)
        return;
    end
    local total_points = 0
    for line in file:lines() do
        local points = 0
        line = string.gsub(line, "Card%s*([0-9]*)%s*:", "")
        local split = string_split(line, "|")
        local tickets = split[1]
        local winning_tickets = split[2]

        local w_ticks = {}
        for w_tick in string.gmatch(winning_tickets, "([^%s*]+)") do
            local count = w_ticks[w_tick]
            if count ~= nil then
                count = count + 1
            else
                count = 1
            end
            w_ticks[w_tick] = count
        end

        tickets = string_split(tickets, "%s*")

        for _, value in pairs(tickets) do
            if w_ticks[value] ~= nil then
                if points == 0 then
                    points = 1
                else
                    points = points * 2
                end
            end
        end
        total_points = total_points + points
    end
    print("answer is ", total_points)
end


solve("example.txt")
solve("input.txt")
