shinyUI(fluidPage(
  br(), titlePanel("Monty Hall Game Simulation"), br(),
  sidebarLayout(
    sidebarPanel(
      helpText("Select your parameters to run the Monty Hall simulation"),
      
      radioButtons("radio", label = h3("Switch"),
                   choices = list("Yes" = 1, "No" = 0)),
      
      sliderInput("slider", label = h3("Number of trials"), min = 100, 
                  max = 5000, value = 2550)
    ),
    mainPanel(
      h3("The Game Setup"),
      h5(a("Back to home", href="http://www.yuechenzhao.com/project/")),
      img(src = "monty_image.jpg", height = 200, style="float:left;   padding-right: 15px; padding-bottom:15px"),
      tags$p(style = "padding-right: 2cm; padding-top: 0", "You're on Monty Hall's game show, with the opporotunity to take home your own brand new car. Monty
        Hall stands in front of three doors. Behind two of them is a goat, while one of them has a car.
        First, Monty will ask you to select a door; then, he will open one of the other two doors to reveal
        a goat. Monty knows where the car is, so he will always open the door with a goat. Now, you are
        give a choice - you can switch to the other door, or you can stay with your selection. Are your chances
        better or the same if you switch? Let's simulate it and find out. On the left, select the number of
        simulations you want to run, and then select whether or not you want to switch doors."),
      br(),br(),
      plotOutput("plot1"),br(),
      h4(textOutput("text1")),
      h4(textOutput("text2")),
      tags$p(style = "padding-right: 2cm", textOutput("explain1")),
      tags$p(style = "padding-right: 2cm", textOutput("explain2")),
      br(),br(),br()
    )
  )
))
