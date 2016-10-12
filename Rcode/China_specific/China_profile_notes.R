### notes on running profiles and making associated plots for China Rockfish assessment
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
out.S <- SS_output(dir.S.base)
out.C <- SS_output(dir.C.base)
out.N <- SS_output(dir.N.base)

# estimated log(R0) values
out.N$estimated_non_rec_devparameters["SR_LN(R0)",]$Value
## [1] 2.6514
out.C$estimated_non_rec_devparameters["SR_LN(R0)",]$Value
## [1] 3.56152
out.S$estimated_non_rec_devparameters["SR_LN(R0)",]$Value
## [1] 4.76973

# vectors of log(R0) spanning estimates 
logR0vec.N <- seq(3.5, 2.3, -.1)
logR0vec.C <- seq(4.6, 2.6, -.2)
logR0vec.S <- seq(6.0, 4.0, -.2)

# vectors of M
M.vec <- sort(c(0.053, seq(0.04, 0.12, 0.02)))

# vectors of steepness
h.vec <- c(0.3, 0.6, 0.773, 0.9)

# create new folder to contain all profiles
#dir.create(file.path(dir.mods, "profiles"))

####################################################################################
# function to copy input files
####################################################################################
copy.SS.files <- function(mod="N", target=NULL,
                          SSsource='c:/ss/SSv3.24U_Aug29/Win64/SS3safe_Win64.exe',
                          control.for.profile=FALSE, overwrite=FALSE){
  dir.base <- get(paste0("dir.",mod,".base"))
  output <- get(paste0("out.",mod))
  start <- SS_readstarter(file.path(dir.base, "starter.ss"))
  dir.create(target)
  file.copy(from=file.path(dir.base, "forecast.ss"),
            to=file.path(target, "forecast.ss"), overwrite=overwrite)
  file.copy(from=file.path(dir.base, start$ctlfile),
            to=file.path(target, start$ctlfile), overwrite=overwrite)
  file.copy(from=file.path(dir.base, 'control.ss_new'),
            to=file.path(target, 'control.ss_new'), overwrite=overwrite)
  file.copy(from=file.path(dir.base, start$datfile),
            to=file.path(target, start$datfile), overwrite=overwrite)
  file.copy(from=SSsource,
            to=file.path(target, "SS3.exe"), overwrite=overwrite)
  if(control.for.profile){
    start$ctlfile <- "control_modified.ss"
    # make sure the prior likelihood is calculated
    # for non-estimated quantities
    start$prior_like <- 1
    # write modified starter file
    SS_writestarter(start, dir=target, overwrite=overwrite)
  }else{
    file.copy(from=file.path(dir.base, "starter.ss"),
              to=file.path(target, "starter.ss"), overwrite=overwrite)
  }
}

####################################################################################
# run profiles
####################################################################################

##################################################################################
# log(R0) profiles
dir.prof.R0.N <- file.path(dir.mods, "profiles", "prof.R0.N")
copy.SS.files(mod="N", target=dir.prof.R0.N, control.for.profile=TRUE)
SS_profile(dir=dir.prof.R0.N, string="R0", profilevec=logR0vec.N)

dir.prof.R0.C <- file.path(dir.mods, "profiles", "prof.R0.C")
copy.SS.files(mod="C", target=dir.prof.R0.C, control.for.profile=TRUE, overwrite=TRUE)
SS_profile(dir=dir.prof.R0.C, string="R0", profilevec=logR0vec.C, extras="-nohess -nox")

dir.prof.R0.S <- file.path(dir.mods, "profiles", "prof.R0.S")
copy.SS.files(mod="S", target=dir.prof.R0.S, control.for.profile=TRUE, overwrite=TRUE)
SS_profile(dir=dir.prof.R0.S, string="R0", profilevec=logR0vec.S, extras="-nohess -nox")

##################################################################################
# mortality profiles
dir.prof.M.N <- file.path(dir.mods, "profiles", "prof.M.N")
copy.SS.files(mod="N", target=dir.prof.M.N, control.for.profile=TRUE, overwrite=TRUE)
SS_profile(dir=dir.prof.M.N, string="NatM_p_1_Fem_GP_1",
           profilevec=M.vec, extras="-nohess -nox")

