---
name: clinician-brief
description: Analyze medical documents (labs, imaging, discharge summaries, consult notes, records) and write a brief for physicians in dense, technical clinical language — an ultra-concise TL;DR, a thorough clinical summary, or both in that order. Use when the user wants a doctor-facing summary, a handoff note, a "tldr for the doctor", or to prep records for a specialist visit.
argument-hint: "<file(s) or folder> [tldr | full | both] [save]"
---

# Clinician Brief

Turn the patient's medical documents into a brief a physician can absorb in seconds, with a thorough version behind it for when they want detail.

The reader is a clinician. Write the way clinicians write to each other: standard terminology, accepted abbreviations, numbers with units, no lay explanations, no filler.

## Options

When run as a slash command, the arguments are: `$ARGUMENTS`
Otherwise, take the same options from the user's request in their own words.

- **Documents**: files attached to the conversation, or file paths, globs, or a folder. If there are none, ask the user for them.
- **Mode** (default `both`):
  - `tldr` — the TL;DR only
  - `full` — the thorough summary only
  - `both` — the TL;DR first, then the thorough summary
- **`save`** — also save the result as a Markdown file named `clinician-brief-YYYY-MM-DD.md` (next to the first source document when working with files on disk). Without it, only reply in chat.

## Step 1: Read everything first

1. Read every document in full. PDFs and images (scans, photos of reports) can be read directly; for long PDFs read all pages in ranges.
2. For each document, note its type, date of service, author/facility, and page count.
3. Extract facts using the checklist in [references/extraction-checklist.md](references/extraction-checklist.md). Record where each fact came from (file name and page).
4. Put the facts on a single timeline and look for trends, discrepancies, and gaps (e.g. a med on one list but not another, a result referenced but never reported, a fact a recommendation depends on that isn't documented). Do this even for a single document.
5. Compare the latest document date with today's date. Any follow-up whose window has already passed is an open item: state when it was due and that completion isn't documented. A window that is open today (e.g. a 6–12 month surveillance CT) is **due now**.

If a page is illegible or a document is cut off, say so rather than guessing.

## Step 2: Write the TL;DR

Goal: the treating physician gets the picture in under 15 seconds. **Hard cap: 120 words**, counting everything below the header line: labels, abbreviations, numbers, and dates each count as a word; symbols like → ↑ + and bullet markers don't. The cap wins over completeness: anything that doesn't fit goes in the thorough summary.

```
**TL;DR** — <patient name>, DOB <date> · <doc type(s)>, <date or date range>

<One-liner: age/sex, pertinent PMH, and why these documents exist. e.g. "68M w/ HFrEF (EF 30%), CKD 3b, T2DM s/p admission 03/02–03/06/2026 for ADHF.">

- **Critical:** <critical/panic values or urgent findings — omit line if none>
- **Key findings:** <abnormal results w/ values + units, flags, Δ vs prior>
- **Dx/problems:** <active diagnoses, new first>
- **Rx changes:** <started / stopped / dose-changed>
- **Open items:** <pending results, recommended f/u, unresolved discrepancies>
```

Rules for the TL;DR:

- Keep the section order above. Within each section, lead with what changes management. Drop normal results unless a normal result is itself the point (e.g. troponin negative ×2 ruling out ACS).
- **Critical** means values the source flags as critical/panic, or findings it calls urgent. Don't promote an abnormal value to critical on your own judgment.
- Use ↑ / ↓ for a single abnormal value and → for a trend (`Cr 2.1 → 1.7 mg/dL`). Don't stack both on one value.
- Identify the patient by name and DOB only if the documents give them. Never include MRN, SSN, or insurance IDs.
- Use standard abbreviations, never ones on the Joint Commission "Do Not Use" list. See [references/abbreviations.md](references/abbreviations.md).

## Step 3: Write the thorough summary

Use this structure. Leave out sections with nothing in them rather than writing "none" — except **Allergies**, which must always appear (write `NKDA` only if the document says so, otherwise `Not documented`).

```
## Clinical Summary

**Sources reviewed:** <list: doc type — date — author/facility — pages>

### Background
<Demographics, PMH, PSH, pertinent FHx/SHx — only what is documented.>

### Presentation / Interval history
<Why these documents exist; course of events in chronological order.>

### Medications
<Current list with dose/route/frequency. Mark changes: **NEW**, **D/C**, **HELD**, **↑ dose**, **↓ dose**.>
**Allergies:** <...>

### Objective
<Vitals. Labs as a table: Test | Latest result (date) | Units | Ref range | Flag | Earlier values (date) — earlier values can be serial values from the same admission or priors from other documents. Imaging/path/procedures: quote the Impression verbatim, then add a one-line synthesis if useful.>

### Assessment
<Problem-oriented: one bullet per problem, with the supporting data.>

### Plan / Recommendations (as documented)
<What the authoring clinicians recommended. Do not add your own recommendations.>

### Pending & follow-up
<Pending results, referrals, scheduled appointments, and recommended follow-ups with no evidence of completion.>

### Discrepancies & gaps
<Conflicts between documents, missing reports, med reconciliation issues, anything a clinician should verify.>

### Questions for the treating team
<2–5 pointed questions the records raise but don't answer.>
```

## Accuracy rules (apply to both versions)

- **Never invent.** Every value, diagnosis, medication, and date must come from the documents. Copy numbers and units exactly. Do not add ICD-10 or CPT codes unless they appear in the source.
- **Keep uncertainty visible.** If the source says "possible", "cannot exclude", or "clinical correlation recommended", the brief says so too. Never firm up a hedged finding.
- **Mark inference.** When you connect dots the documents don't (e.g. a trend across two labs), label it `[inferred]`.
- **Cite.** In the thorough summary, cite the source after each key finding as `(<file>, p.<n>)`, or `(<file>, <section>)` for files without pages. With a single source document, cite once per section instead of after every line. The TL;DR doesn't need citations.
- **No treatment advice.** Summarize what the documents say. Pointed questions are fine ("Was K rechecked after spironolactone was started?"); recommendations ("start X", "stop Y") are not.
- **Absolute dates.** Write dates as MM/DD/YYYY (or MM/YYYY when the source gives no day), not "yesterday" or "HD#2", except inside verbatim quotes. When you turn an interval into a due date ("within 7 days" → 03/13/2026), mark it `[inferred]`.

## Privacy

These documents contain protected health information. Work only with the documents provided. Do not search the web, call external services, or put patient details in URLs. If the user asks to send or share the brief somewhere, confirm with them first.

## Finish

End with one line in italics: *Prepared from patient-supplied records for clinician review; not a substitute for the source documents.*
