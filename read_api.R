library(tidyverse) 
library(httr)
library(jsonlite)

# Setting Up the Path to retrieve 

path <- "https://data.police.uk/api/crimes-street/burglary?"

# Creating API request 
# We will use GET function from httr Package and set tjhe list of parameters
request <- GET(url = path, 
               query = list(
                   lat = 53.421813,
                   lng = -2.330251,
                   date = "2018-05")
)

# check the status of the request (if there is error it will return an error with non-200)
request$status_code

#now we parese the content returned from the server as text using content function
response <- content(request, as = "text", encoding = "UTF-8")

# now we parse the JASON content to data Frame 
df <- fromJSON(response, flatten = TRUE) %>% 
    data.frame()

# Now we select the required variables.
df <- select(df,
             month, category, 
             location = location.street.name,
             long = location.longitude,
             lat = location.latitude)
# Print data
print(df)