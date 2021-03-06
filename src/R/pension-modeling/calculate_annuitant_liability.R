
# Calculate liability of existing annuitants
calculate_annuitant_liability <- function(beneficiary_forecast,npers,ror) {
  annuitants = beneficiary_forecast[[1]]
  avg_benefits_forecast = beneficiary_forecast[[2]]
  
  pv_outflows = c()
  outflows = c()
  
  for (n in 2:npers) {
    outflow = annuitants[,n] * avg_benefits_forecast[,n]
    outflows = c(outflows,outflow)
    pv_outflows = c(pv_outflows, outflow / (1+ror/100)^(n-1))
  }
  
  return(list(pv_outflows,outflows))
}