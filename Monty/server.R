# code
library("ggplot2")
monty_hall_knows <- function(trials, switch_yes) {
  if (trials == "NaN") {trials <- 1}
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
  win
}

monty_hall_ignorant <- function(trials, switch_yes) {
  if (trials == "NaN") {trials <- 1}
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
  win
}

shinyServer(function(input, output) {
  
output$plot1 <- renderPlot(
  ggplot(data=(data.frame(
    label = factor(c("Monty Knows","Monty Ignorant"), levels=c("Monty Knows","Monty Ignorant")),
    wins = c(monty_hall_knows(input$slider, input$radio),  monty_hall_ignorant(input$slider, input$radio))
  )), aes(x=label, y=wins, fill=label)) + labs(x=NULL) + geom_bar(stat="identity", width = .4) + guides(fill=FALSE) + geom_text(aes(label = wins, y = wins+(wins*.05)), size = 5))
output$text1 <- renderText(paste("
                      You won", monty_hall_knows(input$slider, input$radio), "times out of", input$slider,"trials, or", 
                      round(100*(monty_hall_knows(input$slider, input$radio))/input$slider, 2),"% of the time if Monty Hall
                      knows where the car is."))
                      
output$text2 <- renderText(paste("You won", monty_hall_ignorant(input$slider, input$radio), "times out of", input$slider,"trials, or", 
                      round(100*(monty_hall_ignorant(input$slider, input$radio))/input$slider, 2),"% of the time if Monty Hall
                      doesn't know where the car is."))

output$explain1 <- renderText(if (input$radio == 0){
  "Looks like you won approximately a third of the time, regardless of whether Monty knows where the car is or not. 
  Your wins don't seem to to change! Try switching next time and see if it makes a difference."})

output$explain2 <- renderText(if (input$radio == 1){
    "There's a big difference between switching and not switching! Why is this the case? Monty Hall is a 
    problem of conditional probability. When you first select a door, you are taking a guess on that one door
    being the winning door. Your probability of winning is P(car), which is equal to 1/3. However, 
    when Monty opens a door, he is essentially helping you by eliminating one of the 
    doors that does not contain the car. You now have MORE information than when you picked your
    original door. The new probability of winning is conditional on the fact that Monty knows where
    the car is and chose to open a door with a goat. 
    Lets say you select door 1 - your original selection has a 1 in 3 chance of being the winner.
    That is still true regardless if Monty knows where the car is. 
    Thats why if you do not switch, you will win a third of the time, regardless if Monty knows or not.
    However, when Monty removes one of the doors (say, door 2), you know that the probability of the prize 
    being in your original door (door 1) is 1/3. But with door 2 eliminated, the probability that the 
    remaining door has the prize is now 2/3. The problem is conditional on the fact that Monty knows where
    the car is. Your chances are better if you switch, but only if Monty knows!"
})



})

























