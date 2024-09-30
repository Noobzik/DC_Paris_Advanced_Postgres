import pandas as pd
from sqlalchemy import create_engine

if __name__ == '__main__':
    engine = create_engine('postgresql://postgres:example@localhost:5432')
    df: pd.DataFrame = pd.read_csv('./olympic_athletes_2016_14.csv')
    df.to_sql('athletes', engine)