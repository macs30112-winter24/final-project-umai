import pandas as pd
from math import radians, sin, cos, sqrt, atan2

def haversine(lat1, lon1, lat2, lon2):
    '''
    Calculate the distance in meters between two sets of latitude and 
    longitude coordinates. 
    lat1: float, latitude 1
    lon1: float, longitude 1
    lat2: float, latitude 2
    lon2: float, longitude 2
    '''
    lat1, lon1, lat2, lon2 = map(radians, [lat1, lon1, lat2, lon2])
    
    dlat = lat2 - lat1
    dlon = lon2 - lon1
    a = sin(dlat / 2) ** 2 + cos(lat1) * cos(lat2) * sin(dlon / 2) ** 2
    c = 2 * atan2(sqrt(a), sqrt(1 - a))
    R = 6371 
    distance = R * c
    return distance * 1000

def calculate_dist_to(data_file, dest_file, field_name):
    '''
    Calculate the distance from each listing in data_file to the nearest
    POI in dest_file, and return the results in a given field_name.
    data_file: string, file with listing information
    dest_file: string, file with destination information
    field_name: string, customized field name
    '''
    data_df = pd.read_csv(data_file)
    dest_df = pd.read_csv(dest_file)

    results = []

    for index, row in data_df.iterrows():
        lat1 = row['LATITUDE']
        lon1 = row['LONGITUDE']
        to_all_dest = []
        for i, r in dest_df.iterrows():
            lat2 = r['y']
            lon2 = r['x']
            distance = haversine(lat1, lon1, lat2, lon2)
            to_all_dest.append(distance)
        results.append(min(to_all_dest))

    data_df[field_name] = results
    data_df.to_csv(data_file, index=False)

def count_within(threshold, data_file, dest_file, field_name):

    '''
    Count the amount of POIs in dest_file within the distance of 
    threshold at each listing in data_file.
    threshold: integer, buffer radius in meter
    data_file: string, file with listing information
    dest_file: string, file with destination information
    field_name: string, customized field name
    '''

    data_df = pd.read_csv(data_file)
    dest_df = pd.read_csv(dest_file)

    results = []

    for index, row in data_df.iterrows():
        count = 0
        lat1 = row['LATITUDE']
        lon1 = row['LONGITUDE']
        for i, r in dest_df.iterrows():
            lat2 = r['y']
            lon2 = r['x']
            distance = haversine(lat1, lon1, lat2, lon2)
            if distance <= threshold:
                count += 1
        results.append(count)
    
    data_df[field_name] = results
    data_df.to_csv(data_file, index=False)


# Example Usage:
# calculate_dist_to('LAX_Redfin.csv', 'LAX_Hospitals.csv', 'HOSPITAL_D')
# count_within(1000, 'LAX_Redfin.csv', 'LAX_Bus.csv', 'BUS_COUNT')