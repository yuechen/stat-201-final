library("ggplot2")
envelope <- function(trials = 1000){
  record_noswitch <- vector()
  record_switch <- vector()
  for (i in 1:trials){
    noswitch = 0
    switch2 = 0
    for(i in 1:10){ 
      envelope1 <- runif(1,1,100)
      envelope2 <- 2 * envelope1
      selections = c(envelope1, envelope2)
      chosen = sample (selections, 1) # randomly select one
      switchchosen = selections[-chosen] # switch
      noswitch = noswitch + chosen
      switch2 = switchchosen + switch2
    }
    record_noswitch <- c(record_noswitch, noswitch)
    record_switch <- c(record_switch,switch2)
  }
  combined <- data.frame(record = c(record_noswitch, record_switch),
                         criteria = rep(c("a", "b"), each = trials))

  ggplot(combined, aes(record, fill = criteria)) + geom_density(alpha = 0.2)
}
envelope(300)
