* Lab 3

* In this lab we will continue to explore the
* Stanford Open Policing Project Data

* Where you see XX, you need to delete XX and replace with the relevant code

*********
* Part 1: Workflow 
*********

* 1. change working directory to location of data 
cd "C:\Users\schwa\Desktop\UCSD Undergrad\Spring '23\ECON 5\Labs\Lab3"

********
* Part 2: Merging Data
********

* Our data comes in two separate files 
* File 1: stops_driver_chars.dta contains characteristics of drivers that are stopped
* File 2: stops_searches.dta contains information about searches. In some traffic
* stops officers decide to search the vehicle or person for contraband. This 
* file contains information on whether a search was conducted, and if so, whether
* contraband was found 

* 1. Load in stops_driver_chars.dta
use stops_driver_chars.dta, clear

* 2. describe the data and look through the variables (we will eventually need to choose a variable to merge the data)
describe

* 3. Load in stops_searches.dta
use stops_searches.dta, replace

* 4. describe the data and take note of the variables
describe

* 5. Based on the variables in the dataset, what variable do you think you should
* merge the two datasets together?
* A: stop_id

* Next we will merge the two datasets together

* 6. load in one of the two datasets
use stops_driver_chars.dta, clear

* 7. use the merge command to combine the datasets
merge 1:m stop_id using stops_searches.dta

*******
* Part 3: Building the Analysis datasets
*******

* 1. We only want stops that are in both the driver characteristics data 
* and the searches data. Keep only stops that are in both datasets
merge 1:m stop_id using stops_searches.dta, keep(match) nogen

* 2. Drop any new variables that were created in the merge command, given 
* we will not need them anymore 
drop _merge

* 3. Generate a variable that is equal to 1 if search_conducted 
* is equal to TRUE and 0 if search_conducted is equal to FALSE
gen search_flag = cond(search_conducted == "TRUE", 1, 0)

* 4. What fraction of stops end in search overall 
sum search_flag
*4.4%

********
* Part 4: Bar Graph 
********

ssc install blindschemes
set scheme plotplainblind

* 1. Create  bar graph that shows search rates by race 

graph bar (count) search_flag, over(subject_race) ///
	title("Search Rates by Race") ///
	ytitle("Count of Stops") ///
	
	
********
* Part 5: Bonus/Optional
********

* 1. Restrict data only to stops in which a search was conducted
keep if search_conducted == "TRUE"

* 2. Create a bar graph that shows the fraction of searches that
* resulted in contraband found (by the race of the driver). 
graph bar (count), over(subject_race) ///
	title("Fraction of Searches with Contraband Found by Driver Race") ///
	ytitle("Fraction of Searches with Contraband Found") ///






	






 

