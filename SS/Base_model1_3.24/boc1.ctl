#V3.24U
#_data_and_control_files: boc1.dat // boc1.ctl
#_SS-V3.24U-fast;_08/29/2014;_Stock_Synthesis_by_Richard_Methot_(NOAA)_using_ADMB_11.2_Win64
1  #_N_Growth_Patterns
1 #_N_Morphs_Within_GrowthPattern 
#_Cond 1 #_Morph_between/within_stdev_ratio (no read if N_morphs=1)
#_Cond  1 #vector_Morphdist_(-1_in_first_val_gives_normal_approx)
#
#_Cond 0  #  N recruitment designs goes here if N_GP*nseas*area>1
#_Cond 0  #  placeholder for recruitment interaction request
#_Cond 1 1 1  # example recruitment design element for GP=1, seas=1, area=1
#
#_Cond 0 # N_movement_definitions goes here if N_areas > 1
#_Cond 1.0 # first age that moves (real age at begin of season, not integer) also cond on do_migration>0
#_Cond 1 1 1 2 4 10 # example move definition for seas=1, morph=1, source=1 dest=2, age1=4, age2=10
#
2 #_Nblock_Patterns
 1 1 #_blocks_per_pattern 
# begin and end years of blocks
 2003 2016
 1995 2016
#
0.5 #_fracfemale 
0 #_natM_type:_0=1Parm; 1=N_breakpoints;_2=Lorenzen;_3=agespecific;_4=agespec_withseasinterpolate
  #_no additional input for selected M option; read 1P per morph
1 # GrowthModel: 1=vonBert with L1&L2; 2=Richards with L1&L2; 3=age_speciific_K; 4=not implemented
0.5 #_Growth_Age_for_L1
25 #_Growth_Age_for_L2 (999 to use as Linf)
0 #_SD_add_to_LAA (set to 0.1 for SS2 V1.x compatibility)
0 #_CV_Growth_Pattern:  0 CV=f(LAA); 1 CV=F(A); 2 SD=F(LAA); 3 SD=F(A); 4 logSD=F(A)
1 #_maturity_option:  1=length logistic; 2=age logistic; 3=read age-maturity by GP; 4=read age-fecundity by GP; 5=read fec and wt from wtatage.ss; 6=read length-maturity by GP
#_placeholder for empirical age- or length- maturity by growth pattern (female only)
1 #_First_Mature_Age
1 #_fecundity option:(1)eggs=Wt*(a+b*Wt);(2)eggs=a*L^b;(3)eggs=a*Wt^b; (4)eggs=a+b*L; (5)eggs=a+b*W
0 #_hermaphroditism option:  0=none; 1=age-specific fxn
2 #_parameter_offset_approach (1=none, 2= M, G, CV_G as offset from female-GP1, 3=like SS2 V1.x)
2 #_env/block/dev_adjust_method (1=standard; 2=logistic transform keeps in base parm bounds; 3=standard w/ no bound check)
#
#_growth_parms
#_LO HI INIT PRIOR PR_type SD PHASE env-var use_dev dev_minyr dev_maxyr dev_stddev Block Block_Fxn
 0.05 0.4 0.180015 -1.74757 3 0.438438 2 0 0 0 0 0.5 0 0 # NatM_p_1_Fem_GP_1
 1 45 18.0562 17.7256 -1 99 2 0 0 0 0 0.5 0 0 # L_at_Amin_Fem_GP_1
 60 80 67.5106 67.8153 -1 99 2 0 0 0 0 0.5 0 0 # L_at_Amax_Fem_GP_1
 0.05 0.25 0.226187 0.219878 -1 99 2 0 0 0 0 0.5 0 0 # VonBert_K_Fem_GP_1
 0.05 0.25 0.117438 0.116225 -1 99 6 0 0 0 0 0.5 0 0 # CV_young_Fem_GP_1
 0.05 0.25 0.0773378 0.0741631 -1 99 6 0 0 0 0 0.5 0 0 # CV_old_Fem_GP_1
 -0.5 0.5 0 0 -1 99 -2 0 0 0 0 0.5 0 0 # NatM_p_1_Mal_GP_1
 -1 1 0 0 -1 99 -2 0 0 0 0 0.5 0 0 # L_at_Amin_Mal_GP_1
 -1 1 -0.0851966 -0.0767574 -1 99 2 0 0 0 0 0.5 0 0 # L_at_Amax_Mal_GP_1
 -1 1 0.0852954 0.0575865 -1 99 2 0 0 0 0 0.5 0 0 # VonBert_K_Mal_GP_1
 -1 1 -0.0704282 -0.067776 -1 99 6 0 0 0 0 0.5 0 0 # CV_young_Mal_GP_1
 -1 1 0.00345607 0.0729374 -1 99 6 0 0 0 0 0.5 0 0 # CV_old_Mal_GP_1
 -3 3 7.355e-006 7.36e-006 -1 99 -3 0 0 0 0 0.5 0 0 # Wtlen_1_Fem
 -3 4 3.11359 3.11359 -1 99 -3 0 0 0 0 0.5 0 0 # Wtlen_2_Fem
 30 60 37.7 37.7 -1 99 -3 0 0 0 0 0.5 0 0 # Mat50%_Fem
 -3 3 -0.33397 -0.33397 -1 99 -3 0 0 0 0 0.5 0 0 # Mat_slope_Fem
 -3 300 254.9 254.9 -1 99 -3 0 0 0 0 0.5 0 0 # Eggs/kg_inter_Fem
 -3 30 20 20 -1 99 -3 0 0 0 0 0.5 0 0 # Eggs/kg_slope_wt_Fem
 -3 3 7.355e-006 7.36e-006 -1 99 -3 0 0 0 0 0.5 0 0 # Wtlen_1_Mal
 -3 4 3.11359 3.11359 -1 99 -3 0 0 0 0 0.5 0 0 # Wtlen_2_Mal
 0 0 0 0 -1 0 -4 0 0 0 0 0 0 0 # RecrDist_GP_1
 0 0 0 0 -1 0 -4 0 0 0 0 0 0 0 # RecrDist_Area_1
 0 0 0 0 -1 0 -4 0 0 0 0 0 0 0 # RecrDist_Seas_1
 0 0 0 0 -1 0 -4 0 0 0 0 0 0 0 # CohortGrowDev
