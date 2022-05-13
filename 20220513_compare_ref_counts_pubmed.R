#library(devtools)
#install_github("ropensci/rentrez")
library(rentrez)
library(tidyverse)
library(glue)

{
start.time <- Sys.time()

year <- 1922:2022
neurot_stearch <- glue("neuro* AND toxic* AND {year}[PDAT]")
cardiot_stearch <- glue("cardi* AND toxic* AND {year}[PDAT]")
pulmt_stearch <- glue("(pulm* or respri*) AND toxic* AND {year}[PDAT]")
gast_stearch <- glue("gast* AND toxic* AND {year}[PDAT]")
allt_stearch <- glue("tox* AND {year}[PDAT]")
all_stearch <- glue("{year}[PDAT]")

nt_df <- tibble(year = year,
                neurot_stearch=neurot_stearch,
                cardiot_stearch=cardiot_stearch,
                pulmt_stearch=pulmt_stearch,
                gast_stearch=gast_stearch) %>% #,
                #allt_stearch=allt_stearch,
                #all_stearch=all_stearch) %>% 
  mutate(neurot = map_dbl(neurot_stearch, ~entrez_search(db="pubmed",term=.x)$count),
         cardiot = map_dbl(cardiot_stearch, ~entrez_search(db="pubmed",term=.x)$count),
         pulmt = map_dbl(pulmt_stearch, ~entrez_search(db="pubmed",term=.x)$count),
         gast = map_dbl(gast_stearch, ~entrez_search(db="pubmed",term=.x)$count))#,
         #allt = map_dbl(allt_stearch, ~entrez_search(db="pubmed",term=.x)$count),
        # all = map_dbl(all_stearch, ~entrez_search(db="pubmed",term=.x)$count))


nt_df %>% 
  select(year,neurot,cardiot,pulmt,gast) %>%
  filter(year != "2022") %>%
  pivot_longer(-year) %>%
  ggplot(aes(x=year, y = value,group=name,color=name)) + geom_line() + 
  labs(title = "Featured Organ Toxicities\nReferenced Over time") + 
  ylab("Cumulative PubMed Reference Count") +
  xlab("Year")


# 
# nt_df %>% 
#   select(year,neurot,allt,cardiot,pulmt,gast) %>%
#   filter(year != "2022") %>% 
#   mutate(rel_nt = 100 * neurot / allt,
#          rel_ct = 100 * cardiot / allt,
#          rel_pt = 100 * pulmt / allt,
#          rel_gt = 100 * gast / allt,
#          rel_al = 100 * allt / allt) %>%
#   select(year,rel_nt,rel_ct,rel_pt,rel_gt,rel_al) %>%
#   pivot_longer(-year) %>%
#   ggplot(aes(x=year, y = value,group=name,color=name)) + 
#   geom_line() +
#   scale_y_log10()



end.time <- Sys.time()
  total.time <- end.time - start.time
  print(total.time)

}



