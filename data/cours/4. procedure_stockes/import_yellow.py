import gc
import logging
import math
import os
import sys

import pandas as pd
from sqlalchemy import create_engine

logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(levelname)s - %(message)s')

def write_data_postgres(dataframe: pd.DataFrame) -> bool:
    """
    Dumps a Dataframe to the DBMS engine

    Parameters:
        - dataframe (pd.Dataframe) : The dataframe to dump into the DBMS engine

    Returns:
        - bool : True if the connection to the DBMS and the dump to the DBMS is successful, False if either
        execution is failed
    """
    db_config = {
        "dbms_engine": "postgresql",
        "dbms_username": "postgres",
        "dbms_password": "example",
        "dbms_ip": "localhost",
        "dbms_port": "5432",
        "dbms_database": "public",
        "dbms_table": "yellowtripdata"
    }

    db_config["database_url"] = (
        f"{db_config['dbms_engine']}://{db_config['dbms_username']}:{db_config['dbms_password']}@"
        f"{db_config['dbms_ip']}:{db_config['dbms_port']}"
    )
    try:
        engine = create_engine(db_config["database_url"])
        with engine.connect():
            logging.info("Connection successful! Processing parquet file")
            chunk_size = 10000
            total_chunks = math.ceil(len(dataframe) / chunk_size)  # Calculate total chunks

            # Split dataframe into chunks and write to database
            for i in range(0, len(dataframe), chunk_size):
                chunk = dataframe[i:i + chunk_size]
                chunk.to_sql(db_config['dbms_table'], engine, index=False, if_exists='append')
                logging.info(f"Chunk {i // chunk_size + 1}/{total_chunks} of size {len(chunk)} written to database")
            return True

    except Exception as e:
        logging.error(f"Error connection to the database: {e}")
        return False


def clean_column_name(dataframe: pd.DataFrame) -> pd.DataFrame:
    """
    Take a Dataframe and rewrite it columns into a lowercase format.
    Parameters:
        - dataframe (pd.DataFrame) : The dataframe columns to change

    Returns:
        - pd.Dataframe : The changed Dataframe into lowercase format
    """
    dataframe.columns = map(str.lower, dataframe.columns)
    return dataframe


def main() -> None:
    # folder_path: str = r'..\..\data\raw'
    script_dir = os.path.dirname(os.path.abspath(__file__))
    # Construct the relative path to the folder
    # folder_path = os.path.join(script_dir)

    parquet_files = [f for f in os.listdir(script_dir) if
                     f.lower().endswith('.parquet') and os.path.isfile(os.path.join(script_dir, f))]

    for parquet_file in parquet_files:
        parquet_df: pd.DataFrame = pd.read_parquet(os.path.join(script_dir, parquet_file), engine='pyarrow')

        clean_column_name(parquet_df)
        if not write_data_postgres(parquet_df):
            del parquet_df
            gc.collect()
            return

        del parquet_df
        gc.collect()


if __name__ == '__main__':
    sys.exit(main())