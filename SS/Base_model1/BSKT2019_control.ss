#C BSKT control file
0  # 0 means do not read wtatage.ss; 1 means read and use wtatage.ss and also read and use growth parameters
1  #_N_Growth_Patterns
1 #_N_platoons_Within_GrowthPattern 
#_Cond 1 #_Morph_between/within_stdev_ratio (no read if N_morphs=1)
#_Cond  1 #vector_Morphdist_(-1_in_first_val_gives_normal_approx)
#
4 # recr_dist_method for parameters:  1=like 3.24; 2=main effects for GP, Settle timing, Area; 3=each Settle entity; 4=none when N_GP*Nsettle*pop==1
1 # Recruitment: 1=global; 2=by area (future option)
1 #  number of recruitment settlement assignments 
0 # year_x_area_x_settlement_event interaction requested (only for recr_dist_method=1)
#GPat month  area age (for each settlement assignment)
 1 1 1 0
#
#_Cond 0 #_N_movement_definitions
#_Cond 1.0 # first age that moves (real age at begin of season, not integer) if do_migration>0
#_Cond 1 1 1 2 4 10 # example move definition for seas=1, GP=1, source=1 dest=2, age1=4, age2=10
#
2 #_Nblock_Patterns
1 10 #_blocks_per_pattern
1995 2004 #Triennial Q offset
# blocks for retention rate (not yet used)
2008 2008 2009 2009 2010 2010 2011 2011 2012 2012 2013 2013 2014 2014 2015 2015 2016 2016 2017 2018 
#
# controls for all timevary parameters 
1 #_env/block/dev_adjust_method for all time-vary parms (1=warn relative to base parm bounds; 3=no bound check)
1 1 1 1 1 # autogen
# where: 0 = autogen all time-varying parms; 1 = read each time-varying parm line; 2 = read then autogen if min=-12345
# 1st element for biology, 2nd for SR, 3rd for Q, 5th for selex, 4th reserved
#
# setup for M, growth, maturity, fecundity, recruitment distibution, movement 
#
0 		#_natM_type:_0=1Parm; 1=N_breakpoints;_2=Lorenzen;_3=agespecific;_4=agespec_withseasinterpolate
#1 		#_N_breakpoints
#3 		# age(real) at M breakpoints
1  # GrowthModel: 1=vonBert with L1&L2; 2=Richards with L1&L2; 3=age_specific_K; 4=not implemented
0  #_Growth_Age_for_L1
20 #_Growth_Age_for_L2 (999 to use as Linf)
0.36  #_exponential decay for growth above maxage (fixed at 0.2 in 3.24; value should approx initial Z; -999 replicates 3.24)
0  #_placeholder for future growth feature
0  #_SD_add_to_LAA (set to 0.1 for SS2 V1.x compatibility)
2  #_CV_Growth_Pattern:  0 CV=f(LAA); 1 CV=F(A); 2 SD=F(LAA); 3 SD=F(A); 4 logSD=F(A)
1  #_maturity_option:  1=length logistic; 2=age logistic; 3=read age-maturity matrix by growth_pattern; 4=read age-fecundity; 5=disabled; 6=read length-maturity
5  #_First_Mature_Age
1  #_fecundity option:(1)eggs=Wt*(a+b*Wt);(2)eggs=a*L^b;(3)eggs=a*Wt^b; (4)eggs=a+b*L; (5)eggs=a+b*W
0  #_hermaphroditism option:  0=none; 1=female-to-male age-specific fxn; -1=male-to-female age-specific fxn
2  #_parameter_offset_approach (1=none, 2= M, G, CV_G as offset from female-GP1, 3=like SS2 V1.x)
#
#_growth_parms
#_LO	HI	INIT	PRIOR	PR_SD	PR_type	PHASE	env_var&link	dev_link	dev_minyr	dev_maxyr	dev_PH	Block	Block_Fxn		
# Sex: 1  BioPattern: 1  NatMort
# lognormal Hamel prior has meanlog = ln(5.4/maxage) using maxage = 15 
0.01	0.8	0.2	-1.021651 0.0438  3	1	0	0	0	0	0.5	0	0	#	NatM_p_1_Fem_GP_1
# Sex: 1  BioPattern: 1  Growth
10	40	20 	20	99	-1	2	0	0	0	0	0.5	0	0	#	L_at_Amin_Fem_GP_1
150	300	200 	200	99	-1	2	0	0	0	0	0.5	0	0	#	L_at_Amax_Fem_GP_1
0.005	0.5	0.15	0.15	99	-1	1	0	0	0	0	0.5	0	0	#	VonBert_K_Fem_GP_1
1	20	5       0.1	99	-1	5	0	0	0	0	0.5	0	0	#	CV_young_Fem_GP_1
1	20	5       0.1	99 	-1	5	0	0	0	0	0.5	0	0	#	CV_old_Fem_GP_1
# Sex: 1  BioPattern: 1  WtLen
0	3     7.4924e-6 7.4924e-6 99	-1	-3	0	0	0	0	0.5	0	0	#	Wtlen_1_Fem_GP_1
2	4	2.9925	2.9925	99	-1	-3	0	0	0	0	0.5	0	0	#	Wtlen_2_Fem_GP_1
# Sex: 1  BioPattern: 1  Maturity&Fecundity
10	140	148.245	148.245	99	-1	-3	0	0	0	0	0.5	0	0	#	Mat50%_Fem_GP_1
-0.09	-0.05  -0.13155	-0.13155 99	-1	-3	0	0	0	0	0.5	0	0	#	Mat_slope_Fem_GP_1
-3	3	0.5	1	99	-1	-3	0	0	0	0	0.5	0	0	#	Eggs/kg_inter_Fem_GP_1
-3	3	0	0	99	-1	-3	0	0	0	0	0.5	0	0	#	Eggs/kg_slope_wt_Fem_GP_1
# Sex: 2  BioPattern: 1  NatMort
-3	3	0	0	99	0	-2	0	0	0	0	0	0	0	#	NatM_p_1_Mal_GP_1
# Sex: 2  BioPattern: 1  Growth
-1	1	0	0	99	0	-2	0	0	0	0	0	0	0	#	L_at_Amin_Mal_GP_1
-1	1	0	0	99	0	2	0	0	0	0	0	0	0	#	L_at_Amax_Mal_GP_1
-10	20	0	0	99	0	3	0	0	0	0	0	0	0	#	VonBert_K_Mal_GP_1
-1	1	0	0	99	0	-5	0	0	0	0	0	0	0	#	CV_young_Mal_GP_1
-1	1	0	0	99	0	-5	0	0	0	0	0	0	0	#	CV_old_Mal_GP_1
# Sex: 2  BioPattern: 1  WtLen
0	3     7.4924e-6 7.4924e-6 99	-1	-3	0	0	0	0	0.5	0	0	#	Wtlen_1_Mal_GP_1
2	4	2.9925	2.9925	99	-1	-3	0	0	0	0	0.5	0	0	#	Wtlen_2_Mal_GP_1
# Hermaphroditism
#  Recruitment Distribution  
#  Cohort growth dev base
0	2	1	1	99	0	-5	0	0	0	0	0	0	0	#	CohortGrowDev
#  Movement
#  Age Error from parameters
#  catch multiplier
#  fraction female, by GP
0.001	0.999	0.5	0.5	0.5	0	-99	0	0	0	0	0	0	0	#	FracFemale_GP_1

