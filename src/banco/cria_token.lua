

---@param lista_de_tokens DtwResource[]
---@param tamanho number
local function privado_remove_token_mais_antigo(lista_de_tokens,tamanho)
    local mais_antigo = lista_de_tokens[1]
    local data_mais_antiga = mais_antigo.get_value_from_sub_resource("criacao")
    for i=1,tamanho do
        local atual = lista_de_tokens[i]
        local criacao = atual.get_value_from_sub_resource("criacao")

        if criacao + (EXPIRACAO * 60) <  os.time() then
        	atual.destroy()
        	return
        end

        if criacao < data_mais_antiga then
        	mais_antigo = atual
        end
    end
    mais_antigo.destroy()

end

---@param user DtwResource
---@return string
function Cria_token_banco(user)
	local tokens = user.sub_resource("tokens")
    local todos_tokens,tamanho = tokens.list()
    if tamanho > MAXIMO_DE_TOKENS then
        privado_remove_token_mais_antigo(todos_tokens,tamanho)
    end
    local token = tokens.sub_resource_random()
    token.set_value_in_sub_resource("criacao",os.time())

    local hasher  = dtw.newHasher()
    hasher.digest(dtw.newRandonizer().generate_token(50))
    hasher.digest(user.get_value_from_sub_resource(SENHA))
    hasher.digest(os.time())

    local senha = string.sub(hasher.get_value(),1,20)
    token.set_value_in_sub_resource(SENHA,senha)

    local user_id = dtw.newPath(user.get_path_string()).get_only_name()
    local token_id = dtw.newPath(token.get_path_string()).get_only_name()

    return Empacota_token(user_id,token_id,senha)

end