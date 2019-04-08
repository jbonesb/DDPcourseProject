Prediction on mtcars with linear regression
========================================================
author: Sergey Bogdanov
date: 08/04/2019
autosize: true

Task Description
========================================================
This is the simply prediction app that use linier regression model to predict Horsepower based on Miles per Gallon from mtcars dataset.

You can control several options:
- Use slider to select MPG for prediction
- Switch on/off models visualisation on plot
- Select some points on plot to produce Model 1 prediction on this points


Dataset
========================================================


```r
head(mtcars)
```

```
                   mpg cyl disp  hp drat    wt  qsec vs am gear carb
Mazda RX4         21.0   6  160 110 3.90 2.620 16.46  0  1    4    4
Mazda RX4 Wag     21.0   6  160 110 3.90 2.875 17.02  0  1    4    4
Datsun 710        22.8   4  108  93 3.85 2.320 18.61  1  1    4    1
Hornet 4 Drive    21.4   6  258 110 3.08 3.215 19.44  1  0    3    1
Hornet Sportabout 18.7   8  360 175 3.15 3.440 17.02  0  0    3    2
Valiant           18.1   6  225 105 2.76 3.460 20.22  1  0    3    1
```

For more information visit
<https://www.rdocumentation.org/packages/datasets/versions/3.5.3/topics/mtcars>

Model Description
========================================================
Application use two regression models that have following characteristics.

```r
    mtcars$mpgsp <- ifelse(mtcars$mpg - 20 > 0, mtcars$mpg - 20, 0)
    model1 <- lm(hp ~ mpg, data = mtcars)
    model2 <- lm(hp ~ mpgsp + mpg, data = mtcars)    
```

```r
    model1$coefficients
```

```
(Intercept)         mpg 
 324.082314   -8.829731 
```

```r
    model2$coefficients
```

```
(Intercept)       mpgsp         mpg 
 408.014115    8.483785  -14.019533 
```


Result Visualisation
========================================================
Application results are demonstrated in plot, that looks like one on the slide.

![plot of chunk unnamed-chunk-4](MyReproduciblePitchPresentation-figure/unnamed-chunk-4-1.png)