#_no timevary MG parameters
#
#_seasonal_effects_on_biology_parms
 0  0  0  0  0  0  0  0  0  0 #_femwtlen1,femwtlen2,mat1,mat2,fec1,fec2,Malewtlen1,malewtlen2,L1,K
#_ LO HI INIT PRIOR PR_SD PR_type PHASE
#_Cond -2 2 0 0 -1 99 -2 #_placeholder when no seasonal MG parameters
#
#_Spawner-Recruitment
3 #_Spawner-Recruitment; Options: 2=Ricker; 3=std_B-H; 4=SCAA; 5=Hockey; 6=B-H_flattop; 7=survival_3Parm; 8=Shepherd_3Parm; 9=RickerPower_3parm
0  # 0/1 to use steepness in initial equ recruitment calculation
0  #  future feature:  0/1 to make realized sigmaR a function of SR curvature
#_LO            HI          INIT         PRIOR         PR_SD       PR_type      PHASE    env-var    use_dev   dev_mnyr   dev_mxyr     dev_PH      Block    Blk_Fxn #  parm_name
   5            15       7.93855          11.1            10            -1          1          0          0          0          0          0          0          0 # SR_LN(R0)
 0.2             1           0.4           0.6           0.2            -1         -3          0          0          0          0          0          0          0 # SR_BH_steep
   0           0.4           0.3           0.3           0.8            -1         -2          0          0          0          0          0          0          0 # SR_sigmaR
  -2             2             0             0            99            -1         -1          0          0          0          0          0          0          0 # SR_regime
   0             0             0             0             0            -1        -99          0          0          0          0          0          0          0 # SR_autocorr
