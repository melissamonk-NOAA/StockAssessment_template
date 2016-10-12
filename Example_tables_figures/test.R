
#+ results='asis', echo=FALSE
plotInfoTable_mod1 = read.csv('C:/Assessment_template/r4ss/plots_mod1/plotInfoTable_mod1_final.csv')
plotInfoTable_mod1 = data.frame(lapply(plotInfoTable_mod1, as.character), stringsAsFactors=FALSE)   
   
# plots <- list.files("C:/Assessment_template/r4ss/plots_mod1")
for(i in 1:1){
  filename <- 'plotInfoTable_mod1'
  print(cat("![`r ",filename,"[",i,",2]`]","(`r ",filename,"[",i,",1]`)",sep=''))
}