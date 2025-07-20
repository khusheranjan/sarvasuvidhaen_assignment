from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from app.database import SessionLocal
from app import schemas, crud

router = APIRouter()

def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()

@router.post("/api/forms/wheel-specifications", status_code=201)
def submit_wheel_spec(spec: schemas.WheelSpecCreate, db: Session = Depends(get_db)):
    created = crud.create_spec(db, spec)
    
    return {
        "data": {
            "formNumber": created.formNumber,
            "submittedBy": created.submittedBy,
            "submittedDate": created.submittedDate,
            "status": "Saved"
        },
        "message": "Wheel specification submitted successfully.",
        "success": True
    }

@router.get("/api/forms/wheel-specifications")
def get_specs(formNumber: str = None, submittedBy: str = None, submittedDate: str = None, db: Session = Depends(get_db)):
    raw_data = crud.get_specs(db, formNumber, submittedBy, submittedDate)

    result = []
    for row in raw_data:
        result.append({
            "formNumber": row.formNumber,
            "submittedBy": row.submittedBy,
            "submittedDate": row.submittedDate,
            "fields": {
                "condemningDia": row.condemningDia,
                "lastShopIssueSize": row.lastShopIssueSize,
                "treadDiameterNew": row.treadDiameterNew,
                "wheelGauge": row.wheelGauge,
            }
        })

    return {
        "data": result,
        "message": "Filtered wheel specification forms fetched successfully.",
        "success": True
    }