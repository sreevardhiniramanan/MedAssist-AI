from sqlalchemy import Column, Integer, String, ForeignKey, Text
from database import Base


class Prescription(Base):
    __tablename__ = "prescriptions"

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

    appointment_id = Column(
        Integer,
        ForeignKey("appointments.id", ondelete="SET NULL"),
        nullable=True
    )

    prescription_file = Column(Text, nullable=True)
    medicine_details = Column(Text, nullable=True)
    diagnosis = Column(Text, nullable=True)
    instructions = Column(Text, nullable=True)