# WooCloud（uni-app）客户端

<div align="center">

**一套面向多端发布的数字资产交易与金融业务前端工程**

[![uni-app](https://img.shields.io/badge/uni--app-Vue2-blue)](https://uniapp.dcloud.net.cn/)
[![uView](https://img.shields.io/badge/UI-uView-green)](https://www.uviewui.com/)

</div>

---

## 简体中文

### 项目简介

本项目基于 **uni-app** 与 **Vue 2**，集成 **uView UI**，面向 App（含 App-Vue）、H5 及各类小程序等多端。客户端通过 REST API 与后端交互，并使用 **Socket.IO** 建立实时连接；内置 **vue-i18n** 多语言（含简体中文、英文、繁体等）。应用名称在 `manifest.json` 中为 **WooCloud**，当前版本 **0.8.0**（见 `versionName`）。

### 主要功能模块

| 模块 | 说明 |
|------|------|
| **首页 / 行情** | 公告、轮播、行情列表、自选、K 线相关展示 |
| **交易** | 秒合约、合约（杠杆）、币币交易及对应订单 |
| **资产 / 资金** | 多账户类型资产、充值提现、划转、记录查询 |
| **金融 / 理财** | 金融产品入口（与后端 `/dual` 等接口对接） |
| **其他业务** | IEO 认购、锁仓挖矿（LockMining）、跟单/交易员、NFT、OTC、借贷说明页、客服、合规与实名认证等 |

底部 Tab：**首页**、**行情**、**交易**、**金融**、**资产**（见 `pages.json`）。

### 技术栈

- **框架**：Vue 2、uni-app（Vue 3 编译器配置见 `manifest.json` 中 `compilerVersion`）
- **UI**：uView（`uview-ui/`，Easycom 按需组件）
- **状态**：Vuex（`store/index.js`）
- **网络**：uView 封装的 `$u.http`，请求/响应拦截（`common/http.interceptor.js`），API 聚合（`common/http.api.js`）
- **国际化**：`vue-i18n` + `common/locales/`（zh / en / hk / th / jp / kor / fra / spa）
- **实时**：`hyoga-uni-socket_io`（`js_sdk/`）连接 Socket.IO 服务
- **工具**：全局过滤器 `common/filters.js`，工具方法 `common/utils.js`

### 目录结构（摘要）

```
├── App.vue                 # 应用入口逻辑（站点配置、汇率、Socket 等）
├── main.js                 # 入口：uView、Vuex、i18n、拦截器、API 插件
├── manifest.json           # 应用标识、各端打包与权限配置
├── pages.json              # 页面路由、TabBar、全局样式
├── pages/                  # 业务页面（index、market、transaction、fund、setting 等）
├── components/             # 业务与通用组件（含 K 线等）
├── common/                 # API、拦截器、多语言、工具与样式
├── store/                  # Vuex
├── static/                 # 静态资源、字体、图标
├── uview-ui/               # uView 组件库源码
└── js_sdk/                 # 第三方 SDK（如 Socket.IO 适配）
```

### 环境要求

- 安装 **HBuilderX**（推荐）或使用 **uni-app 官方 CLI** 进行开发与发行  
- Node.js（若使用 CLI / npm 依赖安装，需与团队约定版本）
- 依赖说明：`package.json` 中主要列出 `vue-i18n`；完整构建通常以 HBuilderX 内置编译或 CLI 为准

### 配置说明（重要）

1. **接口域名**  
   开发与生产环境下的后端地址在以下文件中以占位符形式出现，**上线前必须替换为真实 API 域名**：

   - `common/http.interceptor.js`：`baseUrl`（开发为 `/api`，生产为 `https://domain`）
   - `store/index.js`：`baseUrl`、`baseDomain`（需与实际上传资源域名一致）

2. **H5**（`manifest.json` → `h5`）  
   - 路由模式：`hash`，`base` 为 `/h5/`  
   - `devServer.https` 为 `true`，本地调试注意证书与端口

3. **微信小程序等**  
   在各端 `appid` 字段填写对应平台应用 ID。

### 开发提示

- 启动后在 `App.vue` 的 `onLaunch` 中会请求站点配置（`getSiteConfig`）、初始化 Tab 文案语言、启动 Socket、拉取法币汇率（第三方 JSON 接口）等。
- Token 通过请求头 `Authorization` 传递；会话失效等业务码在 `http.interceptor.js` 中统一处理（如跳转登录或实名页）。
- 主题色与涨跌色等在 `main.js` 中通过 `Vue.prototype` 注入（如 `$upColor` / `$downColor`）。

### 免责声明

本仓库为前端工程示例或二次开发项目，**不构成任何投资建议**。对接交易所类业务须遵守当地法律法规，并确保后端与合规体系完备。

---

## English

### Overview

This project is a **uni-app** client built with **Vue 2** and **uView UI**, targeting App (App-VUE), H5, and mini-program platforms. It talks to backends via REST APIs and maintains a **Socket.IO** connection for real-time features. **vue-i18n** provides multiple locales (including Simplified Chinese, English, Traditional Chinese, etc.). The application name in `manifest.json` is **WooCloud**, version **0.8.0** (`versionName`).

### Feature highlights

| Area | Description |
|------|-------------|
| **Home & Market** | Announcements, banners, quotations, watchlist, chart-related views |
| **Trading** | Micro (seconds) contracts, leveraged/contract trading, spot trading and orders |
| **Assets** | Multi-account balances, deposit/withdraw, transfers, history |
| **Finance** | Wealth/product entries (integrated with backend routes such as `/dual`) |
| **Others** | IEO, lock-up mining, copy-trading, NFT, OTC, borrowing info pages, KYC, compliance, customer service |

Tab bar: **Home**, **Market**, **Trade**, **Finance**, **Assets** (`pages.json`).

### Tech stack

- **Framework**: Vue 2, uni-app  
- **UI**: uView (`uview-ui/`, Easycom)  
- **State**: Vuex (`store/index.js`)  
- **HTTP**: uView `$u.http` with interceptors (`common/http.interceptor.js`) and grouped APIs (`common/http.api.js`)  
- **i18n**: `vue-i18n` under `common/locales/`  
- **Realtime**: Socket.IO client (`js_sdk/hyoga-uni-socket_io`)  
- **Utils**: filters (`common/filters.js`), helpers (`common/utils.js`)

### Directory layout (summary)

```
├── App.vue
├── main.js
├── manifest.json
├── pages.json
├── pages/
├── components/
├── common/
├── store/
├── static/
├── uview-ui/
└── js_sdk/
```

### Prerequisites

- **HBuilderX** (recommended) or **uni-app CLI** for development and release builds  
- Node.js version aligned with your team when using CLI/npm  
- Dependencies: `package.json` lists `vue-i18n`; full toolchain may rely on HBuilderX built-in tooling

### Configuration

1. **API hosts**  
   Replace placeholders before production:

   - `common/http.interceptor.js`: `baseUrl` (`/api` in development, `https://domain` in production)
   - `store/index.js`: `baseUrl` and `baseDomain` for APIs and static/asset domains

2. **H5** (`manifest.json` → `h5`): hash router, base `/h5/`, HTTPS dev server enabled.

3. **Mini programs**: fill platform-specific `appid` fields.

### Development notes

- `App.vue` `onLaunch`: site config, tab locale, Socket bootstrap, fiat rates, optional storage version cleanup.
- Auth token is sent via `Authorization`; unified handling for session/KYC redirects in `http.interceptor.js`.
- Global theme/trading colors are exposed on `Vue.prototype` in `main.js`.

### Disclaimer

This repository is frontend-only sample or derivative work and **does not constitute investment advice**. Ensure legal compliance and a proper backend for any exchange-related deployment.

---

## License

以项目根目录及依赖库各自的许可证为准（如 `package.json` 与 `uview-ui/package.json` 所述）。
