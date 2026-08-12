from sqlalchemy import Column, Integer, String, ForeignKey, Text, Date
from database import Base


class LabReport(Base):
    __tablename__ = "lab_reports"

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

    report_name = Column(String(200), nullable=False)
    report_type = Column(String(100), nullable=True)
    file_path = Column(Text, nullable=False)
    report_date = Column(Date, nullable=True)
    ai_summary = Column(Text, nullable=True)
    ai_explanation = Column(Text, nullable=True)
    status = Column(String(30), default="uploaded")