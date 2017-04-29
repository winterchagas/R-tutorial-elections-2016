library(gsubfn)
library(proto)
library(RSQLite)
library(sqldf)
library(tcltk)

#Set work directory
setwd("C:/Users/winter/Desktop/UCSC/Data Analysis/Datasets/Elections - Work on this copy")

votes <- read.csv('votes.csv')
education <- read.csv('Education.csv')
population <- read.csv('PopulationEstimates.csv')
poverty <- read.csv('PovertyEstimates.csv')
unemployment <- read.csv('Unemployment.csv')
crime <- read.csv('CrimeData.csv', sep = "\t")

names(votes)
head(poverty)
str(unemployment)
head(education)
head(crime)

election <- sqldf(
  'select vot.FIPS `countyID` , vot.county_name `county`
  , vot.state_abbr `state`, vot.votes_dem_2016 `votes_dem`
  , vot.votes_gop_2016 `votes_gop`
  , vot.total_votes_2016 `votes_total`
  , vot.Clinton `Clinton_points`, vot.Trump`Trump_points`
  , vot.per_point_diff_2016 `point_diff`
  , vot.diff_2016 `votes_diff`, vot.SEX255214 `female%`
  , vot.White + vot.RHI825214 `white`, vot.Black `black`
  , vot.RHI325214 `native`, vot.RHI425214 `asian`
  , vot.RHI525214 `hawaiian`, vot.RHI625214 `multiple_races`
  , vot.Hispanic `hispanic`, vot.POP645213 `foreign_born`
  , pov.PCTPOVALL_2015 `perc_poverty`
  , pov.MEDHHINC_2015 `household_income`
  , pop.POP_ESTIMATE_2015 `population_estimate`
  , une.Unemployment_rate_2015 `unemployment`
  , edu.less_high_school_2015 `less_than_hs`
  , edu.high_school_2015 `highschool`
  , edu.col_incomplete_2015 `associate`
  , edu.bachelors_2015 `bachelor_or_higher`
  , cri.MURDER, cri.RAPE, cri.ROBBERY, cri.AGASSLT
  , cri.BURGLRY, cri.LARCENY, cri.MVTHEFT , cri.ARSON
  from votes vot, poverty pov, population pop, unemployment une
    , education edu, crime cri
  where vot.FIPS = pov.FIPStxt and vot.FIPS = une.FIPStxt
  and vot.FIPS = pop.FIPS and vot.FIPS = edu.FIPS
  and vot.FIPS = cri.X||rightstr("000" || cri.FIPS_CTY, 3)
  and vot.state_abbr not in ("AK","PR")')

head(election)
write.csv(election, file = "Election1.csv")