dir.prof.M.C <- file.path(dir.mods, "profiles", "prof.M.C")
copy.SS.files(mod="C", target=dir.prof.M.C, control.for.profile=TRUE, overwrite=TRUE)
SS_profile(dir=dir.prof.M.C, string="NatM_p_1_Fem_GP_1",
           profilevec=M.vec, extras="-nohess -nox")

dir.prof.M.S <- file.path(dir.mods, "profiles", "prof.M.S")
copy.SS.files(mod="S", target=dir.prof.M.S, control.for.profile=TRUE, overwrite=TRUE)
SS_profile(dir=dir.prof.M.S, string="NatM_p_1_Fem_GP_1",
           profilevec=M.vec, extras="-nohess -nox")

##################################################################################
# steepness profiles
dir.prof.h.N <- file.path(dir.mods, "profiles", "prof.h.N")
copy.SS.files(mod="N", target=dir.prof.h.N, control.for.profile=TRUE, overwrite=TRUE)
SS_profile(dir=dir.prof.h.N, string="steep",
           profilevec=h.vec, extras="-nohess -nox")

dir.prof.h.C <- file.path(dir.mods, "profiles", "prof.h.C")
copy.SS.files(mod="C", target=dir.prof.h.C, control.for.profile=TRUE, overwrite=TRUE)
SS_profile(dir=dir.prof.h.C, string="steep",
           profilevec=h.vec, extras="-nohess -nox")

dir.prof.h.S <- file.path(dir.mods, "profiles", "prof.h.S")
copy.SS.files(mod="S", target=dir.prof.h.S, control.for.profile=TRUE, overwrite=TRUE)
SS_profile(dir=dir.prof.h.S, string="steep",
           profilevec=h.vec, extras="-nohess -nox")

####################################################################################
### plotting profile results
####################################################################################

##################################################################################
# Mortality profile North
profilemodels <- SSgetoutput(dirvec=dir.prof.M.N, keyvec=1:length(M.vec), getcovar=FALSE)
# summarize output
profilesummary <- SSsummarize(profilemodels)
# open PNG file (allows extra axis to be added)
png(file.path(dir.mods, "profiles/profile_Mortality.N.png"),
    width=6.5, height=5, res=300, units='in', pointsize=10)
SSplotProfile(profilesummary,           # summary object
              minfraction = 0.001,
              sort.by.max.change = FALSE,
              plotdir=dir.prof.M.N,
              profile.string = "NatM_p_1_Fem_GP_1", # substring of profile parameter
              profile.label="Natural mortality (M)") # axis label
axis(1,at=0.053) # axis showing base model values (prior median)
dev.off() # close PNG file

SSplotComparisons(profilesummary, subplot=1, legendlabels=paste0("M=",M.vec),
                  png=TRUE, plotdir=file.path(dir.mods, "profiles"), models=1:4,
                  filenameprefix="profile_Mortality.N_")

##################################################################################
# Mortality profile Central
profilemodels <- SSgetoutput(dirvec=dir.prof.M.C, keyvec=1:length(M.vec), getcovar=FALSE)
# summarize output
profilesummary <- SSsummarize(profilemodels)
# open PNG file (allows extra axis to be added)
png(file.path(dir.mods, "profiles/profile_Mortality.C.png"),
    width=6.5, height=5, res=300, units='in', pointsize=10)
SSplotProfile(profilesummary,           # summary object
              minfraction = 0.0001,
              sort.by.max.change = FALSE,
              plotdir=dir.prof.M.C,
              profile.string = "NatM_p_1_Fem_GP_1", # substring of profile parameter
              profile.label="Natural mortality (M)") # axis label
axis(1,at=0.053) # axis showing base model values (prior median)
dev.off() # close PNG file

