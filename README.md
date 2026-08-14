# Homebrew Tap: DeepSeek Harness Desktop

非官方 Homebrew Tap（第三方软件源），用于通过 Homebrew 安装
[DeepSeek Harness Desktop](https://github.com/anywhere-labs/deepseek-harness-desktop)。

> 基于官方 DeepSeek Harness 打造的 Electron 桌面端，深度适配 macOS 和 Windows，
> 提供最佳的、开箱即用的体验。安装包通过 GitHub Releases 分发。

## 系统要求

- **Apple Silicon（M1/M2/M3/M4 芯片）**：当前仅支持 Apple Silicon 架构，Intel 版本暂未发布
- macOS Ventura（13）及以上

> 在 Intel 机器上执行安装会被 Homebrew 直接拒绝并提示架构不兼容。

## 安装

```bash
# 1. 添加本 Tap（只需执行一次）
brew tap anywhere-labs/tap

# 2. 安装应用
brew install --cask deepseek-harness-desktop
```

> 也可以不单独执行 tap，一步完成（Homebrew 会自动添加 Tap）：
>
> ```bash
> brew install --cask anywhere-labs/tap/deepseek-harness-desktop
> ```

### 应用未通过 Apple 公证（Notarization）时

若应用尚未公证，macOS Gatekeeper 可能拦截首次启动，请使用以下任一方式：

```bash
# 方式一：安装时跳过隔离属性（推荐）
brew install --cask --no-quarantine deepseek-harness-desktop

# 方式二：安装后手动移除隔离属性
xattr -dr com.apple.quarantine "/Applications/DeepSeek Harness Desktop.app"
```

## 使用

```bash
# 查看应用信息
brew info --cask deepseek-harness-desktop

# 更新到最新版本
brew upgrade --cask deepseek-harness-desktop

# 卸载（保留配置）
brew uninstall --cask deepseek-harness-desktop

# 彻底卸载（同时清理配置与缓存）
brew uninstall --cask --zap deepseek-harness-desktop
```

## 仓库结构

```text
homebrew-tap/
├── Casks/                             
│   └── deepseek-harness-desktop.rb
├── LICENSE                             
└── README.md                        
```

## 维护者指南

### 发布新版本

每次在 GitHub Releases 发布新版本后，更新 Cask 中的 `version` 与 `sha256`：

```bash
# 1. 计算新版安装包的 SHA-256
curl -fsSL "https://github.com/anywhere-labs/deepseek-harness-desktop/releases/download/v<新版>/DeepSeek-Harness-Desktop-<新版>-arm64.dmg" \
  | shasum -a 256

# 2. 更新 Casks/deepseek-harness-desktop.rb 中的 version 与 sha256

# 3. 本地校验（见下）
brew style ./Casks/deepseek-harness-desktop.rb
brew audit --cask ./Casks/deepseek-harness-desktop.rb

# 4. 提交并推送到本仓库
git add Casks/deepseek-harness-desktop.rb
git commit -m "deepseek-harness-desktop: bump to <新版>"
git push
```

用户随后执行 `brew upgrade --cask deepseek-harness-desktop` 即可升级。

## 许可

- 本 Tap 仓库：见 [LICENSE](./LICENSE)。
- DeepSeek Harness Desktop 应用本身：见[上游仓库](https://github.com/anywhere-labs/deepseek-harness-desktop)的许可条款。
