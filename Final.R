rm(list=ls())
setwd("D:/Project1/Dataset of an actual motor vehicle insurance portfolio")

a <- readxl::read_xls("motor_ins.xls")
b <- read.csv("sample_type_claim.csv")

# Information related to some categorical variables from motor insurance dataset:

# 1) Distribution channel: 0 = Agent; 1 = Insurance brokers
# 2) Payment: 0 = Annually; 1 = Half-yearly
# 3) Risk type: 1 = motorbikes; 2 = vans; 3 = Passenger cars; 4 = Agricultural vehicles
# 4) Area: 0 = Rural; 1 = Urban
# 5) Second driver: 0 = One driver; 1 = Multiple regular drivers

# As the dataset originates from a Spanish Institute, all monetary values are 
# assumed to be in EURO.


summary(a)

# Now we can get a quick glimpse of the all the variables present in motor insurance 
# dataset. We can derive the following insights from the summary: 

# > This dataset involves 32582 distinct policyholders as evident by the 
# max value of ID variable. 

# > Excluding outliers, each policyholder has approximately 1-2 policies in force.

# > The premium amount ranges from approximately 40-3000 EUR per year while the 
# median premium amount is around 300 EUR. 

# > Claim history suggests that approximately 2-3 claims are made during the entire duration of a policy. 

# > As at 31-12-2019, the average market value of insured vehicles stands at 18260 EUR.


# > We will now be calculating policyholder age, vehicle age, license age and policy 
# duration using 31-12-2019 as the base date (latest date mentioned in the dataset).

a$Date_start_contract <- as.Date(a$Date_start_contract)
a$Date_last_renewal <- as.Date(a$Date_last_renewal)
a$Date_next_renewal <- as.Date(a$Date_next_renewal)
a$Date_birth <- as.Date(a$Date_birth)
a$Date_driving_licence <- as.Date(a$Date_driving_licence)
df$vehicle_reg_date <- as.Date(paste0(a$Year_matriculation, "-01-01"))


base_date <- "2019-12-31"

base_date <- as.Date(base_date)

a$age <- as.numeric(difftime(base_date, a$Date_birth, units = "days" )) / 365.25
a$age <- floor(a$age)

# Using 365.25, to account for leap years, in line with the actuarial practice.

a$driver_exp <- as.numeric(difftime(base_date, a$Date_driving_licence, units = "days"))/365.25 
a$driver_exp <- floor(a$driver_exp)

a$policy_dur <- as.numeric(difftime(base_date, a$Date_start_contract, units = "days"))/365.25 

a$vehicle_age <- as.numeric(difftime(base_date, a$Year_matriculation, units = "days"))/365.25

summary(a$vehicle_age)

