# Code and notes on jittering pre-star base models

stop("\n  This file should not be sourced!") # note to stop yourself from accidental sourcing

# Paths on Ian's computers (other folks can add their own statements)
if (system("hostname", intern=TRUE) %in% c("NWCDW01724920","NWCLW01724829") ){
  dir.mods <- 'c:/SS/China/models'  # could be moved to github if we wish
  dir.plots <- 'c:/SS/China/plots'  # could be moved to github if we wish
}

require(r4ss)

# directories for jittering
# NOTE: starter files modified to include 0.1 jitter value
dir.S.jit <- file.path(dir.mods, 'jitters/China_South_2015-06-15_EJ_v01_PRE-STAR_BASE')
dir.C.jit <- file.path(dir.mods, 'jitters/China_Central_PRE-STAR_BASE_candidate2')
dir.N.jit <- file.path(dir.mods, 'jitters/China_North_PRE-STAR_BASE_candidate1')

jit.S <- SS_RunJitter(dir.S.jit, Njitter=100)
jit.C <- SS_RunJitter(dir.C.jit, Njitter=100, model="SS3safe_Win64")
jit.N <- SS_RunJitter(dir.N.jit, Njitter=100, model="SS3safe_Win64")


table(jit.S, useNA='always')
## jit.S
## 616.214 663.868 668.276    <NA> 
##      67       4      28       1

table(jit.C, useNA='always')
## jit.C
## 1840.01    <NA> 
##      94       6 

table(jit.N, useNA='always')
## jit.N
## 1011.07    <NA> 
##     100       0 
