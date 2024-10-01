import pandas as pd
from sqlalchemy import create_engine

if __name__ == '__main__':
    engine = create_engine('postgresql://postgres:example@localhost:5432')
    # athletes_events
    df: pd.DataFrame = pd.read_csv('./athlete_events.csv.gz')
    df.columns = df.columns.str.lower()
    df.rename(columns={'noc': 'country_code', 'team': 'country', 'id': 'athlete_id'}, inplace=True)
    df = df[~df['country'].str.contains(r'-\d', regex=True)]
    df.columns = df.columns.str.lower()
    df.to_sql('athletes', engine, if_exists='replace')
    # oregions
    df: pd.DataFrame = pd.read_csv('./olympic_regions.csv')
    df.columns = df.columns.str.lower()
    df.to_sql('oregions', engine, if_exists='replace')
    # oclimates
    df: pd.DataFrame = pd.read_csv('./oclimates.csv', delimiter=';')
    df.columns = df.columns.str.lower()
    df.to_sql('oclimate', engine, if_exists='replace')
    df: pd.DataFrame = pd.read_csv('./population_gdp_transposed.csv')
    df.columns = df.columns.str.lower()
    df.to_sql('demographics', engine, if_exists='replace')