library(shiny)

shinyServer(function(input, output) {

  dfIn<-reactive({
          
          # Scenarios
          pvals<-seq(0,1,length=1001)  # Possible p Values
          likelihood<-dbinom(input$nCorrect,input$nTotal,pvals)/sum(dbinom(input$nCorrect,input$nTotal,pvals))  # Likelihood as Probability
          pd<-1.5*pvals-0.5  # Proportion of Distinguishers
          pd[pd<0]<-0
          
          # Data
          income<-input$profitPerUnit*input$units*(1-input$pr*pd)
          lostIncome<-input$profitPerUnit*input$units-income
          savings<-input$savingsPerUnit*input$units*(1-input$pr*pd)
          value<-savings-lostIncome
          
          dfIn<-data.frame(cbind(likelihood,value))
          dfIn<-dfIn[dfIn$likelihood > 0.00000000001, ]
            
  })      
  
  output$dfIn<-renderTable({dfIn()})
        
  output$dfOut <- renderTable({
          
          # Expected Payout
          EVi<-dfIn()$value*dfIn()$likelihood  # Expected Value = Sum(X(i) * Prob(i))
          EV<-sum(EVi)
          
          VARi<-(dfIn()$value-EV)^2 * dfIn()$likelihood
          VAR<-sum(VARi)
          s<-sqrt(VAR)
          LCL<-EV-2*s
          UCL<-min(EV+2*s, max(dfIn()$value))
          
          dfOut<-data.frame(cbind(Metric=c("Expected Value","95% LCL","95% UCL"),
                       Value =c(round(EV,0),round(LCL,0),round(UCL,0))))
          names(dfOut)<-c("Estimate","Value ($)")
          dfOut

           
  }, include.rownames=FALSE)     
          
  
  output$myPlot <- renderPlot({    
          
          # Plots         
          plot(dfIn()$value,dfIn()$likelihood, type="l", col="blue",xlab="Value ($)",ylab="Likelihood",frame=FALSE,yaxt='n',xlim=c(min(0,min(dfIn()$value)),max(dfIn()$value)))
          abline(v=0,col="red",lty=2)
          
          
          # Draw Polygon Shaded
          myPoly<-dfIn()[dfIn()$value <= 0,]
          polyx<-c(0,myPoly$value,min(myPoly$value))
          polyy<-c(0,myPoly$likelihood, 0)
          polygon(x=polyx,y=polyy, col="red")
          
  })
  
  
})
###





