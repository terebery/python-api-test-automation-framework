# 📋 BDD Test Requirements

**Project:** test-automation-framework  
**Author:** terebery  
**Stack:** Python · pytest · pytest-bdd · requests · jsonschema  
**Total requirements:** 8 BDD scenarios

---

## 🥉 BASIC LEVEL

---

### REQ-001 — HTTP Response Headers Validation

| Field | Value |
|-------|-------|
| Priority | Medium |
| Category | Headers Validation |
| Endpoint | GET /users/1 |
| Expected status | 200 OK |

**Description:**  
The system must return correct HTTP headers in response to every API request. The `Content-Type` header should indicate the data format and character encoding.

**Acceptance Criteria:**
- The `Content-Type` header contains `application/json`
- The `Content-Type` header contains `charset=utf-8`
- The response returns HTTP status code 200

---

### REQ-002 — Negative Testing — Invalid User ID

| Field | Value |
|-------|-------|
| Priority | High |
| Category | Negative Testing |
| Endpoint | GET /users/{id} |
| Expected status | 404 Not Found |

**Description:**  
The system must return a 404 status code for requests targeting non-existent users. Parametrized tests should cover various types of invalid identifiers: very large numbers, strings, negative numbers, and zero.

**Acceptance Criteria:**
- ID = `99999` returns status 404
- ID = `abc` (string) returns status 404
- ID = `-1` (negative number) returns status 404
- ID = `0` returns status 404

---

### REQ-003 — JSON Schema Validation for a Single User

| Field | Value |
|-------|-------|
| Priority | High |
| Category | Schema Validation |
| Endpoint | GET /users/1 |
| Expected status | 200 OK |

**Description:**  
The API response for a single user must conform to a predefined JSON schema. All required fields must be present and have the correct data types.

**Acceptance Criteria:**
- Response contains fields: `id`, `name`, `username`, `email`
- Field `id` is of type integer
- Field `email` contains the `@` character
- The entire response structure conforms to the defined JSON Schema

---

## 🥈 INTERMEDIATE LEVEL

---

### REQ-004 — API Response Time Validation (Performance Baseline)

| Field | Value |
|-------|-------|
| Priority | Medium |
| Category | Performance |
| Endpoint | GET /users |
| Max response time | 2000ms |

**Description:**  
The API must respond within an acceptable time frame. Requests to the users list endpoint must not exceed 2000ms. This requirement serves as a performance regression baseline.

**Acceptance Criteria:**
- Response time for `GET /users` is less than 2000ms
- Response time for `GET /users/{id}` is less than 1000ms
- Test measures time from sending the request to receiving the full response

---

### REQ-005 — Users List Structure Validation

| Field | Value |
|-------|-------|
| Priority | Medium |
| Category | List Validation |
| Endpoint | GET /users |
| Expected status | 200 OK |

**Description:**  
The users list endpoint must return an array of objects. Each object in the list must contain the required fields. The list must not be empty.

**Acceptance Criteria:**
- Response body is an array (list)
- List contains at least 5 users
- Each user in the list has fields: `id`, `name`, `username`, `email`
- All `id` values in the list are unique

---

## 🥇 ADVANCED LEVEL

---

### REQ-006 — Full User Lifecycle (CRUD E2E)

| Field | Value |
|-------|-------|
| Priority | High |
| Category | E2E Flow |
| Endpoints | POST /users · PUT /users/{id} · DELETE /users/{id} |
| Expected statuses | 201 · 200 · 200 |

**Description:**  
The system must support the full lifecycle of a user resource: creation, update, and deletion within a single test scenario. Each operation must return the correct status code and response body.

**Acceptance Criteria:**
- `POST /users` returns 201 with a new `id`
- `PUT /users/{id}` returns 200 with updated data
- `DELETE /users/{id}` returns 200
- Each step uses the `id` returned from the previous step (chained requests)

---

### REQ-007 — User Creation With Random Data (Faker + Data-Driven)

| Field | Value |
|-------|-------|
| Priority | Medium |
| Category | Data-Driven Testing |
| Endpoint | POST /users |
| Expected status | 201 Created |

**Description:**  
The system must accept user creation with various sets of input data. Parametrized tests using the Faker library verify that the API is not dependent on specific field values and handles diverse inputs correctly.

**Acceptance Criteria:**
- Each data set from the Examples table returns status 201
- Response contains the `id` field for every created user
- Request data is reflected correctly in the response body

---

### REQ-008 — Chained Requests — Using ID From Previous Response

| Field | Value |
|-------|-------|
| Priority | High |
| Category | Chained Requests |
| Endpoints | POST /users · GET /users/{id} |
| Expected statuses | 201 · 200 |

**Description:**  
The system must support creating a user and immediately retrieving it using the `id` returned in the POST response. The scenario verifies data consistency between the write and read operations.

**Acceptance Criteria:**
- `POST /users` returns 201 with a new `id`
- `GET /users/{id}` uses the `id` from the previous response
- Retrieved data matches the `name` and `username` sent during creation
- No step uses a hardcoded ID

---

## 📊 Summary

| ID | Title | Level | Priority |
|----|-------|-------|----------|
| REQ-001 | HTTP Response Headers Validation | Basic | Medium |
| REQ-002 | Negative Testing — Invalid User ID | Basic | High |
| REQ-003 | JSON Schema Validation | Basic | High |
| REQ-004 | Performance Baseline | Intermediate | Medium |
| REQ-005 | Users List Structure Validation | Intermediate | Medium |
| REQ-006 | Full User Lifecycle CRUD E2E | Advanced | High |
| REQ-007 | Data-Driven Testing with Faker | Advanced | Medium |
| REQ-008 | Chained Requests | Advanced | High |