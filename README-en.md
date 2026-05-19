# Woo World BRCoin — Exchange Backend



<p align="center">
  <img src="images/17b3275ed42de9a2497284e3cb87a74369ec31ea7681b.jpg" alt="全部开源的一套数字货币交易所系统源码" width="680"/>
</p>


<p align="center">
  Digital Asset Trading System
</p>

<p align="center">
  <a href="LICENSE"><img src="https://img.shields.io/badge/License-AGPL--3.0-blue.svg?style=flat-square" alt="License: AGPL-3.0"/></a>
  <a href="https://github.com/bizzancoin/Blockchain_Exchange_PHP.UNIAPP/stargazers"><img src="https://img.shields.io/github/stars/THU-MAIC/style=flat-square" alt="Stars"/></a>
</p>

<p align="center">
  <a href="./README-en.md">English</a> | <a href="./README.md">简体中文</a>
  <br/>
</p>



## Overview

This project is a **Laravel 5.5**–based digital asset trading and wallet backend. Functionally it covers **spot/contract-style trading, wallet deposits and withdrawals, fiat/C2C matching, leverage and copy trading, micro contracts (Micro Trade), dual-currency products, NFT blind boxes, insurance, and staking/locked savings**, among others. It also provides an **operations console (`/admin`)**, an **agent console (`/agent`)**, and a lightweight **new admin entry (`/manages`)**.

**Use case:** a **centralized exchange–style Web backend** where H5/mobile apps call `api/*` endpoints and authenticate via Session/Token.

---

## Tech Stack

| Category | In use |
|----------|--------|
| **Backend framework** | Laravel `5.5.*` |
| **Language** | PHP `>=7.0.0` |
| **Database** | **MySQL** |
| **ORM** | Laravel Eloquent |
| **Cache** | Default driver **Redis** |
| **Search** | **Elasticsearch 6.x** |
| **Realtime / long-lived connections** | **Workerman** |
| **HTTP client** | Guzzle 6 |
| **Email** | PHPMailer |
| **Excel** | Maatwebsite Excel 2.x |
| **DB tooling** | Doctrine DBAL |
| **Frontend asset build (admin static assets)** | Laravel Mix + Webpack |

---

## Features

The following is grounded in **`routes/*.php`**, controller folders, **`app/Console/Kernel.php`**, **`app/Jobs/`**, etc. It is descriptive only—not a service-level commitment; actual behavior depends on configuration.

- **Users:** registration/login/password recovery, KYC, security center (gesture/payment password/phone & email), i18n (`resources/lang`: zh, en, hk, jp, etc.).
- **API auth:** `check_api` middleware validates users via **Token** (`app/Http/Middleware/CheckApi.php`, `App\Token`).
- **Wallet & assets:** multi-currency wallets, deposit addresses, withdrawals, flash swap, transfers, statements and log APIs (`Api\WalletController`, etc.).
- **Spot trading:** orders, fills, cancellations, watchlists (`TransactionController`, `OptionalController`).
- **Leverage:** open/close, batch close, stop profit/loss (`Api\LeverController`, admin `Admin\LeverTransactionController`, etc.).
- **Fiat / C2C:** merchant listings, order flow, disputes and admin review (`LegalDealController`, `C2cDealController` and Admin counterparts).
- **Market data & K-line:** market APIs, multi-interval K-lines, ES-related import/write commands (e.g. `ImportMarketFromEsearch`, `MarketHour`).
- **Micro contracts:** submit, list, result queries (`Api\MicroOrderController`, `app/Logic/MicroTradeLogic.php`), async jobs such as `Jobs/HandleMicroTrade.php`.
- **Copy trading:** follow, unfollow, trader profile and history (`Api\FollowController`), scheduled `follow` command (`app/Console/Kernel.php`).
- **Dual-currency products:** product list and subscription (`Api\DualController`, admin `Admin\DualController`).
- **NFT blind boxes:** boxes, artists, auctions, staking, etc. (`Api\BindBoxController`, admin `Admin\BindBoxController`).
- **Insurance:** purchase, claims, termination (`Api\InsuranceController`, admin rules and orders).
- **Staking / lock-up / bank-style savings:** `Api\BankController`, `LhDepositOrder` model, admin `BossController`, etc.
- **IM / chat:** `Api\ChatController`.
- **News / FAQ / marketing pages:** `Api\NewsController`.
- **Admin RBAC:** admins, roles, permissions (`Admin\AdminController`, `AdminRoleController`, `AdminRolePermissionController`).
- **Agent tier:** separate login, stats, team orders (`routes/agent.php`, `Agent\*` controllers).
- **Scheduler:** defined in `app/Console/Kernel.php` (currently enabled examples: `follow`, `remove_queue`, `lhdispatch_interest`; many historical schedules remain commented—restore per environment when deploying).
- **Queue jobs:** `app/Jobs` covers leverage, market data, micro orders, copy trading, etc. (default queue driver—see environment section; with `sync`, jobs run inline).

