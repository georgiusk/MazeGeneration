module MazeGeneration
include("node.jl")
include("solver.jl")
include("visualize.jl")
import Plots
mutable struct Maze
    nodes::Matrix{Node}
    visual::Union{MazeViz,Nothing}
    path::Union{Vector{Node},Nothing}

    function Maze(height::Int, width::Int)
        matrix = [Node((i, j)) for i in 1:height, j in 1:width]
        new(matrix, nothing, nothing)
    end
end

function randomDFS(height::Int, width::Int, matrix::Matrix{Node})
    (starty, startx) = (rand(1:height), rand(1:width))  # Randomly selects 2 coordinates as the start point of the dfs
    current = matrix[starty, startx]                    # Sets the current Node as the starting Node
    visited = Vector{Tuple{Int,Int}}()                 # Initialize both the visited and stack lists
    stack = Vector{Tuple{Int,Int}}()
    push!(stack, current.coords)                        # Adds the starting point into both stack and visited
    push!(visited, current.coords)

    while length(stack) > 0
        avail = neighbors(stack[end], visited, height, width)   # Checks all unvisited neighbours
        (y, x) = stack[end]
        current = matrix[y, x]                                  # Sets the current node as the next node in the stack

        if length(avail) == 0                                   # If the node has no available neighbours, removes the node from the stack
            pop!(stack)

        else
            random = rand(1:length(avail))                      # Randomly selects the next node from the available neighbors list
            next_coord = avail[random]
            push!(stack, next_coord)                            # Adds the next coordinate into the stack and visited
            push!(visited, next_coord)
            (y, x) = next_coord
            next_node = matrix[y, x]                            # Saves the node in the next_coord coordinate

            if y == current.coords[1] + 1                       # Checks if the Node goes up and saves the values
                current.bottom = next_coord
                next_node.up = current.coords

            elseif y == current.coords[1] - 1                   # Checks if the Node goes up and saves the values
                current.up = next_coord
                next_node.bottom = current.coords

            elseif x == current.coords[2] + 1                   # Checks if the Node goes up and saves the values
                current.right = next_coord
                next_node.left = current.coords

            elseif x == current.coords[2] - 1                   # Checks if the Node goes up and saves the values
                current.left = next_coord
                next_node.right = current.coords
            end
        end
    end
end

function maze(height::Int, width::Int)
    maze = Maze(height, width)
    matrix = maze.nodes

    # Assigns the coords to every single Node object in the matrix
    for i = 1:1:height
        for j = 1:1:width
            matrix[i, j] = Node((i, j))
        end
    end

    # Randomly selects a start and end node for the solver
    (starty, startx) = (rand(1:height), rand(1:width))
    if (starty > height / 2)
        endy = rand(1:Int(floor(height / 2)))
    else
        endy = rand(Int(floor(height / 2)):height)
    end

    if (startx > width / 2)
        endx = rand(1:Int(floor(width / 2)))
    else
        endx = rand(Int(floor(width / 2)):width)
    end

    while (startx == endx)
        endx = rand(1:width)
    end

    matrix[starty, startx].key = 1
    matrix[endy, endx].key = 2

    randomDFS(height, width, matrix)                        # Generate a random height x width maze

    maze.path = solve(maze)

    maze.visual = gen_disp(maze.nodes, height, width, maze.path)       # Draw the walls and saves it as MazeViz

    return maze
end
function Base.show(io::IO, ::MIME"text/plain", x::Maze)     # overload the Base show 
    if !isnothing(x.visual)
        display(x.visual.disp)  #If the visual is not nothing, display the maze visual
    else
        println("No visualization available.")
    end
end
end