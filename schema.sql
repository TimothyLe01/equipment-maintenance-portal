-- ════════════════════════════════════════════════════════════
--  Equipment Maintenance Portal — Supabase schema
--  Paste this into: Supabase Dashboard → SQL Editor → New query
-- ════════════════════════════════════════════════════════════

-- One-row table that holds the whole portal state as JSON.
-- Simple model that fits the single-document shape of the existing
-- localStorage data and keeps the client code nearly unchanged.
create table if not exists portal_state (
  id         int primary key default 1,
  data       jsonb not null default '{}'::jsonb,
  updated_at timestamptz not null default now(),
  constraint only_one_row check (id = 1)
);

-- Auto-touch updated_at on every write
create or replace function set_updated_at() returns trigger language plpgsql as $$
begin
  new.updated_at = now();
  return new;
end;
$$;

drop trigger if exists trg_portal_state_updated on portal_state;
create trigger trg_portal_state_updated
  before update on portal_state
  for each row execute procedure set_updated_at();

-- Seed the single row (idempotent)
insert into portal_state (id, data)
values (1, '{}'::jsonb)
on conflict (id) do nothing;

-- ── Row Level Security ────────────────────────────────────
-- This is an internal shared tool. Anyone with the site link and the
-- publishable anon key can read/write. If later you need per-user
-- accounts, replace these policies with auth.uid()-based rules.
alter table portal_state enable row level security;

drop policy if exists "read all" on portal_state;
drop policy if exists "update all" on portal_state;
drop policy if exists "insert all" on portal_state;

create policy "read all"   on portal_state for select using (true);
create policy "update all" on portal_state for update using (true) with check (true);
create policy "insert all" on portal_state for insert with check (true);

-- ── Enable Realtime broadcasting on this table ────────────
alter publication supabase_realtime add table portal_state;