1 #do_recdev:  0=none; 1=devvector (R=F(SSB)+dev); 2=deviations (R=F(SSB)+dev); 3=deviations (R=R0*dev; dev2=R-f(SSB)); 4=like 3 with sum(dev2) adding penalty
1984 # first year of main recr_devs; early devs can preceed this era
2018 # last year of main recr_devs; forecast devs start in following year
-3 #_recdev phase 
1 # (0/1) to read 13 advanced options
 0 #_recdev_early_start (0=none; neg value makes relative to recdev_start)
 -4 #_recdev_early_phase
 -4 #_forecast_recruitment phase (incl. late recr) (0 value resets to maxphase+1)
 1 #_lambda for Fcast_recr_like occurring before endyr+1
 1956 #_last_yr_nobias_adj_in_MPD; begin of ramp
 1970 #_first_yr_fullbias_adj_in_MPD; begin of plateau
 2001 #_last_yr_fullbias_adj_in_MPD
 2002 #_end_yr_for_ramp_in_MPD (can be in forecast to shape ramp, but SS sets bias_adj to 0.0 for fcast yrs)
 1 #_max_bias_adj_in_MPD (-1 to override ramp and set biasadj=1.0 for all estimated recdevs)
 0 #_period of cycles in recruitment (N parms read below)
 -5 #min rec_dev
 5 #max rec_dev
 0 #_read_recdevs
#
#_placeholder for full parameter lines for recruitment cycles
# read specified recr devs
#_Yr Input_value
#
# all recruitment deviations
#  1916R 1917F 1918F 1919F 1920F 1921F 1922F 1923F 1924F 1925F 1926F 1927F 1928F 1929F 1930F 1931F 1932F 1933F 1934F 1935F 1936F 1937F 1938F 1939F 1940F 1941F 1942F 1943F 1944F 1945F 1946F 1947F 1948F 1949F 1950F 1951F 1952F 1953F 1954F 1955F 1956F 1957F 1958F 1959F 1960F 1961F 1962F 1963F 1964F 1965F 1966F 1967F 1968F 1969F 1970F 1971F 1972F 1973F 1974F 1975F 1976F 1977F 1978F 1979F 1980F 1981F 1982F 1983F 1984F 1985F 1986F 1987F 1988F 1989F 1990F 1991F 1992F 1993F 1994F 1995F 1996F 1997F 1998F 1999F 2000F 2001F 2002F 2003F 2004F 2005F 2006F 2007F 2008F 2009F 2010F 2011F 2012F 2013F 2014F 2015F 2016F 2017F 2018F 2019F 2020F 2021F 2022F
#  0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
# implementation error by year in forecast:  0 0 0 0 0 0 0 0 0 0 0 0
#
#Fishing Mortality info 
0.2 # F ballpark
-1999 # F ballpark year (neg value to disable)
3 # F_Method:  1=Pope; 2=instan. F; 3=hybrid (hybrid is recommended)
4 # max F or harvest rate, depends on F_Method
# no additional F input needed for Fmethod 1
# if Fmethod=2; read overall start F value; overall phase; N detailed inputs to read
# if Fmethod=3; read N iterations for tuning for Fmethod 3
4  # N iterations for tuning F in hybrid method (recommend 3 to 7)
#
#_initial_F_parms; count = 0
#_ LO HI INIT PRIOR PR_SD  PR_type  PHASE
##
#_Q_setup
#_   fleet      link link_info  extra_se   biasadj     float  #  fleetname
         5         1         0         1         0         0  #  WCGBTS
         6         1         0         1         0         0  #  Triennial
         7         1         0         1         0         0  #  IPHC
