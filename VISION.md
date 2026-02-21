# CourierMitra — Product Vision & Sprint Tracker

> Last Updated: February 2026
> Built for: Small courier operators across India
> Stack: HTML + Vanilla JS + Supabase + Netlify + Razorpay

---

## What Is CourierMitra?

CourierMitra is a **subscription-based courier operations portal** for small and mid-size courier businesses. It lets any courier operator — without any technical knowledge — sign up, set up their brand, manage shipments, give their customers a tracking link, and generate bills. All from a browser, no app or server needed.

---

## Who Is This For?

**Primary User: The Small Courier Business Owner**

Meet Ramesh. He runs "Ramesh Express" in Pune. He has 2–4 staff, handles 50–200 shipments a day, and currently manages everything on WhatsApp and Excel. He wants to:
- Look professional in front of customers
- Stop getting "where is my parcel?" calls all day
- Generate proper AWB numbers and bills
- Track which shipments are delivered and which are pending

Ramesh is not technical. He needs something simple, affordable, and that works on day one.

**Secondary User: Ramesh's Staff**
- Operators who log in and add/update shipments daily
- They don't need access to billing or settings

**End User: The Consignee (Ramesh's Customer)**
- Receives a tracking link via SMS/WhatsApp
- Visits track.html, enters AWB, sees where their parcel is
- Never needs to create an account

**Platform Owner: You (Super Admin)**
- Manages all courier businesses on the platform
- Controls subscriptions, trials, and support
- Views all data across all businesses

---

## The Three Pillars

```
OPERATE  →  Manage shipments, customers, carriers, staff in one place
TRACK    →  Give every consignee a real-time tracking link
GROW     →  Billing, reports, and business insights
```

---

## Subscription Plans (Proposed)

| Plan        | Price         | Shipments/Month | Staff Logins | Features                        |
|-------------|---------------|-----------------|--------------|----------------------------------|
| Free Trial  | Free 14 days  | Up to 100       | 1 (Owner)    | Full access to test              |
| Starter     | ₹999/month    | Up to 500       | 2            | Core operations + tracking       |
| Growth      | ₹2,499/month  | Up to 2,000     | 5            | + Billing/invoices + reports     |
| Pro         | ₹4,999/month  | Unlimited        | 15           | + Bulk upload + priority support |

---

## Overall Roadmap

```
Phase 1: Fix & Solidify     → Stable, secure, working product
Phase 2: Monetize           → Payments, subscriptions, invoices
Phase 3: Scale              → Staff logins, notifications, reports
Phase 4: Grow               → Bulk tools, custom domains, API
```

---

---

# SPRINT TRACKER

## How to Read This

- [ ] = Not started
- [~] = In progress
- [x] = Done
- Each sprint = 1–2 weeks of focused work

---

---

## PHASE 1 — Fix & Solidify
> Goal: A working, secure product that a real business can use today.

---

### Sprint 1 — Security & Auth Fixes
**Goal:** Close the critical security holes so the product is safe to use.

#### Tasks
- [x] S1-01 — Fix client-admin login: add real password validation (now uses Supabase Auth)
- [x] S1-02 — Remove hardcoded demo credentials from client-admin.html source code
- [x] S1-03 — Enable Supabase Row Level Security (RLS) on all tables
- [x] S1-04 — Write RLS policies: clients can only see their own data
- [x] S1-05 — Write RLS policies: public can only read active shipments (for tracking)
- [x] S1-06 — Escape all dynamic HTML content to prevent XSS attacks
- [ ] S1-07 — Move Supabase credentials to a shared config (stop repeating in every file)

**Definition of Done:** No security warnings. Client A cannot see Client B's data. Login requires correct password.

---

### Sprint 2 — Complete Super Admin
**Goal:** Super Admin can actually manage the platform (currently all buttons show alerts).

#### Tasks
- [ ] S2-01 — Build Add Shipment form in Super Admin dashboard
- [ ] S2-02 — Build Edit Shipment functionality in Super Admin dashboard
- [ ] S2-03 — Build Delete Shipment with confirmation dialog
- [ ] S2-04 — Build View Shipment Details panel (full shipment + tracking history)
- [ ] S2-05 — Add client list view in Super Admin (see all registered businesses)
- [ ] S2-06 — Add ability to activate / suspend a client account from Super Admin
- [ ] S2-07 — Add subscription status badge per client (Trial / Active / Inactive / Suspended)
- [ ] S2-08 — Add search and filter by client name, status, plan in Super Admin

**Definition of Done:** Super Admin can fully manage all shipments and clients without going to Supabase dashboard.

---

### Sprint 3 — Trial & Subscription Enforcement
**Goal:** The 14-day trial actually works — and expired accounts cannot log in.

#### Tasks
- [ ] S3-01 — Store trial_start_date when email is verified
- [ ] S3-02 — Calculate trial days remaining on every client login
- [ ] S3-03 — Show trial countdown banner in client dashboard ("X days remaining in your trial")
- [ ] S3-04 — Block login and show upgrade prompt when trial has expired
- [ ] S3-05 — Super Admin can manually extend a trial (for support/sales)
- [ ] S3-06 — Super Admin can manually set subscription status (active/inactive)
- [ ] S3-07 — Add suspended account page with contact/support message

**Definition of Done:** Trial expires after 14 days. Expired clients see upgrade screen. Super admin can manage manually.

---

### Sprint 4 — Client Dashboard Completion
**Goal:** Every button in the client dashboard does what it says.

#### Tasks
- [ ] S4-01 — Complete "View Shipment Details" — show full info + tracking timeline
- [ ] S4-02 — Add carrier management in Settings tab (add/edit/deactivate carriers)
- [ ] S4-03 — Add AWB prefix configuration in Settings (currently read-only in DB)
- [ ] S4-04 — Add logo upload for company branding (currently only colors supported)
- [ ] S4-05 — Show shipment count limit based on plan (e.g., "423 / 500 shipments used")
- [ ] S4-06 — Debounce search inputs (stop hitting DB on every keystroke)
- [ ] S4-07 — Add pagination to shipments list (currently loads all at once — slow)

**Definition of Done:** No broken buttons. All core features work end-to-end.

---

---

## PHASE 2 — Monetize
> Goal: Real businesses pay real money. Revenue starts flowing.

---

### Sprint 5 — Razorpay Subscription Integration
**Goal:** Businesses can subscribe and pay monthly/annually via Razorpay.

#### Tasks
- [ ] S5-01 — Create Razorpay account and get API keys
- [ ] S5-02 — Build pricing/plans page (public-facing, before login)
- [ ] S5-03 — Integrate Razorpay Subscription API for recurring billing
- [ ] S5-04 — Handle payment success webhook — upgrade subscription_status to 'active'
- [ ] S5-05 — Handle payment failure webhook — notify client, set grace period
- [ ] S5-06 — Handle subscription cancellation — downgrade to inactive after period ends
- [ ] S5-07 — Store payment history in new payments table in Supabase
- [ ] S5-08 — Show billing history tab in client settings (invoices, payment dates)

**Definition of Done:** A new user can sign up, choose a plan, pay, and get access automatically.

---

### Sprint 6 — Invoice & Bill Generation
**Goal:** Clients can generate and download professional invoices for their shipments.

#### Tasks
- [ ] S6-01 — Design invoice template (company logo, AWB, consignee, weight, charges)
- [ ] S6-02 — Add rate card settings per client (price per kg, per shipment, COD charges)
- [ ] S6-03 — Calculate shipment charges automatically based on rate card
- [ ] S6-04 — Add "Generate Invoice" button per shipment
- [ ] S6-05 — Add bulk invoice generation (select multiple shipments → generate combined bill)
- [ ] S6-06 — Generate PDF and allow download (use browser print-to-PDF or PDF library)
- [ ] S6-07 — Add invoice history tab (list of all generated invoices)

**Definition of Done:** A client can select shipments, click Generate Invoice, and download a PDF bill with their logo.

---

---

## PHASE 3 — Scale
> Goal: More users per business. Automated notifications. Business insights.

---

### Sprint 7 — Staff / Multi-User Login
**Goal:** Business owner can add their staff who can log in with their own credentials.

#### Tasks
- [ ] S7-01 — Add "Team" tab in client settings
- [ ] S7-02 — Business owner can invite staff by email
- [ ] S7-03 — Staff receives invite email with set-password link
- [ ] S7-04 — Staff can log in with own email/password (scoped to their company data)
- [ ] S7-05 — Role system: Owner (full access) vs Operator (add/edit shipments only, no billing/settings)
- [ ] S7-06 — Owner can deactivate a staff member's access
- [ ] S7-07 — Enforce staff count limit based on subscription plan

**Definition of Done:** Owner adds staff. Staff logs in and adds shipments. Owner can remove access anytime.

---

### Sprint 8 — SMS & WhatsApp Notifications
**Goal:** Consignees are automatically notified at each shipment milestone.

#### Tasks
- [ ] S8-01 — Integrate Twilio or MSG91 for SMS
- [ ] S8-02 — Send SMS on shipment creation with tracking link
- [ ] S8-03 — Send SMS when status changes to "Out for Delivery"
- [ ] S8-04 — Send SMS on "Delivered"
- [ ] S8-05 — Add WhatsApp notification option (via WhatsApp Business API or Interakt)
- [ ] S8-06 — Client can customize notification templates (add their brand name)
- [ ] S8-07 — Client can toggle notifications on/off per event type in Settings

**Definition of Done:** Consignee gets tracking SMS automatically. Client can customize the message.

---

### Sprint 9 — Reports & Analytics Dashboard
**Goal:** Business owner understands their business performance at a glance.

#### Tasks
- [ ] S9-01 — Add Reports tab in client dashboard
- [ ] S9-02 — Total shipments this month (vs last month)
- [ ] S9-03 — Delivery success rate (% delivered vs cancelled/on-hold)
- [ ] S9-04 — Average delivery time (days from booking to delivery)
- [ ] S9-05 — Top 10 customers by shipment volume
- [ ] S9-06 — Carrier-wise performance breakdown
- [ ] S9-07 — Export reports as CSV/Excel
- [ ] S9-08 — Date range filter for all reports

**Definition of Done:** Business owner opens Reports and immediately understands how their business performed this month.

---

---

## PHASE 4 — Grow
> Goal: Power features that make switching away painful.

---

### Sprint 10 — Bulk Shipment Upload
**Goal:** Clients with high volume can upload 100s of shipments via Excel in one click.

#### Tasks
- [ ] S10-01 — Design Excel/CSV template for bulk upload
- [ ] S10-02 — Build file upload UI in client dashboard
- [ ] S10-03 — Parse and validate uploaded data (highlight errors)
- [ ] S10-04 — Preview before import (show table of what will be created)
- [ ] S10-05 — Batch create shipments and auto-generate AWB numbers
- [ ] S10-06 — Show upload results (X created, Y failed, with reasons)
- [ ] S10-07 — Download failed rows as Excel for correction and re-upload

**Definition of Done:** Client uploads 100-row Excel file. 100 shipments are created with AWB numbers in under 30 seconds.

---

### Sprint 11 — Custom Tracking Domain
**Goal:** Businesses can offer tracking on their own domain (track.rameshexpress.in).

#### Tasks
- [ ] S11-01 — Allow client to configure custom domain in settings
- [ ] S11-02 — Set up DNS CNAME instructions for client
- [ ] S11-03 — Auto-detect custom domain and load correct client branding
- [ ] S11-04 — White-label the tracking page (remove "Powered by CourierMitra" option for Pro plan)

**Definition of Done:** Consignee visits track.rameshexpress.in and sees Ramesh's branded tracking page.

---

### Sprint 12 — Platform Polish & Launch Readiness
**Goal:** The product is ready for public launch and marketing.

#### Tasks
- [ ] S12-01 — Build public landing page (couriermitra.com) explaining the product
- [ ] S12-02 — Add onboarding flow for new signups (guided setup wizard)
- [ ] S12-03 — Add in-app help tooltips and FAQ section
- [ ] S12-04 — Set up error monitoring (e.g., Sentry free tier)
- [ ] S12-05 — Write Terms of Service and Privacy Policy pages
- [ ] S12-06 — Set up customer support channel (email / WhatsApp)
- [ ] S12-07 — Performance audit: page load times, mobile responsiveness check
- [ ] S12-08 — Final security audit before launch

**Definition of Done:** A stranger can visit the website, understand the product, sign up, and start using it without any help.

---

---

## Current Status Summary

| Phase | Sprint | Name                          | Status      |
|-------|--------|-------------------------------|-------------|
| 1     | S1     | Security & Auth Fixes         | Not Started |
| 1     | S2     | Complete Super Admin          | Not Started |
| 1     | S3     | Trial & Subscription Enforcement | Not Started |
| 1     | S4     | Client Dashboard Completion   | Not Started |
| 2     | S5     | Razorpay Integration          | Not Started |
| 2     | S6     | Invoice & Bill Generation     | Not Started |
| 3     | S7     | Staff / Multi-User Login      | Not Started |
| 3     | S8     | SMS & WhatsApp Notifications  | Not Started |
| 3     | S9     | Reports & Analytics           | Not Started |
| 4     | S10    | Bulk Shipment Upload          | Not Started |
| 4     | S11    | Custom Tracking Domain        | Not Started |
| 4     | S12    | Platform Polish & Launch      | Not Started |

---

## What Already Exists (Code Inventory)

| Feature                        | File               | Status              |
|--------------------------------|--------------------|---------------------|
| Shipment CRUD (client)         | client-admin.html  | Working             |
| Customer CRUD (client)         | client-admin.html  | Working             |
| AWB auto-generation            | client-admin.html  | Working             |
| Tracking events on status change | client-admin.html | Working             |
| Company settings (basic)       | client-admin.html  | Partial             |
| Public shipment tracking       | track.html         | Working             |
| Email verification + trial start | verify.html      | Working             |
| Super Admin login              | login.html         | Working             |
| Super Admin shipment view      | index.html         | Working (read-only) |
| Super Admin CRUD               | index.html         | Stubbed (alerts)    |
| Client login with password     | client-admin.html  | Broken (no check)   |
| Subscription enforcement       | (none)             | Not built           |
| Payments                       | (none)             | Not built           |
| Invoicing                      | (none)             | Not built           |
| Staff logins                   | (none)             | Not built           |
| Notifications                  | (none)             | Not built           |
| Reports                        | (none)             | Not built           |

---

*This document is the single source of truth for the CourierMitra build. Update sprint task statuses as work is completed.*
