from selenium import webdriver
from selenium.webdriver.common.by import By
import time

from selenium.webdriver.chrome.options import Options
chrome_options = Options()
chrome_options.add_experimental_option("detach", True)

web = webdriver.Chrome(options=chrome_options)
web.get('https://numeral-systems.com/ieee-754-add/')



A = ['01000001110010101100001010010000','01010100001111000110101010000000','01001000000110111010010111100100','01010001100011110101110000101001','01001000110010101100000010000100']
B = ['01000001110010101100001010010000','01010100001111000110101010000000','01001000000110111010010111100100','01010001100011110101110000101001','01001000110010101100000010000100']


Cookies = web.find_element(By.XPATH,'//*[@id="cookie-banner-buttons-container"]/button[2]')
input_1 = web.find_element(By.XPATH,'//*[@id="number-input-1"]')
input_2 = web.find_element(By.XPATH,'//*[@id="number-input-2"]')
Submit = web.find_element(By.XPATH,'//*[@id="submit-button"]')

Cookies.click()

for i in range(len(A)):
    input_1.send_keys(A[i])
    input_2.send_keys(B[i])

    # time.sleep(0.001)
    Submit.click()

    # time.sleep(0.001)
    Output = web.find_element(By.XPATH,'//*[@id="result-path-container"]/div[8]')
    print(Output.text)

    input_1.clear()
    input_2.clear()
