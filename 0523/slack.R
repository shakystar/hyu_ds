# library(slackr)
# 
# slackr_setup(
#   token = "xoxb-6760062601714-7155368936102-aQueR8rTv6ss8xdEHMMrN54W",
#   username = "slackR"
# )

# slackr_msg('Hello', channel = '#api_test')
# slackr_msg(Sys.time(), channel = '#api_test')


# library(taskscheduleR)
# 
# file_R = 'C:/Users/doomoolmori/Dropbox/lecture/send_time.R'
# taskscheduler_create(
#   taskname = "save_date",
#   rscript = file_R,
#   schedule = "MINUTE",
#   starttime = format(Sys.time() + 61, "%H:%M"),
#   startdate = format(Sys.time (), "%Y/%m/%d"),
#   modifier = 1
# )
# 
# taskscheduler_delete(taskname = "send_time")

# install.packages('miniUI')
# install.packages('shiny')
# install.packages('shinyFiles')
# install.packages('cronR')

library(googlesheets4)
gs4_auth("shakystar777@gmail.com")

(ss <- gs4_create("hanyang_ds", sheets = list(flowers = iris)))


data = read_sheet('https://docs.google.com/spreadsheets/d/1tRVRC3mLVOvD2GRnDS4TcJO7tkAYRHz0Rd-z_sNR7No/edit#gid=482776649')

data

data_2 = read_sheet('1tRVRC3mLVOvD2GRnDS4TcJO7tkAYRHz0Rd-z_sNR7No')

sheet_add(
  '1tRVRC3mLVOvD2GRnDS4TcJO7tkAYRHz0Rd-z_sNR7No',
  sheet = 'mtcars'
)

range_write(
  '1tRVRC3mLVOvD2GRnDS4TcJO7tkAYRHz0Rd-z_sNR7No',
  data = mtcars,
  sheet = 'mtcars',
)