library(tercen)
library(dplyr)
library(nlme)

do.mixed_model = function(df){
  aLme <- try(lme(.y ~ MainFactor, random = ~ 1| RepFactor, data = df), silent = TRUE)
  if (!inherits(aLme, "try-error")) {
    pMain <- anova(aLme)[2,4]
    delta <- as.numeric(fixef(aLme)[2])
  } else {
    pMain <- NaN
    delta <- NaN
  }
  return (data.frame(.ri      = df$.ri[1], 
                     .ci      = df$.ci[1], 
                     pMain    = pMain, 
                     logpMain = -log10(pMain), 
                     delta    = delta))
}

ctx = tercenCtx()

if (length(ctx$colors) != 1) stop("Need a single data color for the main factor.")

groupingType = ifelse(is.null(ctx$op.value('Grouping Variable')), 'categorical', ctx$op.value('Grouping Variable'))

data <- ctx %>% 
  select(.ci, .ri, .y, .x) %>%
  mutate(MainFactor = ctx$select(ctx$colors) %>% pull()) %>%
  rename(RepFactor = as.factor('.x'))

if (groupingType == 'categorical'){
  data <- data %>% mutate(MainFactor = as.factor(MainFactor))
} else {
  if (!is.numeric(data %>% pull(MainFactor))){
    stop("Grouping data can not be used as a numeric variable")
  }
}

data %>%
  group_by(.ci, .ri) %>%
  do(do.mixed_model(.)) %>%
  ctx$addNamespace() %>%
  ctx$save()
