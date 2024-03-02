# %%
import pandas as pd
import matplotlib.pyplot as plt
import plotly.express as px
import geopandas as gpd
from shapely.geometry import MultiPolygon

# %%
# To import regression csv files as pandas dataframe

nyc_file_path = 'nyc_final_for_regression.csv'
lax_file_path = 'lax_final_for_regression.csv'
chi_file_path = 'chi_final_for_regression.csv'

NYC = pd.read_csv(nyc_file_path)
LAX = pd.read_csv(lax_file_path)
CHI = pd.read_csv(chi_file_path)

NYC.head() 


# %%
# Display mean housing price by neighborhood
NYC.groupby('neighborhood')['PRICE'].mean()

# %%
# Plot the graph for NYC and LAX

average_prices = NYC.groupby('neighborhood')['PRICE'].mean().reset_index()

average_prices_sorted = average_prices.sort_values(by='PRICE', ascending=False)

plt.figure(figsize=(10, 6))
plt.bar(average_prices_sorted['neighborhood'], average_prices_sorted['PRICE'])
plt.xlabel('Neighborhood')
plt.ylabel('Average Price')
plt.title('Average Price by Neighborhood (Descending)')
plt.xticks(rotation=90)
plt.tight_layout()
plt.show()


average_prices = LAX.groupby('neighborhood')['PRICE'].mean().reset_index()

average_prices_sorted = average_prices.sort_values(by='PRICE', ascending=False)

plt.figure(figsize=(10, 6))
plt.bar(average_prices_sorted['neighborhood'], average_prices_sorted['PRICE'])
plt.xlabel('Neighborhood')
plt.ylabel('Average Price')
plt.title('Average Price by Neighborhood (Descending)')
plt.xticks(rotation=90)
plt.tight_layout()
plt.show()

# %%
fnb_mean = LAX.groupby('neighborhood')['FnB_COUNTS'].mean() # Summarize FnB_COUNTS by neighborhood
fnb_mean

# %%
fnb = fnb_mean.to_frame(name='FnB_COUNTS')

# %%
# To create Mapbox Choropleth Maps using Plotly

gdf = gpd.read_file('LAX.geojson')

gdf.set_index('name', inplace=True)

merged_df = gdf.merge(fnb, how='left', left_index=True, right_index = True) # Merge the data to be displayed with GEOJSON

fig = px.choropleth_mapbox(merged_df, geojson=merged_df.geometry, locations=merged_df.index, color='FnB_COUNTS',
                           color_continuous_scale="Plasma",
                           mapbox_style="carto-positron",
                           zoom=10, center={"lat": 34.052235, "lon": -118.243683},
                           opacity=0.5,
                           labels={'Value':'Your Value Label'})

fig.update_layout(margin={"r":0,"t":0,"l":0,"b":0})
fig.show()



# %%
# To create Mapbox Choropleth Maps using Plotly

gdf = gpd.read_file('CHI.geojson')

gdf.set_index("pri_neigh", inplace=True)

pop_den = CHI[['neighborhood', 'population.density']].copy()

pop_den.set_index('neighborhood', inplace=True)


merged_df = gdf.merge(pop_den, how='left', left_index=True, right_index = True)

fig = px.choropleth_mapbox(merged_df, geojson=merged_df.geometry, locations=merged_df.index, color='population.density',
                           color_continuous_scale="Plasma",
                           mapbox_style="carto-positron",
                           zoom=10, center={"lat": 41.8781, "lon": -87.6298},
                           opacity=0.5,
                           labels={'Value':'Your Value Label'})

fig.update_layout(margin={"r":0,"t":0,"l":0,"b":0})
fig.show()

# %%
mean_hosp_d = NYC.groupby('neighborhood')['HOSPITAL_D'].mean() # Summarize Distance to Hospital by neighborhood
mean_hosp_d

# %%
mha = mean_hosp_d.to_frame(name='mean_hosp_d')
mha

# %%
# To create Mapbox Choropleth Maps using Plotly

gdf = gpd.read_file('NYC.geojson')

gdf.set_index("neighborhood", inplace=True)

merged_df = gdf.merge(mha, how='left', left_index=True, right_index = True) # Merge data to be displayed with GeoJSON

fig = px.choropleth_mapbox(merged_df, geojson=merged_df.geometry, locations=merged_df.index, color='mean_hosp_d',
                           color_continuous_scale="Plasma",
                           mapbox_style="carto-positron",
                           zoom=10, center={"lat": 40.7128, "lon": -74.0060},
                           opacity=0.5,
                           labels={'Value':'Your Value Label'})

fig.update_layout(margin={"r":0,"t":0,"l":0,"b":0})
fig.show()