#
#_Cond 0  #custom_MG-env_setup (0/1)
#_Cond -2 2 0 0 -1 99 -2 #_placeholder when no MG-environ parameters
#
#_Cond 0  #custom_MG-block_setup (0/1)
#_Cond -2 2 0 0 -1 99 -2 #_placeholder when no MG-block parameters
#_Cond No MG parm trends 
#
#_seasonal_effects_on_biology_parms
 0 0 0 0 0 0 0 0 0 0 #_femwtlen1,femwtlen2,mat1,mat2,fec1,fec2,Malewtlen1,malewtlen2,L1,K
#_Cond -2 2 0 0 -1 99 -2 #_placeholder when no seasonal MG parameters
#
#_Cond -4 #_MGparm_Dev_Phase
#
#_Spawner-Recruitment
3 #_SR_function: 2=Ricker; 3=std_B-H; 4=SCAA; 5=Hockey; 6=B-H_flattop; 7=survival_3Parm; 8=Shepard_3Parm
#_LO HI INIT PRIOR PR_type SD PHASE
 6 15 8.8337 8.6 -1 99 1 # SR_LN(R0)
 0.21 0.99 0.718 0.718 2 0.158 -2 # SR_BH_steep
 0 2 1 1 -1 99 -4 # SR_sigmaR
 -5 5 0 0 -1 99 -3 # SR_envlink
 -5 5 0 0 -1 99 -4 # SR_R1_offset
 0 0.5 0 0 -1 99 -3 # SR_autocorr
0 #_SR_env_link
0 #_SR_env_target_0=none;1=devs;_2=R0;_3=steepness
1 #do_recdev:  0=none; 1=devvector; 2=simple deviations
1964 # first year of main recr_devs; early devs can preceed this era
2015 # last year of main recr_devs; forecast devs start in following year
2 #_recdev phase 
1 # (0/1) to read 13 advanced options
 1954 #_recdev_early_start (0=none; neg value makes relative to recdev_start)
 2 #_recdev_early_phase
 0 #_forecast_recruitment phase (incl. late recr) (0 value resets to maxphase+1)
 1 #_lambda for Fcast_recr_like occurring before endyr+1
 1970.9752 #_last_early_yr_nobias_adj_in_MPD                   
 1971.1051 #_first_yr_fullbias_adj_in_MPD                      
 2015.7167 #_last_yr_fullbias_adj_in_MPD                       
 2016.9832 #_first_recent_yr_nobias_adj_in_MPD                 
 0.9146 #_max_bias_adj_in_MPD (1.0 to mimic pre-2009 models)
 0 #_period of cycles in recruitment (N parms read below)
 -5 #min rec_dev
 5 #max rec_dev
 63 #_read_recdevs
