from sqlalchemy.orm import Session
from app import models, schemas

def create_spec(db: Session, spec: schemas.WheelSpecCreate):
    db_spec = models.WheelSpecification(
        axleBoxHousingBoreDia=spec.fields.axleBoxHousingBoreDia,
        bearingSeatDiameter=spec.fields.bearingSeatDiameter,
        condemningDia=spec.fields.condemningDia,
        intermediateWWP=spec.fields.intermediateWWP,
        lastShopIssueSize=spec.fields.lastShopIssueSize,
        rollerBearingBoreDia=spec.fields.rollerBearingBoreDia,
        rollerBearingOuterDia=spec.fields.rollerBearingOuterDia,
        rollerBearingWidth=spec.fields.rollerBearingWidth,
        treadDiameterNew=spec.fields.treadDiameterNew,
        variationSameAxle=spec.fields.variationSameAxle,
        variationSameBogie=spec.fields.variationSameBogie,
        variationSameCoach=spec.fields.variationSameCoach,
        wheelDiscWidth=spec.fields.wheelDiscWidth,
        wheelGauge=spec.fields.wheelGauge,
        wheelProfile=spec.fields.wheelProfile,
        
        formNumber=spec.formNumber,
        submittedBy=spec.submittedBy,
        submittedDate=spec.submittedDate,
    )
    db.add(db_spec)
    db.commit()
    db.refresh(db_spec)
    return db_spec

def get_specs(db: Session, formNumber: str = None, submittedBy: str = None, submittedDate: str = None):
    query = db.query(models.WheelSpecification)
    if formNumber:
        query = query.filter(models.WheelSpecification.formNumber == formNumber)
    if submittedBy:
        query = query.filter(models.WheelSpecification.submittedBy == submittedBy)
    if submittedDate:
        query = query.filter(models.WheelSpecification.submittedDate == submittedDate)
    return query.all()
