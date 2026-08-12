from sqlalchemy import Column, Integer, Text, ForeignKey
from database import Base


class ChatHistory(Base):
    __tablename__ = "chat_history"

    id = Column(Integer, primary_key=True, index=True)

    patient_id = Column(
        Integer,
        ForeignKey("patients.id", ondelete="CASCADE"),
        nullable=False
    )

    user_message = Column(Text, nullable=False)
    ai_response = Column(Text, nullable=False)