**Project Goal & Summary**

Our project investigates which housing attributes and social resources are most valued within U.S. high-poverty neighborhoods (i.e. neighborhoods with a poverty rate over 20%). We chooses New York City, City of Los Angeles, and Chicago as the representative cities because they "contain the highest number of persistently poor neighborhoods over the past four dacades (Benzow, & Fikri, 2020)." This fact makes them the most appropriate cities for observing long-lasting patterns in how the U.S. low-income populations make housing-related decisions. Our goal is to identify key housing prices drivers and support evidence-based intervention housing policies. Specifically, we ask: What are the key drivers of housing prices in U.S. high-poverty neighborhoods?
To answer the question, we perform a two-level analysis. At the city-level, we distinguish the impact of housing and neighborhood attributes on housing prices. We further test our findings at the inter-city level to improve their validity and generalizability. Method-wise, we hope to inspire computational social scientists working with big data and map visualization to explore robust data processing and mapping tools for tackling large-scale research questions.

**Main findings:**

***At the inter-city level***

Neighborhood attributes weigh more than housing attributes as housing prices drivers in U.S. high-poverty neighborhoods. Specifically, in these neighborhoods, within our expectations, larger houses still command higher prices; young houses are still more popular than the old; Asians still tend to find good deals with lower housing prices. Unexpectedly, being closer to parks could mean higher exposure to risky events (e.g. robbery); people do not show more preference towards public transit (e.g. bus).

***At the city level***

The above findings hold true, but with Chicago showing a preference for single-family residential properties. Specifically, Chicago values single-family residential way more than NYC and LA; LA values business atmosphere more than Chicago and NYC; NYC places less emphasis on the convenience of getting to the hospital than Chicago and LA.

**Navigating this repo:**

***Data Source***

- Redfin -  A real estate company providing residential real estate brokerage and mortgage origination services. Since Redfin no longer permits web-scraping on their data, we found a feasible workaround. With a limitation of 350 records downloaded at a time, we used housing price as a controlling factor to download separate CSV data files from the website. Then we ran a Python code and used Pandas Dataframe to combine CSV file contents into one single dataset. By doing this, we ensure that we collect all the listing properties in the city on the day of collection and avoid possible duplicate data. Due to the nature of Redfin, we can only collect the listings on the day of collection. No historical data can be retrieved.
- City of Chicago(https://data.cityofchicago.org/) - The city of Chicago provides a data portal for infrastructural spatial data access. We will download shapefiles from this portal. Shapefile is the most popular data type for GIS software and analysis. Shapefiles can also be transformed from and to CSV files for more flexible data analysis. Chicago’s data portal provides access to different layers updated at different time points.
- NYC Open Data(https://opendata.cityofnewyork.us/) - Open Data is free public data published by New York City agencies and other partners.
- City of Los Angeles GeoHub(https://geohub.lacity.org/) - The GeoHub is the City's public platform for exploring, visualizing, and downloading location-based Open Data.
- City-Data(https://www.city-data.com/) - Free and open-source information website presenting annually updated information pertaining to U.S. cities, including detailed demographic data by neighborhood in New York City, City of Los Angeles, and Chicago. We plan to scrape population density, dominant race, and median age of high-poverty neighborhoods from the website.
- NYU Furman Center(https://furmancenter.org/neighborhoods), Poverty by city and community (arcgis)(https://www.arcgis.com/apps/dashboards/7846c3c37dff4728923609a9f55f849c), & Illinois Policy(https://www.illinoispolicy.org/black-brown-chicago-neighborhoods-endure-highest-poverty-rates/) - Three federal/local-government-backed platforms with poverty rate in the three cities by neighborhood.

***Library Version***
- 

***Responsibility***
- Progress Report: Xuewei Li & Kuang Sheng
- Data Collection & Cleaning: poverty rate - Xuewei Li; housing attributes - Kuang Sheng; neighborhood attributes - Xuewei Li & Tian Lan
- Data analysis: Tian Lan
- Data visualization: Kuang Sheng & Xuewei Li
- Presentation: Xuewei Li, Kuang Sheng, & Tian Lan
- Code video: Xuewei Li, Kuang Sheng, & Tian Lan
