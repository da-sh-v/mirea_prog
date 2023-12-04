#=
2. ДАНО: Робот - в произвольной клетке поля (без внутренних перегородок и маркеров)
РЕЗУЛЬТАТ: Робот - в исходном положении, и все клетки по периметру внешней рамки промаркированы
=#

using HorizonSideRobots
include("functions.jl")

robot = Robot(animate=true)

function perimeter(robot)
    x = along!(robot, West) #двигаемся влево до упора и запоминаем количество шагов
    y = along!(robot, Sud) #двигаемся вниз до упора и запоминаем количество шагов
    
    #робот в нижнем левом углу
    for s ∈ [Ost, Nord, West, Sud]
        along_mark!(robot, s)
    end

    #возвращаемся в исходное положение
    along!(robot, Ost, x)
    along!(robot, Nord, y)
end

perimeter(robot)