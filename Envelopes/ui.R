shinyUI(fluidPage(
  br(), titlePanel("Two Envelopes Puzzle"), br(),
  sidebarLayout(
    sidebarPanel(
      helpText("How many times do you want to play?"),
      
      sliderInput("slider", label = h3("Number of trials"), min = 100, 
                  max = 5000, value = 2550)
    ),
    mainPanel(
      h3("The Game Setup"),
      h5(a("Back to home", href="http://www.yuechenzhao.com/project/")),
      img(src = "image.jpg", height = 200, style="float:left;   padding-right: 15px; padding-bottom:15px"),
      tags$p(style = "padding-right: 2cm; padding-top: 0", "You are playing a game. A man approaches you and offers two envelopes. Each contains money - however, you 
        do not know if it contains $x or $2x. You select an envelope at random, and if you open it you may keep whatever value is inside. The man keeps the value of the
        other envelope. However, before inspecting it, the man gives you the option to switch for his envelope. You do this 10 times, either switching every time or not, and whoever has the largest sum of money at the end wins."),
      tags$p(style = "padding-right: 2cm; padding-top: 0", "You realize that
        there is equal probability that the other envelope contains 1/2 the value of your envelope or 2 times the value of your envelope. You think back to elementary statistics, and conclude:"),
      tags$p(style = "font-weight: bold;text-align: center;padding-right: 2cm; padding-top: 0", "1/2 x + 2x = 5/4 x"),
      tags$p(style = "padding-right: 2cm; padding-top: 0", "You realize that switching has a 1.25x expected value, and you decide to switch everytime! But is this actually true? Does switching actually help us win more money?"),
      h3("Let's simulate it and see:"),
      plotOutput("plot"),
      h4(textOutput("explain1")),
      tags$p(style = "padding-right: 2cm", textOutput("explain2")),
      br(),br(),br()
    )
  )
))