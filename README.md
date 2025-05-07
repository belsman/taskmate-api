# 🔧 TaskMate – Ruby on Rails API

## 🚀 Setup Instructions

1. **Clone the repository:**

   ```bash
   git clone https://github.com/belsman/taskmate-api.git
   cd taskmate-api
   ```

2. **Install dependencies:**

   ```bash
   bundle install
   ```

3. **Setup database:**

   ```bash
   rails db:create db:migrate db:seed
   ```

4. **Start server:**
   ```bash
   rails s
   ```
   - Accessible via `http://<your-ip>:3000`

## 🔐 JWT Handling

- JWT is generated with `jwt` gem on login/signup.
- Expected in `Authorization: Bearer <token>` for protected routes.
- Secret key is stored in encrypted credentials:
  ```yaml
  jwt_secret: your-very-secure-random-string
  ```
  Accessed with:
  ```ruby
  JWT_SECRET = Rails.application.credentials.jwt_secret
  ```
- Alternatively (less preferred), fallback to:
  ```ruby
  JWT_SECRET = Rails.application.secret_key_base
  ```

## 🌱 Seeding and Test Login

Run:

```bash
rails db:seed
```

It creates these users:

| Email               | Password |
| ------------------- | -------- |
| alice@example.com   | password |
| bob@example.com     | password |
| charlie@example.com | password |

### 🔐 Login Request

**Endpoint:**

```
POST /api/v1/auth/login
```

**Request Example:**

```json
{
  "email": "alice@example.com",
  "password": "password"
}
```

**Response Example:**

```json
{
  "token": "your.jwt.token.here",
  "exp": "2025-05-08T03:00:00Z",
  "user": {
    "id": 1,
    "email": "alice@example.com"
  }
}
```

Use the token like so:

```http
Authorization: Bearer your.jwt.token.here
```

## 🧠 Assumptions

- One user model.
- Token-based auth only.
- CORS enabled for mobile clients.

## ⚠️ Challenges Faced

- Ensuring mobile devices can reach the Rails server locally.
