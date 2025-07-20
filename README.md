## Setup Instructions

### Backend:
1. `cd backend`
2. `docker-compose up`
3. Backend runs at: `http://localhost:8000`

### Frontend (Flutter):
1. `cd frontend`
2. Run: `flutter pub get`
3. Launch: `flutter run` or use Android Studio

---

## Tech Stack

- **Frontend**: Flutter
- **Backend**: Python + FastAPI
- **Database**: PostgreSQL
- **Other**: Docker, Postman
---

## Features

- Submit wheel specification forms with validations.
- Filter forms by Form Number, Submitted By, and Submitted Date.
- Backend API endpoints to handle CRUD operations.
- Integrated Swagger/OpenAPI for API endpoints testing
- Dockerized the backend with `wait-for-it.sh` for proper loading
---

## Limitations & Assumptions
- Only two APIs implemented (GET & POST for wheel-specs)
- Remaining endpoints are dummy and routed to UAT backend
---

## APIs Implemented
### 1. POST `/api/forms/wheel-specifications`
- **Description**: Saves wheel specification form
- **Request**:
  ```json
  {
    {
    "formNumber": "WHEEL-2025-001",
    "submittedBy": "user_id_123",
    "submittedDate": "2025-07-03",
    "fields": {
      "treadDiameterNew": "915 (900-1000)",
      "lastShopIssueSize": "837 (800-900)",
      "condemningDia": "825 (800-900)",
      "wheelGauge": "1600 (+2,-1)",
      "variationSameAxle": "0.5",
      "variationSameBogie": "5",
      "variationSameCoach": "13",
      "wheelProfile": "29.4 Flange Thickness",
      "intermediateWWP": "20 TO 28",
      "bearingSeatDiameter": "130.043 TO 130.068",
      "rollerBearingOuterDia": "280 (+0.0/-0.035)",
      "rollerBearingBoreDia": "130 (+0.0/-0.025)",
      "rollerBearingWidth": "93 (+0/-0.250)",
      "axleBoxHousingBoreDia": "280 (+0.030/+0.052)",
      "wheelDiscWidth": "127 (+4/-0)"
    }
  }

### 1. GET `/api/forms/wheel-specifications`
- **Description**: Returns existing wheel specification based on formNumber, submittedBY, submittedDate
- **Request**
  ```json
  {
    {
    "formNumber": "WHEEL-2025-001",
    "submittedBy": "user_id_123",
    "submittedDate": "2025-07-03",
    }
  }