#_end of advanced SR options
#
#_placeholder for full parameter lines for recruitment cycles
# Specified recr devs to read
#_Yr Input_value
1954	-0.0199364
1955	-0.133606
1956	-0.109327
1957	0.145401
1958	0.413057
1959	0.538787
1960	0.553238
1961	0.50011
1962	0.619387
1963	0.55992
1964	0.492926
1965	2.12408
1966	0.386175
1967	0.445304
1968	0.672189
1969	0.8753
1970	0.842054
1971	0.0249359
1972	1.09061
1973	1.52537
1974	1.27731
1975	0.522253
1976	-1.03396
1977	2.128
1978	1.72194
1979	0.208261
1980	-0.205771
1981	-0.918303
1982	-1.74453
1983	-1.34856
1984	1.3735
1985	0.010248
1986	-0.659544
1987	-0.406167
1988	1.03554
1989	-0.366833
1990	-0.421406
1991	-0.0634992
1992	-0.341444
1993	-0.68615
1994	-0.597033
1995	-1.00339
1996	-0.980401
1997	-0.643869
1998	-1.433
1999	1.25263
2000	-0.547498
2001	-0.829044
2002	-1.1427
2003	-0.0108053
2004	-0.984308
2005	-0.539538
2006	-1.02255
2007	-1.10333
2008	-1.29995
2009	-0.603977
2010	0.435053
2011	0.274555
2012	-0.202828
2013	1.49459
2014	0.779255
2015	0.148344
2016	-0.550293
#
#Fishing Mortality info 
0.2 # F ballpark for annual F (=Z-M) for specified year
-1999 # F ballpark year (neg value to disable)
3 # F_Method:  1=Pope; 2=instan. F; 3=hybrid (hybrid is recommended)
2.9 # max F or harvest rate, depends on F_Method
# no additional F input needed for Fmethod 1
# if Fmethod=2; read overall start F value; overall phase; N detailed inputs to read
# if Fmethod=3; read N iterations for tuning for Fmethod 3
5  # N iterations for tuning F in hybrid method (recommend 3 to 7)
#
#_initial_F_parms
#_LO HI INIT PRIOR PR_type SD PHASE
 0 0.1 0 0.01 -1 99 -2 # InitF_1TrawlSouth
 0.0001 0.05 0.0056048 0.007 -1 99 1 # InitF_2HL 
 0 0.1 0 0.01 -1 99 -2 # InitF_3Setnet
 0 0.1 0 0.01 -1 99 -2 # InitF_4RecSouth
 0 0.1 0 0.01 -1 99 -2 # InitF_5RecCentral
 0 0.1 0 0.01 -1 99 -2 # InitF_6TrawlNorth
#
#_Q_setup
 # Q_type options:  <0=mirror, 0=float_nobiasadj, 1=float_biasadj, 2=parm_nobiasadj, 3=parm_w_random_dev, 4=parm_w_randwalk, 5=mean_unbiased_float_assign_to_parm
#_for_env-var:_enter_index_of_the_env-var_to_be_linked
#_Den-dep  env-var  extra_se  Q_type
 0 0 1 0 # 1 TrawlSouth
 0 0 0 0 # 2 HL
 0 0 0 0 # 3 Setnet
 0 0 1 0 # 4 RecSouth
 0 0 1 0 # 5 RecCentral
 0 0 0 0 # 6 TrawlNorth
 0 0 1 0 # 7 CalCOFI
 0 0 0 0 # 8 Triennial
 0 0 1 0 # 9 CDFWEarlyOB
 0 0 1 0 # 10 NWFSCHook
 0 0 1 0 # 11 NWFSCTrawl
 0 0 1 0 # 12 Juvenile
 0 0 0 0 # 13 Rec2013	# set to  0 0 0 2 # 13 Rec2013
 0 0 1 0 # 14 PPIndex
 0 0 0 0 # 15 Free1
 0 0 0 0 # 16 MirrorRecS
 0 0 1 0 # 17 RecSouthOB
 0 0 1 0 # 18 RecCentralOB
#
#_Cond 0 #_If q has random component, then 0=read one parm for each fleet with random q; 1=read a parm for each year of index
#_Q_parms(if_any);Qunits_are_ln(q)
# LO HI INIT PRIOR PR_type SD PHASE
 0.0001 1 0.0485799 0.04 -1 99 4 # Q_extraSD_1_TrawlSouth
 0.0001 1 0.328252 0.49 -1 99 4 # Q_extraSD_4_RecSouth
 0.0001 1 0.39469 0.66 -1 99 5 # Q_extraSD_5_RecCentral
 0.0001 1 0.159989 0.16 -1 99 4 # Q_extraSD_7_CalCOFI
 0.0001 1 0.262571 0.25 -1 99 4 # Q_extraSD_9_CDFWEarlyOB
 0.0001 1 0.307909 0.22 -1 99 4 # Q_extraSD_10_NWFSCHook
 0.0001 1 0.366492 0.02 -1 99 4 # Q_extraSD_11_NWFSCTrawl
 0.0001 1 0.585769 0.39 -1 99 4 # Q_extraSD_12_Juvenile
 0.0001 1 0.401265 0.38 -1 99 4 # Q_extraSD_14_PPIndex
 0.0001 1 0.549571 0.44 -1 99 4 # Q_extraSD_17_RecSouthOB
 0.0001 1 0.293796 0.23 -1 99 4 # Q_extraSD_18_RecCentralOB
# activate next line for state of nature runs
# -1 1 0 0.01 -1 99 -4 # Q_pier (fix 2013)

#
#_size_selex_types
#discard_options:_0=none;_1=define_retention;_2=retention&mortality;_3=all_discarded_dead
#_Pattern Discard Male Special
 24 0 0 0 # 1 TrawlSouth
 24 0 0 0 # 2 HL
 24 0 0 0 # 3 Setnet
 24 0 0 0 # 4 RecSouth
 24 0 0 0 # 5 RecCentral
 24 0 0 0 # 6 TrawlNorth
 30 0 0 0 # 7 CalCOFI
 24 0 0 0 # 8 Triennial
 5 0 0 5 # 9 CDFWEarlyOB
 24 0 0 0 # 10 NWFSCHook
 24 0 0 0 # 11 NWFSCTrawl
 33 0 0 0 # 12 Juvenile
 0 0 0 0 # 13 PierJuv
 0 0 0 0 # 14 PPIndex
 5 0 0 1 # 15 Free1
 5 0 0 4 # 16 MirrorRecS
 5 0 0 4 # 17 RecSouthOB
 5 0 0 5 # 18 RecCentralOB
