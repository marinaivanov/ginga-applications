
local server = 'localhost'
local port=1883
local mqtt = require("mqtt")
local int cont = 0

-- TODO: Fazer tabela de topicos
local topicos= {'voice_recog', 'onFaceRecognition', 'onGestureRecognition', 
                'onEyeMotion', 'onMotion', 'onTouch', 'onPointer'}

--Variaveis para uso da biblioteca client MQTT 
--local socket = require("socket")
--local client = mqtt.client.create() -- Não funicona o servidor padrão que na biblioteca diz que localhost porta1883
-- Print contents of `tbl`, with indentation.
-- `indent` sets the initial level of indentation.


function tprint (tbl, indent)


 if not indent then indent = 0 end


 for k, v in pairs(tbl) do


   formatting = string.rep("  ", indent) .. k .. ": "


   if type(v) == "table" then


     --print(formatting)


     --tprint(v, indent+1)

   elseif type(v) == 'boolean' then


    -- print(formatting .. tostring(v))   
   else


    -- print(formatting .. v)
   end
 end
end



local callback = function(topic, payload)

  --print(string.format('"%s" was received from \'%s\'.', payload, topic))
  cont = cont +1
  --print("cont1 : ", cont)
     
  --print(string.format('"--->>>> Peguei a mensagem do mqtt %s" was received from \'%s\'.', payload, topic))

     local evt1 = {
            class  = 'ncl',
            type   = 'attribution',
            --name = 'lerAlgoDito',
            name  = 'key',
            value = topic.."/"..payload,
           -- label='', 
      }
      evt1.action = 'start' 
     -- tprint(evt1, 3)
      event.post(evt1)
      evt1.action = 'stop'
      event.post(evt1)
     -- print(payload)

end
local client = mqtt.client.create(server,port, callback)

client:connect('pegaInteracao')

function update ()
    client:handler()
    event.timer(500, update)
end

-- Ao receber um start, este tratador deve se inscrever num tÃ³pico e iniciar uma funÃ§Ã£o update que trata o recebimento de mensagens MQTT

function tratador (evt)

  --print("scriptInt")

  if evt.action == 'start' then
   -- tprint(evt, 3)
    --TODO: loop para se inscrever em todos os topicos da tabela
    --client:subscribe({topico})
    --client:subscribe({"onMotion"})
    --print(string.format("Subscrided to '%s'",topicos))
    for i, v in ipairs(topicos) do
      --print('Elemento', v)
      client:subscribe({v})
    end

    update()

  end
-- Ao finalizar esse script, um cliente deve ser desconectado e finalizada a conexÃ£o MQTT
  if evt.action == 'stop' then
   -- print(string.format("Terminando"))
    client:unsubscribe({topico})
    client:disconnect()
    client:destroy()
  end
end

event.register(tratador)

