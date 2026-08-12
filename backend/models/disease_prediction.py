from sqlalchemy import Column, Integer, String, ForeignKey, JSON, Numeric
from database import Base


class DiseasePrediction(Base):
    __tablename__ = "disease_predictions"

    id = Column(Integer, primary_key=True, index=True)

    patient_id = Column(
        Integer,
        ForeignKey("patients.id", ondelete="CASCADE"),
        nullable=False
    )

    model_name = Column(String(150), nullable=True)
    prediction = Column(String(200), nullable=True)
    probability = Column(Numeric(5, 4), nullable=True)
    input_data = Column(JSON, nullable=True)