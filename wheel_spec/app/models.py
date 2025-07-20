from sqlalchemy import Column, String, Date
from app.database import Base

class WheelSpecification(Base):
    __tablename__ = "wheel_specifications"

    formNumber = Column(String, primary_key=True, index=True, nullable=False)
    submittedBy = Column(String, nullable=False)
    submittedDate = Column(Date, nullable=False)

    
    axleBoxHousingBoreDia = Column(String)
    bearingSeatDiameter = Column(String)
    condemningDia = Column(String)
    intermediateWWP = Column(String)
    lastShopIssueSize = Column(String)
    rollerBearingBoreDia = Column(String)
    rollerBearingOuterDia = Column(String)
    rollerBearingWidth = Column(String)
    treadDiameterNew = Column(String)
    variationSameAxle = Column(String)
    variationSameBogie = Column(String)
    variationSameCoach = Column(String)
    wheelDiscWidth = Column(String)
    wheelGauge = Column(String)
    wheelProfile = Column(String)

