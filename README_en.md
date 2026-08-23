# Homebrew Tap: DeepSeek Harness Desktop (Community-Maintained)

**⚠️ Unofficial Tap**: This repository is maintained by the community and has
**no affiliation** with the authors of
[DeepSeek Harness Desktop](https://github.com/anywhere-labs/deepseek-harness-desktop).
This Tap only links to the official GitHub Releases installers via Homebrew —
it does **not redistribute or modify any binaries**.

> An Electron desktop client built on the official DeepSeek Harness, ready to
> use out of the box.

## System Requirements

- **Apple Silicon and Intel**: universal installers are provided since v2.0.1,
  so both architectures are supported
- macOS Monterey (12) or later

## Installation

```bash
# 1. Add this Tap (only needed once)
brew tap OTOHARiRiSA/deepseek-harness-desktop

# 2. Install the app
brew install --cask deepseek-harness-desktop
```

> You can also skip the separate tap step (Homebrew will add the Tap
> automatically):
>
> ```bash
> brew install --cask OTOHARiRiSA/deepseek-harness-desktop/deepseek-harness-desktop
> ```

### When Gatekeeper Blocks Launch (App Not Notarized)

```bash
# Option 1: skip the quarantine attribute at install time (recommended)
brew install --cask --no-quarantine deepseek-harness-desktop

# Option 2: remove the quarantine attribute manually after installing
xattr -dr com.apple.quarantine "/Applications/DSH Desktop.app"
```

## Usage

```bash
brew info --cask deepseek-harness-desktop             # show app info
brew upgrade --cask deepseek-harness-desktop          # upgrade
brew uninstall --cask deepseek-harness-desktop        # uninstall (keep config)
brew uninstall --cask --zap deepseek-harness-desktop  # uninstall (clean config)
```

## Update Mechanism

- **Automatic**: `.github/workflows/auto-bump.yml` checks the upstream latest
  Release on a daily schedule and, when a new version is found, automatically
  updates `version` and `sha256` and commits the change. The sha256 comes from
  the official asset digest on the GitHub API — **no need to download the
  installer**.
- **Manual**: see the "Maintainer Guide" below.

## Repository Structure

```text
homebrew-deepseek-harness-desktop/
├── Casks/
│   └── deepseek-harness-desktop.rb     # Cask definition (core)
├── .github/
│   └── workflows/
│       ├── ci.yml                      # On every push/PR: style + audit checks
│       └── auto-bump.yml               # Daily check for new upstream versions
├── LICENSE                             # Suggested (e.g. MIT)
├── README.md
└── README_en.md
```

## Maintainer Guide (Manual Update)

When upstream releases a new version (or you can wait for auto-bump):

```bash
# 1. Get the official upstream sha256 digest (no need to download the installer)
curl -s https://api.github.com/repos/anywhere-labs/deepseek-harness-desktop/releases/latest \
  | python3 -c "import json,sys; d=json.load(sys.stdin); print([a.get('digest') for a in d['assets'] if a['name'].endswith('.dmg')])"

# 2. Update version and sha256 in Casks/deepseek-harness-desktop.rb

# 3. Verify locally (via a local tap, since brew audit does not accept file paths)
brew style ./Casks/deepseek-harness-desktop.rb
brew tap OTOHARiRiSA/deepseek-harness-desktop "$PWD"
brew audit --cask OTOHARiRiSA/deepseek-harness-desktop/deepseek-harness-desktop

# 4. Commit and push
git add Casks/deepseek-harness-desktop.rb
git commit -m "deepseek-harness-desktop: bump to <new version>"
git push
```

Users can then upgrade with `brew upgrade --cask deepseek-harness-desktop`.

## License & Disclaimer

- This Tap repository: see [LICENSE](./LICENSE) (chosen by the maintainers).
- The DeepSeek Harness Desktop application itself: see the license terms in the
  [upstream repository](https://github.com/anywhere-labs/deepseek-harness-desktop).
- If upstream later provides an official installation channel (official Tap /
  official cask), this community Tap will step aside accordingly.
