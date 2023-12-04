#ДАНО: Робот находится в произвольной клетке ограниченного прямоугольного поля без внутренних перегородок и маркеров.
#РЕЗУЛЬТАТ: Робот — в исходном положении в центре прямого креста из маркеров, расставленных вплоть до внешней рамки.

using HorizonSideRobots
include("functions.jl")

robot = Robot(animate=true)

function cross!(robot)
    putmarker!(robot)
    for s ∈ [Nord, Sud, West, Ost]
        steps = along_mark!(robot, s)
        along!(robot, inverse(s), steps)
    end
end

cross!(robot)