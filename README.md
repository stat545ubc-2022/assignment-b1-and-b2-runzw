
<!-- README.md is generated from README.Rmd. Please edit that file -->

# count.by.time

<!-- badges: start -->
<!-- badges: end -->

The goal of count.by.time is to provide a function to count the
occurrence of data observations by multiple time frames

## Installation

You can install the development version of count.by.time from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("stat545ubc-2022/assignment-b1-and-b2-runzw")
#> Downloading GitHub repo stat545ubc-2022/assignment-b1-and-b2-runzw@HEAD
#> cli        (3.3.0 -> 3.4.1) [CRAN]
#> vctrs      (0.4.1 -> 0.5.1) [CRAN]
#> tidyselect (1.1.2 -> 1.2.0) [CRAN]
#> lifecycle  (1.0.2 -> 1.0.3) [CRAN]
#> cpp11      (0.4.2 -> 0.4.3) [CRAN]
#> purrr      (0.3.4 -> 0.3.5) [CRAN]
#> lubridate  (1.8.0 -> 1.9.0) [CRAN]
#> Installing 7 packages: cli, vctrs, tidyselect, lifecycle, cpp11, purrr, lubridate
#> Installing packages into 'C:/Users/wrZZZZZ/AppData/Local/Temp/RtmpAnkyr8/temp_libpath4e7832531aad'
#> (as 'lib' is unspecified)
#> 
#>   There is a binary version available but the source version is later:
#>       binary source needs_compilation
#> vctrs  0.5.0  0.5.1              TRUE
#> 
#> package 'cli' successfully unpacked and MD5 sums checked
#> package 'tidyselect' successfully unpacked and MD5 sums checked
#> package 'lifecycle' successfully unpacked and MD5 sums checked
#> package 'cpp11' successfully unpacked and MD5 sums checked
#> package 'purrr' successfully unpacked and MD5 sums checked
#> package 'lubridate' successfully unpacked and MD5 sums checked
#> 
#> The downloaded binary packages are in
#>  C:\Users\wrZZZZZ\AppData\Local\Temp\RtmpmAW0X6\downloaded_packages
#> installing the source package 'vctrs'
#>          checking for file 'C:\Users\wrZZZZZ\AppData\Local\Temp\RtmpmAW0X6\remotes56483bf16131\stat545ubc-2022-assignment-b1-and-b2-runzw-3ddc5a4/DESCRIPTION' ...  ✔  checking for file 'C:\Users\wrZZZZZ\AppData\Local\Temp\RtmpmAW0X6\remotes56483bf16131\stat545ubc-2022-assignment-b1-and-b2-runzw-3ddc5a4/DESCRIPTION'
#>       ─  preparing 'count.by.time':
#>    checking DESCRIPTION meta-information ...     checking DESCRIPTION meta-information ...   ✔  checking DESCRIPTION meta-information
#>       ─  checking for LF line-endings in source and make files and shell scripts
#>   ─  checking for empty or unneeded directories
#>       ─  building 'count.by.time_0.1.0.tar.gz'
#>      
#> 
#> Installing package into 'C:/Users/wrZZZZZ/AppData/Local/Temp/RtmpAnkyr8/temp_libpath4e7832531aad'
#> (as 'lib' is unspecified)
```

## Example

This is a basic example that shows you how to count the number of tree
planted in different years/months/days based on vancouver_trees dataset.

``` r
library(datateachr)
library(dplyr)
library(tidyr)
library(lubridate)
#> Warning: package 'lubridate' was built under R version 4.2.2
#> Warning: package 'timechange' was built under R version 4.2.2
library(count.by.time)
(count_by_time(datateachr::vancouver_trees, "date_planted", "year"))
#> # A tibble: 31 × 2
#> # Groups:   time [31]
#>    time  count
#>    <chr> <int>
#>  1 1989    300
#>  2 1990   1145
#>  3 1991    579
#>  4 1992   1759
#>  5 1993   2128
#>  6 1994   1879
#>  7 1995   2912
#>  8 1996   3079
#>  9 1997   2778
#> 10 1998   3581
#> # … with 21 more rows
(count_by_time(datateachr::vancouver_trees, "date_planted", "month"))
#> # A tibble: 12 × 2
#> # Groups:   time [12]
#>    time  count
#>    <chr> <int>
#>  1 Apr    6815
#>  2 Aug      87
#>  3 Dec    8502
#>  4 Feb   12988
#>  5 Jan   12138
#>  6 Jul     170
#>  7 Jun     516
#>  8 Mar   12299
#>  9 May    1549
#> 10 Nov   12184
#> 11 Oct    2688
#> 12 Sep     127
(count_by_time(datateachr::vancouver_trees, "date_planted", "day"))
#> # A tibble: 31 × 2
#> # Groups:   time [31]
#>    time  count
#>    <chr> <int>
#>  1 01     2259
#>  2 02     2446
#>  3 03     2551
#>  4 04     2438
#>  5 05     2482
#>  6 06     2425
#>  7 07     2284
#>  8 08     2493
#>  9 09     2250
#> 10 10     2407
#> # … with 21 more rows
```
