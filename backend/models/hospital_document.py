from sqlalchemy import Column, Integer, String, ForeignKey, Text
from database import Base


class HospitalDocument(Base):
    __tablename__ = "hospital_documents"

    id = Column(Integer, primary_key=True, index=True)

    uploaded_by = Column(
        Integer,
        ForeignKey("users.id", ondelete="SET NULL"),
        nullable=True
    )

    document_name = Column(String(255), nullable=False)
    document_type = Column(String(100), nullable=True)
    file_path = Column(Text, nullable=False)
    description = Column(Text, nullable=True)