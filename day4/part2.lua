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
    local scratch_cards = {}
    for i = 1, 208, 1 do
        scratch_cards[i] = 1
    end

    local card_number = 1
    for line in file:lines() do
        local matches         = 0
        line                  = string.gsub(line, "Card%s*([0-9]*)%s*:", "")
        local split           = string_split(line, "|")
        local tickets         = split[1]
        local winning_tickets = split[2]

        local w_ticks         = {}
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
                matches = matches + 1
            end
        end

        for mul = 1, scratch_cards[card_number], 1 do
            for inc = 1, matches, 1 do
                scratch_cards[card_number + inc] = scratch_cards[card_number + inc] + 1
            end
        end


        card_number = card_number + 1
    end
    local won_cards = 0
    for card_idx = 1, card_number - 1, 1 do
        local cards = scratch_cards[card_idx]
        won_cards = won_cards + cards
    end
    print("answer is ", won_cards)
end


solve("example.txt")
solve("input.txt")
