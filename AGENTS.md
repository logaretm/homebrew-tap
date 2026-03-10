# AGENTS.md

## Project

Homebrew tap for tools by Abdelrahman Awad (logaretm). Contains formulae that install pre-built binaries from GitHub Releases.

## Structure

```
Formula/
  depnuke.rb      # each formula is a .rb file
README.md
```

## Adding a New Formula

1. Create `Formula/<name>.rb` following this template:

```ruby
class ToolName < Formula
  desc "Short description"
  homepage "https://github.com/logaretm/<name>"
  version "VERSION"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/logaretm/<name>/releases/download/v#{version}/<name>-aarch64-apple-darwin.tar.gz"
      sha256 "SHA256_AARCH64_APPLE_DARWIN"
    else
      url "https://github.com/logaretm/<name>/releases/download/v#{version}/<name>-x86_64-apple-darwin.tar.gz"
      sha256 "SHA256_X86_64_APPLE_DARWIN"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/logaretm/<name>/releases/download/v#{version}/<name>-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "SHA256_AARCH64_UNKNOWN_LINUX_GNU"
    else
      url "https://github.com/logaretm/<name>/releases/download/v#{version}/<name>-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "SHA256_X86_64_UNKNOWN_LINUX_GNU"
    end
  end

  def install
    bin.install "<name>"
  end

  test do
    assert_match "<name>", shell_output("#{bin}/<name> --help")
  end
end
```

2. The class name must be CamelCase of the formula name (e.g. `depnuke` -> `Depnuke`, `my-tool` -> `MyTool`)
3. Use placeholder strings (`VERSION`, `SHA256_*`) if the formula will be auto-updated by CI — the source repo's release workflow will sed-replace these
4. Add the formula to the table in `README.md`

## CI Integration

Each tool repo should have a release workflow that:
1. Builds binaries for 4 targets: `aarch64-apple-darwin`, `x86_64-apple-darwin`, `aarch64-unknown-linux-gnu`, `x86_64-unknown-linux-gnu`
2. Packages each as `<name>-<target>.tar.gz`
3. After release, computes sha256 for each tarball, seds the template formula, and pushes to this repo
4. Requires a `HOMEBREW_TAP_TOKEN` secret (GitHub PAT with repo scope) in the source repo

See `logaretm/depnuke/.github/workflows/release.yml` for a working example.
