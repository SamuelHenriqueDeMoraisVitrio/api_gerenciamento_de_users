

---@param headers Headders
---@param banco DtwResource
---@return serjaoResponse
function Lista_users(headers, banco)
    local ok, erro = Altentica_root(headers,banco)

    if ok == false then
      return erro
    end

    local filtragem_nome = headers.obtem_headder_opcional(NOME)
    local filtragem_email = headers.obtem_headder_opcional(EMAIL)
    local filtragem_saldo_min = headers.obtem_headder_numerico_opcional(SALDO_MIN)
    local filtragem_saldo_max = headers.obtem_headder_numerico_opcional(SALDO_MAX)

    if headers.erro then
    	return headers.erro
    end

    local descricao  = Describe_users(banco, filtragem_nome, filtragem_email, filtragem_saldo_min, filtragem_saldo_max)
    return descricao
end