-9999 0 0 0 0 0
#
#_Q_parms(if_any);Qunits_are_ln(q)
#_          LO            HI          INIT         PRIOR         PR_SD       PR_type      PHASE    env-var    use_dev   dev_mnyr   dev_mxyr     dev_PH      Block    Blk_Fxn  #  parm_name
            -2             2             0             1          0.05             1          1          0          0          0          0          0          0          0  #  LnQ_base_WCGBTS(5)
             0             2           0.1          0.01            99             0          5          0          0          0          0          0          0          0  #  Q_extraSD_WCGBTS(5)
           -10             2             0             0            99             0          1          0          0          0          0          0          1          2  #  LnQ_base_Triennial(6)
             0             2           0.1          0.01            99             0          5          0          0          0          0          0          0          0  #  Q_extraSD_Triennial(6)
           -20             5           -12             0            99             0          1          0          0          0          0          0          0          0  #  LnQ_base_IPHC(7)
             0             2           0.1          0.01            99             0          5          0          0          0          0          0          0          0  #  Q_extraSD_IPHC(7)
# timevary Q parameters 
#_          LO            HI          INIT         PRIOR         PR_SD       PR_type     PHASE  #  parm_name
            -7             0             0             0            99             0      1  # LnQ_base_Triennial(6)_BLK1repl_1995

#_size_selex_types
#discard_options:_0=none;_1=define_retention;_2=retention&mortality;_3=all_discarded_dead
#_Pattern Discard Male Special
24 2 0 0 #  1_Fishery_current    
15 0 0 1 #  2_Fishery_historical    
15 0 0 1 #  3_Discard_historical    
15 0 0 1 #  4_Fishery_tribal    
24 0 0 0 #  5_NWFSC_shelf_slope   
24 0 0 0 #  6_Triennial        
24 0 0 5 #  7_IPHC

#_age_selex_types
#_Pattern Discard Male Special
 0 0 0 0 # 1_Fishery_current     
 0 0 0 0 # 2_Fishery_historical  
 0 0 0 0 # 3_Fishery_tribal  
 0 0 0 0 # 4_NWFSC_shelf_slope  
 0 0 0 0 # 5_NWFSC_slope      
 0 0 0 0 # 6_Triennial         
 0 0 0 0 # 7_AFSC_slope     

#_size_selex_settings
# 1   Fishery_current LenSelex
#_          LO            HI          INIT         PRIOR PR_SD PR_type    PHASE  #  parm_name
            80           150       80.0095            85    99       0          4          0          0          0          0          0          0          0  #  Size_DblN_peak_Fishery_current(1)
           -15             4           -15           -15    99       0         -5          0          0          0          0          0          0          0  #  Size_DblN_top_logit_Fishery_current(1)
            -1             9        7.0738           5.8    99       0          4          0          0          0          0          0          0          0  #  Size_DblN_ascend_se_Fishery_current(1)
            -1            20            20           6.7    99       0         -5          0          0          0          0          0          0          0  #  Size_DblN_descend_se_Fishery_current(1)
          -999             9          -999          -999    99       0         -4          0          0          0          0          0          0          0  #  Size_DblN_start_logit_Fishery_current(1)
          -999             9          -999          -999    99       0         -5          0          0          0          0          0          0          0  #  Size_DblN_end_logit_Fishery_current(1)
