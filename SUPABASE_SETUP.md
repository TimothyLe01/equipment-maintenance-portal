# Supabase setup — 3-minute walkthrough

Shared data across everyone who uses the site, with live updates.

## 1. Create a free project

1. Go to <https://supabase.com> → **Start your project** → sign in with GitHub.
2. **New project** → name it `equipment-portal` (or anything).
3. Pick a strong database password (you won't need it again for this setup).
4. Region: pick the one closest to your users (e.g. `US East (North Virginia)`).
5. Click **Create new project** and wait ~60 seconds for it to provision.

## 2. Run the schema

1. In the left sidebar, click the **SQL Editor** icon.
2. Click **+ New query**.
3. Open `schema.sql` from this folder, copy its contents, paste into the editor.
4. Click **Run** (or Cmd/Ctrl+Enter). You should see "Success. No rows returned".

## 3. Copy the two strings

1. Left sidebar → **Project Settings** (gear icon) → **API**.
2. Copy these two values:
   - **Project URL** — looks like `https://abcdefghijklm.supabase.co`
   - **Project API keys → `anon` `public`** — starts with `eyJ…`

## 4. Paste them in chat

Send them both to me and I'll push the live update. The `anon` key is safe
to expose publicly — it's designed to live in client-side code, and the
Row Level Security policies in `schema.sql` are what control what can be
read/written.

## What you'll see after it's live

- A small status pill in the header: **● Synced** (green), **● Saving…**
  (amber while pushing), or **● Offline** (red if the internet is out).
- Open the site on two browsers at once — checking a PM on one updates
  the other within ~1 second.
- All equipment data, task history, and notification emails live in
  your Supabase database and are the same for every visitor.

## Later, if you want per-user accounts

The schema is set up for an internal shared tool (anyone with the link can
read/write). When you want proper login accounts, replace the RLS policies
with `auth.uid()`-based rules and add Supabase Auth to the portal — ~50 lines
of extra JavaScript.
