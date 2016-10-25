# =============================================================================
# R script for Executive summary figures and tables                      
# The script for the tables is in the order they appear in the document!
#                                                                       
# BELOW IS THE ORDER OF THE TABLES & FIGURES IN THIS SCRIPT              
# If you're looking for a particular figure/table to edit you can search by the number
#
# 1. Recent history of catches figure and tables (need to edit Exec_catch_for_figs.csv)
#      OR, you can comment this plot out, and just use the r4ss generated plot included
#      in the in the main R markdown document 
# 2. Spawning stock output and depletion
# 3. Recruitment
# 4. SPR and exploitation
# 5. Reference points
# 6. Management performance (need to edit Exec_mngmt_performance.csv and maybe table)
# 7. OFL projections
# 8. Decision tables  (need to edit DecisionTable_mod1.csv and other if multiple models)
# 9. Base model summary (need to edit)
#
# Melissa Monk, NMFS
# =============================================================================


# =============================================================================
# 1. Catch FIGURE(S) ----------------------------------------------------------
# Required: Read in CSV file, edit this section depending on # of plots!!
# Read in executive summary catches figure file
Exec_catch =  read.csv('./txt_files/Exec_catch_for_figs.csv')
  
# Assign column names
colnames(Exec_catch) = c('Year',
                         'Fleet 1',
                         'Fleet 2',
                         'Fleet 3',
                         'Fleet 4',
                         'Fleet5')
    
# Split catch by regions -retaning the colunns for each -you'll have to edit
Exec_region1_catch = Exec_catch[,c(1:2)]
Exec_region2_catch = Exec_catch[,c(1,3,4)]
Exec_region3_catch = Exec_catch[,c(1,5,6)]
    
# Melt data so it can be plotted
Exec_region1_catch = melt(Exec_region1_catch, id='Year')
Exec_region2_catch = melt(Exec_region2_catch, id='Year')
Exec_region3_catch = melt(Exec_region3_catch, id='Year')
   
# Reassign column names
colnames(Exec_region1_catch) = c('Year','Fleet','Removals')
colnames(Exec_region2_catch) = c('Year','Fleet','Removals')
colnames(Exec_region3_catch) = c('Year','Fleet','Removals')

# Plot catches function
Plot_catch = function(Catch_df) {
             ggplot(Catch_df, aes(x=Year, y=Removals,fill=Fleet)) +
             geom_area(position='stack') +
             scale_fill_manual(values=c('lightsteelblue3','coral')) +
             scale_x_continuous(breaks=seq(Dat_start,Dat_end,20)) +
             ylab('Landings (mt)')
}

# -----------------------------------------------------------------------------
# CATCH TABLE(S) --------------------------------------------------------------

# Read in executive summary catches table
Exec_catch_summary = read.csv('./txt_files/Exec_catch_summary.csv')
  
# Assign column names as they should appear in the table; change the alignment 
# to match number of columns +1
colnames(Exec_catch_summary) = c('Year', 
                                 'Landings 1',
                                 'Landings 2',
                                 'Landings 3',
                                 'Landings 4', 
                                 'Landings 5',
                                 'Total')
    
