
# 
# library(ggmap)
# 
# ##db[,geocode(Geography),Geography]
# 
# library(maps)
# ## mapStates = map("state", fill = TRUE, plot = FALSE)
# mapWord <- map('world', fill = TRUE,plot=FALSE)
# leaflet(data = mapWord) %>% addTiles() %>%
#   addPolygons(fillColor = topo.colors(10, alpha = NULL), stroke = FALSE)

#' Load data from Excel
#' 
#' @param path character Excel workbook path
#' @param sheet character sheet name default to RAW
#' @import XLConnect
#' @return data.table containing
#' \itemize{
#' \item {location}{thegeography locatioin}
#' }
#' @import data.table
#' @export 
load_data <- 
  function(path,sheet="RAW"){
    if (missing(path))
      path <- file.path("inst","data","database.xlsx")
    wb <- loadWorkbook(path)
    db <- readWorksheet(wb, sheet = "RAW")
    setDT(db)
    db[,list(location=gsub('^[0-9]+ ','',Geography),
             fund=Your_Fund,
             under=Fund_Investment,
             company=Company,
             part=Your_Fund_Percent,
             date=as.Date(As_Of_Date,"%d/%m/%Y"),
             industry=Industry,
             value=Total_Value_YF_Cur,
             cost=Total_Cost_YF_Cur)]
  }

