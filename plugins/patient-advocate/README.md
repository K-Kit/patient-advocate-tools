# patient-advocate

A Claude Code plugin that turns medical documents into two kinds of summaries:

| Skill | Who it's for | What you get |
|---|---|---|
| `clinician-brief` | Doctors, specialists, care teams | A dense TL;DR in clinical shorthand, a thorough problem-oriented summary, or both (TL;DR first) |
| `patient-explainer` | Patients and family | A plain-language explanation of what the documents say, what it means, and what to ask next |

Both skills read PDFs, scanned images, phone photos of reports, and text files.

The examples below use Claude Code slash commands. If you installed the skills in the Claude app instead, attach your documents to a chat and ask in your own words; see the [install guide](../../README.md).

## Using it

Type the skill as a slash command followed by the document(s):

```
/patient-advocate:clinician-brief ~/Records/discharge.pdf
/patient-advocate:clinician-brief ~/Records/ tldr
/patient-advocate:clinician-brief labs-jan.pdf labs-mar.pdf full save
```

```
/patient-advocate:patient-explainer ~/Records/mri-report.pdf
/patient-advocate:patient-explainer ~/Records/ short
/patient-advocate:patient-explainer discharge.pdf for caregiver in Spanish save
```

You can also just ask in your own words — "write a TL;DR of these labs for my cardiologist" or "explain this report to me like I'm not a doctor" — and Claude will pick the right skill.

### Options

**clinician-brief**
- `tldr` — the TL;DR only (120 words max)
- `full` — the thorough summary only
- `both` — TL;DR then thorough summary (default)
- `save` — also save a Markdown file next to the documents

**patient-explainer**
- `short` — just the big picture and questions to ask
- `for caregiver` — written to a family member about the patient
- `in <language>` — write it in another language
- `save` — also save a Markdown file next to the documents

### Try it

A fictional discharge summary is included for testing:

```
/patient-advocate:clinician-brief examples/sample-discharge-summary.md
/patient-advocate:patient-explainer examples/sample-discharge-summary.md
```

To see what to expect before running anything, look at the example outputs for that document: [clinician brief](examples/sample-output-clinician-brief.md) and [patient explainer](examples/sample-output-patient-explainer.md).

## What it will and won't do

- It summarizes and explains only what's in the documents. It doesn't invent values, add diagnosis codes, or make treatment recommendations.
- It keeps the original uncertainty: "possible" stays "possible".
- The clinician brief flags discrepancies between documents (medication lists that don't match, follow-ups with no record of happening) and questions for the care team.
- The patient explainer doesn't predict outcomes or give medical advice, and tells the reader to seek urgent care if a document flags a critical result.
- Neither skill searches the web or sends documents anywhere beyond Claude itself.

## Privacy note

Documents you give Claude are sent to Anthropic to be processed, under the terms of your Claude plan. Use it with your own records or records you're authorized to share. This tool is not a substitute for your care team or the original documents.
