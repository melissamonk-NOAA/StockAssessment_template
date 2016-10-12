### The following script will look for the CSV file plotInfoTable created by r4ss
### in order to automate some of the plots.  The plotInfoTable file is added to the 
### folder each time SS_plots is run (including when you update any of the plots)
### The most recent version of plotInfoTable with the complete list of plots will 
### be used.  
### Note that if you were running the SS_plots in a different folder on your computer
### before migrating to the Assessment_template folder (or whatever you name the working
### directory for your assessment), you will need to purge the prior
### plotInfoTable CSV files, or change their names...due to the search implemented here
### based on file name.  You will end up with multiple duplicates with different file
### locations for each plot.


for(jmod in 1:n_models){

  if(jmod==1){
      # plot directory
      plotdir <- 'plots_mod1'
      # model number
      mod = 'mod1'
   } else {
    if(jmod==2){
      plotdir <- 'plots_mod2'
      mod = 'mod2'
    } else {
      plotdir <- 'plots_mod3'
      mod = 'mod3'
    }}
  
  
  # working directory to the r4ss folder
  dir <- file.path(getwd(),'r4ss')
  
  
# Following code taken from SS_html in the r4ss package.
# check for table in directory with PNG files
#if(is.null(plotInfoTable)){
#  if(!is.null(replist)){

    filenames <- dir(file.path(dir,plotdir))
    # look for all files beginning with the name 'plotInfoTable'
    filenames <- filenames[grep("plotInfoTable",filenames)]
    filenames <- filenames[grep(".csv",filenames)]
    if(length(filenames)==0) stop("No CSV files with name 'plotInfoTable...'")
    plotInfoTable <- NULL
    # loop over matching CSV files and combine them
    for(ifile in 1:length(filenames)){
      filename <- file.path(dir,plotdir,filenames[ifile])
      temp <- read.csv(filename,colClasses = "character")
      plotInfoTable <- rbind(plotInfoTable,temp)
    }
    plotInfoTable$png_time <- as.POSIXlt(plotInfoTable$png_time)
   
    # look for duplicate file names
    filetable <- table(plotInfoTable$file)
    duplicates <- names(filetable[filetable>1])
    
    # loop over duplicates and remove rows for older instance
    if(length(duplicates)>0){
    
      #  if(verbose) cat("Removing duplicate rows in combined plotInfoTable based on mutliple CSV files\n")
      for(idup in 1:length(duplicates)){
        duprows <- grep(duplicates[idup], plotInfoTable$file, fixed=TRUE)
        duptimes <- plotInfoTable$png_time[duprows]
        # keep duplicates with the most recent time
        dupbad <- duprows[duptimes!=max(duptimes)]
        goodrows <- setdiff(1:nrow(plotInfoTable),dupbad)
        plotInfoTable <- plotInfoTable[goodrows,]
      }
    }
#  }else{
#    stop("Need input for 'replist' or 'plotInfoTable'")
#  }
#}
if(!is.data.frame(plotInfoTable))
  stop("'plotInfoTable' needs to be a data frame")

plotInfoTable$basename <- basename(as.character(plotInfoTable$file))
plotInfoTable$dirname <- dirname(as.character(plotInfoTable$file))
plotInfoTable$dirname2 <- basename(dirname(as.character(plotInfoTable$file)))
plotInfoTable$path <- file.path(plotInfoTable$dirname2,plotInfoTable$basename)
#dir <- dirname(plotInfoTable$dirname)[1]

write.csv(plotInfoTable, paste(file.path(dir,plotdir),"/plotInfoTable_",mod,"_final.csv",sep=''),row.names=FALSE)

}