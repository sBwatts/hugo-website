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

src_dir <- "content/courses/crime-control-strat-2025/syllabus"
dst_dir <- "public/courses/crime-control-strat-2025/syllabus"

dir.create(dst_dir, recursive = TRUE, showWarnings = FALSE)

rmd_files <- list.files(src_dir, pattern = "\\.Rmd$", full.names = TRUE)

for (f in rmd_files) {
  cat("Rendering (in-place):", f, "\n")
  pdf_path <- tryCatch({
    # render where the Rmd lives (no output_dir) to avoid LaTeX path bugs
    out <- rmarkdown::render(
      input  = f,
      output_format = "stevetemplates::syllabus",
      clean  = TRUE,
      envir  = new.env(parent = globalenv())
    )
    out  # returns the path to the PDF
  }, error = function(e) {
    stop("Render failed for ", f, " -> ", e$message)
  })
  
  # copy the PDF into public/
  file.copy(pdf_path, file.path(dst_dir, basename(pdf_path)), overwrite = TRUE)
  cat("Copied:", basename(pdf_path), "to", dst_dir, "\n")
}