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