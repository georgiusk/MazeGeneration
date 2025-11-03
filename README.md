# Maze Generation Project

## 1. Setup
### This struct has freedom of choice so any additions or revisions are fine but as a basis, it should have the following
- struct Node
    - Values:
        - key::(Pilih sendiri)
        - coords::Tuple(Int, Int)
        - up::Union{Tuple(Int, Int), Nothing}
        - left::Union{Tuple(Int, Int), Nothing}
        - bottom::Union{Tuple(Int, Int), Nothing}
        - right::Union{Tuple(Int, Int), Nothing}
    - Functions:
        - neighbours(node::Node)
### This struct is fixed so we will only include the given values
- struct Maze
    - Values:
        - nodes::Matrix{Node}
        - visual::Union{MazeViz, Nothing}
        - path::Union{Vector{Node}, Nothing}
    - Functions:
        - maze(height::Int, width::Int)
- struct MazeViz
    - Values:
    - Functions

## 2. Main Course
### Setup
Setup is simply initializing an n-m grid, with each element in the grid as a node object (Julia has a base datatype called Matrix{Node}([...])). The values of n and m are given as inputs for the maze function.

### Backtracking DFS
This should be as simple as possible. Due to the nature of the maze datatype as a matrix, the struct node can hold the coords of its neighbours as a tuple with (x, y) values. We start by selecting 2 random numbers within the scope of the matrix. To make life easier in the solver portion, we CAN force the beginning to start at the edges so that it only has to choose from 3 sides (this however is optional). Continuing from this the code will use DFS (the one with the stack not the recursive one, this way we can preserve backtracking). This dfs will run until there are in total n x m number of nodes. Thus the generation for the maze should be done.


DFS details:
- It should have a stack (obviously). This stack should take its neighbours as values. Due to the ambiguity of the task I am unsure whether the neighbour function we have to make is supposed to give neighbours before or after the maze generation, so for now, don't use it.
- Have a visited list. This stores all the nodes that has already been visited. Before a new neighbour is added into the stack, check this list first.
- The loop should run until the length of the visited list equal to n x m.
- The node value 'key' stores the start and end nodes. The datatype is up to you peeps, as long as it stores a clear and start value (e.g: str, int, bool, etc...)
- Each time a neighbour is added into the stack, make sure to add its coordinates as the current nodes left, middle or right value.


### Maze vizualizations
TBD

### Solver
The right hand rule is a simple way to solve a maze (simple doesn't mean fast). As mentioned in the backtracking dfs section, the complicated part is the starting node. We must choose the correct direction for the code to run correctly. After the selection process, the code should be simple as it will always check clockwise.

RHR details:
- Make a vector of nodes to save the path taken by the player
- Use the neighbours function to check the possible visited nodes, IF its supposed to give neighbours after maze generation. If not, see next.
- Check the nodes clockwise and DO NOT ADD ALL THE NEIGHBOURS TO THE VECTOR. Simply add the right most neighbour after checking clockwise.
- The beginning will the be the most complicated as it has to determine which is the right most wall. Keep in mind that it might be easier to save the direction of where the player is looking at.
- Does not need a visited list. The player/ pointer can go back the same way it came essentially

Src:
- https://medium.com/swlh/maze-generation-with-depth-first-search-and-recursive-backtracking-869f5c4496ad
- https://www.youtube.com/watch?v=gHU5RQWbmWE
