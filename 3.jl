#=
3. ДАНО: Робот - в произвольной клетке ограниченного прямоугольного поля
РЕЗУЛЬТАТ: Робот - в исходном положении, и все клетки поля промаркированы
=#

using HorizonSideRobots
include("functions.jl")

robot = Robot("situations/1.sit", animate=true)

function fill!(robot)
    x = along!(robot, West) #двигаемся влево до упора и запоминаем количество шагов
    y = along!(robot, Sud) #двигаемся вниз до упора и запоминаем количество шагов
    
    #робот в нижнем левом углу
    direction = Ost
    while true
        putmarker!(robot)
        along_mark!(robot, direction)
        if (isborder(robot, Nord))
            break
        end

        move!(robot, Nord)
        direction = inverse(direction)
    end

    #двигаемся к нижнему левому углу
    along!(robot, West)
    along!(robot, Sud)
    
    #возвращаемся в исходное положение
    along!(robot, Ost, x)
    along!(robot, Nord, y)
end

fill!(robot)