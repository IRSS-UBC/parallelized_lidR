library(lidR)

# clean_las Function
# Description: Cleans and processes LIDAR data
# Input:
#   - las_fname: Input LAS filename
#   - in_dir: Directory containing input LAS files.
#   - out_dir: Directory where cleaned LAS files will be saved.

clean_las <- function(las_fname, in_dir, out_dir) {
  
  # Set the input file path
  input_las_filepath <- file.path(in_dir, las_fname)
  
  # Set the output file path
  output_las_filepath <- file.path(out_dir, las_fname)
  
  # Read LAS, filter duplicates, classify ground and noise, filter noise
  las <- readLAS(input_las_filepath)
  las <- filter_duplicates(las) 
  las <- classify_ground(las, algorithm = pmf(ws = 5, th = 3))
  las <- classify_noise(las, sor(9, 2))
  las <- filter_poi(las, Classification != 18L)
  
  # Perform ground classification and height normalization
  dtm <- grid_terrain(las, 1, knnidw()) 
  las <- normalize_height(las, dtm, method = "bilinear")
  
  # Save the cleaned LAS file in the final directory
  writeLAS(las, output_las_filepath)
  
}
