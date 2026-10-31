# Patient Advocate Tools

A Claude Code plugin marketplace with tools a patient advocate can give clients for making sense of medical documents.

## Plugins

- **[patient-advocate](plugins/patient-advocate/)** — Turn medical documents into a concise clinician brief (TL;DR + full summary) or a plain-language explainer for patients.

## Install in the Claude app (easiest)

Works in the Claude desktop app and at claude.ai.

1. Download one or both skills:
   - **[patient-explainer.zip](https://github.com/K-Kit/patient-advocate-tools/releases/latest/download/patient-explainer.zip)** — explains your medical documents in plain language
   - **[clinician-brief.zip](https://github.com/K-Kit/patient-advocate-tools/releases/latest/download/clinician-brief.zip)** — writes a short, technical summary to give your doctor
2. In Claude, open **Settings → Capabilities**, find **Skills**, and choose **Upload skill**. Upload each zip as-is (don't unzip it).
3. Start a new chat, attach a medical document (PDF or photo), and ask, for example:
   - "Explain this report to me in plain language."
   - "Write a TL;DR of these records for my cardiologist."

If you don't see Skills in Settings, your Claude plan or organization may not have it turned on.

## Install in Claude Code

If you use [Claude Code](https://claude.com/claude-code), install it as a plugin instead. Inside Claude Code:

```
/plugin marketplace add K-Kit/patient-advocate-tools
/plugin install patient-advocate@patient-advocate-tools
```

Or from a terminal:

```bash
claude plugin marketplace add K-Kit/patient-advocate-tools
```

```bash
claude plugin install patient-advocate@patient-advocate-tools
```

Restart Claude Code, then try `/patient-advocate:patient-explainer path/to/report.pdf`.

To get updates later:

```bash
claude plugin update patient-advocate@patient-advocate-tools
```

## Layout

```
.claude-plugin/marketplace.json        marketplace listing
scripts/build-skill-zips.sh            builds the Claude app zips into dist/
plugins/patient-advocate/
  .claude-plugin/plugin.json           plugin manifest
  skills/clinician-brief/              doctor-facing TL;DR + full summary
  skills/patient-explainer/            plain-language explainer
  examples/                            fictional sample document and example outputs
```

## Releasing a new version

1. Bump `version` in both `plugins/patient-advocate/.claude-plugin/plugin.json` and `.claude-plugin/marketplace.json`.
2. Check everything:
   ```bash
   claude plugin validate . --strict
   ```
3. Commit and push. Claude Code users get the update with `claude plugin update`.
4. Rebuild the Claude app zips and attach them to a new GitHub release, so the download links above serve the new version:
   ```bash
   ./scripts/build-skill-zips.sh
   ```
   ```bash
   gh release create v0.2.0 dist/*.zip --title "v0.2.0" --notes "What changed"
   ```
   Claude app users need to download and re-upload the zips to get the update.
