
## Test using R 
# Because useful

# printing from script 
print("Hello World")

# installing a package
install.packages("tidyverse")

# load a package
library(tidyverse) # name after line the action

# make a demographics table

df <- tibble(
  name = "Nyssa",
  age = "29",
  eye_color = "blue",
  driver = "yes",
  height = "168",
  units = "cm",
  favorite_pet = "cat"
)

view(df)
print(df)
head(df)
summary(df)

write_csv(df,
          "C:/Users/nynat/Documents/GitHub/cautious-giggle/other/h2l2c/20230724_h2l2c_nyssa_demographics_table.csv")

## wrong direction
# C:\Users\nynat\Documents\GitHub\cautious-giggle\other\h2l2c