#
#_age_selex_types
#_Pattern ___ Male Special
 11 0 0 0 # 1 TrawlSouth
 11 0 0 0 # 2 HL
 11 0 0 0 # 3 Setnet
 11 0 0 0 # 4 RecSouth
 11 0 0 0 # 5 RecCentral
 11 0 0 0 # 6 TrawlNorth
 11 0 0 0 # 7 CalCOFI
 11 0 0 0 # 8 Triennial
 11 0 0 0 # 9 CDFWEarlyOB
 11 0 0 0 # 10 NWFSCHook
 11 0 0 0 # 11 NWFSCTrawl
 11 0 0 0 # 12 Juvenile
 11 0 0 0 # 13 PierJuv
 11 0 0 0 # 14 PPIndex
 11 0 0 0 # 15 Free1
 11 0 0 0 # 16 MirrorRecS
 11 0 0 0 # 17 RecSouthOB
 11 0 0 0 # 18 RecCentralOB
#_LO HI INIT PRIOR PR_type SD PHASE env-var use_dev dev_minyr dev_maxyr dev_stddev Block Block_Fxn
 16 64 43.5216 43.7321 -1 10 3 0 0 0 0 0.5 1 2 # SizeSel_1P_1_TrawlSouth
 -20 1 -11.9444 -11.8577 -1 10 4 0 0 0 0 0.5 0 0 # SizeSel_1P_2_TrawlSouth
 1 10 4.41788 4.42101 -1 10 4 0 0 0 0 0.5 1 2 # SizeSel_1P_3_TrawlSouth
 -1 9 4.48147 4.59596 -1 10 4 0 0 0 0 0.5 1 2 # SizeSel_1P_4_TrawlSouth
 -30 0 -16.32 -16.2796 -1 10 4 0 0 0 0 0.5 0 0 # SizeSel_1P_5_TrawlSouth
 -5 5 -1.49873 -1.51897 -1 10 4 0 0 0 0 0.5 1 2 # SizeSel_1P_6_TrawlSouth
 16 60 49.9798 50.2935 -1 10 3 0 0 0 0 0.5 0 0 # SizeSel_2P_1_HL
 -20 0 -11.2421 -11.1769 -1 10 3 0 0 0 0 0.5 0 0 # SizeSel_2P_2_HL
 1 12 4.9191 4.85455 -1 10 3 0 0 0 0 0.5 0 0 # SizeSel_2P_3_HL
 -1 9 4.05868 4.09085 -1 10 3 0 0 0 0 0.5 0 0 # SizeSel_2P_4_HL
 -15 0 -11.7498 -7.65174 -1 10 3 0 0 0 0 0.5 0 0 # SizeSel_2P_5_HL
 -5 5 -0.732217 -0.891802 -1 10 3 0 0 0 0 0.5 0 0 # SizeSel_2P_6_HL
 16 60 47.5724 47.7691 -1 10 3 0 0 0 0 0.5 0 0 # SizeSel_3P_1_Setnet
 -20 0 -12.1807 -12.0492 -1 10 3 0 0 0 0 0.5 0 0 # SizeSel_3P_2_Setnet
 1 10 3.60495 3.62227 -1 10 3 0 0 0 0 0.5 0 0 # SizeSel_3P_3_Setnet
 -1 9 3.90286 4.00071 -1 10 3 0 0 0 0 0.5 0 0 # SizeSel_3P_4_Setnet
 -10 3 -6.36802 -6.40904 -1 10 3 0 0 0 0 0.5 0 0 # SizeSel_3P_5_Setnet
 -5 5 -1.86879 -1.92151 -1 10 3 0 0 0 0 0.5 0 0 # SizeSel_3P_6_Setnet
 16 60 37.6043 37.8456 -1 10 3 0 0 0 0 0.5 1 2 # SizeSel_4P_1_RecSouth
 -20 0 -3.71068 -4.03328 -1 10 3 0 0 0 0 0.5 0 0 # SizeSel_4P_2_RecSouth
 1 10 4.60431 4.63756 -1 10 3 0 0 0 0 0.5 1 2 # SizeSel_4P_3_RecSouth
 -1 9 5.47951 5.56413 -1 10 3 0 0 0 0 0.5 1 2 # SizeSel_4P_4_RecSouth
 -10 2 -6.92706 -6.9658 -1 10 3 0 0 0 0 0.5 0 0 # SizeSel_4P_5_RecSouth
 -10 9 -3.55526 -3.8711 -1 10 3 0 0 0 0 0.5 1 2 # SizeSel_4P_6_RecSouth
 16 60 46.7185 47.65 -1 10 3 0 0 0 0 0.5 1 2 # SizeSel_5P_1_RecCentral
 -20 0 -11.184 -11.3327 -1 10 3 0 0 0 0 0.5 0 0 # SizeSel_5P_2_RecCentral
 1 10 5.49866 5.55578 -1 10 3 0 0 0 0 0.5 1 2 # SizeSel_5P_3_RecCentral
 -1 9 3.91104 3.88992 -1 10 3 0 0 0 0 0.5 1 2 # SizeSel_5P_4_RecCentral
 -10 2 -5.39875 -5.46783 -1 10 3 0 0 0 0 0.5 0 0 # SizeSel_5P_5_RecCentral
 -10 9 0.149474 0.0533028 -1 10 3 0 0 0 0 0.5 1 2 # SizeSel_5P_6_RecCentral
 16 60 45.3221 45.9359 -1 10 3 0 0 0 0 0.5 1 2 # SizeSel_6P_1_TrawlNorth
 -5 5 -0.989052 -0.853133 -1 10 4 0 0 0 0 0.5 0 0 # SizeSel_6P_2_TrawlNorth
 1 15 3.75127 3.8369 -1 10 4 0 0 0 0 0.5 1 2 # SizeSel_6P_3_TrawlNorth
 -5 5 3.12598 2.9507 -1 10 4 0 0 0 0 0.5 1 2 # SizeSel_6P_4_TrawlNorth
 -15 0 -9.01175 -9.40927 -1 10 4 0 0 0 0 0.5 0 0 # SizeSel_6P_5_TrawlNorth
 -10 10 0.173239 0.0689498 -1 10 4 0 0 0 0 0.5 1 2 # SizeSel_6P_6_TrawlNorth
 16 60 27.7141 28.0443 -1 10 2 0 0 0 0 0.5 2 2 # SizeSel_8P_1_Triennial
 -20 0 -12.204 -12.004 -1 10 2 0 0 0 0 0.5 0 0 # SizeSel_8P_2_Triennial
 1 10 1.85739 1.92642 -1 10 2 0 0 0 0 0.5 2 2 # SizeSel_8P_3_Triennial
 -20 3 -8.5 -4.99989 -1 10 2 0 0 0 0 0.5 2 2 # SizeSel_8P_4_Triennial
 -999 1 -999 -999 -1 10 -4 0 0 0 0 0.5 0 0 # SizeSel_8P_5_Triennial
 -5 5 -0.9154 -0.913258 -1 10 2 0 0 0 0 0.5 2 2 # SizeSel_8P_6_Triennial
 -1 10 -1 -1 -1 99 -3 0 0 0 0 0.5 0 0 # SizeSel_9P_1_CDFWEarlyOB
 -1 10 -1 -1 -1 99 -3 0 0 0 0 0.5 0 0 # SizeSel_9P_2_CDFWEarlyOB
 16 60 49.386 43.8236 -1 10 3 0 0 0 0 0.5 0 0 # SizeSel_10P_1_NWFSCHook
 -5 5 -4.36387 -1.42363 -1 10 3 0 0 0 0 0.5 0 0 # SizeSel_10P_2_NWFSCHook
 -1 10 5.19475 4.66827 -1 10 3 0 0 0 0 0.5 0 0 # SizeSel_10P_3_NWFSCHook
 -1 9 4.34772 4.31619 -1 10 3 0 0 0 0 0.5 0 0 # SizeSel_10P_4_NWFSCHook
 -15 -5 -12.0665 -12.0962 -1 10 3 0 0 0 0 0.5 0 0 # SizeSel_10P_5_NWFSCHook
 -5 5 -2.02432 -2.34605 -1 10 3 0 0 0 0 0.5 0 0 # SizeSel_10P_6_NWFSCHook
 13 60 23.1669 23.1912 -1 10 3 0 0 0 0 0.5 0 0 # SizeSel_11P_1_NWFSCTrawl
 -20 0 -10.873 -11.5426 -1 10 3 0 0 0 0 0.5 0 0 # SizeSel_11P_2_NWFSCTrawl
 -5 15 -4.22836 -4.71677 -1 10 3 0 0 0 0 0.5 0 0 # SizeSel_11P_3_NWFSCTrawl
 -1 9 6.34128 6.55647 -1 10 3 0 0 0 0 0.5 0 0 # SizeSel_11P_4_NWFSCTrawl
 -15 5 -0.247111 0.377822 -1 10 3 0 0 0 0 0.5 0 0 # SizeSel_11P_5_NWFSCTrawl
 -5 5 -2.9855 -2.93515 -1 10 3 0 0 0 0 0.5 0 0 # SizeSel_11P_6_NWFSCTrawl
 -1 20 -1 -1 -1 99 -3 0 0 0 0 0.5 0 0 # SizeSel_15P_1_Free1
 -1 20 -1 -1 -1 99 -3 0 0 0 0 0.5 0 0 # SizeSel_15P_2_Free1
 -1 20 -1 -1 -1 99 -3 0 0 0 0 0.5 0 0 # SizeSel_16P_1_MirrorRecS
 -1 20 -1 -1 -1 99 -3 0 0 0 0 0.5 0 0 # SizeSel_16P_2_MirrorRecS
 -1 20 -1 -1 -1 99 -3 0 0 0 0 0.5 0 0 # SizeSel_17P_1_RecSouthOB
 -1 20 -1 -1 -1 99 -3 0 0 0 0 0.5 0 0 # SizeSel_17P_2_RecSouthOB
 -1 20 -1 -1 -1 99 -3 0 0 0 0 0.5 0 0 # SizeSel_18P_1_RecCentralOB
 -1 20 -1 -1 -1 99 -3 0 0 0 0 0.5 0 0 # SizeSel_18P_2_RecCentralOB
 0 41 0.1 0.1 -1 99 -2 0 0 0 0 0.5 0 0 # AgeSel_1P_1_TrawlSouth
 0 41 34 34 -1 99 -2 0 0 0 0 0.5 0 0 # AgeSel_1P_2_TrawlSouth
 0 41 0.1 0.1 -1 99 -2 0 0 0 0 0.5 0 0 # AgeSel_2P_1_HL
 0 41 34 34 -1 99 -2 0 0 0 0 0.5 0 0 # AgeSel_2P_2_HL
 0 41 0.1 0.1 -1 99 -2 0 0 0 0 0.5 0 0 # AgeSel_3P_1_Setnet
 0 41 34 34 -1 99 -2 0 0 0 0 0.5 0 0 # AgeSel_3P_2_Setnet
 0 41 0.1 0.1 -1 99 -2 0 0 0 0 0.5 0 0 # AgeSel_4P_1_RecSouth
 0 41 34 34 -1 99 -2 0 0 0 0 0.5 0 0 # AgeSel_4P_2_RecSouth
 0 41 0.1 0.1 -1 99 -2 0 0 0 0 0.5 0 0 # AgeSel_5P_1_RecCentral
 0 41 34 34 -1 99 -2 0 0 0 0 0.5 0 0 # AgeSel_5P_2_RecCentral
 0 41 0.1 0.1 -1 99 -2 0 0 0 0 0.5 0 0 # AgeSel_6P_1_TrawlNorth
 0 41 34 34 -1 99 -2 0 0 0 0 0.5 0 0 # AgeSel_6P_2_TrawlNorth
 0 41 0.1 0.1 -1 99 -2 0 0 0 0 0.5 0 0 # AgeSel_7P_1_CalCOFI
 0 41 34 34 -1 99 -2 0 0 0 0 0.5 0 0 # AgeSel_7P_2_CalCOFI
 0 41 0.1 0.1 -1 99 -2 0 0 0 0 0.5 0 0 # AgeSel_8P_1_Triennial
 0 41 34 34 -1 99 -2 0 0 0 0 0.5 0 0 # AgeSel_8P_2_Triennial
 0 41 0.1 0.1 -1 99 -2 0 0 0 0 0.5 0 0 # AgeSel_9P_1_CDFWEarlyOB
 0 41 34 34 -1 99 -2 0 0 0 0 0.5 0 0 # AgeSel_9P_2_CDFWEarlyOB
 0 41 0.1 0.1 -1 99 -2 0 0 0 0 0.5 0 0 # AgeSel_10P_1_NWFSCHook
 0 41 34 34 -1 99 -2 0 0 0 0 0.5 0 0 # AgeSel_10P_2_NWFSCHook
 0 41 0.1 0.1 -1 99 -2 0 0 0 0 0.5 0 0 # AgeSel_11P_1_NWFSCTrawl
 0 41 34 34 0 99 -1 0 0 0 0 0.5 0 0 # AgeSel_11P_2_NWFSCTrawl
 0 41 0 0 -1 99 -1 0 0 0 0 0.5 0 0 # AgeSel_12P_1_Juvenile
 0 41 0 0 -1 99 -1 0 0 0 0 0.5 0 0 # AgeSel_12P_2_Juvenile
 0 41 0 0 -1 99 -1 0 0 0 0 0.5 0 0 # AgeSel_13P_1_Rec2013
 0 41 0 0 -1 99 -1 0 0 0 0 0.5 0 0 # AgeSel_13P_2_Rec2013
 0 41 0 0 -1 99 -1 0 0 0 0 0.5 0 0 # AgeSel_14P_1_PPIndex
 0 41 0 0 -1 99 -1 0 0 0 0 0.5 0 0 # AgeSel_14P_2_PPIndex
 0 41 0 0 -1 99 -1 0 0 0 0 0.5 0 0 # AgeSel_15P_1_Free1
 0 41 40 40 -1 99 -1 0 0 0 0 0.5 0 0 # AgeSel_15P_2_Free1
 0 41 0 0 -1 99 -1 0 0 0 0 0.5 0 0 # AgeSel_16P_1_MirrorRecS
 0 41 40 40 -1 99 -1 0 0 0 0 0.5 0 0 # AgeSel_16P_2_MirrorRecS
 0 41 0.1 0.1 -1 99 -2 0 0 0 0 0.5 0 0 # AgeSel_17P_1_RecSouthOB
 0 41 34 34 -1 99 -2 0 0 0 0 0.5 0 0 # AgeSel_17P_2_RecSouthOB
 0 41 0.1 0.1 -1 99 -2 0 0 0 0 0.5 0 0 # AgeSel_18P_1_RecCentralOB
 0 41 34 34 -1 99 -2 0 0 0 0 0.5 0 0 # AgeSel_18P_2_RecCentralOB
