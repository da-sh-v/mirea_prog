#=
7. ДАНО: Робот - рядом с горизонтальной бесконечно продолжающейся в 
обе стороны перегородкой (под ней), в которой имеется проход шириной в одну клетку.
РЕЗУЛЬТАТ: Робот - в клетке под проходом
=#

using HorizonSideRobots
include("functions.jl")

robot = Robot("situations/7.sit", animate=true)

function shuttle!(robot)
    direction = West
    steps = 1
    while isborder(robot, Nord)
        along!(robot, direction, steps)
        direction = inverse(direction)
        steps += 1
    end
end

shuttle!(robot)