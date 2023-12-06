#=
6. ДАНО: Робот - в произвольной клетке ограниченного прямоугольного 
поля, на котором могут находиться также внутренние прямоугольные 
перегородки (все перегородки изолированы друг от друга, прямоугольники могут вырождаться в отрезки)

РЕЗУЛЬТАТ: Робот - в исходном положении и -
a) по всему периметру внешней рамки стоят маркеры;
б) маркеры не во всех клетках периметра, а только в 4-х позициях - напротив исходного положения робота.
=#

using HorizonSideRobots
include("functions.jl")

robot = Robot("situations/6.sit", animate=true)

function perimeter_a!(robot)
    path = move_to_corner!(robot, Sud, West)

    for s in [Ost, Nord, West, Sud]
        along_mark!(robot, s)
    end

    for p in Iterators.Reverse(path)
        along!(robot, inverse(p.side), p.steps)
    end
end

function perimeter_b!(robot)
    path = move_to_corner!(robot, Sud, West)
    
    #"координаты" относительно левого нижнего угла
    dx = sum(p -> p.side == West ? p.steps : 0, path)
    dy = sum(p -> p.side == Sud ? p.steps : 0, path)

    function projection!(robot, side, dt)
        along!(robot, side, dt)
        putmarker!(robot)
        return along!(robot, side)
    end

    x_rem = projection!(robot, Ost, dx)
    y_rem = projection!(robot, Nord, dy)

    projection!(robot, West, x_rem)
    projection!(robot, Sud, y_rem)

    for p in Iterators.Reverse(path)
        along!(robot, inverse(p.side), p.steps)
    end
end

perimeter_b!(robot)