# 1   Fishery_current Retention
#_          LO            HI          INIT         PRIOR PR_SD PR_type    PHASE  #  parm_name
            15           150       66.7519            67    99       0          2          0          0          0          0          0          0          0  #  Retain_L_infl_Fishery_current(1)
           0.1            10       5.61124             8    99       0          2          0          0          0          0          0          0          0  #  Retain_L_width_Fishery_current(1)
           -10            10     0.0729519            10    99       0          3          0          0          0          0          0          2          2  #  Retain_L_asymptote_logit_Fishery_current(1)
             0             0             0             0    99       0         -3          0          0          0          0          0          0          0  #  Retain_L_maleoffset_Fishery_current(1)
# 1   Fishery_current Discard mortality                                            0
#_          LO            HI          INIT         PRIOR PR_SD PR_type    PHASE  #  parm_name
             5            15             5             5    99       0         -4          0          0          0          0          0          0          0  #  DiscMort_L_infl_Fishery_current(1)
         0.001            10             0             0    99       0         -4          0          0          0          0          0          0          0  #  DiscMort_L_width_Fishery_current(1)
             0             1           0.5           0.5    99       0         -5          0          0          0          0          0          0          0  #  DiscMort_L_level_old_Fishery_current(1)
             0             0             0             0    99       0         -5          0          0          0          0          0          0          0  #  DiscMort_L_male_offset_Fishery_current(1)
# 2   Discard_historical LenSelex
# 3   Fishery_historical LenSelex
# 4   Fishery_tribal LenSelex
# 5   WCGBTS LenSelex
#_          LO            HI          INIT         PRIOR PR_SD PR_type    PHASE  #  parm_name
            50           150       61.7687            85    99       0          4          0          0          0          0          0          0          0  #  Size_DblN_peak_WCGBTS(5)
           -15             4           -15           -15    99       0         -5          0          0          0          0          0          0          0  #  Size_DblN_top_logit_WCGBTS(5)
            -1             9       6.15752           5.8    99       0          4          0          0          0          0          0          0          0  #  Size_DblN_ascend_se_WCGBTS(5)
            -1            20       9.56599           6.7    99       0          5          0          0          0          0          0          0          0  #  Size_DblN_descend_se_WCGBTS(5)
          -999             9            -5          -999    99       0         -4          0          0          0          0          0          0          0  #  Size_DblN_start_logit_WCGBTS(5)
          -999             9          -999          -999    99       0         -5          0          0          0          0          0          0          0  #  Size_DblN_end_logit_WCGBTS(5)
# 6   Triennial LenSelex
#_          LO            HI          INIT         PRIOR PR_SD PR_type    PHASE  #  parm_name
            50           180       176.434            75    99       0          4          0          0          0          0          0          0          0  #  Size_DblN_peak_Triennial(6)
           -15             4           -15           -15    99       0         -5          0          0          0          0          0          0          0  #  Size_DblN_top_logit_Triennial(6)
            -1             9       8.93782             9    99       0          4          0          0          0          0          0          0          0  #  Size_DblN_ascend_se_Triennial(6)
            -1            20     -0.957179           7.2    99       0          5          0          0          0          0          0          0          0  #  Size_DblN_descend_se_Triennial(6)
          -999             9            -5          -999    99       0         -4          0          0          0          0          0          0          0  #  Size_DblN_start_logit_Triennial(6)
          -999             9          -999          -999    99       0         -5          0          0          0          0          0          0          0  #  Size_DblN_end_logit_Triennial(6)
