install.packages(c("lidR", "parallel"))

library(parallel)

#Set up global vars
clean_las_fn_path <- "D:/Sync/IRSS_Github_Organization/parallelized_lidR/clean_las.R" 
in_dir <- "C:/Users/hseely/Downloads/test_in_dir"
out_dir <- "C:/Users/hseely/Downloads/test_out_dir"

#Set the number of cores you want to use (currently set to use 10% of CPU cores)
ncores <- round(detectCores()*0.1, 0) 
cat("Using", ncores, "CPU cores.")

#Test function on a single las without using parallel processing
source(clean_las_fn_path)

clean_las(las_fname = "NBGOV8692_train.las", 
          in_dir = in_dir, 
          out_dir = out_dir)

#Vectorize function
clean_las_parallel <- function(chunk, in_dir, out_dir, clean_las_fn_path) {
  source(clean_las_fn_path)
  out_chunk <- lapply(chunk, function(las_fname) {
    clean_las(las_fname, in_dir, out_dir)
  })
  return(out_chunk)
}


#Get vector of las filenames
las_fnames <- list.files(in_dir)

#Divide input filenames into chunks based assigned to each cpu core
chunks <- split(las_fnames, rep(1:ncores, length.out = length(las_fnames)))
print(chunks)

# Start a parallel cluster
cl <- makeCluster(ncores)

# Run the function in parallel
parLapply(cl, chunks, clean_las_parallel, in_dir=in_dir, out_dir=out_dir, clean_las_fn_path=clean_las_fn_path)

# Stop the parallel cluster
stopCluster(cl)
