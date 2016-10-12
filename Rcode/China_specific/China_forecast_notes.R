### notes on makeing plots for China Rockfish assessment document
### started 6/13/15

stop("\n  This file should not be sourced!") # note to stop Ian from accidental sourcing

# paths on Ian's computers (other folks can add their own statements)
if (system("hostname", intern=TRUE) %in% c("NWCDW01724920","NWCLW01724829") ){
  dir.mods <- 'c:/SS/China/models' # could be moved to github if we wish
  dir.plots <- 'c:/SS/China/plots'  # could be moved to github if we wish
}

# read base model from each area
dir.S.base <- file.path(dir.mods, 'China_South_2015-06-15_EJ_v01_PRE-STAR_BASE')
dir.C.base <- file.path(dir.mods, 'China_Central_PRE-STAR_BASE_candidate2')
dir.N.base <- file.path(dir.mods, 'China_North_PRE-STAR_BASE_candidate1')
out.S <- SS_output(dir.S.base)
out.C <- SS_output(dir.C.base)
out.N <- SS_output(dir.N.base)

# get dead(B) cols from timeseries
dead.S <- out.S$timeseries[ ,grep("dead(B)", names(out.S$timeseries), fixed=TRUE)]
yr.S <- out.S$timeseries$Yr
# average ratios over past 5 years
avg5.S <- apply(dead.S[yr.S %in% 2010:2014,], 2, sum)/5
# average ratios over past 2 years
avg2.S <- apply(dead.S[yr.S %in% 2013:2014,], 2, sum)/2
# average ratios over past 1 years
avg1.S <- apply(dead.S[yr.S %in% 2014,], 2, sum)/1

# average catch per year over most recent 5, 2, and 1 years
round(rbind(avg5.S, avg2.S, avg1.S), 3)
##      dead(B):_1 dead(B):_2 dead(B):_3 dead(B):_4
## avg5      0.507      1.521      6.057      6.305
## avg2      0.315      1.634      4.432      4.761
## avg1      0.251      2.011      4.336      5.249

out.S$FleetNames
## [1] "1_CA_SouthOf4010_Comm_Dead"           
## [2] "2_CA_SouthOf4010_Comm_Live"           
## [3] "3_CA_SouthOf4010_Rec_PC"              
## [4] "4_CA_SouthOf4010_Rec_PR"              
## [5] "5_CA_SouthOf4010_Rec_PC_DWV_index"    
## [6] "6_CA_SouthOf4010_Rec_PC_onboard_index"
## [7] "7_CA_SouthOf4010_CCFRP_comps_only"    
## [8] "8_CA_SouthOf4010_Abrams_thesis_comps" 

# Looks like live fishery is increasing and dead decreasing.
# Choosing 2014 as most representative



# get dead(B) cols from timeseries
dead.N <- out.N$timeseries[ ,grep("dead(B)", names(out.N$timeseries), fixed=TRUE)]
dead.C <- out.C$timeseries[ ,grep("dead(B)", names(out.C$timeseries), fixed=TRUE)]
names(dead.N) <- paste0("N",1:ncol(dead.N))
names(dead.C) <- paste0("C",1:ncol(dead.C))
# dead for North and Central
dead.NC <- cbind(dead.N, dead.C)

yr.NC <- out.N$timeseries$Yr
# average ratios over past 5 years
avg5.NC <- apply(dead.NC[yr.NC %in% 2010:2014,], 2, sum)/5
# average ratios over past 2 years
avg2.NC <- apply(dead.NC[yr.NC %in% 2013:2014,], 2, sum)/2
# average ratios over past 1 years
avg1.NC <- apply(dead.NC[yr.NC %in% 2014,], 2, sum)/1

# average catch per year over most recent 5, 2, and 1 years
(avgs <- round(rbind(avg5.NC, avg2.NC, avg1.NC), 3))
##      dead(B):_1 dead(B):_2 dead(B):_3 dead(B):_4
## avg5      0.507      1.521      6.057      6.305
## avg2      0.315      1.634      4.432      4.761
## avg1      0.251      2.011      4.336      5.249

