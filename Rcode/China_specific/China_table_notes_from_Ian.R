# unfinished example of table of parameters for China models
library(r4ss)
 setwd("C:/China2015")
 load("./r4ss/Chinanorth2015.RData")

likenames <- NULL
parnames <- c("NatM_p_1_Fem",
              "L_at_Amin_Fem_GP_1",
              "L_at_Amax_Fem_GP_1",
              "VonBert_K_Fem_GP_1",
              "CV_young_Fem_GP_1",
              "CV_old_Fem_GP_1",
              "SR_LN",
              "Q_extraSD",
              paste0("SizeSel_",1:12,"P_1"),
              paste0("SizeSel_",1:12,"P_1"),
              paste0("Retain_2P_1"),
              paste0("Retain_2P_2"))

pars.S <- SStableComparisons(SSsummarize(list(modN)),
                             names=parnames, likenames=likenames)
pars.S$parameter <- NA
pars.S$parameter[grep("NatM",pars.S$Label)] <- "Natural mortality"
pars.S$parameter[grep("L_at_Amin",pars.S$Label)] <- "Length at age 0"
pars.S$parameter[grep("L_at_Amax",pars.S$Label)] <- "Length at age 20"
pars.S$parameter[grep("Von",pars.S$Label)] <- "von Bertalanffy k"
pars.S$parameter[grep("CV_young",pars.S$Label)] <- "CV of length at age 0"
pars.S$parameter[grep("CV_old",pars.S$Label)] <- "CV of length at age 20"
pars.S$parameter[grep("SR_LN",pars.S$Label)] <- "log equilibrium recruitment (1000s)"
pars.S$parameter[grep("Q_extraSD",pars.S$Label)] <- "extra survey standard deviation for fleet XXX"
pars.S$parameter[grep("Retain_2P_1",pars.S$Label)] <- "Length at 50% retention for commercial fishery"
pars.S$parameter[grep("Retain_2P_2",pars.S$Label)] <- "Slope for retention"
### these ones didn't work
pars.S$parameter[intersect(grep("SizeSel",pars.S$Label),
                           grep("P_1",pars.S$Label))] <- "Length at peak selectivity for fleet XXX"
pars.S$parameter[intersect(grep("SizeSel",pars.S$Label),
                           grep("P_2",pars.S$Label))] <- "Ascending selectivity slope parameter for fleet XXX"

pars.S$model1 <- round(pars.S$model1,2)
# reverse columns
pars.S[,c(3,2,1)]
##                                         parameter model1                                             Label
## 1                               Natural mortality   0.05                                 NatM_p_1_Fem_GP_1
## 2                                 Length at age 0   2.00                                L_at_Amin_Fem_GP_1
## 3                                Length at age 20  31.60                                L_at_Amax_Fem_GP_1
## 4                               von Bertalanffy k   0.16                                VonBert_K_Fem_GP_1
## 5                           CV of length at age 0   0.10                                 CV_young_Fem_GP_1
## 6                          CV of length at age 20   0.11                                   CV_old_Fem_GP_1
## 7             log equilibrium recruitment (1000s)   4.77                                         SR_LN(R0)
## 8   extra survey standard deviation for fleet XXX   0.10               Q_extraSD_3_3_CA_SouthOf4010_Rec_PC
## 9   extra survey standard deviation for fleet XXX   0.16     Q_extraSD_5_5_CA_SouthOf4010_Rec_PC_DWV_index
## 10  extra survey standard deviation for fleet XXX   0.23 Q_extraSD_6_6_CA_SouthOf4010_Rec_PC_onboard_index
## 11       Length at peak selectivity for fleet XXX  32.11           SizeSel_1P_1_1_CA_SouthOf4010_Comm_Dead
## 12       Length at peak selectivity for fleet XXX  32.00           SizeSel_2P_1_2_CA_SouthOf4010_Comm_Live
## 13       Length at peak selectivity for fleet XXX  31.02              SizeSel_3P_1_3_CA_SouthOf4010_Rec_PC
## 14       Length at peak selectivity for fleet XXX  33.72              SizeSel_4P_1_4_CA_SouthOf4010_Rec_PR
## 15       Length at peak selectivity for fleet XXX  32.11           SizeSel_1P_1_1_CA_SouthOf4010_Comm_Dead
## 16       Length at peak selectivity for fleet XXX  32.00           SizeSel_2P_1_2_CA_SouthOf4010_Comm_Live
## 17       Length at peak selectivity for fleet XXX  31.02              SizeSel_3P_1_3_CA_SouthOf4010_Rec_PC
## 18       Length at peak selectivity for fleet XXX  33.72              SizeSel_4P_1_4_CA_SouthOf4010_Rec_PR
## 19 Length at 50% retention for commercial fishery  30.65            Retain_2P_1_2_CA_SouthOf4010_Comm_Live
## 20                            Slope for retention   0.82            Retain_2P_2_2_CA_SouthOf4010_Comm_Live
