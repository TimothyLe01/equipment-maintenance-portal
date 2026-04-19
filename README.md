# Equipment Maintenance Portal — Website

A live, installable web application for tracking imaging equipment PM,
physicist surveys, repairs, and alerts across Townsen Memorial facilities.

- **Fully static** — no backend required. All data persists in the browser's `localStorage`.
- **Installable PWA** — "Add to Home Screen" on iOS/Android, "Install" button in Chrome/Edge.
- **Offline-capable** — the service worker caches the shell so the portal still works without internet.
- **Responsive** — works on desktop, tablet, and phone.

## Going live — three easy options

### ⚡ Option 1 — Netlify Drop (fastest, no account needed to preview)

1. Open <https://app.netlify.com/drop> in your browser.
2. Drag the entire `site/` folder onto the drop zone.
3. You'll get an instant public URL like `https://equipment-maintenance-abc123.netlify.app/`.
4. (Optional) Sign in to claim the site and assign a custom subdomain / domain.

**Time to live: about 30 seconds.**

### 🚀 Option 2 — Vercel (custom domain, auto-deploy on push)

1. Install the Vercel CLI: `npm i -g vercel`
2. From inside `site/`: `vercel --prod`
3. Follow the prompts (login, project name, scope). Done.

### 🐙 Option 3 — GitHub Pages (free, auto-deploy via Actions)

1. Create a new GitHub repo and push the contents of `site/` to it:
   ```bash
   cd site
   git init
   git add .
   git commit -m "Initial commit"
   git branch -M main
   git remote add origin https://github.com/<you>/equipment-maintenance.git
   git push -u origin main
   ```
2. On GitHub: **Settings → Pages → Source: GitHub Actions**.
3. The included workflow (`.github/workflows/deploy.yml`) auto-publishes on every push to `main`.
4. Your site goes live at `https://<you>.github.io/equipment-maintenance/`.

## Project layout

```
site/
├── index.html              The portal application
├── favicon.svg             App icon
├── manifest.webmanifest    PWA manifest (enables install prompt)
├── sw.js                   Service worker (offline caching)
├── 404.html                Custom not-found page
├── robots.txt              Blocks crawlers (internal tool)
├── netlify.toml            Netlify config + security headers
├── vercel.json             Vercel config + security headers
└── .github/workflows/      GitHub Pages auto-deploy
```

## Custom domain

Once deployed, point a CNAME (e.g. `equipment.townsenmemorial.com`) at your
host's target and add the domain in the host's dashboard:

- **Netlify**: *Site settings → Domain management → Add custom domain*
- **Vercel**:  *Project → Settings → Domains*
- **GitHub Pages**: add a file `CNAME` in the repo root containing your domain

All three hosts provision a free Let's Encrypt SSL certificate automatically.

## Data & privacy

All equipment data, task history, and notification email list stay inside the
user's browser — nothing is sent to any server. If users need shared data
across devices, a backend (Supabase / Firebase / a custom API) would need to
be added; the current build is purposefully single-user.

## Updating the app

Any change to `index.html` (or other files) automatically propagates:

- **Netlify / Vercel / GitHub Pages**: push to `main` and the site redeploys
  in under a minute.
- **Netlify Drop**: re-drag the updated folder.

The service worker serves cached content first; users will see the new
version after a refresh (typically within one extra reload).
