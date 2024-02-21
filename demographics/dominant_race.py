import requests         
from bs4 import BeautifulSoup
import sys
import csv
import re
import time
import random
import pandas as pd

def overall(city_url, base_url):
    full_urls = get_neighborhood_url(base_url, city_url)
    souped_pages = get_neighborhood_souptxt(full_urls)
    dominant_race = get_neighborhood_domininant_race(souped_pages)
    neighborhood_name = get_neighborhood_name(full_urls)
    city_name = extract_city_name_from_url(city_url)
    get_dominant_csv(city_name, neighborhood_name, dominant_race)



city_url_nyc = "https://www.city-data.com/nbmaps/neigh-New-York-New-York.html"
city_url_la = "https://www.city-data.com/nbmaps/neigh-Los-Angeles-California.html"
city_url_chicago = "https://www.city-data.com/nbmaps/neigh-Chicago-Illinois.html"
base_url = "https://www.city-data.com"
dominant_race_chicago_csv = overall(city_url_chicago, base_url)
dominant_race_nyc_csv = overall(city_url_nyc, base_url)
dominant_race_la_csv = overall(city_url_la, base_url)



###Auxiliary Function：
def get_neighborhood_url(base_url, city_url):
    response = requests.get(city_url)
    soup = BeautifulSoup(response.text, "html.parser")
    links = []
    for element in soup.find_all("div", class_="neighborhood"):
        for link in element.find_all('a', href=lambda href: href and "neighborhood" in href): 
            links.append(link['href'])
    full_urls = [(base_url + link) for link in links]
    return full_urls

def get_neighborhood_souptxt(full_urls):
    requested_pages = []
    for index, full_url in enumerate(full_urls):            
        requested_url = requests.get(full_url)                              
        requested_url_txt = requested_url.text                   
        time.sleep(random.randint(1, 2))                         
        requested_pages.append(requested_url_txt)
    souped_pages = []
    for requested_page in requested_pages:    
        souped_page = BeautifulSoup(requested_page, 'html.parser')   
        souped_pages.append(souped_page)
    return souped_pages

def get_neighborhood_domininant_race(souped_pages):
    dominant_race = []
    for soup in souped_pages:
        race_info = soup.find('span', class_='badge alert-info')
        if race_info:
            dmn_race = race_info.find_next('b').get_text(strip=True)
        else:
            dmn_race = None 
        dominant_race.append(dmn_race)
    return(dominant_race)

def get_neighborhood_name(full_urls):
    neighborhood_name = []
    pattern = re.compile(r'-(Los-Angeles-CA|New-York-NY|Chicago-IL)\.html$')
    for url in full_urls:
        name = pattern.sub('', url.split('/')[-1])
        name = name.replace('-', ' ')
        neighborhood_name.append(name)
    return neighborhood_name

def extract_city_name_from_url(city_url):
    pattern = re.compile(r'neigh-(.*?)-(New-York|California|Illinois)\.html')
    
    match = pattern.search(city_url)
    if match:
        city_name_with_dashes = match.group(1)
        city_name = city_name_with_dashes.replace('-', ' ')
    return city_name

def get_dominant_csv(city_name, neighborhood_name, dominant_race):
    df = pd.DataFrame(list(zip(neighborhood_name, dominant_race)), 
                      columns=['Neighborhood Name', 'Dominant Race'])
    filename = f'C:/Users/13945/Desktop/data mgmt/umai/neighborhood_dominant_race_{city_name}.csv'
    df.to_csv(filename, index=False)

def overall(city_url, base_url):
    full_urls = get_neighborhood_url(base_url, city_url)
    souped_pages = get_neighborhood_souptxt(full_urls)
    dominant_race = get_neighborhood_domininant_race(souped_pages)
    neighborhood_name = get_neighborhood_name(full_urls)
    city_name = extract_city_name_from_url(city_url)
    get_dominant_csv(city_name, neighborhood_name, dominant_race)


