#=
5. ДАНО: На ограниченном внешней прямоугольной рамкой поле имеется 
ровно одна внутренняя перегородка в форме прямоугольника. Робот - в 
произвольной клетке поля между внешней и внутренней перегородками. 

РЕЗУЛЬТАТ: Робот - в исходном положении и по всему периметру 
внутренней, как внутренней, так и внешней, перегородки поставлены маркеры.
=#

using HorizonSideRobots
include("functions.jl")

robot = Robot("situations/5.sit", animate=true)

function along_mark!(robot, side::HorizonSide, border::HorizonSide)
    while !isborder(robot, side)
        move!(robot, side)
        putmarker!(robot)

        if !isborder(robot, border)
            break
        end
    end
end

function mark_inner_border!(robot, direction)
    get_border_direction = direction != Ost ? clockwise : anticlockwise
    putmarker!(robot)
    for s in [Nord, direction, Sud, inverse(direction)]
        along_mark!(robot, s, get_border_direction(s))
    end
end

function perimeter!(robot)
    #перемещаем робота в нижний левый угол и запоминаем путь до исходного положения
    path = NamedTuple{(:side, :steps), Tuple{HorizonSide, Int64}}[]
    for s ∈ [West, Sud, West]
        pushfirst!(path, (side=s, steps=along!(robot, s)))
    end

    for s ∈ [Ost, Nord, West, Sud]
        along_mark!(robot, s)
    end
    
    #теперь двигаемся змейкой, пытаясь найти внутренюю перегородку
    width = along!(robot, Ost)
    move!(robot, Nord)
    direction = West
    while true
        x = along!(robot, direction)
        if x < width
            mark_inner_border!(robot, direction)
            along!(robot, Sud)
            along!(robot, West)
            break
        end

        move!(robot, Nord)
        direction = inverse(direction)
    end

    #возвращаемся в исходное положение
    for p ∈ path
        along!(robot, inverse(p.side), p.steps)
    end
end

perimeter!(robot)