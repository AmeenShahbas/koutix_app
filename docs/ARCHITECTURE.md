# Koutix Frontend Architecture & Product Knowledge

## 1. Overview
Koutix frontend is one Flutter project that serves two different products:

### Web App (Phase 1)
- **Used by**: Supermarkets / hypermarkets
- **Purpose**: Setup, control, monitoring
- **Platform**: Web (Chrome)

### Partner App (Phase 2)
- **Used by**: Store owners, managers, staff
- **Purpose**: Daily operations
- **Platform**: Android / iOS

**Both products:**
- Share the same backend
- Share the same authentication system (Firebase Auth)
- Share the same data models
- Are separated only by platform (web vs mobile) and role

## 2. Core Philosophy
The frontend is **not a billing system**. It is a **control & experience layer**.

**Key Principles:**
- Frontend never decides prices or tax
- Frontend never edits POS data
- Frontend reflects backend truth
- Frontend enforces UX clarity, not business logic

## 3. Platform Split
**Platform decides what app the user sees.** This decision happens at app entry, not at routing level.

| Platform | App |
| :--- | :--- |
| Web (Chrome) | Web Admin App |
| Android / iOS | Partner App |

## 4. Web App (Phase 1) — Product Knowledge
### 4.1 Who Uses It
- Store Owner
- Store Manager
- Admin staff (finance / audit)
- Koutix internal admin (later)
- **Context**: Office setting, laptops/desktops.

### 4.2 Purpose
- Onboard stores / Configure branding
- Connect POS systems
- Monitor transactions / View reports
- **Role**: Control plane of Koutix.

### 4.3 Responsibilities (What it DOES)
- **Authenticates users**: Via Firebase Auth (Backend maps user -> store + role)
- **Creates & manages stores**: Name, Address, Status
- **Manages branding**: Logo, Colors (consumed by mobile apps)
- **Sets up POS integration**: Instructions, Live health check (Does NOT edit POS data)
- **Shows transactions**: Read-only, Linked to invoice numbers, For audit/reconciliation
- **Shows analytics**: Counts, Trends

### 4.4 Constraints (What it NEVER DOES)
- Never edits prices
- Never calculates tax
- Never pushes invoices manually
- Never bypasses POS
- Never serves customers

## 5. Partner App (Phase 2) — Product Knowledge
### 5.1 Who Uses It
- Store Owner (mobile)
- Store Manager
- Floor Supervisor
- Security / Staff
- **Context**: Shop floor, need fast info/alerts.

### 5.2 Purpose
- Monitor store activity in real time
- React to issues / Control operations
- **Role**: Operations layer of Koutix.

### 5.3 Responsibilities (What it DOES)
- **Shows live store status**: POS online/offline, Checkout enabled/disabled
- **Shows live activity**: Recent transactions, Payment success/failure
- **Shows alerts**: POS disconnected, Sync failed, Suspicious activity
- **Provides quick actions**: Pause/Resume checkout, Force POS sync
- **Respects permissions**: (Owner: all, Manager: ops, Staff: view)

### 5.4 Constraints (What it NEVER DOES)
- Never handles onboarding
- Never edits branding
- Never manages users
- Never replaces web dashboards
- Never touches accounting

## 6. Authentication & Identity
- **Frontend Role**: Log users in, Get ID token.
- **Backend Role**: Decide roles, permissions, authorization.
- Frontend does **not** trust Firebase claims blindly.

## 7. Role Awareness
- Frontend knows the role to: Hide screens, Disable actions, Show correct UI.
- Backend performs final permission checks and security enforcement.

## 8. Data Flow
`User Action -> Frontend UI -> Backend API -> POS Connector/DB -> Backend Response -> Frontend Render`
- Frontend never "assumes" success.

## 9. State Management
- **Frontend state is**: Session-based, Store-context aware, Read-heavy, Reactive.
- **Key State**: Auth state, Active store, Active role, POS status, Transaction list.
- No long-term critical state lives only on frontend.

## 10. Error Handling
- **Philosophy**: Clear, Non-technical, Guide next action.
- **Examples**: "POS is currently offline", "Unable to sync, retrying..."
- **Never expose**: Stack traces, DB errors, POS internals.

## 11. UI/UX Philosophy
- **Web App**: Clean, Professional, Dashboard-like, Data dense but readable.
- **Partner App**: Minimal, Large touch targets, Alert-driven, Fast glance usability.

## 12. Mental Model
Koutix frontend is a **platform interface** with:
- A web control plane
- A mobile operations layer
- A backend-driven brain
- A POS-centric truth