# time series plots from profiles
SSplotComparisons(profilesummary, subplot=1, legendlabels=paste0("M=",M.vec),
                  png=TRUE, plotdir=file.path(dir.mods, "profiles"), models=1:4,
                  filenameprefix="profile_Mortality.C_")

##################################################################################
# Mortality profile South
profilemodels <- SSgetoutput(dirvec=dir.prof.M.S, keyvec=1:length(M.vec), getcovar=FALSE)
# summarize output
profilesummary <- SSsummarize(profilemodels)
# open PNG file (allows extra axis to be added)
png(file.path(dir.mods, "profiles/profile_Mortality.S.png"),
    width=6.5, height=5, res=300, units='in', pointsize=10)
SSplotProfile(profilesummary,           # summary object
              minfraction = 0.001,
              sort.by.max.change = FALSE,
              plotdir=dir.prof.M.S,
              profile.string = "NatM_p_1_Fem_GP_1", # substring of profile parameter
              profile.label="Natural mortality (M)") # axis label
axis(1,at=0.053) # axis showing base model values (prior median)
dev.off() # close PNG file

SSplotComparisons(profilesummary, subplot=1, legendlabels=paste0("M=",M.vec),
                  png=TRUE, plotdir=file.path(dir.mods, "profiles"), models=1:4,
                  filenameprefix="profile_Mortality.S_")

##################################################################################
# R0 profile North
profilemodels <- SSgetoutput(dirvec=dir.prof.R0.N, keyvec=1:length(logR0vec.N),
                             getcovar=FALSE)
profilemodels$MLE <- out.N
profilesummary <- SSsummarize(profilemodels)
# plot profile using summary created above
SSplotProfile(profilesummary,           # summary object
              minfraction = 0.0001,
              sort.by.max.change = FALSE,
              ymax=60,
              plotdir=dir.prof.R0.N,
              print=TRUE,
              profile.string = "R0", # substring of profile parameter
              profile.label="Log of unfished equilibrium recruitment, log(R0)") # axis label
file.copy(file.path(dir.prof.R0.N, 'profile_plot_likelihood.png'),
          file.path(dir.prof.R0.N, '../profile_logR0.N.png'), overwrite=TRUE)

##################################################################################
# R0 profile Central
dir.prof.R0.C <- file.path(dir.mods, "profiles", "prof.R0.C")
profilemodels <- SSgetoutput(dirvec=dir.prof.R0.C, keyvec=1:length(logR0vec.C),
                             getcovar=FALSE)
profilemodels$MLE <- out.C
profilesummary <- SSsummarize(profilemodels)
# plot profile using summary created above
SSplotProfile(profilesummary,           # summary object
              minfraction = 0.0001,
              sort.by.max.change = FALSE,
              xlim=c(3.2,4.6),
              ymax=200,
              plotdir=dir.prof.R0.C,
              print=TRUE,
              profile.string = "R0", # substring of profile parameter
              profile.label="Log of unfished equilibrium recruitment, log(R0)") # axis label
file.copy(file.path(dir.prof.R0.C, 'profile_plot_likelihood.png'),
          file.path(dir.prof.R0.C, '../profile_logR0.C.png'), overwrite=TRUE)
# Piner Plot showing influence of age comps by fleet
PinerPlot(profilesummary,           # summary object
          component="Age_like",
          main="Changes in length-composition likelihoods by fleet",
          minfraction = 0.0001,
          xlim=c(3.2,4.6),
          ymax=200,
          plotdir=dir.prof.R0.C,
          print=FALSE,
          profile.string = "R0", # substring of profile parameter
          profile.label="Log of unfished equilibrium recruitment, log(R0)") # axis label
file.copy(file.path(dir.prof.R0.C, 'profile_plot_likelihood.png'),
          file.path(dir.prof.R0.C, '../profile_logR0.C.png'), overwrite=TRUE)


# plot profile using summary created above
SSplotProfile(profilesummary,           # summary object
              minfraction = 0.0001,
              sort.by.max.change = FALSE,
              xlim=c(3.2,4.6),
              ymax=5,
              plotdir=dir.prof.R0.C,
              print=TRUE,
              profile.string = "R0", # substring of profile parameter
              profile.label="Log of unfished equilibrium recruitment, log(R0)") # axis label
