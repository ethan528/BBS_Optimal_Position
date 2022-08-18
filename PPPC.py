import pandas as pd
import numpy as np
from selenium import webdriver
from bs4 import BeautifulSoup
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
from selenium.webdriver.common.keys import Keys

import warnings
warnings.filterwarnings("ignore")

def title_text(title):
    title = [i.text for i in title]
    return title

def addr_text(addr):
    addr = [i.text for i in addr if i.text != '']
    return addr

PPP = pd.DataFrame(index=range(0, 10), columns = {'주소', '공중전화'})

options = webdriver.ChromeOptions()
options.add_argument('headless')
options.add_experimental_option("excludeSwitches", ["enable-logging"])
user_agent = 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/104.0.0.0 Safari/537.36'
options.add_argument('user-agent=' + user_agent)

path = 'C:/git/BBSOP/chromedriver.exe' # 크롬드라이버 경로 설정 BSS_Optimal_Position

source_url = "https://map.kakao.com/" # 리뷰주소 크롤링을 해 올 주소 설정


driver = webdriver.Chrome(executable_path=path, chrome_options=options)
driver.get(source_url)

driver.find_element_by_xpath("//input[@id='search.keyword.query']").send_keys('광명시 공중전화', Keys.ENTER) # 검색
WebDriverWait(driver, 5).until(EC.presence_of_element_located((By.XPATH, '//*[@id="info.search.place.list"]')))

html = driver.page_source
soup = BeautifulSoup(html, "html.parser") # 페이지 소스 파싱
title = soup.select(".link_name") # CSS class값
addr = soup.select(".addr > p") # ID값

print(title)
print('+++++++++++++++++++++++++++++++++++++++++++++++++++++++')
print(addr)
print('+++++++++++++++++++++++++++++++++++++++++++++++++++++++')

button = driver.find_element_by_xpath('//*[@id="info.search.place.more"]')
driver.execute_script("arguments[0].click();", button)
WebDriverWait(driver, 5).until(EC.presence_of_element_located((By.XPATH, '//*[@id="info.search.place.list"]')))

html = driver.page_source
soup = BeautifulSoup(html, "html.parser") # 페이지 소스 파싱
title = soup.select(".link_name") # CSS class값
addr = soup.select(".addr > p") # ID값

print(title)
print('+++++++++++++++++++++++++++++++++++++++++++++++++++++++')
print(addr)

driver.close()