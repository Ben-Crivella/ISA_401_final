# Check if required packages are installed
if(require(tidyquant)==FALSE) install.packages("tidyquant")
if(require(ggplot2)==FALSE) install.packages("ggplot2")
if(require(dplyr)==FALSE) install.packages("dplyr")
if(require(tidyr)==FALSE) install.packages("tidyr")

# Load the necessary libraries
library(tidyquant)
library(ggplot2)
library(dplyr)
library(tidyr)

# Pull data for Gold
gold_data <- tidyquant::tq_get("GC=F", from = "2020-01-01", to = Sys.Date())
# Pull data for S&P 500, BTC, ETH, and XRP
sp500_data <- tidyquant::tq_get("^GSPC", from = "2020-01-01", to = Sys.Date())
btc_data <- tidyquant::tq_get("BTC-USD", from = "2020-01-01", to = Sys.Date())
eth_data <- tidyquant::tq_get("ETH-USD", from = "2020-01-01", to = Sys.Date())
xrp_data <- tidyquant::tq_get("XRP-USD", from = "2020-01-01", to = Sys.Date())

# Normalize gold data
gold_data <- gold_data |> 
  mutate(adjusted = adjusted / first(adjusted)) |> 
  mutate(symbol = "Gold")

# Normalize other datasets
sp500_data <- sp500_data |> 
  mutate(adjusted = adjusted / first(adjusted)) |> 
  mutate(symbol = "S&P 500")

btc_data <- btc_data |> 
  mutate(adjusted = adjusted / first(adjusted)) |> 
  mutate(symbol = "BTC")

eth_data <- eth_data |> 
  mutate(adjusted = adjusted / first(adjusted)) |> 
  mutate(symbol = "ETH")

xrp_data <- xrp_data |> 
  mutate(adjusted = adjusted / first(adjusted)) |> 
  mutate(symbol = "XRP")
# Combine all datasets
all_data <- bind_rows(sp500_data, btc_data, eth_data, xrp_data, gold_data)

# Plot the data
ggplot(all_data, aes(x = date, y = adjusted, color = symbol)) +
  geom_line() +
  labs(title = "Normalized Price Changes Over Time",
       x = "Date",
       y = "Normalized Price (Base = 1)",
       color = "Asset") +
  theme_minimal()
  



ggplot(all_data, aes(x = date, y = adjusted, color = symbol)) +
  geom_line() +
  scale_y_log10() +
  labs(title = "Growth Over Time (Logarithmic Scale)",
       x = "Date",
       y = "Adjusted Price (Log Scale)",
       color = "Asset") +
  theme_minimal()

head(all_data)
