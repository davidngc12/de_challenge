from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy import Column, Integer, String, TIMESTAMP, Date
from sqlalchemy.sql.sqltypes import Float, INTEGER, Numeric

Base = declarative_base()


class Test(Base):
    __tablename__ = "test"
    id_usuario = Column(Integer, primary_key=True, index=True)