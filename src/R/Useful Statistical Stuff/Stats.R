# TAB
dataset %>%
  group_by(var) %>%
  summarise(n = n()) %>%
  mutate(totalN = (cumsum(n)),
         percent = round((n / sum(n)), 3),
         cumpercent = round(cumsum(freq = n / sum(n)), 3))