#_Cond 0 #_custom_sel-env_setup (0/1) 
#_Cond -2 2 0 0 -1 99 -2 #_placeholder when no enviro fxns
1 #_custom_sel-blk_setup (0/1) 
 16 70 62.9659 57.2955 -1 10 2 # SizeSel_1P_1_TrawlSouth_BLK1repl_2003
 1 10 6.34249 5.78733 -1 10 4 # SizeSel_1P_3_TrawlSouth_BLK1repl_2003
 -1 9 3.19425 4.07747 -1 10 4 # SizeSel_1P_4_TrawlSouth_BLK1repl_2003
 -5 5 0.153495 0.0218787 -1 10 4 # SizeSel_1P_6_TrawlSouth_BLK1repl_2003
 16 60 36.7936 37.5583 -1 10 2 # SizeSel_4P_1_RecSouth_BLK1repl_2003
 1 15 4.1888 4.22662 -1 10 4 # SizeSel_4P_3_RecSouth_BLK1repl_2003
 -5 5 4.83513 4.80844 -1 10 4 # SizeSel_4P_4_RecSouth_BLK1repl_2003
 -10 10 -3.94352 -4.06332 -1 10 4 # SizeSel_4P_6_RecSouth_BLK1repl_2003
 16 60 44.5585 43.4264 -1 10 2 # SizeSel_5P_1_RecCentral_BLK1repl_2003
 1 10 4.80412 4.60145 -1 10 4 # SizeSel_5P_3_RecCentral_BLK1repl_2003
 -1 9 4.43746 4.86781 -1 10 4 # SizeSel_5P_4_RecCentral_BLK1repl_2003
 -5 5 -0.985288 -1.24814 -1 10 4 # SizeSel_5P_6_RecCentral_BLK1repl_2003
 16 60 46.7563 44.323 -1 10 2 # SizeSel_6P_1_TrawlNorth_BLK1repl_2003
 1 15 5.32255 4.66351 -1 10 4 # SizeSel_6P_3_TrawlNorth_BLK1repl_2003
 -5 5 -0.21722 -0.0248232 -1 10 4 # SizeSel_6P_4_TrawlNorth_BLK1repl_2003
 -10 10 8.7104 8.38712 -1 10 4 # SizeSel_6P_6_TrawlNorth_BLK1repl_2003
 16 60 22.9195 22.9248 -1 10 2 # SizeSel_8P_1_Triennial_BLK2repl_1995
 1 15 1.25748 1.34611 -1 10 4 # SizeSel_8P_3_Triennial_BLK2repl_1995
 -15 5 -7.27507 -7.36054 -1 10 4 # SizeSel_8P_4_Triennial_BLK2repl_1995
 -10 10 -1.94439 -1.94337 -1 10 4 # SizeSel_8P_6_Triennial_BLK2repl_1995
