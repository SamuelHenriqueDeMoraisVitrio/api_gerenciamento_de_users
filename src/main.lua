serjao = require("dependencies/serjao_berranteiro/serjao_berranteiro")
dtw = require("dependencies/luaDoTheWorld/luaDoTheWorld")

set_server.single_process = false
set_server.nullterminator = "null"

require("consts")
require("dependencies/requires")
require_dir("tratamento_de_erros")
require_dir("banco")
require_dir("rotas")
require("token")
SENHA_ROOT_MAIN = SENHA_ROOT_MAX
SENHA_ROOT_READ = SENHA_ROOT_READ

---@param rq Request
local function main_server(rq)

  if rq.route == "/" then
    
    return serjao.send_file("pages/index.html")

  end


  if not dtw.starts_with(rq.route, API) then
    
    local arquivo = dtw.concat_path("pages", rq.route)

    arquivo = arquivo .. ".html"

    if dtw.isfile(arquivo) then
      
      return serjao.send_file(arquivo)

    end

    return serjao.send_file("pages/not_found.html", 404)

  end


  local banco = add_banco()
  local headders = Cria_headders(rq.header)
  local body = Cria_body(rq.read_body)


  if API..ADD..TOKEN_ROUTE == rq.route then
    return Cria_token(headders, banco)
  end

  if API .. ADD .. USER == rq.route then
    return Cria_user_server(headders, banco)
  end

  if API .. LIST .. USER == rq.route then
    return Lista_users(headders, banco)
  end

  if API .. INCREASES .. BALANCE .. LOTE == rq.route then

    return Registrar_transacoes_rota(headders,banco, 1)
  end

  if API .. DECREASES .. BALANCE .. LOTE == rq.route then
    
    return Registrar_transacoes_rota(headders, banco, -1)
  end

  if API .. INCREASES .. BALANCE .. USER == rq.route then
    
    return registra_transacao_por_email(headders, banco, 1)

  end
  if API .. DECREASES .. BALANCE .. USER == rq.route then
    
    return registra_transacao_por_email(headders, banco, -1)

  end

  if API .. DELETE .. USER == rq.route then
    
    return delete_user(headders, banco)
  end

  if API .. LIST .. USER .. CURRENT == rq.route then
    
    return list_current(headders, banco)

  end

  if API .. ADD .. IMAGEM == rq.route then
    
    return Add_img(headders, banco, body)
  end

  if API .. DELETE .. ALL .. IMAGEM == rq.route then
    
    return Dell_all_imgs(headders, banco)
  end

  if API .. LIST .. ALL .. IMAGEM == rq.route then
    
    return List_imgs(headders, banco)
  end

  if API .. PREVIEW .. IMAGEM == rq.route then
    
    return preview_img(headders, banco)
  end

  if API .. DELETE .. IMAGEM then
    
  end

  return ROTA_NAO_ENCONTRADA, 404
end

serjao.server(3000, 5000, main_server)

