#' Add line breaks to a text file (SS input files for print in the document)
#' 
#' Facilitates inclusion of SS input files in rMarkdown document
#' 
#' 
#' 
#' @param dir      Directory where file is located
#' @param oldfile  File with long lines that need linebreaks
#' @param newfile  File to write with linebreaks added
#' @param length   Length of lines to be broken

linebreaks <- function(dir,out.dir, oldfile, newfile, length=75){
  # read lines
  lines <- readLines(file.path(dir, oldfile))
  # place to store broken lines
  newlines <- NULL
  # loop over lines of existing file
  for(iline in 1:length(lines)){
    # individual line
    line <- lines[iline]
    # replace tabs with single spaces
    line <- gsub(pattern="\t", replacement=" ", x=line)
    # code for whether file has been processed adequately
    finished <- FALSE
    # iterate up to 10 times per line
    for(iteration in 1:10){
      # do remaining stuff only if not finished
      if(!finished){
        if(nchar(line)>length){
          # chop line in two pieces if longer than threshold
          first <- substring(line, first=1, last=length)
          line  <- substring(line, first=length+1)
          # add comment mark before remaining part of line
          # if there was a comment in the first part
          if(length(grep("#", first))>0){
            line <- paste("#",line)
          }
          # add first part to newlines object
          newlines <- c(newlines, first)
        }else{
          finished <- TRUE
          newlines <- c(newlines, line)
        }
      }
    }
  }
  # write to new file
  cat('writing to',file.path(out.dir, newfile),'\n')
  writeLines(newlines, con=file.path(out.dir, newfile))
}


# =============================================================================
# Change file path to the assessment document folder, subfolder linebreak_files

# output directory
linebreak.dir = file.path(getwd(),"SS/linebreak_files")

# remove any old files
do.call(file.remove,list(list.files(linebreak.dir,full.names=TRUE)))


  
for(imod in 1:n_models){  
# change the model directoy
 mod.dir  = paste(file.path(getwd(),'SS/Base_model'),imod,sep='')

 if(imod==1){
   data_file = mod1_dat
   control_file = mod1_ctrl
   data_new = 'mod1_data.ss'
   ctrl_new = 'mod1_control.ss'
   starter_new = 'mod1_starter.ss'
   forecast_new = 'mod1_forecast.ss'
    } else {
   if(imod==2){
     data_file = mod2_dat
     control_file = mod2_ctrl
     data_new = 'mod3_data.ss'
     ctrl_new = 'mod2_control.ss'
     starter_new = 'mod2_starter.ss'
     forecast_new = 'mod2_forecast.ss'
   } else {
     data_file = mod3_dat
     control_file = mod3_ctrl
     data_new = 'mod3_data.ss'
     ctrl_new = 'mod3_control.ss'
     starter_new = 'mod3_starter.ss'
     forecast_new = 'mod3_forecast.ss'
   }}


# data files
linebreaks(dir = mod.dir, out.dir = linebreak.dir, oldfile = data_file, newfile = data_new, length=75)

# control files
linebreaks(dir = mod.dir, out.dir=linebreak.dir, oldfile = control_file, newfile = ctrl_new, length=75)

# starter files
linebreaks(dir = mod.dir, out.dir=linebreak.dir, oldfile='starter.ss', newfile = starter_new, length=75)
 
# forecast files
linebreaks(dir = mod.dir, out.dir=linebreak.dir, oldfile='forecast.ss', newfile = forecast_new, length=75)
    
}



  

