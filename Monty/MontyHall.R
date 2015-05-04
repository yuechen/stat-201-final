library(shiny)
setwd("/Users/Pam/Desktop/Stat201/Final Project") 

monty_hall_knows <- function(trials, switch_yes) {
  selection <- c("goat", "goat", "car") # create our variables
  win = 0
  for (i in 1:trials){ #simulation
    doors <- sample(selection, 3) #randomly assign/reset 
    door_select <- sample(doors, 1) #select a door
    if (switch_yes == 1){
      remove <- match(door_select, doors) 
      doors <- doors[-remove] #remove door from options
      remove2 <- match ("goat", doors) # monty must pick the goat
      door_select <- doors[-remove2] # remove monty's door so the door we switch to remains
    }
    if(door_select == "car"){win = win+1}
  }
  print(win)
}

monty_hall_ignorant <- function(trials, switch_yes) {
  selection <- c("goat", "goat", "car") # create our variables
  win = 0
  for (i in 1:trials){ #simulation
    doors <- sample(selection, 3) #randomly assign/reset 
    door_select <- sample(doors, 1) #select a door
    if (switch_yes == 1){ #if we switch 
      remove <- match(door_select, doors) 
      doors <- doors[-remove] #remove selected door from options
      monty_rand <- sample(doors, 1) # monty can pick either remaining door
      if (monty_rand == "cars") {win = win + 1}
      else{
        remove2 <- match(monty_rand, doors)
        door_select <- doors[-remove2] # remove monty's door so the door we switch to remains
        if(door_select == "car"){win = win+1}}
    }
    else if(door_select == "car"){win = win+1} # no switching
  }  
  print(win)
}
