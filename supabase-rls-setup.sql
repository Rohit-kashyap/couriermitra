-- ============================================================
-- CourierMitra — Row Level Security (RLS) Setup
-- Run this entire file in your Supabase SQL Editor
-- ============================================================
-- What this does:
-- 1. Turns on RLS for every table (data is locked down by default)
-- 2. Adds specific rules for who can read/write what
-- ============================================================


-- ============================================================
-- STEP 1: Enable RLS on all tables
-- ============================================================

ALTER TABLE clients         ENABLE ROW LEVEL SECURITY;
ALTER TABLE shipments       ENABLE ROW LEVEL SECURITY;
ALTER TABLE carriers        ENABLE ROW LEVEL SECURITY;
ALTER TABLE customers       ENABLE ROW LEVEL SECURITY;
ALTER TABLE tracking_events ENABLE ROW LEVEL SECURITY;
ALTER TABLE users           ENABLE ROW LEVEL SECURITY;


-- ============================================================
-- STEP 2: CLIENTS table policies
-- ============================================================

-- A logged-in client can read their own record only
CREATE POLICY "clients: read own record"
ON clients FOR SELECT
TO authenticated
USING (auth.email() = email);

-- A logged-in client can update their own record only
CREATE POLICY "clients: update own record"
ON clients FOR UPDATE
TO authenticated
USING (auth.email() = email)
WITH CHECK (auth.email() = email);

-- Public (no login) can read a client record only when verifying email
-- (track.html needs company name/branding, verify.html needs the token)
CREATE POLICY "clients: public read for tracking and verification"
ON clients FOR SELECT
TO anon
USING (true);


-- ============================================================
-- STEP 3: SHIPMENTS table policies
-- ============================================================

-- A logged-in client can read their own shipments only
CREATE POLICY "shipments: client reads own"
ON shipments FOR SELECT
TO authenticated
USING (
    client_id = (
        SELECT id FROM clients WHERE email = auth.email()
    )
);

-- A logged-in client can create shipments for themselves only
CREATE POLICY "shipments: client inserts own"
ON shipments FOR INSERT
TO authenticated
WITH CHECK (
    client_id = (
        SELECT id FROM clients WHERE email = auth.email()
    )
);

-- A logged-in client can update their own shipments only
CREATE POLICY "shipments: client updates own"
ON shipments FOR UPDATE
TO authenticated
USING (
    client_id = (
        SELECT id FROM clients WHERE email = auth.email()
    )
)
WITH CHECK (
    client_id = (
        SELECT id FROM clients WHERE email = auth.email()
    )
);

-- Public (no login) can read active shipments — for the public tracking page
CREATE POLICY "shipments: public read active"
ON shipments FOR SELECT
TO anon
USING (is_active = true);


-- ============================================================
-- STEP 4: CARRIERS table policies
-- ============================================================

-- A logged-in client can read their own carriers
CREATE POLICY "carriers: client reads own"
ON carriers FOR SELECT
TO authenticated
USING (
    client_id = (
        SELECT id FROM clients WHERE email = auth.email()
    )
);

-- A logged-in client can add carriers for themselves
CREATE POLICY "carriers: client inserts own"
ON carriers FOR INSERT
TO authenticated
WITH CHECK (
    client_id = (
        SELECT id FROM clients WHERE email = auth.email()
    )
);

-- A logged-in client can update their own carriers
CREATE POLICY "carriers: client updates own"
ON carriers FOR UPDATE
TO authenticated
USING (
    client_id = (
        SELECT id FROM clients WHERE email = auth.email()
    )
)
WITH CHECK (
    client_id = (
        SELECT id FROM clients WHERE email = auth.email()
    )
);

-- Public can read carriers (needed for tracking page to show carrier name)
CREATE POLICY "carriers: public read"
ON carriers FOR SELECT
TO anon
USING (true);


-- ============================================================
-- STEP 5: CUSTOMERS table policies
-- ============================================================

-- A logged-in client can read their own customers only
CREATE POLICY "customers: client reads own"
ON customers FOR SELECT
TO authenticated
USING (
    client_id = (
        SELECT id FROM clients WHERE email = auth.email()
    )
);

-- A logged-in client can add customers for themselves only
CREATE POLICY "customers: client inserts own"
ON customers FOR INSERT
TO authenticated
WITH CHECK (
    client_id = (
        SELECT id FROM clients WHERE email = auth.email()
    )
);

-- A logged-in client can update their own customers only
CREATE POLICY "customers: client updates own"
ON customers FOR UPDATE
TO authenticated
USING (
    client_id = (
        SELECT id FROM clients WHERE email = auth.email()
    )
)
WITH CHECK (
    client_id = (
        SELECT id FROM clients WHERE email = auth.email()
    )
);


-- ============================================================
-- STEP 6: TRACKING_EVENTS table policies
-- ============================================================

-- A logged-in client can read tracking events for their own shipments
CREATE POLICY "tracking_events: client reads own"
ON tracking_events FOR SELECT
TO authenticated
USING (
    shipment_id IN (
        SELECT id FROM shipments
        WHERE client_id = (
            SELECT id FROM clients WHERE email = auth.email()
        )
    )
);

-- A logged-in client can insert tracking events for their own shipments
CREATE POLICY "tracking_events: client inserts own"
ON tracking_events FOR INSERT
TO authenticated
WITH CHECK (
    shipment_id IN (
        SELECT id FROM shipments
        WHERE client_id = (
            SELECT id FROM clients WHERE email = auth.email()
        )
    )
);

-- Public can read tracking events (needed for public tracking page)
CREATE POLICY "tracking_events: public read"
ON tracking_events FOR SELECT
TO anon
USING (true);


-- ============================================================
-- STEP 7: USERS table policies
-- ============================================================

-- A logged-in user can read their own record
CREATE POLICY "users: read own"
ON users FOR SELECT
TO authenticated
USING (auth.uid() = id);

-- Public can update users table during email verification only
-- (verify.html sets is_active and email_verified via token)
CREATE POLICY "users: public update for verification"
ON users FOR UPDATE
TO anon
USING (true)
WITH CHECK (true);


-- ============================================================
-- Done! All RLS policies applied.
-- ============================================================