---

## Entry Points & Processes

| Type | Path / command |
|------|----------------|
| **HTTP (site & API)** | `public/index.php` (point the web server document root at `public`) |
| **CLI** | `artisan` in project root (`php artisan`) |
| **WebSocket / Workerman (market feeds, etc.)** | `public/start.php` (comments suggest `php start.php start`; the script references `public/mobile/chat/gateway/start*.php`—create or adjust paths in deployment if missing) |
| **Socket.IO sample (under vendor)** | `public/vendor/webmsgsender/start*.php` (third-party sample; whether it matches production is an ops decision) |

---

## API & Routing

`app/Providers/RouteServiceProvider.php` loads four route files:

1. **`routes/web.php`** (middleware group `web`)  
   - Hosts **most client-facing HTTP APIs** under **`/api/...`** (e.g. `/api/user/login`), plus **`/admin/*`** console login and business routes (requires `admin_auth`), and partly **`/winadmin`**, etc.  
   - Many routes use middleware: `check_api`, `lang`, `XSS`, `demo_limit`, `validate_locked`, etc. (see `app/Http/Kernel.php`).

2. **`routes/api.php`** (URI prefix **`api`** + middleware group `api`)  
   - Smaller surface, e.g. Huixin-related routes, `currency/match_price`, `lh/deposit`, etc.; full URLs look like **`/api/...`** (coexists with `/api/...` from `web.php`—avoid duplicate conflicts).

3. **`routes/agent.php`** (middleware group `web`)  
   - Agent login, statistics, orders, user management (mostly under **`/agent/...`**).

4. **`routes/manages.php`** (middleware group `web`)  
   - New admin login **`manages/login`**, home **`manages/index`**, etc. (the route group’s middleware array is currently empty—tighten permissions in follow-up work).

**Auth summary:**  
- User API: `Token` + `check_api`.  
- Admin: `AdminAuthenticate` (`admin_auth`).  
- Agent: `AgentAuth` (`agent_auth`).

---

## Cron / Scheduler

Configure on the server (example):

```bash
* * * * * cd /path/to/project && php artisan schedule:run >> /dev/null 2>&1
```

See `schedule()` in **`app/Console/Kernel.php`** for details.

---

## Artisan Commands (selection)

Custom commands live under **`app/Console/Commands/`**; some are registered in `$commands` inside `app/Console/Kernel.php`, e.g. `LHDisptchInterest`, `RemoveQueue`, `FollowCommand` (matching `follow`, `remove_queue`, `lhdispatch_interest`). Many more commands exist for market sync, wallet, leverage, C2C, etc.—whether they run depends on scheduler config and manual ops.

Run `php artisan list` for the full command list.

---

## Directory Layout

