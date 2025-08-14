setwd("/Users/sethwatts/Dropbox (Personal)/MAIN/hugo-website")

# Define paths
src_dir <- "content/courses/crime-control-strat-2025/slides"
dst_dir <- "public/courses/crime-control-strat-2025/slides"

# Ensure output dir exists
dir.create(dst_dir, recursive = TRUE, showWarnings = FALSE)

# List all Rmd files in the source folder
rmd_files <- list.files(src_dir, pattern = "\\.Rmd$", full.names = TRUE)

# Render each .Rmd in place
for (f in rmd_files) {
  cat("Rendering:", f, "\n")
  tryCatch({
    rmarkdown::render(f)
  }, error = function(e) {
    message("❌ Error in ", f, ": ", e$message)
  })
}

# Copy everything from source to public (HTML, images, libs, CSS, etc.)
cat("Copying all slide assets...\n")
file.copy(
  from = list.files(src_dir, full.names = TRUE),
  to = dst_dir,
  recursive = TRUE,
  overwrite = TRUE
)

# syllabus 

# Define paths
src_dir <- "content/courses/crime-control-strat-2025/syllabus"
dst_dir <- "public/courses/crime-control-strat-2025/syllabus"

# Ensure output dir exists
dir.create(dst_dir, recursive = TRUE, showWarnings = FALSE)

# List all Rmd files in the source folder
rmd_files <- list.files(src_dir, pattern = "\\.Rmd$", full.names = TRUE)

# Render each .Rmd in place
for (f in rmd_files) {
  cat("Rendering:", f, "\n")
  tryCatch({
    rmarkdown::render(f)
  }, error = function(e) {
    message("❌ Error in ", f, ": ", e$message)
  })
}

# Copy everything from source to public (HTML, images, libs, CSS, etc.)
cat("Copying all slide assets...\n")
file.copy(
  from = list.files(src_dir, full.names = TRUE),
  to = dst_dir,
  recursive = TRUE,
  overwrite = TRUE
)
