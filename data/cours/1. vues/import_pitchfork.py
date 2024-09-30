import pandas as pd
from sqlalchemy import create_engine

if __name__ == '__main__':
    engine = create_engine('postgresql://postgres:example@localhost:5432')
    df: pd.DataFrame = pd.read_csv('./pitchfork_data.csv')
    df.to_sql('pitchfork', engine)