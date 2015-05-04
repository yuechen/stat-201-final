library("ggplot2")
envelope <- function(trials = 1000){
  record_noswitch <- vector()
  record_switch <- vector()
  for (i in 1:trials){
    noswitch = 0
    switch2 = 0
    for(i in 1:12){ 
      envelope1 <- runif(1,1,100)
      envelope2 <- 2 * envelope1
      rand = runif(1,0,2)
      if (rand<=1)
        {chosen = envelope1
         switchchosen = envelope2}
      else{
        chosen = envelope2
        switchchosen = envelope1
      }
      noswitch = noswitch + chosen
      switch2 = switchchosen + switch2
    }
    record_noswitch <- c(record_noswitch, noswitch/12)
    record_switch <- c(record_switch, switch2/12)
  }
  combined1 <- data.frame(x = record_noswitch)
  combined2 <- data.frame(x = record_switch)

  ggplot() + geom_density(aes(x=x), colour="red", data=combined1, label = "No Switching") + 
    geom_density(aes(x=x), colour="blue", data=combined2, label = "Switching") + xlab("Money Won") + annotate("text", label = "No Switching", x = 46.58, y = .025, size = 5, colour = "red") + annotate("text", label = "Switching", x = 46, y = .023, size = 5, colour = "blue")
}

shinyServer(function(input, output) {

output$plot <- renderPlot(envelope(input$slider))

output$explain1 <- renderText("Switching doesn't matter!")
output$explain2 <- renderText("The above calculation of expected value is incorrect: switching does not
                              make a difference on the outcome. This is evidence since the distribution
                              of winnings is the same, regardless of whether or not you switch.
                              In actually, switching is not the ideal strategy - if you cannot inspect
                              the envelope that you receive, then it makes sense to simply always switch 
                              until you are switching for eternity. The expected value calculation
                              above is incorrect. The correct calculation is  (2*$X/3 + $X/3)/2 = $X/2
                              If one envelope has $X/3, then the other envelope has $2*X/3. The 
                              expected wininings of the game is always the average of those two values,
                              $X/2. Switching does not change this outcome.")

})

























