#=
8. ДАНО: Где-то на неограниченном со всех сторон поле без внутренних 
перегородок имеется единственный маркер. Робот - в произвольной клетке этого поля.
РЕЗУЛЬТАТ: Робот - в клетке с маркером.
=#

using HorizonSideRobots
include("functions.jl")

robot = Robot("situations/8.sit", animate=true)

function search_along!(robot, side, steps)
    for _ in 1:steps
        move!(robot, side)
        if ismarker(robot)
            return true
        end
    end

    return false
end

function spiral!(robot)
    i = 0
    steps = 0
    direction = Nord
    while !ismarker(robot)
        if i == 0
            steps += 1
        end

        search_along!(robot, direction, steps)
        direction = clockwise(direction)
        i = (i + 1) % 2
    end
end

spiral!(robot)