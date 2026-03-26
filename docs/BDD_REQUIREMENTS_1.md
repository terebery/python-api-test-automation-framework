# 📋 BDD Test Requirements

**Project:** test-automation-framework  
**Author:** terebery  
**Stack:** Python · pytest · pytest-bdd · requests · jsonschema  
**Total requirements:** 10 test cases

---

## TC-01 — Create User With Complete Data

| Field | Value |
|-------|-------|
| Priority | High |
| Category | User Creation |
| Endpoint | POST /users |
| Expected status | 201 Created |

**Description:**  
The system must allow creating a new user when a complete payload is provided. The response must confirm successful creation by returning a unique user identifier.

**Acceptance Criteria:**
- Request with complete user data returns HTTP status 201
- Response body contains a non-empty `id` field
- The `id` field is of type integer

---

## TC-02 — Get Existing User

| Field | Value |
|-------|-------|
| Priority | High |
| Category | User Retrieval |
| Endpoint | GET /users/{id} |
| Expected status | 200 OK |

**Description:**  
The system must return a user object when a valid and existing user ID is provided. The response must have the correct structure and data format.

**Acceptance Criteria:**
- Request for an existing user ID returns HTTP status 200
- Response body contains a properly structured user object
- Response body includes fields: `id`, `name`, `username`, `email`

---

## TC-03 — Get Non-Existing User

| Field | Value |
|-------|-------|
| Priority | High |
| Category | Negative Testing |
| Endpoint | GET /users/{id} |
| Expected status | 404 Not Found |

**Description:**  
The system must return a 404 status code when a request is made for a user that does not exist. The response body must be an empty object.

**Acceptance Criteria:**
- Request for a non-existing user ID returns HTTP status 404
- Response body is equal to `{}`
- No user data is returned in the response

---

## TC-04 — Get All Users

| Field | Value |
|-------|-------|
| Priority | Medium |
| Category | User Retrieval |
| Endpoint | GET /users |
| Expected status | 200 OK |

**Description:**  
The system must return a complete list of all users when the users collection endpoint is called. The response must be a list containing the expected number of elements.

**Acceptance Criteria:**
- Request returns HTTP status 200
- Response body is a list (array)
- List contains exactly 10 elements

---

## TC-05 — Check Format of Single User (Parametrized)

| Field | Value |
|-------|-------|
| Priority | High |
| Category | Schema Validation |
| Endpoint | GET /users/{id} |
| Expected statuses | 200 OK · 404 Not Found |

**Description:**  
The system must return the correct status code and a valid response body for each user ID provided. For existing users the response must pass schema validation. For non-existing users the response must return an empty object.

**Acceptance Criteria:**
- User ID `1` returns status 200 and passes schema validation
- User ID `2` returns status 200 and passes schema validation
- User ID `13` returns status 404
- User ID `45465` returns status 404
- Response body for 200 responses conforms to the user JSON schema

---

## TC-06 — Update User Data (Parametrized)

| Field | Value |
|-------|-------|
| Priority | High |
| Category | User Update |
| Endpoint | PUT /users/{id} |
| Expected status | 200 OK |

**Description:**  
The system must allow updating user data by providing a valid user ID along with new `name` and `username` values. The response must reflect the updated data.

**Acceptance Criteria:**
- PUT request for user ID `1` with name `Brady` and username `sagvdfs` returns 200
- PUT request for user ID `2` with name `Auston` and username `NoRingTill67` returns 200
- PUT request for user ID `3` with name `Nathan` and username `MissingEmptyNet` returns 200
- Response body contains the updated `name` and `username` values

---

## TC-07 — Delete User

| Field | Value |
|-------|-------|
| Priority | High |
| Category | User Deletion |
| Endpoint | DELETE /users/{id} |
| Expected status | 200 OK |

**Description:**  
The system must allow deleting an existing user by ID. The response must confirm successful deletion with a 200 status code and an empty response body.

**Acceptance Criteria:**
- DELETE request for an existing user returns HTTP status 200
- Response body is equal to `{}`
- No user data is returned after deletion

---

## TC-08 — Validate Content-Type Response Header

| Field | Value |
|-------|-------|
| Priority | Medium |
| Category | Headers Validation |
| Endpoint | GET /users/{id} |
| Expected status | 200 OK |

**Description:**  
The system must return the correct `Content-Type` header for every API response. The header must indicate that the response body is formatted as JSON.

**Acceptance Criteria:**
- Request for an existing user returns HTTP status 200
- Response header `Content-Type` contains `application/json`
- Response header `Content-Type` contains `charset=utf-8`

---

## TC-09 — Create User With Minimal Payload

| Field | Value |
|-------|-------|
| Priority | Medium |
| Category | User Creation |
| Endpoint | POST /users |
| Expected status | 201 Created |

**Description:**  
The system must accept user creation when only the required minimum fields are provided in the request body. This verifies that optional fields are truly optional and do not block the creation process.

**Acceptance Criteria:**
- POST request with only `name` in the payload returns HTTP status 201
- Response body contains a non-empty `id` field
- No error is returned for missing optional fields

---

## TC-10 — Validate Nested Fields in User Response (Parametrized)

| Field | Value |
|-------|-------|
| Priority | Medium |
| Category | Schema Validation |
| Endpoint | GET /users/{id} |
| Expected status | 200 OK |

**Description:**  
The system must return user objects that contain the expected nested fields. Each specified key must be present inside its corresponding parent field in the response body.

**Acceptance Criteria:**
- Request for an existing user returns HTTP status 200
- Field `city` is nested inside the `address` object
- Field `name` is nested inside the `company` object
- Both nested fields contain non-empty values

---

## 📊 Summary

| ID | Title | Category | Priority |
|----|-------|----------|----------|
| TC-01 | Create User With Complete Data | User Creation | High |
| TC-02 | Get Existing User | User Retrieval | High |
| TC-03 | Get Non-Existing User | Negative Testing | High |
| TC-04 | Get All Users | User Retrieval | Medium |
| TC-05 | Check Format of Single User | Schema Validation | High |
| TC-06 | Update User Data | User Update | High |
| TC-07 | Delete User | User Deletion | High |
| TC-08 | Validate Content-Type Header | Headers Validation | Medium |
| TC-09 | Create User With Minimal Payload | User Creation | Medium |
| TC-10 | Validate Nested Fields in Response | Schema Validation | Medium |