# Make executive summary catch xtable
Exec_catch.table = xtable(Exec_catch_summary, 
                          caption = c(paste('Recent ',spp,' landings (mt) by 
                                            fleet.', sep='')), 
                          label='tab:Exec_catch')
    
# Add alignment - you will have to adjust based on the number of columns you have
# and the desired width, remember to add one leading ghost column for row.names
align(Exec_catch.table) = c('l', 'l', 
                            '>{\\centering}p{1in}', 
                            '>{\\centering}p{1in}',
                            '>{\\centering}p{1in}', 
                            '>{\\centering}p{.9in}',
                            '>{\\centering}p{.9in}',
                            '>{\\centering}p{.6in}')  

  
# =============================================================================
# Spawning output and Depletion -----------------------------------------------

# Retreive data on spawning output and depletion
for (model in 1:n_models) {
    if (model==1) {
     mod=mod1
     mod_area='mod1'
    } else {
    
    if (model==2) {
     mod=mod2
     mod_area='mod2'
    } else {
     mod=mod3
     mod_area='mod3'
    }}
          
  # Extract biomass/output  
  SpawningB = mod$derived_quants[grep('SPB', mod$derived_quants$LABEL), ]
  SpawningB = SpawningB[c(-1, -2), ]
     
      
  # Spawning biomass and std.dev data, calculate lower and upper 95% CI                 
  SpawningByrs = SpawningB[SpawningB$LABEL >= paste('SPB_', FirstYR,sep='') 
                         & SpawningB$LABEL <= paste('SPB_', LastYR,sep=''), ]     
  
  SpawningByrs$YEAR = seq(FirstYR, LastYR)
  
  SpawningByrs$lowerCI = round(SpawningByrs$Value + 
                                 qnorm(0.025) * SpawningByrs$StdDev, 
                               digits = 2)
  
  SpawningByrs$upperCI = round(SpawningByrs$Value - 
                                 qnorm(0.025) * SpawningByrs$StdDev, 
                               digits = 2)
    
  # Save individual depletion table before CI combined to character
  assign(paste('SpawnB_', mod_area, sep = ''), SpawningByrs)
  SpawnB = SpawningByrs  
      
  # Calculate confidence intervals
  SpawningByrs$CI = paste('(', SpawningByrs$lowerCI, '-', SpawningByrs$upperCI, ')', 
                          sep = '')
  SpawningBtab = subset(SpawningByrs, select = c('YEAR', 'Value', 'CI'))
      
  # Assign column names
  colnames(SpawningBtab) = c('Year', paste('Spawning Output (', fecund_unit,')', 
                                           sep=''), '~ 95% confidence interval')
  
  
  # Extract Depletion values  
  Depletion = mod$derived_quants[grep('Bratio', mod$derived_quants$LABEL), ]
  Depletion = Depletion[c(-1, -2), ]
     
  # Estimated depletion, pull out correct years, list years, and estimate 95% CI
  Depletionyrs = Depletion[Depletion$LABEL >= paste('Bratio_', FirstYR,sep='') &
                           Depletion$LABEL <= paste('Bratio_', LastYR,sep=''), ]     
  
  Depletionyrs$YEAR = seq(FirstYR, LastYR)
  
  Depletion$Value = round(Depletion$Value, digits=3)
  
  Depletionyrs$lowerCI = round(Depletionyrs$Value + 
                               qnorm(0.025)*Depletionyrs$StdDev, digits=3)
  
  Depletionyrs$upperCI = round(Depletionyrs$Value - 
                               qnorm(0.025)*Depletionyrs$StdDev, digits=3)
        
  # Save individual depletion tables
  assign(paste('Deplete_', mod_area, sep=''), Depletionyrs)
  Deplete = Depletionyrs     
    
  Depletionyrs$CI = paste('(', Depletionyrs$lowerCI, '-', Depletionyrs$upperCI, ')', 
                          sep = '')
  
  Depletiontab = subset(Depletionyrs, select=c('Value', 'CI'))
  
  colnames(Depletiontab) = c('Estimated depletion', '~ 95% confidence interval')
    
  # Bind the spawning output and depletion data together 
  Spawn_Deplete = cbind(SpawningBtab, Depletiontab)
 
  colnames(Spawn_Deplete) = c('Year', 
                              paste('Spawning Output (', fecund_unit, ')', sep = ''), 
                              '~ 95% confidence interval',
                              'Estimated depletion',
                              '~ 95% confidence interval')
        
  # Assign a model number to the Spawn_deplete table, if you do cbind within this step
  assign(paste('SpawnDeplete_',mod_area,sep=''), Spawn_Deplete)
    
  # 9.1.15 R now won't read the file with any underscores for xtable,
  # so use SpawnDeplete without spaces for that  
  assign(paste('SpawnDeplete',mod_area, sep=''), Spawn_Deplete)
       
  assign(paste('Depl_',mod_area, sep=''), percent(Deplete[nrow(Deplete), 2]))
          
  assign(paste('Depl_',mod_area,'_CI',sep=''), 
         paste(percent(Deplete[nrow(Deplete), 7]), '-', 
               percent(Deplete[nrow(Deplete), 8]), sep=''))
        
  assign(paste('Spawn_', mod_area, sep=''), SpawnB[nrow(SpawnB), 2])
    
  assign(paste('Spawn_',mod_area,'_CI',sep=''), 
         paste(SpawnB[nrow(SpawnB), 7], '-', SpawnB[nrow(SpawnB), 8], sep=''))

} # end model for loop for spawning biomass and depletion


# =============================================================================
# =============================================================================
# Create Spawning/Depletion tables for the correct number of models
# Model 1 table ---------------------------------------------------------------
Spawn_Deplete_mod1.table = xtable(SpawnDepletemod1, 
                           caption = c(paste('Recent trend in beginning of the 
                                      year spawning output and depletion for
                                      the ', mod1_label, ' for ', spp, '.',sep='')), 
                           label='tab:SpawningDeplete_mod1',digits=3)  

# Add column spacing    
align(Spawn_Deplete_mod1.table) = c('l', 'l', 
                                    '>{\\centering}p{1.3in}', 
                                    '>{\\centering}p{1.2in}', 
                                    '>{\\centering}p{1in}', 
                                    '>{\\centering}p{1.2in}')  

# Model 2 table ---------------------------------------------------------------
if (n_models >= 2) {
  Spawn_Deplete_mod2.table = xtable(SpawnDepletemod2, 
                                    caption=c(paste('Recent trend in 
                                             beginning of the year spawning output
                                             and depletion for the ', mod2_label,
                                             ' for ', spp,'.',sep='')), 
                                    label='tab:SpawningDeplete_mod2', digits = 3)     

 # Add alignment 
  align(Spawn_Deplete_mod2.table) = c('l', 'l',
                                    '>{\\centering}p{1.3in}', 
                                    '>{\\centering}p{1.2in}',
                                    '>{\\centering}p{1in}',
                                    '>{\\centering}p{1.2in}')  
} # end n_models>=2

# Model 3 table ---------------------------------------------------------------
if (n_models == 3) {
  Spawn_Deplete_mod3.table = xtable(SpawnDepletemod3, 
                                    caption=c(paste('Recent trend in beginning of
                                              the year spawning output and                                           
                                              depletion for the ', mod3_label, 
                                              ' for ', spp, '.', sep='')), 
                                    label='tab:SpawningDeplete_mod3',digits=3)     

 # Add alignment  
  align(Spawn_Deplete_mod3.table) = c('l', 'l', 
                                    '>{\\centering}p{1.3in}',
                                    '>{\\centering}p{1.2in}', 
                                    '>{\\centering}p{1in}',
                                    '>{\\centering}p{1.2in}')  
} # end n_models==3

# =============================================================================
# Recruitment =================================================================

# Extract recruitment values
for (model in 1:n_models) {
  if (model==1) {
   mod=mod1
   mod_area='mod1'
  } else {
  if (model==2) {
   mod=mod2
   mod_area='mod2'
  } else {
   mod=mod3
   mod_area='mod3'
 }}
        
  # Pull out recuitment  
  Recruit = mod$derived_quants[grep('Recr',mod$derived_quants$LABEL),]
  Recruit = Recruit[c(-1,-2),]
  
  # Recruitment and std.dev data, calculate lower and upper 95% CI                 
  Recruityrs = Recruit[Recruit$LABEL >= paste('Recr_', FirstYR, sep = '') &  
                       Recruit$LABEL <= paste('Recr_', LastYR, sep = ''), ]     
  
  Recruityrs$YEAR = seq(FirstYR, LastYR)
  
  # assume recruitments have log-normal distribution 
  # from first principals (multiplicative survival probabilities)
  Recruityrs$logint <- sqrt(log(1+(Recruityrs$StdDev/Recruityrs$Value)^2))
  Recruityrs$lowerCI <- exp(log(Recruityrs$Value) + qnorm(0.025)*Recruityrs$logint)
  Recruityrs$upperCI <- exp(log(Recruityrs$Value) + qnorm(0.975)*Recruityrs$logint)
  
  Recruit_units <- "1,000s"
  if(mean(Recruityrs$Value) > 1000){
    Recruit_units <- "millions"
    Recruityrs$Value <- Recruityrs$Value/1000
    Recruityrs$lowerCI <- Recruityrs$lowerCI/1000
    Recruityrs$upperCI <- Recruityrs$upperCI/1000
  }
  
  Recruityrs$CI = paste('(', round(Recruityrs$lowerCI, digits = 2), 
                        ' - ', round(Recruityrs$upperCI, digits = 2), ')', sep='')
  
  Recruityrs$Value = round(Recruityrs$Value, digits = 2)
  
  Recruittab=subset(Recruityrs, select = c('YEAR', 'Value', 'CI'))
  
  colnames(Recruittab) = c('Year',
                           paste0('Estimated Recruitment (',Recruit_units,')'),
                           '~ 95% confidence interval')
  
  assign(paste('Recruittab_',mod_area,sep=''), Recruittab)

} # end model loop for recruitment


# -----------------------------------------------------------------------------
# Create recruitment tables

# Model 1 table
Recruit_mod1.table = xtable(Recruittab_mod1, 
                            caption = c(paste('Recent recruitment for the ', 
                                        mod1_label, '.', sep='')),
                            label = 'tab:Recruit_mod1', digits = 2)     
        
# Add alignment
#align(Recruit_mod1.table) = c('l', 'l',
#                              '>{\\centering}p{1in}',
#                              '>{\\centering}p{1.2in}') 


    
# Model 2
if (n_models >= 2) {
Recruit_mod2.table = xtable(Recruittab_mod2, 
                            caption=c(paste('Recent recruitment for the ',
                                      mod2_label,'.',sep='')),
                            label='tab:Recruit_mod2', digits = 2) 
# Add alignment       
#align(Recruit_mod2.table) = c('l', 'l',
#                              '>{\\centering}p{1in}',
#                              '>{\\centering}p{1.2in}') 
}


# Model 3
if (n_models == 3) {
Recruit_mod3.table = xtable(Recruittab_mod3, 
                            caption=c(paste('Recent recruitment for the ', 
                                      mod3_label,'.',sep='')), 
                            label = 'tab:Recruit_mod3', digits = 2)  
# Add alignment       
#align(Recruit_mod3.table) = c('l', 'l',
#                              '>{\\centering}p{1in}',
#                              '>{\\centering}p{1.2in}') 
}

# =============================================================================
# Exploitation data -----------------------------------------------------------

# Extract exploitation values
for (model in 1:n_models) {
  if (model == 1) {
    mod = mod1
    mod_area = 'mod1'
  } else {
  if (model == 2){
    mod = mod2
    mod_area = 'mod2'
  } else {
    mod = mod3
    mod_area = 'mod3'
 }}  
      
  # Extract exploitation and SPR ratio values from r4SS output
  Exploit = mod$derived_quants[grep('F',mod$derived_quants$LABEL),]
  Exploit = Exploit[c(-1,-2),]
        
  SPRratio = mod$derived_quants[grep('SPRratio',mod$derived_quants$LABEL),]
  SPRratio = SPRratio[c(-1,-2),]
        
  # Exploitation and calculate lower and upper 95% CI                 
  Exploityrs = Exploit[Exploit$LABEL >= paste('F_', FirstYR-1, sep='') &
                       Exploit$LABEL <= paste('F_', LastYR-1, sep=''), ]     
  
  Exploityrs$YEAR = seq(FirstYR-1, LastYR-1)
  
  Exploityrs$lowerCI = round(Exploityrs$Value +
                            qnorm(0.025) * Exploityrs$StdDev, digits = 2)
  
  Exploityrs$upperCI = round(Exploityrs$Value -
                            qnorm(0.025) * Exploityrs$StdDev, digits = 2)
  
  Exploityrs$CI = paste('(', Exploityrs$lowerCI, '-', Exploityrs$upperCI, ')', sep='')
  
  Exploittab = subset(Exploityrs, select=c('Value', 'CI'))
 
   colnames(Exploittab) = c('Exploitation rate', '~ 95% confidence interval')
        
        
  # Spawning potential ratio and calculate lower and upper 95% CI  
  SPRratioyrs = SPRratio[SPRratio$LABEL >= paste('SPRratio_', FirstYR-1, sep='') 
                       & SPRratio$LABEL <= paste('SPRratio_', LastYR-1, sep=''), ]     
  
  SPRratioyrs$Year = seq(FirstYR-1, LastYR-1)
  
  SPRratioyrs$lowerCI = round(SPRratioyrs$Value +
                              qnorm(0.025) * SPRratioyrs$StdDev, digits = 2)
  
  SPRratioyrs$upperCI = round(SPRratioyrs$Value -
                              qnorm(0.025) * SPRratioyrs$StdDev, digits = 2)
  
  SPRratioyrs$CI = paste('(', SPRratioyrs$lowerCI, '-', SPRratioyrs$upperCI, ')', sep='')
  
  SPRratiotab = subset(SPRratioyrs, select = c('Year', 'Value', 'CI'))
  
  SPRratiotab$Year = as.factor(SPRratiotab$Year)
  
  colnames(SPRratiotab) = c('Year', 'Fishing intensity', '~ 95% confidence interval')
      
  assign(paste('SPRratio_Exploit_', mod_area, sep=''), cbind(SPRratiotab, Exploittab))

} # end for loop for SPR ratio and exploitation

# =============================================================================
# Create the three tables for SPR Ratio and Exploitation

# Model 1 
SPRratio_Exploit_mod1.table = xtable(SPRratio_Exploit_mod1, 
                              caption=c(paste('Recent trend in spawning potential 
                                        ratio and exploitation for ', spp, ' in the ', 
                                        mod1_label, '.  Fishing intensity is (1-SPR) 
                                        divided by 50\\% (the SPR target) and exploitation 
                                        is F divided by F\\textsubscript{SPR}.', sep='')), 
                              label='tab:SPR_Exploit_mod1')  
      
align(SPRratio_Exploit_mod1.table) = c('l','l',
                                       '>{\\centering}p{1in}',
                                       '>{\\centering}p{1.2in}',
                                       '>{\\centering}p{1in}',
                                       '>{\\centering}p{1.2in}') 
     
# Model 2
if (n_models >= 2) {
SPRratio_Exploit_mod2.table = xtable(SPRratio_Exploit_mod2, 
                              caption=c(paste('Recent trend in spawning potential 
                                        ratio and exploitation for ', spp, ' in the ', 
                                        mod2_label, '. Fishing intensity is (1-SPR) 
                                        divided by 50\\% (the SPR target) and exploitation 
                                        is F divided by F\\textsubscript{SPR}.', sep='')), 
                              label='tab:SPR_Exploit_mod2')  
        
align(SPRratio_Exploit_mod2.table) = c('l','l',
                                       '>{\\centering}p{1in}',
                                       '>{\\centering}p{1.2in}',
                                       '>{\\centering}p{1in}',
                                       '>{\\centering}p{1.2in}') 
}


# Model 3
if (n_models == 3) {
SPRratio_Exploit_mod3.table = xtable(SPRratio_Exploit_mod3, 
                              caption=c(paste('Recent trend in spawning potential 
                                        ratio and exploitation for ', spp, ' in the ', 
                                        mod3_label,'.  Fishing intensity is (1-SPR) 
                                        divided by 50\\% (the SPR target) and exploitation 
                                        is F divided by F\\textsubscript{SPR}.',sep='')), 
                              label='tab:SPR_Exploit_mod3')  
        
align(SPRratio_Exploit_mod3.table) = c('l','l',
                                       '>{\\centering}p{1in}',
                                       '>{\\centering}p{1.2in}',
                                       '>{\\centering}p{1in}',
                                       '>{\\centering}p{1.2in}') 
}

# =============================================================================
# Reference points ------------------------------------------------------------

# Extract reference points table data
for (model in 1:n_models) {
 if (model == 1){
   mod = mod1
   mod_area = 'mod1'
  } else {
  if(model == 2) {
   mod = mod2
   mod_area = 'mod2'
  } else {
   mod = mod3
   mod_area = 'mod3'
 }}
      

  # Rbind all of the data for the big summary reference table  
  Ref_pts = rbind (
  SSB_Unfished    = mod$derived_quants[grep('SSB_U', mod$derived_quants$LABEL), ],
  TotBio_Unfished = mod$derived_quants[grep('TotBio', mod$derived_quants$LABEL), ],
  Recr_Unfished   = mod$derived_quants[grep('Recr_Un', mod$derived_quants$LABEL), ],
  SPB_lastyr      = mod$derived_quants[grep(paste0('SPB_', LastYR), mod$derived_quants$LABEL), ],
  Depletion_lastyr= mod$derived_quants[grep(paste0('Bratio_', LastYR), mod$derived_quants$LABEL), ],
  Refpt_sB        = c(NA, NA, NA),
  SSB_Btgt        = mod$derived_quants[grep('SSB_Btgt', mod$derived_quants$LABEL), ],
  SPR_Btgt        = mod$derived_quants[grep('SPR_Btgt', mod$derived_quants$LABEL), ],
  Fstd_Btgt       = mod$derived_quants[grep('Fstd_Btgt', mod$derived_quants$LABEL), ],
  TotYield_Btgt   = mod$derived_quants[grep('TotYield_Btgt', mod$derived_quants$LABEL), ],
  Refpt_SPR       = c(NA, NA, NA),
  SSB_SPRtgt      = mod$derived_quants[grep('SSB_SPRtgt', mod$derived_quants$LABEL), ],
  SPR_proxy       = c('SPR_proxy', .5, NA),
  Fstd_SPRtgt     = mod$derived_quants[grep('Fstd_SPRtgt', mod$derived_quants$LABEL), ],
  TotYield_SPRtgt = mod$derived_quants[grep('TotYield_SPRtgt', mod$derived_quants$LABEL), ],
  Refpts_MSY      = c(NA, NA, NA),
  SSB_MSY         = mod$derived_quants[grep('SSB_MSY', mod$derived_quants$LABEL), ],
  SPR_MSY         = mod$derived_quants[grep('SPR_MSY', mod$derived_quants$LABEL), ],
  Fstd_MSY        = mod$derived_quants[grep('Fstd_MSY', mod$derived_quants$LABEL), ],
  TotYield_MSY    = mod$derived_quants[grep('TotYield_MSY', mod$derived_quants$LABEL), ] )
  Ref_pts         = Ref_pts[, 1:3]
  Ref_pts$Value   = as.numeric(Ref_pts$Value)
  Ref_pts$StdDev  = as.numeric(Ref_pts$StdDev)
  Ref_pts$Value1  = ifelse(Ref_pts$Value >= 1, as.character(round(Ref_pts$Value, 1)), 
                           as.character(round(Ref_pts$Value, 4)))   
        
  Ref_pts$lowerCI  = round(Ref_pts$Value + qnorm(0.025) * Ref_pts$StdDev, digits = 4)
  
  Ref_pts$upperCI  = round(Ref_pts$Value - qnorm(0.025) * Ref_pts$StdDev, digits = 4)
  
  Ref_pts$lowerCI1 = ifelse(Ref_pts$lowerCI >= 1, as.character(round(Ref_pts$lowerCI, 1)), 
                            as.character(round(Ref_pts$lowerCI, 4))) 
  
  Ref_pts$upperCI1 = ifelse(Ref_pts$upperCI>=1, as.character(round(Ref_pts$upperCI,1)), 
                            as.character(round(Ref_pts$upperCI, 4))) 
  
  Ref_pts$CI1      = paste('(', Ref_pts$lowerCI1, '-', Ref_pts$upperCI1, ')', sep='')
        
  Quantity = c(paste('Unfished spawning output (', fecund_unit, ')', sep = ''),
                     paste('Unfished age ', min_age, ' biomass (mt)', sep = ''),
                    'Unfished recruitment (R0, thousands)',
                     paste('Spawning output', '(', LastYR, ' ', fecund_unit, ')', sep = ''),
                     paste('Depletion (', LastYR,')',sep=''),
                    '\\textbf{$\\text{Reference points based on } \\mathbf{SB_{40\\%}}$}',
                    'Proxy spawning output ($B_{40\\%}$)',
                    'SPR resulting in $B_{40\\%}$ ($SPR_{B40\\%}$)',
                    'Exploitation rate resulting in $B_{40\\%}$',
                    'Yield with $SPR_{B40\\%}$ at $B_{40\\%}$ (mt)',
                    '\\textbf{\\textit{Reference points based on SPR proxy for MSY}}',
                    'Spawning output',
                    '$SPR_{proxy}$',
                    'Exploitation rate corresponding to $SPR_{proxy}$',
                    'Yield with $SPR_{proxy}$ at $SB_{SPR}$ (mt)',
                    '\\textbf{\\textit{Reference points based on estimated MSY values}}',
                    'Spawning output at $MSY$ ($SB_{MSY}$)',
                    '$SPR_{MSY}$',
                    'Exploitation rate at $MSY$',
                    '$MSY$ (mt) ')
        
  Ref_pts = cbind(Quantity, Ref_pts[, c(4, 9)])
  Ref_pts[c(6, 11, 13, 16), 3] = ''
  Ref_pts[c(6, 11, 16), 2] = ''
  colnames(Ref_pts) = c('\\textbf{Quantity}', '\\textbf{Estimate}', 
                        '\\textbf{\\~95\\%  Confidence Interval}')
  assign(paste('Ref_pts_', mod_area, sep = ''), Ref_pts)

} # end for loop for n models for reference points table

# =============================================================================
# Create reference point table(s)----------------------------------------------

# Model 1 
Ref_pts_mod1.table = xtable(Ref_pts_mod1, 
                            caption=c(paste('Summary of reference 
                                      points and management quantities for the 
                                      base case ', mod1_label, '.',sep = '')), 
                            label='tab:Ref_pts_mod1')  
# Add alignment      
align(Ref_pts_mod1.table) = c('l',
                              '>{\\raggedright}p{4.1in}',
                              '>{\\centering}p{.65in}',
                              '>{\\centering}p{1.4in}')  


# Model 2
if (n_models >= 2) {
Ref_pts_mod2.table = xtable(Ref_pts_mod2, 
                            caption=c(paste('Summary of reference points 
                                      and management quantities for the base case ', 
                                      mod2_label, '.', sep = '')),  
                            label='tab:Ref_pts_mod2') 
# Add alignment      
align(Ref_pts_mod2.table) = c('l',
                              '>{\\raggedright}p{4.1in}',
                              '>{\\centering}p{.65in}',
                              '>{\\centering}p{1.4in}')  
}

# Model 3
if (n_models == 3) {
Ref_pts_mod3.table = xtable(Ref_pts_mod3, 
                            caption=c(paste('Summary of reference points 
                                      and management quantities for the base 
                                      case ', mod3_label, '.',sep='')), 
                            label='tab:Ref_pts_mod3')  
# Add alignment      
align(Ref_pts_mod3.table) = c('l',
                              '>{\\raggedright}p{4.1in}',
                              '>{\\centering}p{.65in}',
                              '>{\\centering}p{1.4in}')  
}

# =============================================================================
# Management performance ------------------------------------------------------
# Required: EDIT and READ IN Exec_mngmt_performance.csv FILE ------------------
# Read in the management performance table - get from John Devore
# Will have to change the column names, caption, and the alignment
  
mngmnt = read.csv('./txt_files/Exec_mngmt_performance.csv')

colnames(mngmnt) = c('Year',
                     'OFL (mt; ABC prior to 2011)',  
                     'ABC (mt)', 
                     'ACL (mt; OY prior to 2011)', 
                     'Estimated total catch (mt)')

# Create the management performance table
mngmnt.table = xtable(mngmnt, 
                      caption=c('Recent trend in total catch and commercial 
                              landings (mt) relative to the management guidelines. 
                              Estimated total catch reflect the commercial landings 
                              plus the model estimated discarded biomass.'), 
                      label='tab:mnmgt_perform')  
# Add alignment
align(mngmnt.table) = c('l',
                        '>{\\raggedleft}p{1in}',
                        '>{\\centering}p{1in}',
                        '>{\\centering}p{1in}',
                        '>{\\centering}p{1in}', 
                        '>{\\centering}p{1in}')  


# =============================================================================
# OFL projection --------------------------------------------------------------


#For 1 model:
if (n_models == 1) {
# Extract OFLs for next 10 years for each model
      OFL_mod1 = mod1$derived_quants[grep('OFL',mod1$derived_quants$LABEL),]
      OFL_mod1 = OFL_mod1[, 2]    #OFL_mod1[c(-1,-2),2]
      
      #Turn into a dataframe and get the total
      OFL = as.data.frame(OFL_mod1)
      OFL$Year=seq(Project_firstyr,Project_lastyr,1)
      OFL$Year = as.factor(OFL$Year)
      OFL = OFL[,c(2,1)]
      colnames(OFL) = c('Year','OFL') 

# Create the table
      OFL.table = xtable(OFL, caption=c('Projections of potential OFL (mt) for each model, using the base model forecast.'),
                  label = 'tab:OFL_projection')
}

# For 2 models:
      if (n_models == 2) {
        # Extract OFLs for next 10 years for each model
        OFL_mod1 = mod1$derived_quants[grep('OFL',mod1$derived_quants$LABEL),]
        OFL_mod1 = OFL_mod1[c(-1,-2),2]
        
        OFL_mod2 = mod2$derived_quants[grep('OFL',mod2$derived_quants$LABEL),]
        OFL_mod2 = OFL_mod2[c(-1,-2),2]
        
        # Turn into a dataframe and get the total
        OFL = as.data.frame(cbind(OFL_mod1, OFL_mod2))
        OFL$Total = rowSums(OFL)
        OFL$Year=seq(Project_firstyr,Project_lastyr,1)
        OFL$Year = as.factor(OFL$Year)
        OFL = OFL[,c(4,1,2,3)]
        colnames(OFL) = c('Year','Model 1','Model 2','Total') 
        
        # Create the table
        OFL.table = xtable(OFL, caption=c('Projections of potential OFL (mt) for each model, using the base model forecast.'),
                           label = 'tab:OFL_projection')     
}           
      
      
#For 3 models:
if (n_models == 3) {
      # Extract OFLs for next 10 years for each model
      OFL_mod1 = mod1$derived_quants[grep('OFL',mod1$derived_quants$LABEL),]
      OFL_mod1 = OFL_mod1[c(-1,-2),2]
      
      OFL_mod2 = mod2$derived_quants[grep('OFL',mod2$derived_quants$LABEL),]
      OFL_mod2 = OFL_mod2[c(-1,-2),2]
      
      OFL_mod3 = mod3$derived_quants[grep('OFL',mod3$derived_quants$LABEL),]
      OFL_mod3 = OFL_mod3[c(-1,-2),2]
      
      #Turn into a dataframe and get the total
      OFL = as.data.frame(cbind(OFL_mod1, OFL_mod2, OFL_mod2))
      OFL$Total = rowSums(OFL)
      OFL$Year=seq(Project_firstyr,Project_lastyr,1)
      OFL$Year = as.factor(OFL$Year)
      OFL = OFL[,c(5,1,2,3,4)]
      colnames(OFL) = c('Year','North','Central','South','Total') 
      
      # Create the table
      OFL.table = xtable(OFL, caption=c('Projections of potential OFL (mt) for each model, using the base model forecast.'),
                         label = 'tab:OFL_projection')     
      
}      

# =============================================================================
# Decision Table(s) -----------------------------------------------------------
# Required: READ in the DecisionTable_mod CSV files ---------------------------

# Model 1
# Read in decision table file
  decision_mod1 = read.csv('./txt_files/DecisionTable_mod1.csv')
       colnames(decision_mod1) = c('', 
                                   'Year',  
                                   'Catch',	
                                   'Spawning Output',	
                                   'Depletion', 
                                   'Spawning Output',	
                                   'Depletion',	
                                   'Spawning Output',	
                                   'Depletion')
      
       decision_mod1.table = xtable(decision_mod1, 
                                    caption = c(paste('Summary of 10-year 
                                             projections beginning in ', LastYR+2,' 
                                             for alternate states of nature based on 
                                             an axis of uncertainty for the ', mod1_label, 
                                             '.  Columns range over low, mid, and high
                                             states of nature, and rows range over different 
                                             assumptions of catch levels. An entry of "--" 
                                             indicates that the stock is driven to very low 
                                             abundance under the particular scenario.', sep = '')), 
                                     label='tab:Decision_table_mod1')
      
    # Assign alignment and add the header columns
        align(decision_mod1.table) = c('l','l|','c','c|','>{\\centering}p{.7in}','c|','>{\\centering}p{.7in}','c|','>{\\centering}p{.7in}','c') 
    
        addtorow <- list()
        addtorow$pos <- list()
        addtorow$pos[[1]] <- -1
        addtorow$pos[[2]] <- -1
        addtorow$command <- c( ' \\multicolumn{3}{c}{}  &  \\multicolumn{2}{c}{} 
                               & \\multicolumn{2}{c}{\\textbf{States of nature}} 
                               & \\multicolumn{2}{c}{} \\\\\n', 
                               ' \\multicolumn{3}{c}{}  &  \\multicolumn{2}{c}{Low M 0.05} 
                               & \\multicolumn{2}{c}{Base M 0.07} 
                               &  \\multicolumn{2}{c}{High M 0.09} \\\\\n')
        
  
# Model 2
if (n_models >= 2) {
    # Read in decision table file 
    decision_mod2 = read.csv('./txt_files/DecisionTable_mod2.csv')
         colnames(decision_mod2) = c('', 
                                     'Year',  
                                     'Catch',  
                                     'Spawning Output',	
                                     'Depletion',
                                     'Spawning Output',	
                                     'Depletion',	
                                     'Spawning Output',	
                                     'Depletion')
  
     decision_mod2.table = xtable(decision_mod2, 
                                  caption=c(paste('Summary of 10-year projections 
                                                  beginning in ', LastYR+2,' for 
                                                  alternate states of nature based 
                                                  on an axis of uncertainty for the ',
                                                  mod2_label,'.  Columns range over low, 
                                                  mid, and high states of nature, and rows 
                                                  range over different assumptions of catch 
                                                  levels. An entry of "--" indicates that the 
                                                  stock is driven to very low abundance under the
                                                  particular scenario.', sep='')), 
                                      label='tab:Decision_table_mod2')
  
    # Assign alignment and add the header columns
    align(decision_mod2.table) = c('l',
                                   'l|',
                                   'c',
                                   'c|',
                                   '>{\\centering}p{.7in}',
                                   'c|',
                                   '>{\\centering}p{.7in}',
                                   'c|',
                                   '>{\\centering}p{.7in}',
                                   'c') 
    # Add additional header
    addtorow <- list()
    addtorow$pos <- list()
    addtorow$pos[[1]] <- -1
    addtorow$pos[[2]] <- -1
    addtorow$command <- c( ' \\multicolumn{3}{c}{} &  \\multicolumn{2}{c}{} 
                          &  \\multicolumn{2}{c}{\\textbf{States of nature}} 
                          &   \\multicolumn{2}{c}{} \\\\\n', 
                          ' \\multicolumn{3}{c}{}  &  \\multicolumn{2}{c}{Low M 0.05} 
                          &  \\multicolumn{2}{c}{Base M 0.07} 
                          &   \\multicolumn{2}{c}{High M 0.09} \\\\\n')
}   
    
# Model 3
if (n_models == 3) {
  # Read in decision table file
  decision_mod3 = read.csv('./txt_files/DecisionTable_mod3.csv')
      colnames(decision_mod3) = c('', 
                                  'Year',  
                                  'Catch',  
                                  'Spawning Output',	
                                  'Depletion',
                                  'Spawning Output',	
                                  'Depletion',	
                                  'Spawning Output',	
                                  'Depletion')
      
      decision_mod3.table = xtable(decision_mod3, 
                                   caption = c(paste('Summary of 10-year projections 
                                                     beginning in ', LastYR+2, ' for 
                                                     alternate states of nature based 
                                                     on an axis of uncertainty for the ', 
                                                     mod3_label,'.  Columns range over low, 
                                                     mid, and high states of nature, and rows \
                                                     range over different assumptions of catch 
                                                     levels. An entry of "--" indicates that the 
                                                     stock is driven to very low abundance under the
                                                     particular scenario.',sep='')), 
                                    label='tab:Decision_table_mod3')
  
    # Assign alignment and add the header columns
    align(decision_mod3.table) = c('l',
                                   'l|',
                                   'c',
                                   'c|',
                                   '>{\\centering}p{.7in}',
                                   'c|',
                                   '>{\\centering}p{.7in}',
                                   'c|',
                                   '>{\\centering}p{.7in}','c') 
    # Add extra colulmn headers    
    addtorow <- list()
    addtorow$pos <- list()
    addtorow$pos[[1]] <- -1
    addtorow$pos[[2]] <- -1
    addtorow$command <- c( ' \\multicolumn{3}{c}{} &  \\multicolumn{2}{c}{} 
                           &  \\multicolumn{2}{c}{\\textbf{States of nature}} 
                           &   \\multicolumn{2}{c}{} \\\\\n', 
                           ' \\multicolumn{3}{c}{}  &  \\multicolumn{2}{c}{Low M 0.05} 
                           &  \\multicolumn{2}{c}{Base M 0.07} 
                           &   \\multicolumn{2}{c}{High M 0.09} \\\\\n')
}


# =============================================================================
# Base case summary table -----------------------------------------------------
# Required: PARTIALLY READS CSV FILE ------------------------------------------

# Collect the data from all the tables
# Read in the management table
mngmt = read.csv('./txt_files/Exec_basemodel_summary.csv')
mngmt = mngmt[,-1]
    
# Model 1
  # SPR ratio and exploitation
  SPRratio_Exploit_mod1 = SPRratio_Exploit_mod1[,c(2,4)]
  SPRratio_Exploit_mod1[,c(1,2)] = round(SPRratio_Exploit_mod1[,c(1,2)],2)
  SPRratio_Exploit_mod1 = SPRratio_Exploit_mod1[-dim(SPRratio_Exploit_mod1)[1],]

  # SPR blanks for the last year
  blanks = c(NA,NA)
  SPRratio_Exploit_mod1 = rbind(SPRratio_Exploit_mod1,blanks)
  
  # Age 5+ biomass
  Age5biomass_mod1 = mod1$timeseries[,c('Yr','Bio_smry')]
  Age5biomassyrs_mod1 = subset(Age5biomass_mod1, Yr>=(FirstYR) & Yr<=(LastYR))
  Age5biomassyrs_mod1 = Age5biomassyrs_mod1[,2]
  Age5biomassyrs_mod1 = round(Age5biomassyrs_mod1,2)
  
  # Spawning biomass and depltion
  SpawnDeplete_mod1 = SpawnDeplete_mod1[,c(2:5)]
  SpawnDeplete_mod1[,1] = round(SpawnDeplete_mod1[,1],1)
  SpawnDeplete_mod1[,3] = round(SpawnDeplete_mod1[,3],1)
  
  # Recruitment
  Recruittab_mod1 = Recruittab_mod1[,c(2,3)]
  Recruittab_mod1[,2] = Recruittab_mod1[,2]
  
  # BIND ALL DATA TOGETHER
  mod1_summary = cbind(SPRratio_Exploit_mod1,Age5biomassyrs_mod1,SpawnDeplete_mod1,Recruittab_mod1)
    
# Model 2
if (n_models >= 2) {
  # SPR ratio and exploitation
  SPRratio_Exploit_mod2 = SPRratio_Exploit_mod2[,c(2,4)]
  SPRratio_Exploit_mod2[,c(1,2)] = round(SPRratio_Exploit_mod2[,c(1,2)],2)
  SPRratio_Exploit_mod2 = SPRratio_Exploit_mod2[-dim(SPRratio_Exploit_mod2)[1],]
  SPRratio_Exploit_mod2 = rbind(SPRratio_Exploit_mod2,blanks)

  # Age 5+ biomass 
  Age5biomass_mod2 = mod2$timeseries[,c('Yr','Bio_smry')]
  Age5biomassyrs_mod2 = subset(Age5biomass_mod2, Yr>=(FirstYR) & Yr<=(LastYR))
  Age5biomassyrs_mod2 = Age5biomassyrs_mod2[,2]
  Age5biomassyrs_mod2 = round(Age5biomassyrs_mod2,2)
  
  # Spawning biomass and depltion
  SpawnDeplete_mod2 = SpawnDeplete_mod2[,c(2:5)]
  SpawnDeplete_mod2[,1] = round(SpawnDeplete_mod2[,1],0)
  SpawnDeplete_mod2[,3] = round(SpawnDeplete_mod2[,3],2)
  
  # Recruitment 
  Recruittab_mod2 = Recruittab_mod2[,c(2,3)]
  
  # BIND ALL DATA TOGETHER
  mod2_summary = cbind(SPRratio_Exploit_mod2,Age5biomassyrs_mod2,SpawnDeplete_mod2,Recruittab_mod2)
}
  
# Model 3
if (n_models == 3) {
  # SPR ratio and exploitation
  SPRratio_Exploit_mod3 = SPRratio_Exploit_mod3[,c(2,4)]
  SPRratio_Exploit_mod3[,c(1,2)] = round(SPRratio_Exploit_mod3[,c(1,2)],2)
  SPRratio_Exploit_mod3 = SPRratio_Exploit_mod3[-dim(SPRratio_Exploit_mod3)[1],]
  SPRratio_Exploit_mod3 = rbind(SPRratio_Exploit_mod3,blanks)
 
  # Age 5+ biomass 
  Age5biomass_mod3 = mod3$timeseries[,c('Yr','Bio_smry')]
  Age5biomassyrs_mod3 = subset(Age5biomass_mod3, Yr>=(FirstYR) & Yr<=(LastYR))
  Age5biomassyrs_mod3 = Age5biomassyrs_mod3[,2]
  Age5biomassyrs_mod3 = round(Age5biomassyrs_mod3,2)
  
  # Spawning biomass and depltion 
  SpawnDeplete_mod3 = SpawnDeplete_mod3[,c(2:5)]
  SpawnDeplete_mod3[,1] = round(SpawnDeplete_mod3[,1],0)
  SpawnDeplete_mod3[,3] = round(SpawnDeplete_mod3[,3],2)
  
  # Recruitment 
  Recruittab_mod3 = Recruittab_mod3[,c(2,3)]
  
# BIND ALL DATA TOGETHER
mod3_summary = cbind(SPRratio_Exploit_mod3,Age5biomassyrs_mod3,SpawnDeplete_mod3,Recruittab_mod3)
}

# -----------------------------------------------------------------------------    
# CREATE TABLES BASED ON HOW MANY MODELS AND MANAGEMENT AREAS YOU HAVE
  
# ONE MODEL
if (n_models == 1) {
  # Bind data from all three models together
  base_summary = cbind(mngmt,mod1_summary)
  
  
  # Transpose the dataframe to create the table and create data labels  
  base_summary = as.data.frame(t(base_summary))
  base_summary$names=c('Landings (mt)',
                       'Total Est. Catch (mt)',
                       'OFL (mt)', 
                       'ACL (mt)',
                       
                       '(1-$SPR$)(1-$SPR_{50\\%}$)',
                       'Exploitation rate',
                       paste('Age ',min_age,' biomass (mt)',sep=''),
                       'Spawning Output',
                       '~95\\% CI',
                       'Depletion',
                       '~95\\% CI',
                       'Recruits',
                       '~95\\% CI')
  
  base_summary = base_summary[,c(11,10,1:9)]
  colnames(base_summary) = c('Quantity',seq(FirstYR,LastYR))
  
  # Create the table
  base_summary.table = xtable(base_summary, caption=c('Base case results summary.'), 
                              label='tab:base_summary',digits=0) 
  # Add alignment   
  align(base_summary.table) = c('l',
                                'r', 
                                '>{\\centering}p{1.1in}',
                                '>{\\centering}p{1.1in}', 
                                '>{\\centering}p{1.1in}', 
                                '>{\\centering}p{1.1in}', 
                                '>{\\centering}p{1.1in}', 
                                '>{\\centering}p{1.1in}', 
                                '>{\\centering}p{1.1in}', 
                                '>{\\centering}p{1.1in}', 
                                '>{\\centering}p{1.1in}', 
                                '>{\\centering}p{1.1in}')    
}
  # TWO MODELS
if (n_models == 2) {
  # Bind data from all three models together
  base_summary = cbind(mngmt,mod1_summary, mod2_summary)
  
  
  # Transpose the dataframe to create the table and create data labels  
  base_summary = as.data.frame(t(base_summary))
  base_summary$names=c('Landings (mt)',
                       'Total Est. Catch (mt)',
                       'OFL (mt)', 
                       'ACL (mt)',
                       
                       '(1-$SPR$)(1-$SPR_{50\\%}$)',
                       'Exploitation rate',
                       paste('Age ',min_age,' biomass (mt)',sep=''),
                       'Spawning Output',
                       '~95\\% CI',
                       'Depletion',
                       '~95\\% CI',
                       'Recruits',
                       '~95\\% CI',
                       
                       '(1-$SPR$)(1-$SPR_{50\\%}$)',
                       'Exploitation rate',
                       paste('Age ',min_age,' biomass (mt)',sep=''),
                       'Spawning Output',
                       '~95\\% CI',
                       'Depletion',
                       '~95\\% CI',
                       'Recruits',
                       '~95\\% CI')
  
  base_summary$region = c('','','','',
                          'Model 1','Base Case','','','','','','','',
                          'Model 2','Base Case','','','','','','','' )
  
  base_summary = base_summary[,c(12,11,1:10)]
  colnames(base_summary) = c('Model Region','Quantity',seq(FirstYR,LastYR))
  
  # Create the table
  base_summary.table = xtable(base_summary, caption=c(paste(spp,' base case results summary.',sep='')), 
                              label='tab:base_summary',digits=0) 
  # Add alignment   
  align(base_summary.table) = c('l',
                                'r',
                                'r', 
                                '>{\\centering}p{1.1in}', 
                                '>{\\centering}p{1.1in}', 
                                '>{\\centering}p{1.1in}', 
                                '>{\\centering}p{1.1in}', 
                                '>{\\centering}p{1.1in}', 
                                '>{\\centering}p{1.1in}', 
                                '>{\\centering}p{1.1in}', 
                                '>{\\centering}p{1.1in}', 
                                '>{\\centering}p{1.1in}', 
                                '>{\\centering}p{1.1in}')    
}
#THREE MODELS 
if (n_models == 3) {
# Bind data from all three models together
base_summary = cbind(mngmt,mod1_summary, mod2_summary, mod3_summary)
    
    
# Transpose the dataframe to create the table and create data labels  
base_summary = as.data.frame(t(base_summary))
base_summary$names=c('Landings (mt)',
                     'Total Est. Catch (mt)',
                     'OFL (mt)', 
                     'ACL (mt)',
                     
                     '(1-$SPR$)(1-$SPR_{50\\%}$)',
                     'Exploitation rate',
                     paste('Age ',min_age,' biomass (mt)',sep=''),
                     'Spawning Output',
                     '~95\\% CI',
                     'Depletion',
                     '~95\\% CI',
                     'Recruits',
                     '~95\\% CI',
                     
                     '(1-$SPR$)(1-$SPR_{50\\%}$)',
                     'Exploitation rate',
                     paste('Age ',min_age,' biomass (mt)',sep=''),
                     'Spawning Output',
                     '~95\\% CI',
                     'Depletion',
                     '~95\\% CI',
                     'Recruits',
                     '~95\\% CI',
                     
                     '(1-$SPR$)(1-$SPR_{50\\%}$)',
                     'Exploitation rate',
                     paste('Age ',min_age,' biomass (mt)',sep=''),
                     'Spawning Output',
                     '~95\\% CI',
                     'Depletion',
                     '~95\\% CI',
                     'Recruits',
                     '~95\\% CI')

base_summary$region = c('','','','',
                        'Model 1','Base Case','','','','','','','',
                        'Model 2','Base Case','','','','','','','',
                        'Model 3','Base Case','','','','','','','')

base_summary = base_summary[,c(12,11,1:10)]
colnames(base_summary) = c('Region','Quantity',seq(FirstYR,LastYR))

# Create the table
base_summary.table = xtable(base_summary, caption=c('Base case results summary.'), 
                                  label='tab:base_summary',digits=0) 
# Add alignment   
align(base_summary.table) = c('l',
                              'r',
                              'r', 
                              '>{\\centering}p{1.1in}', 
                              '>{\\centering}p{1.1in}', 
                              '>{\\centering}p{1.1in}', 
                              '>{\\centering}p{1.1in}', 
                              '>{\\centering}p{1.1in}', 
                              '>{\\centering}p{1.1in}', 
                              '>{\\centering}p{1.1in}', 
                              '>{\\centering}p{1.1in}', 
                              '>{\\centering}p{1.1in}', 
                              '>{\\centering}p{1.1in}')  
}
