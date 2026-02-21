-- ============================================================
-- CourierMitra — Database Migration
-- Run this in your Supabase SQL Editor
-- ============================================================

-- ── 1. UPDATE clients table ──
ALTER TABLE clients
    ADD COLUMN IF NOT EXISTS company_code     TEXT,
    ADD COLUMN IF NOT EXISTS location_code    TEXT,
    ADD COLUMN IF NOT EXISTS address2         TEXT,
    ADD COLUMN IF NOT EXISTS phone2           TEXT,
    ADD COLUMN IF NOT EXISTS phone3           TEXT,
    ADD COLUMN IF NOT EXISTS gst_number       TEXT,
    ADD COLUMN IF NOT EXISTS website          TEXT,
    ADD COLUMN IF NOT EXISTS hsn_sac_code     TEXT,
    ADD COLUMN IF NOT EXISTS state            TEXT,
    ADD COLUMN IF NOT EXISTS bank_name        TEXT,
    ADD COLUMN IF NOT EXISTS bank_branch      TEXT,
    ADD COLUMN IF NOT EXISTS bank_account     TEXT,
    ADD COLUMN IF NOT EXISTS bank_ifsc        TEXT,
    ADD COLUMN IF NOT EXISTS cgst_rate        NUMERIC DEFAULT 9,
    ADD COLUMN IF NOT EXISTS sgst_rate        NUMERIC DEFAULT 9,
    ADD COLUMN IF NOT EXISTS igst_rate        NUMERIC DEFAULT 18;

-- ── 2. UPDATE customers table ──
ALTER TABLE customers
    ADD COLUMN IF NOT EXISTS ac_code   TEXT,
    ADD COLUMN IF NOT EXISTS gst_no    TEXT,
    ADD COLUMN IF NOT EXISTS state     TEXT,
    ADD COLUMN IF NOT EXISTS status    TEXT DEFAULT 'active';

-- ── 3. UPDATE shipments table ──
ALTER TABLE shipments
    ADD COLUMN IF NOT EXISTS customer_id         UUID REFERENCES customers(id) ON DELETE SET NULL,
    ADD COLUMN IF NOT EXISTS doc_type            TEXT DEFAULT 'N - Non Document',
    ADD COLUMN IF NOT EXISTS network_tracking_no TEXT,
    ADD COLUMN IF NOT EXISTS receiver_name       TEXT,
    ADD COLUMN IF NOT EXISTS remarks             TEXT,
    ADD COLUMN IF NOT EXISTS sender_name         TEXT,
    ADD COLUMN IF NOT EXISTS sender_reference    TEXT,
    ADD COLUMN IF NOT EXISTS sender_phone        TEXT,
    ADD COLUMN IF NOT EXISTS sender_address      TEXT,
    ADD COLUMN IF NOT EXISTS sender_city         TEXT,
    ADD COLUMN IF NOT EXISTS sender_state        TEXT,
    ADD COLUMN IF NOT EXISTS sender_pincode      TEXT,
    ADD COLUMN IF NOT EXISTS sender_country      TEXT DEFAULT 'India',
    ADD COLUMN IF NOT EXISTS consignee_state     TEXT,
    ADD COLUMN IF NOT EXISTS consignee_zip       TEXT,
    ADD COLUMN IF NOT EXISTS total_actual_weight NUMERIC,
    ADD COLUMN IF NOT EXISTS total_vol_weight    NUMERIC,
    ADD COLUMN IF NOT EXISTS piece_data          TEXT,
    ADD COLUMN IF NOT EXISTS rate_per_kg         NUMERIC,
    ADD COLUMN IF NOT EXISTS lump_sum_amount     NUMERIC,
    ADD COLUMN IF NOT EXISTS base_amount         NUMERIC,
    ADD COLUMN IF NOT EXISTS gst_amount          NUMERIC,
    ADD COLUMN IF NOT EXISTS total_amount        NUMERIC;

-- ── 4. CREATE invoices table ──
CREATE TABLE IF NOT EXISTS invoices (
    id             UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    client_id      UUID NOT NULL REFERENCES clients(id) ON DELETE CASCADE,
    customer_id    UUID REFERENCES customers(id) ON DELETE SET NULL,
    invoice_no     TEXT NOT NULL,
    invoice_date   DATE NOT NULL,
    period_from    DATE NOT NULL,
    period_to      DATE NOT NULL,
    shipment_count INTEGER DEFAULT 0,
    grand_total    NUMERIC DEFAULT 0,
    gst_total      NUMERIC DEFAULT 0,
    status         TEXT DEFAULT 'generated',
    shipment_ids   TEXT,
    created_at     TIMESTAMPTZ DEFAULT NOW()
);

-- RLS for invoices
ALTER TABLE invoices ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Clients can manage own invoices"
ON invoices FOR ALL
USING (client_id = (
    SELECT id FROM clients WHERE email = auth.jwt() ->> 'email'
));

-- ── 5. ADD carrier_name text column to shipments ──
ALTER TABLE shipments
    ADD COLUMN IF NOT EXISTS carrier_name TEXT;

-- ── 6. INDEX for performance ──
CREATE INDEX IF NOT EXISTS idx_shipments_client_id   ON shipments(client_id);
CREATE INDEX IF NOT EXISTS idx_shipments_customer_id ON shipments(customer_id);
CREATE INDEX IF NOT EXISTS idx_invoices_client_id    ON invoices(client_id);
CREATE INDEX IF NOT EXISTS idx_customers_client_id   ON customers(client_id);
