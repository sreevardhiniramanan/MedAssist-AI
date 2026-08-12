from sqlalchemy import Column, Integer, String, ForeignKey, Text
from database import Base


class Staff(Base):
    __tablename__ = "staff"

    id = Column(Integer, primary_key=True, index=True)
    user_id = Column(Integer, ForeignKey("users.id"), unique=True, nullable=False)

    staff_type = Column(String(50), nullable=True)
    department = Column(String(100), nullable=True)
    qualification = Column(String(150), nullable=True)
    employee_id = Column(String(100), unique=True, nullable=True)
    phone = Column(String(20), nullable=True)
    notes = Column(Text, nullable=True)