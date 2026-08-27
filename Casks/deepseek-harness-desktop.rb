cask "deepseek-harness-desktop" do
  version "2.0.3"
  sha256 "9a5d4a51689baa7c24be7f11903f0ba9cfe4885a3241e573a1cc4134cd500329"

  url "https://github.com/anywhere-labs/deepseek-harness-desktop/releases/download/v#{version}/DSH.Desktop-#{version}-universal.dmg"
  name "DSH Desktop", "DeepSeek Harness Desktop"
  desc "基于官方 DeepSeek Harness 打造的 Electron 图形化桌面客户端，开箱即用。"
  homepage "https://github.com/anywhere-labs/deepseek-harness-desktop"

  livecheck do
    url :homepage
    strategy :github_latest
  end

  depends_on macos: :monterey

  app "DSH Desktop.app"

  zap trash: [
    # v0.x 时代的残留（供从旧版升级的用户清理）
    "~/Library/Application Support/DeepSeek Harness",
    "~/Library/Application Support/DSH Desktop",
    "~/Library/Preferences/ai.deepseek.dsh.desktop.plist",
    "~/Library/Preferences/ai.deepseek.harness.desktop.plist",
  ]

  # -------------------------------------------------------------------
  # 公证（Notarization）说明：
  # Homebrew 无法在 depends_on 中检测签名状态。若你的应用尚未通过
  # Apple 公证，Gatekeeper 会阻止首次启动。以下提示会在安装结束时
  # 打印给用户，指导他们用 --no-quarantine 或手动移除隔离属性。
  # -------------------------------------------------------------------
  caveats do
    <<~EOS
      如果应用未经过 Apple 公证（Notarization），首次启动可能被 Gatekeeper 拦截。

      方案一（推荐）：安装时直接跳过隔离属性
          brew install --cask --no-quarantine deepseek-harness-desktop

      方案二：安装完成后手动移除隔离属性
          xattr -dr com.apple.quarantine "/Applications/DSH Desktop.app"

      从 v0.x 升级的用户：旧版应用（"DeepSeek Harness.app"）不会被自动删除，
      确认新版正常后请在「应用程序」中手动移除。
    EOS
  end
end
