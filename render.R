# This script builds both the HTML and PDF versions of your CV

# declare param inputs to render
sheet_ss_id <-  "11a0k5JRCjy0wSU3iNGDKU6tK2hjWH4AZwHJoegGSUME"
online_link <- "https://ctsmith12.github.io/resume/"
pdf_location <- "https://github.com/ctsmith12/resume/raw/main/resume.pdf"
# Knit the HTML version
rmarkdown::render("resume.rmd",
                  params = list(pdf_export = FALSE, 
                                sheet_ss_id = sheet_ss_id, 
                                online_link = online_link, 
                                pdf_location = pdf_location
                                ),
                  output_file = "index.html")


# Knit the PDF version to temporary html location
tmp_html_cv_loc <- fs::file_temp(ext = ".html")
rmarkdown::render("resume.rmd",
                  params = list(pdf_export = TRUE, 
                                sheet_ss_id = sheet_ss_id, 
                                online_link = online_link, 
                                pdf_location = pdf_location
                  ),
                  output_file = tmp_html_cv_loc)

# Convert to PDF using Pagedown
pagedown::chrome_print(input = tmp_html_cv_loc,
                       output = "resume_pre.pdf") 
pdftools::pdf_compress("resume_pre.pdf", output = "resume.pdf")

