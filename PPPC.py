print('+++++++++++++++++++++++++++++++++++++++++++++++++++++++')
import pandas as pd
import numpy as np
from selenium import webdriver
from bs4 import BeautifulSoup
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC

import warnings
warnings.filterwarnings("ignore")

PPP = pd.DataFrame(index=range(0, 10), columns = {'주소', '공중전화'})

options = webdriver.ChromeOptions()
options.add_argument('headless')

path = 'C:/git/BBSOP/chromedriver.exe' # 크롬드라이버 경로 설정 BSS_Optimal_Position

source_url = "https://map.kakao.com/" # 리뷰주소 크롤링을 해 올 주소 설정

driver = webdriver.Chrome(executable_path=path, chrome_options=options)
driver.get(source_url)

search_bar = driver.find_element_by_xpath("//input[@id='search.keyword.query']") # 검색창 찾기
search_bar.send_keys('광명시 공중전화')
searchbutton = driver.find_element_by_xpath("//button[@id='search.keyword.submit']") # 검색 버튼 누르기
driver.execute_script("arguments[0].click();", searchbutton)
WebDriverWait(driver, 5).until(EC.presence_of_element_located((By.XPATH, '//*[@id="info.search.place.list"]')))

html = driver.page_source
soup = BeautifulSoup(html, "html.parser") # 페이지 소스 파싱
title = soup.select(".link_name") # CSS class값
addr = soup.select(".addr > p") # ID값


driver.find_element_by_css_selector("#info\.search\.place\.more")
WebDriverWait(driver, 5).until(EC.presence_of_element_located((By.XPATH, '//*[@id="info.search.place.list"]')))

html = driver.page_source
soup = BeautifulSoup(html, "html.parser") # 페이지 소스 파싱
title = soup.select(".link_name") # CSS class값
addr = soup.select(".addr > p") # ID값



driver.close()