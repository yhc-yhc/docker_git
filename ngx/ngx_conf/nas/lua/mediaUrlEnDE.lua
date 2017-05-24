local KEY="PICTUREAIR082816"
local IV = "PICTUREAIR082816"
local aes = require "resty.aes"
local str = require "resty.string" 
local local_localtoin = "/media/"
function fromhex(str)
    return (str:gsub('..', function (cc) 
        return string.char(tonumber(cc, 16))
    end))
end
local aes_128_cbc_with_iv = assert(aes:new(KEY, nil, aes.cipher(128,"cbc"), {iv=IV}))
local method_name = ngx.req.get_method()
-- local request_uri = ngx.unescape_uri(ngx.var.request_uri)
local uri = ngx.unescape_uri(ngx.var.uri)
if("GET"==method_name) then 
  local internal_photo_image_url=string.sub(uri,string.len(local_localtoin)+1,  string.len(uri)) 
  local internal_photo_image_url_DE=aes_128_cbc_with_iv:decrypt(fromhex(internal_photo_image_url))
  local get_url_args = ngx.req.get_uri_args()  
  -- ngx.header.content_type = "text/plain"
   local execUrl=internal_photo_image_url_DE
  -- internal_photo_image_url_DE.."?"..
  if(ngx.var.query_string) then  
     execUrl= internal_photo_image_url_DE.."?"..ngx.var.query_string
  end   
  return ngx.exec(execUrl)                
  -- ngx.print(args) 
  -- ngx.header.content_type = "text/plain"
  -- ngx.say("method_name :", method_name)
  -- return ngx.exec(internal_photo_image_url_DE)
      -- ngx.header.content_type = "text/plain" 
     --  ngx.say("uri :", uri) 
     --  ngx.say("internal_photo_image_url :", internal_photo_image_url) 
     --  ngx.say("internal_photo_image_url_DE :", internal_photo_image_url_DE) 
     --  local encrypted = aes_128_cbc_with_iv:encrypt("/photos/test.jpg") 
     --  ngx.say("AES 128 CBC (WITH IV) Encrypted HEX: ", str.to_hex(encrypted))
else
  ngx.header.content_type = "text/plain"
  ngx.say("method_name :", method_name)
end