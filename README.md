# ip_details

Purpose:
  The purpose of this project is to fetch the RAM usage and top processes consuming the memory.
 
Requirement:
  1. input.csv : The list of IPs with required number of top processes.

Assumption:
  1. The ssh keys are copied to the target server. 

Notes:
  1. I have used devopskey.pem as my ssh key.
  2. Output will be displayed and stored in output.txt
  3. If IP is not reachable or incorrect input provided in place of IP custom error message will be generated ("Server Unreachable: SSH Connection failed").
