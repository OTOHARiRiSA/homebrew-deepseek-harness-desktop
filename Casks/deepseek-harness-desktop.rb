cask "deepseek-harness-desktop" do
  version "2.0.0"
  sha256 "d3f7f10acd90ea58ac0922428ab3d8a96ced8c73227b8c8f76f313181e8a0cfe"

  url "https://github.com/anywhere-labs/deepseek-harness-desktop/releases/download/v#{version}/DeepSeek-Harness-#{version}-arm64.dmg"
  name "DeepSeek Harness Desktop"
  desc "基于官方 DeepSeek Harness 打造的 Electron 图形化桌面客户端，开箱即用。"
  homepage "https://github.com/anywhere-labs/deepseek-harness-desktop"

  livecheck do
    url :homepage
    strategy :github_latest
  end

  depends_on macos: :monterey
  depends_on arch: :arm64

  app "DeepSeek Harness.app"

  zap trash: [
    "~/Library/Application Support/DeepSeek Harness",
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
          xattr -dr com.apple.quarantine "/Applications/DeepSeek Harness.app"
    EOS
  end
end
