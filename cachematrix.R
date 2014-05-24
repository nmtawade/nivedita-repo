
## This function creates a special "matrix" object that can cache its inverse.
## 1. it takes an argument x of type numeric metrix
## 2. it returns a list with 4 list items  (they are actually 4 functions wrapped in a list)

makeCacheMatrix <- function(x = matrix()) {
  
  m <- NULL          #m is inverse of matrix x     
  
  set <- function(y) {  #set the value of the matrix
    x <<- y
    m <<- NULL
  }
  get <- function() x     #get the value of the matrix
  
  setInverse <- function(inverse) m <<- inverse      # set the value of the inverse of matrix
  
  getInverse <- function() m                # get the value of the inverse of matrix
  
  list(set = set, get = get,    #returns a list with 4 list items  (they are actually 4 functions wrapped in a list)
       setInverse = setInverse,
       getInverse = getInverse)
}


## cacheDolve is just a client function that uses "makeCacheMatrix" function in its implementation.
#The input is expecting a "special metrix" made from makeCacheMatrix (ignore the ... for now).
#The output is the inverse of the metrix coming whether from the special vector's  cache or computation.

cacheSolve <- function(x, ...) {
  ## Return a matrix that is the inverse of 'x'
  m <- x$getInverse()                    #query the x metrix's cache 
  if(!is.null(m)) {                      #if there is a cache
    message("getting cached data")
    return(m)                            #just return the cache, no computation needed
  }
  data <- x$get()                        #if there's no cache

  m <- solve(data, ...)                 #we actually compute them here

  x$setInverse(m)                       #save the result back to x's cache

  m                                      #return the result
}
