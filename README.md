# Online Documents (bina database, bina server)

Koi data kahin save nahi hota. File admin ke browser se seedha client ke browser me jati hai.

## Files
- `index.html` – client page (OTP maangta hai)
- `admin.html` – admin login + panel
- `config.js` – settings
- `style.css`, `logo.svg`

## Setup (sirf 2 step)
1. Sab files GitHub repo me upload karo → **Settings → Pages → main / root → Save**.
2. `https://USERNAME.github.io/REPO/admin.html` kholo → pehli baar "Set admin password" dikhega.
   Password likho → jo `ADMIN_HASH: "..."` line aaye usko `config.js` me paste karke GitHub pe save karo.
   Ab admin.html reload karke usi password se login karo.

## Use
1. Admin login → document name + file → **Create link** → **Copy link** → client ko bhejo.
2. Client link kholega, OTP maangega → aap **Generate OTP** dabao → OTP client ko bhejo.
3. Client OTP dale → file download.
4. **Edit** (naam/file badlo), **Delete** (link turant band, kuch nahi dikhta).

## Dhyan rakho
- **Admin page open aur online rehna chahiye.** File sirf tab download hoti hai jab admin page khula ho.
- Page reload ya band karne par saare documents aur links hat jate hain (kuch save nahi hota).
- Ek hi tab/device se admin kholo.
- Bahut badi files (100MB+) ke liye ye theek nahi, 50MB tak achha chalta hai.
- OTP 6 digit, 15 min, ek baar, 5 galat try ke baad band.
