from sqlalchemy import Column, Integer, String, ForeignKey, Text
from database import Base


class PrescriptionScan(Base):
    __tablename__ = "prescription_scans"

    id = Column(Integer, primary_key=True, index=True)

    patient_id = Column(
        Integer,
        ForeignKey("patients.id", ondelete="CASCADE"),
        nullable=False
    )

    uploaded_by_staff_id = Column(
        Integer,
        ForeignKey("staff.id", ondelete="SET NULL"),
        nullable=True
    )

    image_path = Column(Text, nullable=False)
    extracted_text = Column(Text, nullable=True)
    extracted_medicines = Column(Text, nullable=True)
    ocr_status = Column(String(30), default="pending")