file.copy(file.path(dir.prof.R0.C, 'profile_plot_likelihood.png'),
          file.path(dir.prof.R0.C, '../profile_logR0.C_ymax5.png'), overwrite=TRUE)

##################################################################################
# R0 profile South
profilemodels <- SSgetoutput(dirvec=dir.prof.R0.S, keyvec=1:length(logR0vec.S),
                             getcovar=FALSE)
profilemodels$MLE <- out.S
profilesummary <- SSsummarize(profilemodels)
# plot profile using summary created above
SSplotProfile(profilesummary,           # summary object
              models=1:9,
              minfraction = 0.0001,
              sort.by.max.change = FALSE,
              #xlim=c(3.2,4.6),
              ymax=100,
              plotdir=dir.prof.R0.S,
              print=TRUE,
              profile.string = "R0", # substring of profile parameter
              profile.label="Log of unfished equilibrium recruitment, log(R0)") # axis label
file.copy(file.path(dir.prof.R0.S, 'profile_plot_likelihood.png'),
          file.path(dir.prof.R0.S, '../profile_logR0.S.png'), overwrite=TRUE)

##################################################################################
# Steepness profile North
profilemodels <- SSgetoutput(dirvec=dir.prof.h.N, keyvec=1:length(h.vec), getcovar=FALSE)
# summarize output
profilesummary <- SSsummarize(profilemodels)
# open PNG file (allows extra axis to be added)
png(file.path(dir.mods, "profiles/profile_Steepness.N.png"),
    width=6.5, height=5, res=300, units='in', pointsize=10)
SSplotProfile(profilesummary,           # summary object
              minfraction = 0.001,
              sort.by.max.change = FALSE,
              plotdir=dir.prof.h.N,
              profile.string = "steep", # substring of profile parameter
              profile.label="Stock-recruit steepness (h)",
              axes=FALSE)
axis(1,at=h.vec[h.vec!=0.773]) # axis for small numbers
axis(1,at=h.vec[h.vec==0.773]) # axis with more decimals
axis(2)
dev.off() # close PNG file

##################################################################################
# Steepness profile Central
profilemodels <- SSgetoutput(dirvec=dir.prof.h.C, keyvec=1:length(h.vec), getcovar=FALSE)
# summarize output
profilesummary <- SSsummarize(profilemodels)
# open PNG file (allows extra axis to be added)
png(file.path(dir.mods, "profiles/profile_Steepness.C.png"),
    width=6.5, height=5, res=300, units='in', pointsize=10)
SSplotProfile(profilesummary,           # summary object
              minfraction = 0.0001,
              sort.by.max.change = FALSE,
              plotdir=dir.prof.h.C,
              profile.string = "steep", # substring of profile parameter
              profile.label="Stock-recruit steepness (h)",
              axes=FALSE)
axis(1,at=h.vec[h.vec!=0.773]) # axis for small numbers
axis(1,at=h.vec[h.vec==0.773]) # axis with more decimals
axis(2)
dev.off() # close PNG file

##################################################################################
# Steepness profile South
profilemodels <- SSgetoutput(dirvec=dir.prof.h.S, keyvec=1:length(h.vec), getcovar=FALSE)
# summarize output
profilesummary <- SSsummarize(profilemodels)
# open PNG file (allows extra axis to be added)
png(file.path(dir.mods, "profiles/profile_Steepness.S.png"),
    width=6.5, height=5, res=300, units='in', pointsize=10)
SSplotProfile(profilesummary,           # summary object
              minfraction = 0.001,
              sort.by.max.change = FALSE,
              plotdir=dir.prof.h.S,
              profile.string = "steep", # substring of profile parameter
              profile.label="Stock-recruit steepness (h)",
              axes=FALSE)
axis(1,at=h.vec[h.vec!=0.773]) # axis for small numbers
axis(1,at=h.vec[h.vec==0.773]) # axis with more decimals
axis(2)
dev.off() # close PNG file
