### notes on running retrospective analyses and making associated plots
### for China Rockfish assessment
### started 6/15/15

stop("\n  This file should not be sourced!") # note to stop Ian from accidental sourcing

# paths on Ian's computers (other folks can add their own statements)
if (system("hostname", intern=TRUE) %in% c("NWCDW01724920","NWCLW01724829") ){
  dir.mods <- 'c:/SS/China/models' # could be moved to github if we wish
  dir.plots <- 'c:/SS/China/plots'  # could be moved to github if we wish
}

# read base model from each area
dir.S.base <- file.path(dir.mods, 'China_South_2015-06-15_EJ_v01_PRE-STAR_BASE')
dir.C.base <- file.path(dir.mods, 'China_Central_PRE-STAR_BASE_candidate1')
dir.N.base <- file.path(dir.mods, 'China_North_PRE-STAR_BASE_candidate1')

# create new folder to contain all profiles
dir.create(file.path(dir.mods, "retrospectives"))

####################################################################################
# run retros
####################################################################################

# retro North
dir.retro.N <- file.path(dir.mods, "retrospectives", "retro.N")
SS_doRetro(masterdir=dir.N.base, oldsubdir="", newsubdir="../retrospectives/retro.N",
           years=0:-5)

# retro Central
dir.retro.C <- file.path(dir.mods, "retrospectives", "retro.C")
SS_doRetro(masterdir=dir.C.base, oldsubdir="", newsubdir="../retrospectives/retro.C",
           years=0:-5, extras="-nox -cbs 5000000000")

# retro South
dir.retro.S <- file.path(dir.mods, "retrospectives", "retro.S")
SS_doRetro(masterdir=dir.S.base, oldsubdir="", newsubdir="../retrospectives/retro.S",
           years=0:-5, extras="-nox -cbs 5000000000")

####################################################################################
# plot retro results
####################################################################################

# retro North
# make time-series plots
retroMods.N <- SSgetoutput(dirvec=file.path(dir.mods, 'retrospectives/retro.N',
                               paste("retro",0:-5,sep="")))
retroSummary <- SSsummarize(retroMods.N)
endyrvec <- retroSummary$endyrs + 0:-5
# general timeseries plots
SSplotComparisons(retroSummary, endyrvec=endyrvec, png=TRUE, indexUncertainty=TRUE,
                  plotdir=file.path(dir.mods, 'retrospectives'),
                  filenameprefix="retro.N_", 
                  legendlabels=paste("Data",0:-5,"years"))
# fits to indices
for(index in unique(retroSummary$indices$Fleet)){
  SSplotComparisons(retroSummary, endyrvec=endyrvec, png=TRUE, indexUncertainty=TRUE,
                    plotdir=file.path(dir.mods, 'retrospectives'),
                    subplot=11:12,indexfleets=index,
                    filenameprefix="retro.N_", 
                    legendlabels=paste("Data",0:-5,"years"))
}

# retro Central
# make time-series plots
retroMods.C <- SSgetoutput(dirvec=file.path(dir.mods, 'retrospectives/retro.C',
                               paste("retro",0:-5,sep="")))
retroSummary <- SSsummarize(retroMods.C)
endyrvec <- retroSummary$endyrs + 0:-5
# general timeseries plots
SSplotComparisons(retroSummary, endyrvec=endyrvec, png=TRUE, indexUncertainty=TRUE,
                  plotdir=file.path(dir.mods, 'retrospectives'),
                  filenameprefix="retro.C_", 
                  legendlabels=paste("Data",0:-5,"years"))
# fits to indices
for(index in unique(retroSummary$indices$Fleet)){
  SSplotComparisons(retroSummary, endyrvec=endyrvec, png=TRUE, indexUncertainty=TRUE,
                    plotdir=file.path(dir.mods, 'retrospectives'),
                    subplot=11:12,indexfleets=index,
                    filenameprefix="retro.C_", 
                    legendlabels=paste("Data",0:-5,"years"))
}

# retro South
# make time-series plots
retroMods.S <- SSgetoutput(dirvec=file.path(dir.mods, 'retrospectives/retro.S',
                               paste("retro",0:-5,sep="")))
retroSummary <- SSsummarize(retroMods.S)
endyrvec <- retroSummary$endyrs + 0:-5
# general timeseries plots
SSplotComparisons(retroSummary, endyrvec=endyrvec, png=TRUE, indexUncertainty=TRUE,
                  plotdir=file.path(dir.mods, 'retrospectives'),
                  filenameprefix="retro.S_", 
                  legendlabels=paste("Data",0:-5,"years"))
# fits to indices
for(index in unique(retroSummary$indices$Fleet)){
  SSplotComparisons(retroSummary, endyrvec=endyrvec, png=TRUE, indexUncertainty=TRUE,
                    plotdir=file.path(dir.mods, 'retrospectives'),
                    subplot=11:12,indexfleets=index,
                    filenameprefix="retro.S_", 
                    legendlabels=paste("Data",0:-5,"years"))
}
