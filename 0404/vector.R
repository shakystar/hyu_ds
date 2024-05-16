vec_integer = 8:17
vec_integer

vec_double = c(0.5, 0.6, 0.2) # combine
vec_double

vec_char = c('a', 'b', 'c')
vec_char

c('a', 'b', 'c', 1, 2, 3) # 상위 타입 : 문자
c(1, 2, 3, TRUE, FALSE) # 상위 타입 : 정수

v1 = 8:17
c(v1, 18:22)
v1[2]
v1[2:4]
v1[c(2, 4, 6)]

# 마이너스 기호를 입력하면, 해당 순서를 제외한 데이터가 추출된다.
v1[-1]
v1[-c(2, 4, 6, 8)]

v1 < 12
v1[v1 < 12]
v1[v1 < 12 | v1 > 15]
