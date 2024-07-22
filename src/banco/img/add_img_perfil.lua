


---@param banco DtwResource
---@param user DtwResource
---@param file any
---@param extension string
---@return serjaoResponse
function Add_img_perfil_banco(banco, user, file, extension)

    local dir_perfil = user.sub_resource(DIR_PERFIL)

    local name_file = Perfil_img_for_bool(dir_perfil)

    if name_file then
        dir_perfil.sub_resource(name_file).destroy()
    end

    local file_perfil = IMG_PERFIL .. extension

    dir_perfil.set_value_in_sub_resource(file_perfil, file)
    dir_perfil.set_value_in_sub_resource(BOOL_PERFIL, true)

    banco.commit()

    return serjao.send_text(IMG_ADD, 200)
end