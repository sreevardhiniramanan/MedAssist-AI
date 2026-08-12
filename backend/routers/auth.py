from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session

from database import get_db
from schemas.auth import RegisterRequest
from models.user import User
from core.security import hash_password

router = APIRouter(
    prefix="/auth",
    tags=["Authentication"]
)


@router.get("/test")
def test():
    return {
        "message": "Authentication Router Working"
    }


@router.post("/register")
def register(
    user: RegisterRequest,
    db: Session = Depends(get_db)
):
    try:
        # Check if email already exists
        existing_user = db.query(User).filter(User.email == user.email).first()

        if existing_user:
            return {
                "success": False,
                "message": "Email already exists"
            }

        # Hash password
        hashed_password = hash_password(user.password)

        # Create new user
        new_user = User(
            full_name=user.full_name,
            email=user.email,
            password_hash=hashed_password,
            role=user.role
        )

        db.add(new_user)
        db.commit()
        db.refresh(new_user)

        return {
            "success": True,
            "message": "Registration Successful",
            "user_id": new_user.id
        }

    except Exception as e:
        db.rollback()
        import traceback
        traceback.print_exc()

        return {
            "success": False,
            "error": str(e),
            "type": type(e).__name__
        }