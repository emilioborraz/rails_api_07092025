# Backend API – Game Events Tracker

This project is a simple API-only Rails backend designed to manage user authentication and track game events for logged-in users.

---

## 🚀

### Rails and ruby installation

https://guides.rubyonrails.org/install_ruby_on_rails.html

### ✅ Running this project

```bash
git clone git@github.com:emilioborraz/rails_api_07092025.git
cd rails_api_07092025
rails db:migrate
rails server
```

Navigate to http://127.0.0.1:3000/api/health and you should see a 200 OK returned.

Use this [Postman collection](https://github.com/emilioborraz/rails_api_07092025/tree/main/postman) to interact with the API.



## 📚 Development Process Overview
If you want to know more about the dev process of this project, continue reading.

### Environment Setup
Ruby and Rails were installed using Homebrew, following the official setup instructions. After setting the proper Ruby version, an API-only Rails project was created using `rails new backend_app --api`.

### User creation and authentication
The SessionsController and ApiController handle user registration and login. The Authentication concern is responsible of validating the user's token for protected APIs, it uses a custom token implementation in the Session model.

### Game Events Management
A GameEvent model and controller were scaffolded to handle game tracking. The initial attempt used a type column, but this conflicted with Rails' built-in STI mechanism, so it was renamed to game_type. A user_id field was added to associate each event with a user.

### InterviewsAccounts External API Integration
The user's subscription_status is managed by an external API. The InterviewsAccounts service class is responsible of fetching the subscription_status using an API key that is securely stored using Rails’ encrypted credentials mechanism.

### Testing
Rails scaffolding provides basic tests by default. Additional tests were added as needed, and all tests were run using: `rails test`


### ✅ Phase 1 – Project Initialization & Authentication

```bash
rails new backend_app --api
rails generate authentication
rails db:migrate

rails generate controller Api health
rails generate migration AddAuthTokenToSessions auth_token:string
rails db:migrate
```
### ✅ Phase 2 – Game Events & User Associations

```bash
# Initial scaffold attempt (note: renamed 'type' to avoid Rails STI conflict)
rails generate scaffold GameEvent game_name:string game_type:string occurred_at:datetime
rails db:migrate

# Add user reference to GameEvents
rails generate migration AddUserIdToGameEvents user_id:int
rails db:migrate

rails credentials:edit

rails test
```

### ✅ Phase 3 – Secure External API Integration & Tests

```bash
rails credentials:edit

rails test
```