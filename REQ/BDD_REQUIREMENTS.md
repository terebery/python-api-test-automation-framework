# 📋 BDD Test Requirements

**Projekt:** test-automation-framework  
**Autor:** terebery  
**Stack:** Python · pytest · pytest-bdd · requests · jsonschema  
**Liczba wymagań:** 8 scenariuszy BDD

---

## 🥉 POZIOM PODSTAWOWY

---

### REQ-001 — Walidacja nagłówków odpowiedzi HTTP

| Pole | Wartość |
|------|---------|
| Priorytet | Średni |
| Kategoria | Headers Validation |
| Endpoint | GET /users/1 |
| Oczekiwany status | 200 OK |

**Opis:**  
System musi zwracać poprawne nagłówki HTTP w odpowiedzi na każde żądanie API. Nagłówek `Content-Type` powinien wskazywać format danych oraz kodowanie znaków.

**Kryteria akceptacji:**
- Nagłówek `Content-Type` zawiera wartość `application/json`
- Nagłówek `Content-Type` zawiera `charset=utf-8`
- Odpowiedź zwraca kod statusu 200

**Scenariusz Gherkin:**
```gherkin
Feature: Response Headers Validation

  Scenario: Response contains correct Content-Type header
    Given I send GET request to "/users/1"
    Then response status code should be 200
    And response header "Content-Type" should contain "application/json"
    And response header "Content-Type" should contain "charset=utf-8"
```

---

### REQ-002 — Negative testing — nieprawidłowe ID użytkownika

| Pole | Wartość |
|------|---------|
| Priorytet | Wysoki |
| Kategoria | Negative Testing |
| Endpoint | GET /users/{id} |
| Oczekiwany status | 404 Not Found |

**Opis:**  
System musi zwracać status 404 dla zapytań o nieistniejących użytkowników. Testy parametryczne powinny obejmować różne typy nieprawidłowych identyfikatorów: bardzo duże liczby, stringi, liczby ujemne i zero.

**Kryteria akceptacji:**
- ID = `99999` zwraca status 404
- ID = `abc` (string) zwraca status 404
- ID = `-1` (ujemna liczba) zwraca status 404
- ID = `0` zwraca status 404

**Scenariusz Gherkin:**
```gherkin
Feature: Negative Testing - Invalid User ID

  Scenario Outline: Get user with invalid ID returns 404
    Given I send GET request to "/users/<invalid_id>"
    Then response status code should be 404

    Examples:
      | invalid_id |
      | 99999      |
      | abc        |
      | -1         |
      | 0          |
```

---

### REQ-003 — Walidacja schematu JSON pojedynczego użytkownika

| Pole | Wartość |
|------|---------|
| Priorytet | Wysoki |
| Kategoria | Schema Validation |
| Endpoint | GET /users/1 |
| Oczekiwany status | 200 OK |

**Opis:**  
Odpowiedź API dla pojedynczego użytkownika musi być zgodna ze zdefiniowanym schematem JSON. Wszystkie wymagane pola muszą być obecne i mieć poprawny typ danych.

**Kryteria akceptacji:**
- Odpowiedź zawiera pola: `id`, `name`, `username`, `email`
- Pole `id` jest typu integer
- Pole `email` zawiera znak `@`
- Cała struktura jest zgodna z JSON Schema

**Scenariusz Gherkin:**
```gherkin
Feature: User Schema Validation

  Scenario: Single user response matches JSON schema
    Given I send GET request to "/users/1"
    Then response status should be 200
    And response body should match user schema
    And user schema should contain fields "id, name, username, email"
```

---

## 🥈 POZIOM ŚREDNI

---

### REQ-004 — Walidacja czasu odpowiedzi API (Performance Baseline)

| Pole | Wartość |
|------|---------|
| Priorytet | Średni |
| Kategoria | Performance |
| Endpoint | GET /users |
| Max czas odpowiedzi | 2000ms |

**Opis:**  
API musi odpowiadać w akceptowalnym czasie. Każde żądanie do endpointów listy użytkowników nie może przekraczać 2000ms. Wymaganie służy jako baseline do monitorowania regresji wydajnościowej.

**Kryteria akceptacji:**
- Czas odpowiedzi `GET /users` < 2000ms
- Czas odpowiedzi `GET /users/{id}` < 1000ms
- Test mierzy czas od wysyłki żądania do otrzymania odpowiedzi

**Scenariusz Gherkin:**
```gherkin
Feature: Performance Baseline

  Scenario: API responds within acceptable time for users list
    Given I send GET request to "/users"
    Then response status should be 200
    And response time should be less than 2000 milliseconds

  Scenario: API responds within acceptable time for single user
    Given I send GET request to "/users/1"
    Then response status should be 200
    And response time should be less than 1000 milliseconds
```

---

### REQ-005 — Walidacja struktury listy użytkowników

| Pole | Wartość |
|------|---------|
| Priorytet | Średni |
| Kategoria | List Validation |
| Endpoint | GET /users |
| Oczekiwany status | 200 OK |

**Opis:**  
Endpoint listy użytkowników musi zwracać tablicę obiektów. Każdy obiekt na liście musi posiadać wymagane pola. Lista nie może być pusta.

