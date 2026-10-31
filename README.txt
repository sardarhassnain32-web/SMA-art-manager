SMA ART GALLERY — FILE GUIDE

Files:
index.html   Public gallery page
admin.html   Private admin sign-in and artwork editor
style.css   Shared black + antique gold design
config.js   Your Supabase project URL and public anon/publishable key
 gallery.js  Public gallery loading/search/filter/details
admin.js     Admin login, upload, edit and delete
setup.sql    Database and secure access rules

IMPORTANT
- GitHub Pages hosts the website files; Supabase stores shared artwork and photos.
- Do not put a Supabase service_role/secret key in config.js. Use only the anon/publishable key.
- Do not share your Supabase password or private keys.

SETUP STILL REQUIRED IN YOUR ACCOUNTS
1. Supabase: run setup.sql once in SQL Editor.
2. Supabase: create one user in Authentication > Users (email + password).
3. Copy that user's UUID and run the final INSERT statement in setup.sql after replacing the placeholder UUID.
4. Supabase: Project Settings > API (or API Keys) — copy Project URL and anon/publishable key into config.js.
5. GitHub: upload all files from this folder into the ROOT of your existing SMA Art Gallery repository. Keep filenames exactly as shown.
6. Enable GitHub Pages from main branch, /(root).
7. Open index.html site URL. Use /admin.html for admin sign-in.

The site does not show prices, checkout, or sales. Public visitors can view artwork. Only the authorised admin account can add/edit/delete.
