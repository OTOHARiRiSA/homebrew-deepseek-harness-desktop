# Homebrew Tap: DeepSeek Harness Desktop（社区维护）

**⚠️ 非官方 Tap**：本仓库由社区维护，与
[DeepSeek Harness Desktop](https://github.com/anywhere-labs/deepseek-harness-desktop)
的作者**无隶属关系**。本 Tap 仅通过 Homebrew 链接到上游官方 GitHub Releases
安装包，**不重新分发、不修改任何二进制**。

> 基于官方 DeepSeek Harness 打造的 Electron 桌面端，开箱即用。

## 系统要求

- **Apple Silicon（M1/M2/M3/M4 芯片）**：上游暂未发布 Intel 版本
- macOS Monterey（12）及以上

> 在 Intel 机器上执行安装会被 Homebrew 直接拒绝并提示架构不兼容。

## 安装

```bash
# 1. 添加本 Tap（只需执行一次）
brew tap OTOHARiRiSA/deepseek-harness-desktop

# 2. 安装应用
brew install --cask deepseek-harness-desktop
```

> 也可以不单独执行 tap，一步完成（Homebrew 会自动添加 Tap）：
>
> ```bash
> brew install --cask OTOHARiRiSA/deepseek-harness-desktop/deepseek-harness-desktop
> ```

### Gatekeeper 拦截时（应用未通过公证）

```bash
# 方式一：安装时跳过隔离属性（推荐）
brew install --cask --no-quarantine deepseek-harness-desktop

# 方式二：安装完成后手动移除隔离属性
xattr -dr com.apple.quarantine "/Applications/DeepSeek Harness.app"
```

## 使用

```bash
brew info --cask deepseek-harness-desktop      # 查看应用信息
brew upgrade --cask deepseek-harness-desktop   # 升级
brew uninstall --cask deepseek-harness-desktop # 卸载（保留配置）
brew uninstall --cask --zap deepseek-harness-desktop  # 彻底卸载（清理配置）
```

## 更新机制

- **自动化**：`.github/workflows/auto-bump.yml` 每天定时检查上游最新
  Release，发现新版本后自动更新 `version` 与 `sha256` 并提交。
  sha256 取自 GitHub API 的官方资产 digest，**无需下载安装包**。
- **手动**：见下方「维护者指南」。

## 仓库结构

```text
homebrew-deepseek-harness-desktop/
├── Casks/
│   └── deepseek-harness-desktop.rb     # Cask 定义（核心）
├── .github/
│   └── workflows/
│       ├── ci.yml                      # 每次推送/PR：style + audit 校验
│       └── auto-bump.yml               # 每天检查上游新版本并自动更新
├── LICENSE                             # 建议添加（如 MIT）
└── README.md
```

## 维护者指南（手动更新）

上游发新版后（也可等 auto-bump 自动完成）：

```bash
# 1. 取上游官方 sha256 digest（无需下载安装包）
curl -s https://api.github.com/repos/anywhere-labs/deepseek-harness-desktop/releases/latest \
  | python3 -c "import json,sys; d=json.load(sys.stdin); print([a.get('digest') for a in d['assets'] if a['name'].endswith('.dmg')])"

# 2. 更新 Casks/deepseek-harness-desktop.rb 中的 version 与 sha256

# 3. 本地校验（本地 tap 方式，因 brew audit 不接受文件路径）
brew style ./Casks/deepseek-harness-desktop.rb
brew tap OTOHARiRiSA/deepseek-harness-desktop "$PWD"
brew audit --cask OTOHARiRiSA/deepseek-harness-desktop/deepseek-harness-desktop

# 4. 提交推送
git add Casks/deepseek-harness-desktop.rb
git commit -m "deepseek-harness-desktop: bump to <新版>"
git push
```

用户随后执行 `brew upgrade --cask deepseek-harness-desktop` 即可升级。

## 许可与免责声明

- 本 Tap 仓库：见 [LICENSE](./LICENSE)（由维护者自行选择）。
- DeepSeek Harness Desktop 应用本身：见[上游仓库](https://github.com/anywhere-labs/deepseek-harness-desktop)的许可条款。
- 若上游日后推出官方安装渠道（官方 Tap / 官方 cask），本社区 Tap 将相应让位。
