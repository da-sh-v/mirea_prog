#=
4. ДАНО: Робот находится в произвольной клетке ограниченного прямоугольного поля без внутренних перегородок и маркеров.
РЕЗУЛЬТАТ: Робот — в исходном положении в центре косого креста из маркеров, расставленных вплоть до внешней рамки.
=#

using HorizonSideRobots
include("functions.jl")

robot = Robot("situations/1.sit", animate=true)

function HorizonSideRobots.move!(robot, side::NTuple{2, HorizonSide})
    for s ∈ side
        move!(robot, s)
    end
end

function HorizonSideRobots.isborder(robot, side::NTuple{2, HorizonSide})
    return isborder(robot, side[1]) || isborder(robot, side[2])
end

inverse(side::NTuple{2, HorizonSide}) = inverse.(side)

function cross_x!(robot)
    putmarker!(robot)
    for x ∈ [Nord, Sud]
        for y ∈ [West, Ost]
            s = (x, y)
            steps = along_mark!(robot, s)
            along!(robot, inverse(s), steps)
        end
    end
end

cross_x!(robot)