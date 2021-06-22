local dx, dy = canvas:attrSize()

function handler(evt)

    print ('Name: '..evt.type)
    if evt.type == 'attribution' then -- and evt.action == 'stop' then
        print ("attribution stop")
        print (evt.name)
        if evt.name == 'usuario1' then
            canvas:attrColor('blue')
            canvas:drawRect('fill', 0, 0, dx,dy)
            canvas:attrColor('white')
            canvas:drawText(dx/3, dy/4, "Usuario 1 pressionou...")
            print (evt.name)
            canvas:flush()
        end
    end
end

event.register(handler)