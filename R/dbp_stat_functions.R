
library(tidyverse)
library(REdaS)

geom_bar_cnt <- function(df, col){
    df %>% 
        count_(col) %>% 
        mutate(
            per = n/sum(n),
            labely = per+0.02, 
            labelt = percent(per)
            ) %>% 
        mutate(col = fct_reorder(as.factor(col), desc("n"))) %>% 
        ggplot(aes_string(x = col, fill = col, y="per")) +
        geom_bar(stat =  "identity", color = "black") +
        geom_text(aes_string(x = col, y = "labely", label = "labelt")) +
        scale_y_continuous(labels = percent)+
        labs(
            y = "",
            x = ""
        )+
        guides(fill=FALSE)
}

get_tolvprvh <- function(sph, cyl){
    s <- pmax(abs(sph), abs(sph+cyl))
    0.25 + 0.1*s
}

get_tolvprvv <- function(sph, cyl){
    s <- pmax(abs(sph), abs(sph+cyl))
    0.25 + 0.05*s
}

extrapolate_prvh <- function(prvh, prvv, sph, cyl, axDeg, dx, dy, dtDeg){
    se <-  sph + cyl/2
    cplus <-  cyl/2*cos(2*deg2rad(axDeg))
    ccros <-  cyl/2*sin(2*deg2rad(axDeg))
    prvh_extr_1 <- prvh + (-se + cplus)*dx/10 + ccros*dy/10
    prvv_extr_1 <- prvv + ccros*dx/10 + (-se - cplus)*dy/10
    cos(deg2rad(dtDeg)) * prvh_extr_1 + sin(deg2rad(dtDeg)) * prvv_extr_1
}


extrapolate_prvv <- function(prvh, prvv, sph, cyl, axDeg, dx, dy, dtDeg){
    se <-  sph + cyl/2
    cplus <-  cyl/2*cos(2*deg2rad(axDeg))
    ccros <-  cyl/2*sin(2*deg2rad(axDeg))
    prvh_extr_1 <- prvh + (-se + cplus)*dx/10 + ccros*dy/10
    prvv_extr_1 <- prvv + ccros*dx/10 + (-se - cplus)*dy/10
    -sin(deg2rad(dtDeg)) * prvh_extr_1 + cos(deg2rad(dtDeg)) * prvv_extr_1
}

cylv_diff <- function(cyl1, ax1Deg, cyl2, ax2Deg){
    sqrt(
        (cyl1*cos(2*deg2rad(ax1Deg))-cyl2*cos(2*deg2rad(ax2Deg)))^2+
        (cyl1*sin(2*deg2rad(ax1Deg))-cyl2*sin(2*deg2rad(ax2Deg)))^2
    )
}
