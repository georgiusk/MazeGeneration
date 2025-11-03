mutable struct Node
    key::Int                                # Value for the start and end of the solver
    coords::Tuple{Int,Int}                  # The current coordinate
    up::Union{Tuple{Int,Int}, Nothing}      # All the coordinates of its adjacent neighbors, nothing if its a wall
    left::Union{Tuple{Int,Int}, Nothing}
    bottom::Union{Tuple{Int,Int}, Nothing}
    right::Union{Tuple{Int,Int}, Nothing}
    function Node(coord::Tuple{Int,Int})
        new(0, coord, nothing, nothing, nothing, nothing)
    end
end

function neighbors(coord::Tuple{Int,Int}, visited::Vector{Tuple{Int,Int}}, height::Int, width::Int)::Vector{Tuple{Int,Int}}
    # Gets all available neighbors of the current node
    avail = Vector{Tuple{Int,Int}}()
    (y, x) = coord

    if y+1 <= height && (y+1, x) ∉ visited #down
        push!(avail, (y+1,x))
    end
    if y-1 >= 1 && (y-1, x) ∉ visited #up
        push!(avail, (y-1,x))
    end
    if x+1 <= width && (y, x+1) ∉ visited #right
        push!(avail, (y,x+1))
    end
    if x-1 >= 1 && (y, x-1) ∉ visited #left
        push!(avail, (y, x-1))
    end

    return avail
end