# average fraction of North catch out of North + Central models over 5, 2, 1 year
round(c(sum(avg5.NC[grep("N",names(avg5.NC))])/sum(avg5.NC),
        sum(avg2.NC[grep("N",names(avg2.NC))])/sum(avg2.NC),
        sum(avg1.NC[grep("N",names(avg1.NC))])/sum(avg1.NC)),3)
# [1] 0.226 0.250 0.300
# looks like North (WA) catch has increased relative to central (OR + N.CA)
# Choosing 2014 makes sense again for forecast


# ABC contributions for N and S of 40-10 based on Table o
ABCcontrib.S <- 13.8
# vector of 2014 catches scaled to ABC contribution:
cat1516.S <- round(ABCcontrib.S*avg1.S/sum(avg1.S),2)
# putting into SS format
n <- out.S$nfishfleets
fore.dead.S <- rbind(data.frame(Year=2015, Seas=1, Fleet=1:n, Catch=cat1516.S,
                                fleet=paste0("# ",out.S$FleetNames[1:n])),
                     data.frame(Year=2016, Seas=1, Fleet=1:n, Catch=cat1516.S,
                                fleet=paste0("# ",out.S$FleetNames[1:n])))
# adding # at front of header
names(fore.dead.S)[1] <- "#Year"
# print
print(fore.dead.S, row.names=FALSE)
 #Year Seas Fleet Catch                        fleet
  2015    1     1  0.29 # 1_CA_SouthOf4010_Comm_Dead
  2015    1     2  2.34 # 2_CA_SouthOf4010_Comm_Live
  2015    1     3  5.05    # 3_CA_SouthOf4010_Rec_PC
  2015    1     4  6.11    # 4_CA_SouthOf4010_Rec_PR
  2016    1     1  0.29 # 1_CA_SouthOf4010_Comm_Dead
  2016    1     2  2.34 # 2_CA_SouthOf4010_Comm_Live
  2016    1     3  5.05    # 3_CA_SouthOf4010_Rec_PC
  2016    1     4  6.11    # 4_CA_SouthOf4010_Rec_PR


# ABC contributions for N and S of 40-10 based on Table o
ABCcontrib.NC <- 8.2
# vector of 2014 catches scaled to ABC contribution:
cat1516.NC <- round(ABCcontrib.NC*avg1.NC/sum(avg1.NC),2)
# putting into SS format
n <- out.N$nfishfleets
fore.dead.N <- rbind(data.frame(Year=2015, Seas=1, Fleet=1:n,
                                Catch=cat1516.NC[grep("N",names(cat1516.NC))],
                                fleet=paste0("# ",out.N$FleetNames[1:n])),
                     data.frame(Year=2016, Seas=1, Fleet=1:n,
                                Catch=cat1516.NC[grep("N",names(cat1516.NC))],
                                fleet=paste0("# ",out.N$FleetNames[1:n])))
# adding # at front of header
names(fore.dead.N)[1] <- "#Year"
# print
print(fore.dead.N, row.names=FALSE)
 #Year Seas Fleet Catch                      fleet
  2015    1     1  0.03 # 1_WA_SouthernWA_Rec_PCPR
  2015    1     2  0.24   # 2_WA_NorthernWA_Rec_PC
  2015    1     3  2.18   # 3_WA_NorthernWA_Rec_PR
  2016    1     1  0.03 # 1_WA_SouthernWA_Rec_PCPR
  2016    1     2  0.24   # 2_WA_NorthernWA_Rec_PC
  2016    1     3  2.18   # 3_WA_NorthernWA_Rec_PR

n <- out.C$nfishfleets
fore.dead.C <- rbind(data.frame(Year=2015, Seas=1, Fleet=1:n,
                                Catch=cat1516.NC[grep("C",names(cat1516.NC))],
                                fleet=paste0("# ",out.C$FleetNames[1:n])),
                     data.frame(Year=2016, Seas=1, Fleet=1:n,
                                Catch=cat1516.NC[grep("C",names(cat1516.NC))],
                                fleet=paste0("# ",out.C$FleetNames[1:n])))
