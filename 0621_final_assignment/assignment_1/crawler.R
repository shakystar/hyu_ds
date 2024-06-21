# 모바일 HTML 파싱해보니, POST 문으로 충분히 크롤링 가능

library(httr)
library(rvest)
library(RSQLite)

parse_data <- function (quote_html) {
  numbers <- quote_html %>%
    html_nodes('div.bx_lotto_winnum') %>%
    html_nodes('span') %>%
    html_text()

  numbers_int <- as.integer(numbers[1:6])
  bonus <- as.integer(numbers[8])
  
  data <- list(numbers = numbers_int, bonus = bonus)
  
  return (data)
}

save_data_to_sqlite <- function() {
  # SQLite 데이터베이스 연결
  db <- dbConnect(SQLite(), dbname = "lottery_results.sqlite")
  
  # 테이블 생성
  dbExecute(db, "CREATE TABLE IF NOT EXISTS results (drwNo INTEGER, number1 INTEGER, number2 INTEGER, number3 INTEGER, number4 INTEGER, number5 INTEGER, number6 INTEGER, bonus INTEGER)")
  
  # 데이터 수집 및 저장
  drwNo <- 1
  repeat {
    # drwNo가 데이터베이스에 존재하는지 확인
    exists <- dbGetQuery(db, "SELECT EXISTS(SELECT 1 FROM results WHERE drwNo = ?)", params = list(drwNo))
    
    if (exists[1, 1] == 1) {
      # 이미 존재하면 다음 drwNo로 넘어감
      drwNo <- drwNo + 1
      next
    }
    
    # 진행 상황 출력
    cat(paste("drwNo", drwNo, "회차 크롤링 ...", "\r"))
    flush.console()
    
    url <- 'https://m.dhlottery.co.kr/gameResult.do?method=byWin'
    quote <- POST(url, body = list(drwNo = drwNo))
    quote_html <- read_html(quote)
    
    data <- parse_data(quote_html)
    
    # NA 값이 나올 때까지 루프
    if (is.na(data$bonus)) {
      break
    }
    
    # 데이터베이스에 저장
    dbExecute(db, "INSERT INTO results (drwNo, number1, number2, number3, number4, number5, number6, bonus) VALUES (?, ?, ?, ?, ?, ?, ?, ?)",
              params = c(drwNo, data$numbers, data$bonus))
    
    # drwNo 값을 증가
    drwNo <- drwNo + 1
    
    # 잠시 대기 (예: 서버에 과부하 방지를 위해)
    Sys.sleep(3)
  }

  # 데이터베이스 연결 종료
  dbDisconnect(db)
}

save_data_to_sqlite()