#_Cond No selex parm trends 
#_Cond -4 # placeholder for selparm_Dev_Phase
1 #_env/block/dev_adjust_method (1=standard; 2=logistic trans to keep in base parm bounds; 3=standard w/ no bound check)
#
# Tag loss and Tag reporting parameters go next
0  # TG_custom:  0=no read; 1=read if tags exist
#_Cond -6 6 1 1 2 0.01 -4 0 0 0 0 0 0 0  #_placeholder if no parameters
#
1 #_Variance_adjustments_to_input_values
0.0000 0.0000 0.0000 0.0000 0.0000 0.0000 0.0000 0.0000 0.0000 0.0000 0.0000 0.0000 0.0000 0.0000 0.0000 0.0000 0.0000 0.0000
0.0000 0.0000 0.0000 0.0000 0.0000 0.0000 0.0000 0.0000 0.0000 0.0000 0.0000 0.0000 0.0000 0.0000 0.0000 0.0000 0.0000 0.0000
0.0000 0.0000 0.0000 0.0000 0.0000 0.0000 0.0000 0.0000 0.0000 0.0000 0.0000 0.0000 0.0000 0.0000 0.0000 0.0000 0.0000 0.0000
0.0881 0.1289 0.0399 0.1068 0.1114 0.1237 1.0000 0.1392 0.0700 0.0512 0.1038 1.0000 1.0000 1.0000 0.2783 0.1479 1.0000 1.0000
0.2241 0.3340 0.6780 1.0000 1.0000 0.2471 1.0000 1.0000 1.0000 1.0000 0.2203 1.0000 1.0000 1.0000 1.0000 1.0000 1.0000 1.0000
1.0000 1.0000 1.0000 1.0000 1.0000 1.0000 1.0000 1.0000 1.0000 1.0000 1.0000 1.0000 1.0000 1.0000 1.0000 1.0000 1.0000 1.0000
#
4 #_maxlambdaphase
1 #_sd_offset
#
54 # number of changes to make to default Lambdas (default value is 1.0)
# Like_comp codes:  1=surv; 2=disc; 3=mnwt; 4=length; 5=age; 6=SizeFreq; 7=sizeage; 8=catch; 9=init_equ_catch; 
# 10=recrdev; 11=parm_prior; 12=parm_dev; 13=CrashPen; 14=Morphcomp; 15=Tag-comp; 16=Tag-negbin; 17=F_ballpark
#like_comp fleet/survey  phase  value  sizefreq_method
 1 1 1 1 1
 1 2 1 1 1
 1 3 1 1 1
 1 4 1 1 1
 1 5 1 1 1
 1 6 1 1 1
 1 7 1 1 1
 1 8 1 1 1
 1 9 1 1 1
 1 10 1 1 1
 1 11 1 1 1
 1 12 1 1 1
 1 13 1 0 1		# set to 1 13 1 1 1	# for low and hight state of nature runs
 1 14 1 1 1
 1 15 1 1 1
 1 16 1 1 1
 1 17 1 1 1
 1 18 1 1 1
 4 1 1 1 1
 4 2 1 1 1
 4 3 1 1 1
 4 4 1 1 1
 4 5 1 1 1
 4 6 1 1 1
 4 7 1 1 1
 4 8 1 1 1
 4 9 1 1 1
 4 10 1 1 1
 4 11 1 1 1
 4 12 1 1 1
 4 13 1 1 1
 4 14 1 1 1
 4 15 1 0 1
 4 16 1 1 1
 4 17 1 0 1
 4 18 1 0 1
 5 1 1 1 1
 5 2 1 1 1
 5 3 1 1 1
 5 4 1 1 1
 5 5 1 1 1
 5 6 1 1 1
 5 7 1 1 1
 5 8 1 1 1
 5 9 1 1 1
 5 10 1 1 1
 5 11 1 1 1
 5 12 1 1 1
 5 13 1 1 1
 5 14 1 1 1
 5 15 1 0 1
 5 16 1 1 1
 5 17 1 0 1
 5 18 1 0 1
