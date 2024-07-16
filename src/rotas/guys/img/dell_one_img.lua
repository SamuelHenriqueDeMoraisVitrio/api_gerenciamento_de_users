


---@param headders Headders
---@param banco DtwResource
---@return DtwResource|serjaoResponse|nil
function Dell_one_img_guys(headders, banco)

    local ok, error_or_user = Altentica(headders, banco, false)

    if not ok then
        return error_or_user
    end

    local id = headders.obtem_headder_numerico(ID)

    if headders.erro then
        return headders.erro
    end

    if id < 0 or id > 12 then
        return serjao.send_text(ID_INVALID, 400)
    end

    local response = Dell_one_img_banco(banco, error_or_user, id)

    return response
end