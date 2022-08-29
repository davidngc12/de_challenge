from sys import excepthook
import pandas as pd
import numpy as np
from sqlalchemy import create_engine
import geopy
import geopandas as gpd
import os
import shutil
from datetime import datetime

geopy.geocoders.options.default_user_agent = 'de_challenge'

uploads_path = os.getcwd()+'/app/uploads/'
processed_path = os.getcwd()+'/app/processed/'

engine = create_engine('postgresql+psycopg2://postgres:postgres@db/de_challenge', echo=False)

def reverse_geocoding(df):

    origins = gpd.GeoSeries.from_wkt(df['origin_coord'])
    destinations = gpd.GeoSeries.from_wkt(df['destination_coord'])
    df['origin_address'] = gpd.tools.reverse_geocode(origins, provider='nominatim')['address']
    df['destination_address'] = gpd.tools.reverse_geocode(destinations, provider='nominatim')['address']

    return df

for file in os.listdir(uploads_path):

    try:
        print(f'Uploading {file} to database')
        #chunksize can be as big as the ram available allows. for this challenge set it to 40 so we can see a status update
        df = pd.read_csv(uploads_path+file, chunksize=40) 
        processed_dts = datetime.now().strftime("%d/%m/%Y %H:%M:%S")
        count = 0

        for df_chunk in df:
            # nominatim api sometime throws a Service not available error. in this case delete the records loaded from table and rerun the script
            df_chunk = reverse_geocoding(df_chunk)
            df_chunk['upload_datetime'] = processed_dts
            df_chunk.to_sql('trips', con=engine, if_exists='append', index=False)
            print(f'Uploaded {len(df_chunk)} records for a total of {count+len(df_chunk)}')
            count = count + len(df_chunk)

        print(f'{file} loaded succesfully. Moving to processed folder')
        shutil.move(uploads_path + file, processed_path + file) 

    except Exception as e:
        print(f'Problem uploading file {file}')
        print(e)
        pass