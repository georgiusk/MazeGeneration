using Plots
mutable struct MazeViz
    disp::Any
    function MazeViz(this::Any)
        new(this)
    end
end

function gen_disp(maze::Matrix{Node}, height::Int, width::Int, path::Vector{Node})
    # Initializes the plot for visualization
    plot_obj = plot(legend=false, grid=false, xlims=(0, width), ylims=(0, height), aspect_ratio=:equal)

    # Checks every single node in the matrix
    for r in 1:height
        for c in 1:width
            node = maze[r, c]
            x, y = c - 1, height - r

            # Generates the start of the solver as a green dot
            if node.key == 1
                (starty, startx) = node.coords
                scatter!([startx - 0.5], [height - starty + 0.5], color=:green, markersize=(50 / max(height, width)), label="Start")
            end

            # Generates the end of the solver as a red dot
            if node.key == 2
                (endy, endx) = node.coords
                scatter!([endx - 0.5], [height - endy + 0.5], color=:red, markersize=(50 / max(height, width)), label="End")
            end

            # If the any of the cardinal adjacent nodes are nothing, generate a black line between these 2 nodes
            if node.up === nothing
                plot!(plot_obj, [x, x + 1], [y + 1, y + 1], color=:black, linewidth=2)
            end
            if node.bottom === nothing
                plot!(plot_obj, [x, x + 1], [y, y], color=:black, linewidth=2)
            end
            if node.left === nothing
                plot!(plot_obj, [x, x], [y, y + 1], color=:black, linewidth=2)
            end
            if node.right === nothing
                plot!(plot_obj, [x + 1, x + 1], [y, y + 1], color=:black, linewidth=2)
            end
        end
    end

    # Generate the path from start to finish based on the solver
    for i in 1:(length(path)-1)
        node1 = path[i]
        node2 = path[i+1]
        x1, y1 = node1.coords[2] - 0.5, height - node1.coords[1] + 0.5
        x2, y2 = node2.coords[2] - 0.5, height - node2.coords[1] + 0.5
        plot!(plot_obj, [x1, x2], [y1, y2], color=:blue, linewidth=2, label=false)
    end

    # Generate a MazeViz object
    maze_vis = MazeViz(plot_obj)
    return maze_vis
end