#
# lambdas (for info only; columns are phases)
#  1 1 1 1 #_CPUE/survey:_1
#  0 0 0 0 #_CPUE/survey:_2
#  0 0 0 0 #_CPUE/survey:_3
#  1 1 1 1 #_CPUE/survey:_4
#  1 1 1 1 #_CPUE/survey:_5
#  0 0 0 0 #_CPUE/survey:_6
#  1 1 1 1 #_CPUE/survey:_7
#  1 1 1 1 #_CPUE/survey:_8
#  1 1 1 1 #_CPUE/survey:_9
#  1 1 1 1 #_CPUE/survey:_10
#  1 1 1 1 #_CPUE/survey:_11
#  1 1 1 1 #_CPUE/survey:_12
#  0 0 0 0 #_CPUE/survey:_13
#  1 1 1 1 #_CPUE/survey:_14
#  0 0 0 0 #_CPUE/survey:_15
#  0 0 0 0 #_CPUE/survey:_16
#  1 1 1 1 #_CPUE/survey:_17
#  1 1 1 1 #_CPUE/survey:_18
#  1 1 1 1 #_lencomp:_1
#  1 1 1 1 #_lencomp:_2
#  1 1 1 1 #_lencomp:_3
#  1 1 1 1 #_lencomp:_4
#  1 1 1 1 #_lencomp:_5
#  1 1 1 1 #_lencomp:_6
#  0 0 0 0 #_lencomp:_7
#  1 1 1 1 #_lencomp:_8
#  1 1 1 1 #_lencomp:_9
#  1 1 1 1 #_lencomp:_10
#  1 1 1 1 #_lencomp:_11
#  0 0 0 0 #_lencomp:_12
#  0 0 0 0 #_lencomp:_13
#  0 0 0 0 #_lencomp:_14
#  0 0 0 0 #_lencomp:_15
#  1 1 1 1 #_lencomp:_16
#  0 0 0 0 #_lencomp:_17
#  0 0 0 0 #_lencomp:_18
#  1 1 1 1 #_agecomp:_1
#  1 1 1 1 #_agecomp:_2
#  1 1 1 1 #_agecomp:_3
#  0 0 0 0 #_agecomp:_4
#  0 0 0 0 #_agecomp:_5
#  1 1 1 1 #_agecomp:_6
#  0 0 0 0 #_agecomp:_7
#  0 0 0 0 #_agecomp:_8
#  0 0 0 0 #_agecomp:_9
#  0 0 0 0 #_agecomp:_10
#  1 1 1 1 #_agecomp:_11
#  0 0 0 0 #_agecomp:_12
#  0 0 0 0 #_agecomp:_13
#  0 0 0 0 #_agecomp:_14
#  0 0 0 0 #_agecomp:_15
#  0 0 0 0 #_agecomp:_16
#  0 0 0 0 #_agecomp:_17
#  0 0 0 0 #_agecomp:_18
#  1 1 1 1 #_init_equ_catch
#  1 1 1 1 #_recruitments
#  1 1 1 1 #_parameter-priors
#  1 1 1 1 #_parameter-dev-vectors
#  1 1 1 1 #_crashPenLambda
#  0 0 0 0 # F_ballpark_lambda
0 # (0/1) read specs for more stddev reporting 
 # 0 1 -1 5 1 5 1 -1 5 # placeholder for selex type, len/age, year, N selex bins, Growth pattern, N growth ages, NatAge_area(-1 for all), NatAge_yr, N Natages
 # placeholder for vector of selex bins to be reported
 # placeholder for vector of growth ages to be reported
 # placeholder for vector of NatAges ages to be reported
999

