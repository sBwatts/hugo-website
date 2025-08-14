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
static_dst <- "static/courses/crime-control-strat-2025/syllabus"

dir.create(static_dst, recursive = TRUE, showWarnings = FALSE)

rmd_files <- list.files(src_dir, pattern = "\\.Rmd$", full.names = TRUE)

for (f in rmd_files) {
  cat("Rendering in-place:", f, "\n")
  out_pdf <- rmarkdown::render(
    input = f,
    output_format = "stevetemplates::syllabus",
    clean = TRUE,
    envir = new.env(parent = globalenv())
  )
  
  # 1) Copy the good PDF into static/ (the source Hugo will publish)
  file.copy(out_pdf, file.path(static_dst, "syllabus.pdf"), overwrite = TRUE)
  cat("Copied to static:", file.path(static_dst, "syllabus.pdf"), "\n")
  
  # 2) Remove the PDF from content/ so it cannot overwrite during hugo build
  file.remove(out_pdf)
  cat("Removed content-side copy:", out_pdf, "\n")
}