```bash
woo.worldbrcoin.xyz/
├── app/                          # Application core
│   ├── Console/                  # Artisan commands & Kernel (scheduler)
│   ├── Http/
│   │   ├── Controllers/
│   │   │   ├── Api/              # Mobile / public API controllers
│   │   │   ├── Admin/            # Operations console
│   │   │   ├── Agent/            # Agent console
│   │   │   ├── Manages/          # Lightweight new admin UI
│   │   │   └── Auth/             # Laravel auth scaffolding
│   │   └── Middleware/           # Auth, CORS, XSS, risk controls, etc.
│   ├── Jobs/                     # Queued jobs (market, leverage, micro trades, …)
│   ├── Logic/                    # Heavy business logic (e.g. MicroTrade, CoinTrade)
│   ├── Service/                  # e.g. RedisService
│   ├── Utils/                    # Helpers & Workerman callbacks
│   └── *.php                     # Eloquent models (many live under `App\` at app root)
├── bootstrap/                    # Framework bootstrap & caches
├── common/
│   └── functions.php             # Global helpers (Composer autoload files)
├── config/                       # DB, cache, queue, ES, SMS, WebSocket, …
├── database/
│   ├── migrations/               # Migrations (includes jobs/failed_jobs, …)
│   └── seeds/                    # Seeders (if any)
├── public/                       # Web root: index.php, assets, uploads, Workerman starters
├── resources/
│   ├── lang/                     # Translations
│   └── views/                    # Blade (admin & manages pages)
├── routes/
│   ├── web.php                   # Main business & most API / admin routes
│   ├── api.php                   # Extra routes under /api prefix
│   ├── agent.php                 # Agent routes
│   └── manages.php               # Manages admin routes
├── storage/                      # Logs, cache, sessions, compiled views
├── tests/                        # PHPUnit
├── artisan                       # CLI entry
├── composer.json                 # PHP deps & install hooks
├── package.json                  # Frontend build (Laravel Mix)
└── Laravel5/                     # Secondary Laravel sample/backup in repo (do not confuse with the root app in deployment)
```

---

## Local Setup (summary)

```bash
# PHP dependencies
composer install

# Copy env (prefer root `.env`; you may reference Laravel5/.env.example)
# After configuring DB, Redis, ES, etc.:
php artisan key:generate
php artisan migrate

# Frontend assets (if you compile admin assets)
npm install
npm run dev    # or npm run production
```

**Queues & Redis:** if `.env` has `QUEUE_DRIVER=redis`, run `php artisan queue:work`. If cache uses Redis, ensure Redis is reachable.

---

## Deployment & Operations Notes

- **Web server:** set the **document root** to **`public/`**.
- **PHP extensions:** meet Laravel 5.5 and project requirements; Workerman scripts on Linux often need **pcntl** and **posix** (see comments in `public/start.php`).
- **Logs:** under `storage/logs/` with subfolders for different domains (e.g. wallet, wss, microtrade—created by Composer hooks in some setups).
- **Security:** `VerifyCsrfToken` is **commented out** for the `web` middleware group in `app/Http/Kernel.php`—re-evaluate CSRF and route protection before production, especially for `manages` routes where middleware is currently empty.

## Support

If this project has been helpful to you, I would appreciate it if you could buy me a coffee.☕️

```bash
# USDT-TRC20:
TTz4y9EE5DqtRAneK5iQtWNW4k9E888888
```

<img src="images/image-20250817222238049-1778147062261-1.png" width="500" alt="微信公众号二维码" align="center" />





## Statement

The source code is intended solely for educational and non-commercial exchange purposes.

It must not be used for any purpose that violates the laws and regulations of the People's Republic of China (including Taiwan Province) or the jurisdiction in which the user resides.

As the author has never participated in any operational or profit-generating activities undertaken by the user—nor does the author exercise control over the user's subsequent application of the source code for specific purposes—any legal liabilities arising from the user's utilization of this code shall be borne exclusively by the user.           

```
！！！Warning！！！
The blockchain tokens involved in this project are intended solely for educational purposes; the author does not endorse the financial attributes associated with tokens derived from blockchain technology.
Furthermore, the author neither encourages nor supports any illicit activities—such as "mining," "speculative trading," or "virtual currency ICOs."
The virtual currency market operates outside the scope of regulatory requirements and controls; therefore, caution is advised regarding any investment or trading activities. This material is provided strictly for the purpose of learning about blockchain technology.
```

