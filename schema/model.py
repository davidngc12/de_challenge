from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy import Column, Integer, String, TIMESTAMP, Date
from sqlalchemy.sql.sqltypes import Float, INTEGER, Numeric

Base = declarative_base()


class Trips(Base):
    __tablename__ = "trips"
    id = Column(Integer, primary_key=True, index=True)
    region = Column(String)
    origin_coord = Column(String)
    destination_coord = Column(String)
    datetime = Column(String)
    datasource = Column(String)
    origin_address = Column(String)
    destination_address = Column(String)
    upload_datetime = Column(String)