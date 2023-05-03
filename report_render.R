## GNXS report render script
## Add info here
library(optparse)
option_list = list(
  make_option(c("-d", "--dir"), type="character", default=NULL,
              help="directory containing files to be used for workflow validation", metavar="character"))
opt_parser = OptionParser(option_list=option_list);
opt = parse_args(opt_parser)


#dir.create(paste0(opt$dir, "/validation_report"))
html_filename = paste0(opt$dir, "/validation_report.html")

# rmarkdown::render('~/USB/USB_Diagnostics/GNXS_reports/report.Rmd',
#                   params = list(diroi = opt$dir),
#                   output_file = html_filename)

rmarkdown::render('/home/ionadmin/github_app/workflow_validation/report.Rmd',
                  params = list(diroi = opt$dir),
                  output_file = html_filename)

