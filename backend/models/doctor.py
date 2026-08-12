from sqlalchemy import Column, Integer, String, ForeignKey, Text
from database import Base


class Doctor(Base):
    __tablename__ = "doctors"

    id = Column(Integer, primary_key=True, index=True)
    user_id = Column(Integer, ForeignKey("users.id"), unique=True, nullable=False)

    specialization = Column(String(100), nullable=True)
    qualification = Column(String(150), nullable=True)
    experience_years = Column(Integer, nullable=True)
    license_number = Column(String(100), unique=True, nullable=True)
    department = Column(String(100), nullable=True)
    bio = Column(Text, nullable=True)