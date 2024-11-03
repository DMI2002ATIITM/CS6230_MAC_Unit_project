from selenium import webdriver
from selenium.webdriver.common.by import By
import time

from selenium.webdriver.chrome.options import Options
chrome_options = Options()
chrome_options.add_experimental_option("detach", True)

web = webdriver.Chrome(options=chrome_options)
web.get('https://numeral-systems.com/ieee-754-add/')

file = open("Padded_negAB_output.txt","r")
AB = file.readlines()
file.close()

file = open("negC_binary.txt","r")
C = file.readlines()
file.close()

file = open("NN_MAC_binary.txt","w")


Cookies = web.find_element(By.XPATH,'//*[@id="cookie-banner-buttons-container"]/button[2]')
input_1 = web.find_element(By.XPATH,'//*[@id="number-input-1"]')
input_2 = web.find_element(By.XPATH,'//*[@id="number-input-2"]')
Submit = web.find_element(By.XPATH,'//*[@id="submit-button"]')

Cookies.click()


for i in range(len(AB)):
    input_1.send_keys(AB[i])
    input_2.send_keys(C[i])

    Submit.click()
    # time.sleep(5)
    Output = web.find_element(By.XPATH,'//*[@id="result-path-container"]/div[8]')
    file.write(Output.text+"\n")
    print(f"Done {i+1}  {Output.text}")

    input_1.clear()
    input_2.clear()

file.close()
print("FINISHED!!!")
