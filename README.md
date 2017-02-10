# Network-Pinger
Intended to be "set and forget": Takes a list of IP's and continuously loops through, checking for network presence and outputting an updated CSV with number of successes, number of runs, and last successful date for each IP. Can be set to run for a period of time, or until selected to stop.

# Dependencies
  > network.csv: an example is included. Be warned that the program expects the header to be set up, even on the first go round. In my own use, I had the IP list as an output from a different source, and so took advantage of needing to organize it from that source anyway. The initial creation of this might be something I want to go back and look at.
  
# Use
  > This program creates a temp.csv as a copy of the most recent run while writing new info to network.csv. BE Warned: breaks if you have either of the csv's open when it attempts to open or close them. 
  > Since normal run time is pretty long if you have 1,000+ addresses, it should be reasonable to open network.csv to see how close the program is to opening/closing, then peruse temp.csv to get a full summary of the most recently updated full run.
  > At program initialization, message boxes will prompt for choice of date or run until. Date explains itself pretty well, and will end itself at midnight the morning of the set day. If you choose to run until, a box will pop up for five minutes at the end of each full check-through. If "no, don't halt" is selected, or the five minutes expires, the program will start throught the list again from the top. If "yes, halt" is selected, the program will end.
