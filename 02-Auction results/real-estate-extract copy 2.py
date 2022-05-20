from selenium import webdriver
from selenium.webdriver.common.keys import Keys

driver = webdriver.Chrome('C:\Users\willw\Downloads\chromedriver_win32\chromedriver.exe')

driver.get("https://www.python.org")

print(driver.title) 

driver.close()python -c "import selenium; print(selenium.__version__)"