from pydantic import BaseModel
from typing import Optional
from datetime import date

class WheelSpecFields(BaseModel):
    axleBoxHousingBoreDia: str
    bearingSeatDiameter: str
    condemningDia: str
    intermediateWWP: str
    lastShopIssueSize: str
    rollerBearingBoreDia: str
    rollerBearingOuterDia: str
    rollerBearingWidth: str
    treadDiameterNew: str
    variationSameAxle: str
    variationSameBogie: str
    variationSameCoach: str
    wheelDiscWidth: str
    wheelGauge: str
    wheelProfile: str


class WheelSpecCreate(BaseModel):
    fields: WheelSpecFields
    formNumber: str
    submittedBy: str
    submittedDate: date

class WheelSpecResponse(WheelSpecCreate):
    status: str = "Saved"
