# Online Documents – Setup (Hinglish)

## Files
- `index.html` – client page (link kholne par OTP maangta hai)
- `admin.html` – admin login + panel
- `config.js` – Supabase URL aur key yaha daalni hai
- `supabase.sql` – database setup
- `style.css`, `logo.svg`

## Step 1: Supabase (free)
1. https://supabase.com par account banao → **New project**.
2. **SQL Editor** kholo → `supabase.sql` ka poora content paste karo → **Run**.
3. **Authentication → Users → Add user** → apna email + password banao (ye aapka admin login hai). "Auto confirm user" ON rakho.
4. **Authentication → Sign In / Providers → Email** me **"Allow new users to sign up" OFF** kar do, taaki koi aur admin na ban sake.
5. **Project Settings → API** se `Project URL` aur `anon public key` copy karo → `config.js` me paste karo.
   (anon key public hoti hai, ye theek hai. `service_role` key kabhi mat daalna.)

## Step 2: GitHub Pages
1. GitHub par new repository banao, saari files upload karo.
2. **Settings → Pages → Branch: main / root → Save**.
3. Site: `https://USERNAME.github.io/REPO/`
   Admin: `https://USERNAME.github.io/REPO/admin.html`

## Kaise use karna hai
1. `admin.html` kholo → login.
2. Document name likho, file chuno → **Upload & create link**.
3. **Copy link** → client ko bhejo.
4. Jab client link khole aur OTP maange → **Generate OTP** dabao → OTP client ko bhejo.
5. Client OTP daale → file download ho jayegi.
6. **Edit** se naam/file badlo, **Delete** se hamesha ke liye hata do (delete ke baad link kuch nahi dikhata).

## Security
- OTP 6 digit, 15 minute valid, ek hi baar chalta hai.
- 5 galat try ke baad OTP band, naya OTP banana padega.
- OTP aur file ka path sirf sahi OTP ke baad milta hai.
