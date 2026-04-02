# ARCHITECTURE.md

## Tech Stack

- Flutter (Dart)
- Supabase (Auth, Postgres, Realtime, Storage)
- Riverpod (Notifier, AsyncNotifier)
- Local DB: Isar (encrypted)
- Payments: Stripe (flutter_stripe)
- Biometrics: local_auth

## App Architecture

- Feature-first architecture
- Clean separation: data / application / presentation

## Folder Structure

lib/
├── core/
│   ├── constants/
│   ├── theme/
│   ├── utils/
│   ├── services/
│   │    ├── supabase_service.dart
│   │    ├── local_db_service.dart
│
├── features/
│   ├── auth/
│   ├── ticket/
│   │   ├── data/
│   │   │   ├── models/
│   │   │   ├── repositories/
│   │   ├── application/
│   │   │   ├── providers/
│   │   ├── presentation/
│   │
│   ├── conductor/
│   ├── refund/
│   ├── wallet/

## Ticket System Design

- Floating ticket (no route/vehicle initially)
- Fields:
  - id
  - user_id
  - source
  - destination
  - qr_code
  - pin
  - route_no (nullable)
  - vehicle_no (nullable)
  - verified (bool)
  - status (active | verified | expired | refunded)
  - created_at
  - verified_at (nullable)

## Ticket Lifecycle

- active → verified → expired
- active → refunded
- Ticket expires after 12 hours

## Conductor System

- Conductor must start a shift before verification
- Shift includes:
  - route_no
  - vehicle_no
  - bus_image_url

- Ticket verification must:
  - set verified = true
  - set route_no
  - set vehicle_no
  - set verified_at

## Wallet & Payments

- Each user has a wallet
- Wallet stores balance
- Transactions include:
  - topup (Stripe)
  - payment (ticket purchase)
  - refund

## Refund System

- User submits:
  - reason
  - optional video proof

- Refund linked to:
  - ticket_id
  - vehicle_no (post verification)

## Session Management

- Each user has current_session_id
- On login:
  - overwrite session
- If mismatch:
  - force logout

## Offline Strategy

- Load from Isar first
- Sync with Supabase when online
- Always cache active tickets

## Realtime Handshake

- Subscribe to ticket_id via Supabase Realtime
- On verified=true:
  - update local DB
  - update UI instantly
  - attach route_no + vehicle_no

## Security

- Block screenshots (flutter_windowmanager / screen_protector)
- Encrypt local DB keys via flutter_secure_storage

## Performance

- Dispose realtime subscriptions properly
- Avoid heavy rebuilds in animation
- Handle websocket reconnection

---

## Rules

- Use Riverpod ONLY
- No Firebase usage
- No business logic in UI
- All data access via repositories
- Must support offline-first behavior
- All local storage must be encrypted

---

**Important:** This file is the single source of truth. All generated code must follow it strictly.