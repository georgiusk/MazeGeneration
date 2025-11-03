function solve(maze)::Vector{Node}                                                                               # Solves the maze with right hand rule
    nodes = maze.nodes                                                                                           # Initialization
    rows, cols = size(nodes)
    Start_node = nodes[1, 1]
    End_node = nodes[1, 2]
    path_taken = Vector{Node}()
    visited = Vector{Node}()
    for i in 1:rows                                                                                              # Look for the end and start nodes
        for j in 1:cols
            if nodes[i, j].key == 1
                Start_node = nodes[i, j]
            end
            if nodes[i, j].key == 2
                End_node = nodes[i, j]
            end
        end
    end
    push!(path_taken, Start_node)
    push!(visited, Start_node)
    player_directions = ["up", "right", "bottom", "left"]
    player_direction = rand(player_directions)
    next_node = Start_node
    while path_taken[end] !== End_node                                                                                          # While it has not reach the end node
        if player_direction == "up"
            next2_node = next_node.up
            if next_node.right !== nothing && !(nodes[next_node.right[1], next_node.right[2]] in visited)                       # Checks if the right node is not a wall and is not in visited
                new_x = next_node.right[2]
                new_y = next_node.right[1]
                player_direction = "right"
                next_node = nodes[new_y, new_x]
            elseif next2_node !== nothing && !(nodes[next2_node[1], next2_node[2]] in visited)                                  # Checks if the up node is not a wall and is not in visited
                new_x = next2_node[2]
                new_y = next2_node[1]
                next_node = nodes[new_y, new_x]
            else                                                                                                                # If there are no nodes that can be accessed, check if there are any that can be accessed from the left
                new_direction = check_surroundings(next_node, player_direction, visited, nodes)
                if new_direction == player_direction                                                                            # If there are no nodes that can be accessed, check if there are any that can be accessed from the bottom (badcktracking)
                    pop!(path_taken)                                                                                            # Backtrack
                    next_node = path_taken[end]                                                                                 # Takes the current latest node
                    continue
                else                                                                                                            # If there is a node that can be accessed from the left
                    player_direction = new_direction
                    continue
                end
            end
        elseif player_direction == "left"                                                                                       # Same concept as the direction up
            next2_node = next_node.left
            if next_node.up !== nothing && !(nodes[next_node.up[1], next_node.up[2]] in visited)
                new_x = next_node.up[2]
                new_y = next_node.up[1]
                player_direction = "up"
                next_node = nodes[new_y, new_x]
            elseif next2_node !== nothing && !(nodes[next2_node[1], next2_node[2]] in visited)
                new_x = next2_node[2]
                new_y = next2_node[1]
                next_node = nodes[new_y, new_x]
            else
                new_direction = check_surroundings(next_node, player_direction, visited, nodes)
                if new_direction == player_direction
                    pop!(path_taken)
                    next_node = path_taken[end]
                    continue
                else
                    player_direction = new_direction
                    continue
                end
            end
        elseif player_direction == "bottom"
            next2_node = next_node.bottom
            if next_node.left !== nothing && !(nodes[next_node.left[1], next_node.left[2]] in visited)
                new_x = next_node.left[2]
                new_y = next_node.left[1]
                player_direction = "left"
                next_node = nodes[new_y, new_x]
            elseif next2_node !== nothing && !(nodes[next2_node[1], next2_node[2]] in visited)
                new_x = next2_node[2]
                new_y = next2_node[1]
                next_node = nodes[new_y, new_x]
            else
                new_direction = check_surroundings(next_node, player_direction, visited, nodes)
                if new_direction == player_direction
                    pop!(path_taken)
                    next_node = path_taken[end]
                    continue
                else
                    player_direction = new_direction
                    continue
                end
            end
        elseif player_direction == "right"
            next2_node = next_node.right
            if next_node.bottom !== nothing && !(nodes[next_node.bottom[1], next_node.bottom[2]] in visited)
                new_x = next_node.bottom[2]
                new_y = next_node.bottom[1]
                player_direction = "bottom"
                next_node = nodes[new_y, new_x]
            elseif next2_node !== nothing && !(nodes[next2_node[1], next2_node[2]] in visited)
                new_x = next2_node[2]
                new_y = next2_node[1]
                next_node = nodes[new_y, new_x]
            else
                new_direction = check_surroundings(next_node, player_direction, visited, nodes)
                if new_direction == player_direction
                    pop!(path_taken)
                    next_node = path_taken[end]
                    continue
                else
                    player_direction = new_direction
                    continue
                end
            end
        end
        push!(path_taken, next_node)
        push!(visited, next_node)
    end
    return path_taken
end

function check_surroundings(current_Node::Node, current_direction::String, visited::Vector{Node}, nodes::Matrix{Node})                     # Checks if there are any nodes that can be accessed from the current direction that has not been visited    
    directions = ["up", "right", "bottom", "left"]
    for i in 1:4                                                                                                                             # Loops through the 4 direction (hence 4)
        new_direction = directions[i]
        if new_direction == "right" && current_Node.right !== nothing && !(nodes[current_Node.right[1], current_Node.right[2]] in visited)   # If the new_direction is right, check if the right node is not a wall and is not in visited
            return "right"
        elseif new_direction == "bottom" && current_Node.bottom !== nothing && !(nodes[current_Node.bottom[1], current_Node.bottom[2]] in visited)
            return "bottom"
        elseif new_direction == "left" && current_Node.left !== nothing && !(nodes[current_Node.left[1], current_Node.left[2]] in visited)
            return "left"
        elseif new_direction == "up" && current_Node.up !== nothing && !(nodes[current_Node.up[1], current_Node.up[2]] in visited)
            return "up"
        end
    end
    return current_direction                                                                                                                  # else return the current_direction
end