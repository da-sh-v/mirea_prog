using  HorizonSideRobots

function along_mark!(robot, side)
    steps = 0
    while !isborder(robot, side)
        move!(robot, side)
        putmarker!(robot)
        steps += 1
    end

    return steps
end

function along!(robot, side)
    steps = 0
    while !isborder(robot, side)
        move!(robot, side)
        steps += 1
    end

    return steps
end

function along!(robot, side, steps)
    for _ in 1:steps
        move!(robot, side)
    end
end

function inverse(side)
    return HorizonSide(mod(Int(side)+2, 4))
end

function clockwise(side)
    return HorizonSide(mod(Int(side)+1, 4))
end

function anticlockwise(side)
    return HorizonSide(mod(Int(side)-1, 4))
end

"""
перемещает робота в указанный угол и возвращает проделанный путь
"""
function move_to_corner!(robot, sideX, sideY)
    directions = [sideX, sideY]
    path = NamedTuple{(:side, :steps), Tuple{HorizonSide, Int64}}[]
    i = 0
    while !(isborder(robot, sideX) && isborder(robot, sideY))
        steps = along!(robot, directions[i+1])
        push!(path, (side=directions[i+1], steps=steps))
        i = (i + 1) % 2
    end

    return path
end