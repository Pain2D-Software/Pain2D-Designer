# Pain2D-Designer is part of Pain2D-Software package
#
# app.R is part of Pain2D-Designer: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License,   or
# (at your option) any later version.
#
# app.R is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with Main.R  If not, see <http://www.gnu.org/licenses/>.
#
# Pain2D-Designer ist Teil des Pain2D-Software package
#
# app.R ist Teil von Pain2D-Designer: Sie können es unter den Bedingungen
# der GNU General Public License, wie von der Free Software Foundation,
# Version 3 der Lizenz oder (nach Ihrer Wahl) jeder neueren
# veröffentlichten Version, weiter verteilen und/oder modifizieren.
#
# app.R wird in der Hoffnung, dass es nützlich sein wird, aber
# OHNE JEDE GEWÄHRLEISTUNG, bereitgestellt; sogar ohne die implizite
# Gewährleistung der MARKTFÄHIGKEIT oder EIGNUNG FÜR EINEN BESTIMMTEN ZWECK.
# Siehe die GNU General Public License für weitere Details.
#
# Sie sollten eine Kopie der GNU General Public License zusammen mit diesem
# Programm erhalten haben. Wenn nicht, siehe <https://www.gnu.org/licenses>
###################################################################
# @author Natasza Szczypien (pain2dsoftware@gmail.com)
# @author Pia Purr
#
###################################################################

library(shiny)
library(shinydashboard)
library(htmlwidgets)
library(shinyjs)
library(shinyBS)

drop.rows = 8
drop.cols = 7
title <- tags$a(href='https://livruen.github.io/Pain2D_Web/',
                tags$img(src="logo_designer/logo_pain2d_designer.png", height = '100'),class="main-header logo")
ui <- dashboardPage(
  dashboardHeader(title = title, titleWidth = 100,
                  tags$li(class = "dropdown",
                  uiOutput('buttonHeader'),
                  actionButton('uploadsvg','upload svg-template',class='rightAlign'),
                  actionButton('buttonNext',label = 'generate Template', icon('arrow-circle-right'),class='rightAlign'),
                  actionButton("buttonPlus", "+", class = 'rightAlign'),
                  actionButton("buttonMinus", "-", class = 'rightAlign'),
                  actionButton("buttonReset", "Reset", class = 'rightAlign'),
                  actionButton("buttonGrid", "Show Grid", class = 'rightAlign'),
                  actionButton("buttonInfo", icon("info"), class = 'rightAlign'))
  ),
  
  dashboardSidebar(width = 100,
                   tags$style(".left-side, .main-sidebar {padding-top: 100px}"),
                   tags$script(JS("document.getElementsByClassName('sidebar-toggle')[0].style.visibility = 'hidden';")),
                   sidebarMenu( id = "tabs",
                                menuItem("Full Body", tabName = "fullBody"),
                                menuItem("Children", tabName = "children"),
                                menuItem("Upper Body", tabName = "upperBody"),
                                menuItem("Head", tabName = "head"),
                                menuItem("Legs", tabName = "legs"),
                                menuItem("Arms", tabName = "arms"),
                                menuItem("Feet", tabName = "feet"),
                                menuItem("Hands", tabName = "hands"),
                                menuItem("Teeth", tabName = "teeth"),
                                menuItem("New", tabName = "new")
                   )),
  dashboardBody(
    tags$head(
      tags$link(rel = "stylesheet", type = "text/css", href = "pdd.css"),
      useShinyjs()),
    fluidRow(
      column(width = 4,
             tags$div(id = "imageSelection"),
      ),
      
      column(width = 5
             ),
      column(width = 8,
             div(id= "dropTable", class= "dropelement", ondrop="drop(event)", ondragover="allowDrop(event)", style= "display: flex",
                 lapply(1:drop.cols, function(i){
                   div(style= "display:flex; flex-direction:column; flex-grow: 1; flex: 1 1 0;", 
                       lapply(drop.rows:1, function(j){
                         div(id=paste0("drop",j,i), class="tableCell")
                       })
                   )
                 })
             )
      ),
    
          uiOutput('templateModel'),
          uiOutput('templateNegativ')
    )
    )
)