from sqlalchemy import Column, Integer, String, Date, Time, ForeignKey, Text
from database import Base


class Appointment(Base):
    __tablename__ = "appointments"

    id = Column(Integer, primary_key=True, index=True)

    patient_id = Column(
        Integer,
        ForeignKey("patients.id", ondelete="CASCADE"),
        nullable=False
    )

    doctor_id = Column(
        Integer,
        ForeignKey("doctors.id", ondelete="CASCADE"),
        nullable=False
    )

    appointment_date = Column(Date, nullable=False)
    appointment_time = Column(Time, nullable=False)

    reason = Column(Text, nullable=True)

    status = Column(
        String(30),
        default="scheduled",
        nullable=False
    )

    doctor_notes = Column(Text, nullable=True)