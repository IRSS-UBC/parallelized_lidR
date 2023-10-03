# Parallelized lidR

Disclaimer: This code is presented as an alternative method to the built in parallelization offered in the lidR package. There are several methods in the LAS catalog processing engine that support parallelization that are described in the following links:

https://r-lidar.github.io/lidRbook/engine.html
---
https://tgoodbody.github.io/lidRtutorial/08_engine2.html

Specifically for working with clipped plot point clouds:
https://tgoodbody.github.io/lidRtutorial/07_engine.html#independent-files-e.g.-plots-as-catalogs

![parallel_vs_serial](parallel_vs_serial_computing.png)

Simple example of how to perform a function in parallel with the [lidR](https://r-lidar.github.io/lidRbook/) package. This is particularly useful in situations where you need to apply functions to small disconnected las/laz files (i.e., not a full tile processed as a las catalog).

**clean_las.R** is the function you want to parallelize

**parallelize_lidR.R** is the script which runs the function in parallel

While there are several options for parallelization in R, this approach uses the [parallel](https://bookdown.org/rdpeng/rprogdatascience/parallel-computation.html) package.


