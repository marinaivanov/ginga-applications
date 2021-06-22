local dx, dy = canvas:attrSize()

function handler(evt)
  if evt.type == 'attribution' and evt.action == 'stop' then
    if (evt.name =='usr') then
        canvas:attrColor('blue')
        canvas:drawRect('fill', 0, 0, dx,dy)
        canvas:attrColor('white')
        canvas:drawText(dx/6, dy/4, 'Compra realizada pelo usuário: '..evt.value)
        canvas:flush()
    end
    evt.action = 'stop'
    event.post(evt)
    return
  end
end
event.register(handler)