**Kryteria akceptacji:**
- Odpowiedź jest tablicą (lista)
- Lista zawiera co najmniej 5 użytkowników
- Każdy użytkownik na liście posiada pola: `id`, `name`, `username`, `email`
- Każde `id` na liście jest unikalne

**Scenariusz Gherkin:**
```gherkin
Feature: Users List Validation

  Scenario: Users list returns correct structure
    Given I send GET request to "/users"
    Then response status should be 200
    And response should be a list
    And list should contain at least 5 users
    And each user in list should have fields "id, name, username, email"
    And all user IDs in list should be unique
```

---

## 🥇 POZIOM ZAAWANSOWANY

---

### REQ-006 — Pełny cykl życia użytkownika (CRUD E2E)

| Pole | Wartość |
|------|---------|
| Priorytet | Wysoki |
| Kategoria | E2E Flow |
| Endpointy | POST /users · PUT /users/{id} · DELETE /users/{id} |
| Oczekiwane statusy | 201 · 200 · 200 |

**Opis:**  
System musi obsługiwać pełny cykl życia zasobu użytkownika: utworzenie, aktualizację i usunięcie w ramach jednego scenariusza testowego. Każda operacja musi zwrócić poprawny status i dane.

**Kryteria akceptacji:**
- `POST /users` zwraca 201 i nowe `id`
- `PUT /users/{id}` zwraca 200 i zaktualizowane dane
- `DELETE /users/{id}` zwraca 200
- Każdy krok używa `id` z poprzedniego kroku (chained requests)

**Scenariusz Gherkin:**
```gherkin
Feature: User Lifecycle

  Scenario: Full user CRUD lifecycle
    Given I create a new user with name "John" and username "john_doe"
    Then response status should be 201
    And created user should have an ID

    When I update the user name to "Johnny"
    Then response status should be 200
    And response body name should be "Johnny"

    When I delete the user
    Then response status should be 200
```

---

### REQ-007 — Tworzenie użytkownika z losowymi danymi (Faker + Outline)

| Pole | Wartość |
|------|---------|
| Priorytet | Średni |
| Kategoria | Data-Driven Testing |
| Endpoint | POST /users |
| Oczekiwany status | 201 Created |

**Opis:**  
System musi akceptować tworzenie użytkowników z różnymi zestawami danych wejściowych. Testy parametryczne z biblioteką Faker weryfikują że API nie jest zależne od konkretnych wartości pól.

**Kryteria akceptacji:**
- Każdy zestaw danych z tabeli Examples zwraca 201
- Odpowiedź zawiera pole `id` dla każdego utworzonego użytkownika
- Dane z żądania są odzwierciedlone w odpowiedzi

**Scenariusz Gherkin:**
```gherkin
Feature: Create Users With Various Data

  Scenario Outline: Create user with different data sets returns 201
    Given I create a user with name "<name>" and username "<username>"
    Then response status should be 201
    And response should contain field "id"
    And response field "name" should equal "<name>"

    Examples:
      | name          | username      |
      | John Doe      | johndoe123    |
      | Anna Kowalska | anna_k        |
      | Test User     | testuser_99   |
```

---

### REQ-008 — Chained requests — użycie ID z poprzedniej odpowiedzi

| Pole | Wartość |
|------|---------|
| Priorytet | Wysoki |
| Kategoria | Chained Requests |
| Endpointy | POST /users · GET /users/{id} |
| Oczekiwane statusy | 201 · 200 |

**Opis:**  
System musi umożliwiać tworzenie użytkownika i natychmiastowe pobranie go po ID zwróconym w odpowiedzi POST. Scenariusz weryfikuje spójność danych między operacją zapisu a odczytu.

**Kryteria akceptacji:**
- `POST /users` zwraca 201 z nowym `id`
- `GET /users/{id}` używa `id` z poprzedniej odpowiedzi
- Pobrane dane zawierają te same wartości `name` i `username` co przy tworzeniu
- Żaden krok nie używa hardcoded ID

**Scenariusz Gherkin:**
```gherkin
Feature: Chained API Calls

  Scenario: Create user and retrieve it by returned ID
    Given I create a new user with name "TestUser" and username "test_chained"
    Then response status should be 201
    And I save the returned user ID

    When I get the user by the saved ID
    Then response status should be 200
    And the retrieved user name should be "TestUser"
    And the retrieved username should be "test_chained"
```

---

## 📊 Podsumowanie

| ID | Tytuł | Poziom | Priorytet |
|----|-------|--------|-----------|
| REQ-001 | Walidacja nagłówków HTTP | Podstawowy | Średni |
| REQ-002 | Negative testing — nieprawidłowe ID | Podstawowy | Wysoki |
| REQ-003 | Walidacja schematu JSON | Podstawowy | Wysoki |
| REQ-004 | Performance Baseline | Średni | Średni |
| REQ-005 | Walidacja struktury listy | Średni | Średni |
| REQ-006 | Pełny cykl CRUD E2E | Zaawansowany | Wysoki |
| REQ-007 | Data-driven z Faker | Zaawansowany | Średni |
| REQ-008 | Chained requests | Zaawansowany | Wysoki |
