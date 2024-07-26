local dtw = require("luaDoTheWorld/luaDoTheWorld")

local function mudanca()
    print("moudou")
end

local sha_antigo = dtw.generate_sha_from_folder_by_content("src")
while true do
    print("verifying..")
    os.execute("git pull")
    local sha_novo = dtw.generate_sha_from_folder_by_content("src")
    if sha_antigo ~= sha_novo then
        sha_antigo = sha_novo
        mudanca()
    end
    os.execute("sleep 60")
end