# 7   IPHC LenSelex
#_          LO            HI          INIT         PRIOR PR_SD PR_type    PHASE  #  parm_name
            50           180       120.817            75    99       0          4          0          0          0          0          0          0          0  #  Size_DblN_peak_IPHC(7)
           -15             4           -15           -15    99       0         -5          0          0          0          0          0          0          0  #  Size_DblN_top_logit_IPHC(7)
            -1             9       6.93617             9    99       0          4          0          0          0          0          0          0          0  #  Size_DblN_ascend_se_IPHC(7)
            -1            20       16.1363           7.2    99       0          5          0          0          0          0          0          0          0  #  Size_DblN_descend_se_IPHC(7)
          -999             9            -5          -999    99       0         -4          0          0          0          0          0          0          0  #  Size_DblN_start_logit_IPHC(7)
          -999             9          -999          -999    99       0         -5          0          0          0          0          0          0          0  #  Size_DblN_end_logit_IPHC(7)
# 1   Fishery_current AgeSelex
# 2   Discard_historical AgeSelex
# 3   Fishery_historical AgeSelex
# 4   Fishery_tribal AgeSelex
# 5   WCGBTS AgeSelex
# 6   Triennial AgeSelex
# 7   IPHC AgeSelex
# timevary selex parameters 
#_          LO            HI          INIT         PRIOR PR_SD PR_type    PHASE  #  parm_name
           -10            10       1.37269           0.6    99       0      4  # Retain_L_asymptote_logit_Fishery_current(1)_BLK2repl_2008
           -10            10       1.58009           0.6    99       0      4  # Retain_L_asymptote_logit_Fishery_current(1)_BLK2repl_2009
           -10            10       7.91782           0.6    99       0      4  # Retain_L_asymptote_logit_Fishery_current(1)_BLK2repl_2010
           -10            10       9.77089           0.6    99       0      4  # Retain_L_asymptote_logit_Fishery_current(1)_BLK2repl_2011
           -10            10       9.27732           0.6    99       0      4  # Retain_L_asymptote_logit_Fishery_current(1)_BLK2repl_2012
           -10            10       3.83195           0.6    99       0      4  # Retain_L_asymptote_logit_Fishery_current(1)_BLK2repl_2013
           -10            10       4.29056           0.6    99       0      4  # Retain_L_asymptote_logit_Fishery_current(1)_BLK2repl_2014
           -10            10       3.67212           0.6    99       0      4  # Retain_L_asymptote_logit_Fishery_current(1)_BLK2repl_2015
           -10            10       2.84151           0.6    99       0      4  # Retain_L_asymptote_logit_Fishery_current(1)_BLK2repl_2016
           -10            10       3.20117           0.6    99       0      4  # Retain_L_asymptote_logit_Fishery_current(1)_BLK2repl_2017
# info on dev vectors created for selex parms are reported with other devs after tag parameter section 
#
0  #_ 0/1 to request experimental 2D_AR selectivity smoother options
# Tag loss and Tag reporting parameters go next
0  # TG_custom:  0=no read; 1=read if tags exist
#_Cond -6 6 1 1 2 0.01 -4 0 0 0 0 0 0 0  #_placeholder if no parameters
#
# deviation vectors for timevary parameters
#  base   base first block   block  env  env   dev   dev   dev   dev   dev
#  type  index  parm trend pattern link  var  vectr link _mnyr  mxyr phase  dev_vector
#      3     1     1     0     0     0     0     0     0     0     0     0
#      3     3     1     0     0     0     0     0     0     0     0     0
#      3     5     1     0     0     0     0     0     0     0     0     0
#      3     8     1     0     0     0     0     0     0     0     0     0
     #