# adding # at front of header
names(fore.dead.C)[1] <- "#Year"
# print
print(fore.dead.C, row.names=FALSE)

 #Year Seas Fleet Catch                        fleet
  2015    1     1  0.02 # 1_CA_NorthOf4010_Comm_Dead
  2015    1     2  0.07 # 2_CA_NorthOf4010_Comm_Live
  2015    1     3  0.07    # 3_CA_NorthOf4010_Rec_PC
  2015    1     4  0.54    # 4_CA_NorthOf4010_Rec_PR
  2015    1     5  0.60  # 5_OR_SouthernOR_Comm_Dead
  2015    1     6  3.03  # 6_OR_SouthernOR_Comm_Live
  2015    1     7  0.15     # 7_OR_SouthernOR_Rec_PC
  2015    1     8  0.39     # 8_OR_SouthernOR_Rec_PR
  2015    1     9  0.02       # 9_OR_NorthernOR_Comm
  2015    1    10  0.42    # 10_OR_NorthernOR_Rec_PC
  2015    1    11  0.43    # 11_OR_NorthernOR_Rec_PR
  2016    1     1  0.02 # 1_CA_NorthOf4010_Comm_Dead
  2016    1     2  0.07 # 2_CA_NorthOf4010_Comm_Live
  2016    1     3  0.07    # 3_CA_NorthOf4010_Rec_PC
  2016    1     4  0.54    # 4_CA_NorthOf4010_Rec_PR
  2016    1     5  0.60  # 5_OR_SouthernOR_Comm_Dead
  2016    1     6  3.03  # 6_OR_SouthernOR_Comm_Live
  2016    1     7  0.15     # 7_OR_SouthernOR_Rec_PC
  2016    1     8  0.39     # 8_OR_SouthernOR_Rec_PR
  2016    1     9  0.02       # 9_OR_NorthernOR_Comm
  2016    1    10  0.42    # 10_OR_NorthernOR_Rec_PC
  2016    1    11  0.43    # 11_OR_NorthernOR_Rec_PR

### tables above copied into forecast files along with this block of text:
# start block
   # multiplier below based on P*=0.45 and Category 2 Sigma = 0.72
   # qlnorm(0.45, 0, 0.72) = 0.913
   0.913 # Control rule target as fraction of Flimit (e.g. 0.75) 
# end block

### read output after models finish
dir.S.fore <- file.path(dir.mods, 'forecasts/China_South_2015-06-15_EJ_v01_PRE-STAR_BASE')
dir.C.fore <- file.path(dir.mods, 'forecasts/China_Central_PRE-STAR_BASE_candidate2')
dir.N.fore <- file.path(dir.mods, 'forecasts/China_North_PRE-STAR_BASE_candidate1')
out.S.fore <- SS_output(dir.S.fore)
out.C.fore <- SS_output(dir.C.fore)
out.N.fore <- SS_output(dir.N.fore)
############################################################################
# stuff for comparing across models

# vector of names and colors for N, C, and S
mod.names <- c("North","Central","South")
mod.cols  <- c("blue", "purple", "red")

# create base model summary list
fore.summary <- SSsummarize(list(out.N.fore, out.C.fore, out.S.fore))


############################################################################
# time series comparison plots for exec summary (and repeated with regular plots)
SSplotComparisons(fore.summary, plot=FALSE, print=TRUE, plotdir=dir.plots,
                  subplot=1:4,
                  spacepoints=20,  # years between points on each line
                  initpoint=0,     # "first" year of points (modular arithmetic)
                  staggerpoints=0, # points aligned across models
                  endyrvec=2025,   # final year to show in time series
                  tickEndYr=FALSE, # don't show ending year on axis due to overlap
                  legendlabels=mod.names, filenameprefix="forecast_", col=mod.cols)