# Input variance adjustments factors: 
 #_1=add_to_survey_CV
 #_2=add_to_discard_stddev
 #_3=add_to_bodywt_CV
 #_4=mult_by_lencomp_N
 #_5=mult_by_agecomp_N
 #_6=mult_by_size-at-age_N
 #_7=mult_by_generalized_sizecomp
 #Factor Fleet New_Var_adj hash Old_Var_adj New_Francis   New_MI Francis_mult Francis_lo Francis_hi  MI_mult Type            Name                              Note
       4     1    0.058465    #    0.033668    0.058465 0.049194     1.736503   1.032268   3.871811 1.461153  len Fishery_current                                  
       4     5    0.072162    #    0.093821    0.072162 0.564407     0.769151   0.532181   1.479075 6.015785  len          WCGBTS                                  
       4     6    1.163594    #    0.924847    1.163594 1.393440     1.258148   1.258148        Inf 1.506671  len       Triennial                                  
       4     7    0.558397    #    1.000000          NA 0.558397           NA         NA         NA 0.558397  len            IPHC No Francis weight--using MI value
       5     1    0.051710    #    0.075651    0.051710 0.417821     0.683529   0.420439   9.653104 5.523007  age Fishery_current                                  
       5     5    0.045605    #    0.094543    0.045605 0.444375     0.482371   0.249351 179.181253 4.700242  age          WCGBTS
#
   -9999     1    0  # terminator
#
1 #_maxlambdaphase
1 #_sd_offset
# read 0 changes to default Lambdas (default value is 1.0)
# Like_comp codes:  1=surv; 2=disc; 3=mnwt; 4=length; 5=age; 6=SizeFreq; 7=sizeage; 8=catch; 9=init_equ_catch; 
# 10=recrdev; 11=parm_prior; 12=parm_dev; 13=CrashPen; 14=Morphcomp; 15=Tag-comp; 16=Tag-negbin; 17=F_ballpark
#like_comp fleet  phase  value  sizefreq_method
-9999  1  1  1  1  #  terminator
#
# lambdas (for info only; columns are phases)
#  1 #_CPUE/survey:_1
#  0 #_CPUE/survey:_2
#  1 #_CPUE/survey:_3
#  0 #_CPUE/survey:_4
#  1 #_CPUE/survey:_5
#  0 #_CPUE/survey:_6
#  1 #_CPUE/survey:_7
#  1 #_CPUE/survey:_8
#  1 #_CPUE/survey:_9
#  1 #_CPUE/survey:_10
#  1 #_CPUE/survey:_11
#  1 #_CPUE/survey:_12
#  1 #_lencomp:_1
#  1 #_lencomp:_2
#  1 #_lencomp:_3
#  1 #_lencomp:_4
#  1 #_lencomp:_5
#  1 #_lencomp:_6
#  1 #_lencomp:_7
#  1 #_lencomp:_8
#  1 #_lencomp:_9
#  1 #_lencomp:_10
#  1 #_lencomp:_11
#  1 #_lencomp:_12
#  1 #_agecomp:_1
#  1 #_agecomp:_2
#  1 #_agecomp:_3
#  1 #_agecomp:_4
#  1 #_agecomp:_5
#  1 #_agecomp:_6
#  0 #_agecomp:_7
#  0 #_agecomp:_8
#  1 #_agecomp:_9
#  0 #_agecomp:_10
#  1 #_agecomp:_11
#  0 #_agecomp:_12
#  1 #_init_equ_catch
#  1 #_recruitments
#  1 #_parameter-priors
#  1 #_parameter-dev-vectors
#  1 #_crashPenLambda
#  1 # F_ballpark_lambda
0 # (0/1) read specs for more stddev reporting 
 # 0 1 -1 5 1 5 1 -1 5 # placeholder for selex type, len/age, year, N selex bins, Growth pattern, N growth ages, NatAge_area(-1 for all), NatAge_yr, N Natages
 # placeholder for vector of selex bins to be reported
 # placeholder for vector of growth ages to be reported
 # placeholder for vector of NatAges ages to be reported
999

