---
name: submittal-rfi-triage
description: Triage submittal review comments and RFIs on MEP/AEC projects, or scan an equipment submittal for its electrical data and the NEC that applies to it, and produce a one-page PDF brief a teammate can act on. Use this whenever the user shares GC or reviewer comments on a submittal, an RFI log or a single RFI, or asks to sort, respond to, or draft a reply for either. Use it equally when AHA is the reviewer and there are no comments yet — an equipment submittal handed over to be checked, scanned, or reviewed (RTU, MAU, AHU, chiller, condensing unit, generator, ATS, transformer, switchgear, panelboard, UPS, VFD, pump, fire pump, elevator, duct heater, EVSE, kitchen or medical equipment) — where the job is to pull the electrical data off the package, set it against our schedules, one-line, and panel schedules, and say what is wrong. Also use it for any question about equipment electrical data (MCA, MOCP, MOP, SCCR, FLA, RLA, LRA, nameplate or connected load, voltage or phase mismatch, accessory and by-others circuits, feeder or breaker sizing, voltage drop, motor current, disconnect scope, working space, lug and termination data) or the NEC article that governs a piece of equipment, and for mechanical arithmetic (chilled water GPM/delta T, airflow, BTU/heat, kW/ton), even when the user doesn't say "submittal" or "RFI" — e.g. "the GC sent back comments on this chiller submittal", "scan this MAU submittal and tell me what's wrong", "pull the electrical data off these RTUs", "what NEC applies to this generator", "here's an RFI asking about breaker size", "does this panel exceed MOCP", "check this submittal against our schedule".
---

# Submittal and RFI triage

The deliverable is a **PDF brief, one page**, that a teammate can pick up and start
answering from without opening the source package. The brief is the output. Analysis
that doesn't land on that page didn't need doing.

## Step 1 — intake

Read the source first. For a PDF, don't fight the Read tool's page limits — convert it:

```
powershell -File "<skill>/scripts/pdf-to-text.ps1" -Pdf "<source.pdf>" -Out "<scratch>/source.txt"
```

That uses `pdftotext -layout`, which keeps the column structure Procore and Forma exports
depend on. Drawings and scans have no text layer, so render those pages and read the
images instead:

```
pdftoppm -png -r 150 -f <page> -l <page> "<source.pdf>" "<scratch>/p"
```

Crop with `-x -y -W -H` at `-r 300` to read a nameplate or a stencilled rating. Never take
a value off a drawing you haven't looked at directly; the critic checks these against the
source and a misread caps the score at 4.

Header facts: project, package type and number, subject/equipment, who sent it, date
received, response due. Pull everything you can from the document first.

If something load-bearing is still missing — the response due date, which sheets or spec
sections govern, who owns the discipline, whether this is a first submission or a
resubmittal — **ask with AskUserQuestion.** Rules for asking:

- One round, batched. Every open question in a single call, not a drip of follow-ups.
- Always include a bypass option: *"Run with what you have"* — mark the gaps on the brief
  and keep going. Never block a run on a question.
- Don't ask for anything cosmetic. A missing project number becomes an em dash. A missing
  due date changes what the brief says, so that one's worth asking about.
- If the user bypasses, write the unknown as `— (not provided)` on the face of the brief
  rather than guessing or quietly omitting it. The teammate reading it needs to see the
  hole.

When the user says up front to just run it, skip the questions entirely.

Then read the workflow that applies:

- Submittal comments, a comment log, a resubmittal → [references/submittal-workflow.md](references/submittal-workflow.md)
- An RFI, an RFI log, a field question → [references/rfi-workflow.md](references/rfi-workflow.md)
- Both present (common) → read both

### Is there a comment log at all?

Check before anything else, because it decides where the items come from.

**Someone else's comments exist** → normal triage. Their numbering governs. Go to Step 2.

**No comment log, because AHA is the reviewer** → this is an equipment scan, and the
scan produces the comments. Common for OFCI equipment that arrives for our review. Work
[references/equipment-scan.md](references/equipment-scan.md) end to end first, then come
back to Step 2 and track the findings the same way. Number the items yourself, in the
order a reader should meet them, and say on the brief that these are AHA's comments to
issue rather than someone else's to answer.

**Comments exist and the package also has equipment in it** → both. Run the scan as a
background pass: it feeds the Numbers block and it catches the comment the reviewer
missed. The reviewer's numbering still governs the item table. A scan finding that is
not in their log goes in *Before you answer*, not as a new numbered row.

## Step 2 — sort every item into a track

Keep the reviewer's original item numbers. Never renumber, never merge two comments
into one row. The brief has to line up with their document item for item.

In scan mode there is no prior numbering to preserve, so you own it. Number in the order
a reader should meet the findings: what changes what gets built first, documentation
last. The tracks still apply, and **F** carries a different weight here — a scan finding
on our own schedule is ours to fix whether or not anyone else has noticed it yet.

| Code | Track | What the row must carry |
|---|---|---|
| **P** | Closed by pointer — answer already exists in our documents or the package | The sheet, detail, or spec section to cite |
| **F** | Ours to fix — a real gap or conflict in our documents | What revises, and by when |
| **A** | Answer only — give design intent, decline the installation or means-and-methods call | The one-sentence answer |
| **D** | Needs direction — cost, schedule, or scope dressed as a technical question | Who decides: owner, EOR, CM, PM |

Cluster check before moving on: if three or more items land on the same sheet, detail,
or piece of equipment, say so in one line. It usually means a single supplemental
sketch closes all of them, which is the highest-value thing on the page.

## Step 3 — run the numbers

Any item touching equipment data — nameplate values, MCA vs. MOCP, SCCR, accessory
circuits, terminations, ambient or enclosure rating, harmonics, grounding, emergency
power — or mechanical arithmetic — GPM and delta T, airflow, BTU, kW/ton, voltage drop,
motor current — goes through
[references/electrical-checklist.md](references/electrical-checklist.md).

Calculate. Don't assert. Each result is one line in the Numbers block: the value, what
it's compared against, the verdict, the basis. A number ends an argument that an
adjective only prolongs.

### The code behind the number

Once a number has a verdict, find the article that carries it.
[references/nec-by-equipment.md](references/nec-by-equipment.md) is keyed by the machine
in hand — packaged HVAC, motors, VFDs, generators, transfer switches, transformers,
switchgear, UPS and batteries, fire pumps, elevators, data center and ITE rooms, electric
heat, EVSE, PV, kitchen, health care, hazardous locations, controls and fire alarm.

Citation rules, and they are not optional:

- **Confirm the adopted edition and the state amendments before writing a section
  number.** The spec's code compliance section or the code sheet usually says. If nothing
  does, ask, or make the argument without the subsection.
- **Prefer the durable citation.** For listed equipment that is almost always 110.3(B)
  plus the value marked on the nameplate. It survives every edition change and it is very
  hard to argue with. Subsection numbering moves between cycles; the listing requirement
  does not.
- **Cite only what you have confirmed.** A wrong article number in a submittal response
  is worse than no article number, and the critic caps the brief at 4 for one.

A code citation is not required on every row. It's required when the comment is that
something is non-compliant, as opposed to merely inconsistent with our design.

## Step 4 — build the PDF

1. Copy [assets/brief-template.html](assets/brief-template.html) into the scratchpad and
   fill every `{{FIELD}}`. Delete any section that has no real content — an empty box
   costs a reader more than a missing one. `assets/example-brief.html` and its rendered
   `example-brief.pdf` are a worked example that scored 9/10: 9 items on a page, with room
   for about 15.

   The **equipment strip** (`{{EQUIPMENT_ROWS}}`) is one row per unit tag: submitted
   V/phase, MCA, MOCP, against our OCPD and feeder, plus SCCR. Keep it for an equipment
   package and delete the whole block, heading included, for anything else. Mark the cell
   that conflicts `class="hit"`, a value you checked and it agrees `class="fit"`, and what
   the package never states `class="ns"`. Never leave a cell blank — *not stated* is a
   finding and a blank reads as an oversight.

   The strip is worth roughly three item rows of page. It earns that when the numbers are
   the argument, which in scan mode they usually are. When it doesn't, cut it and put the
   two values that matter in the row that cites them.
2. Render it:

   ```
   powershell -File "<skill>/scripts/brief-to-pdf.ps1" -Html "<filled.html>" -Pdf "<output.pdf>"
   ```

   The script prints `PAGES: n`. One page is the target. A second page is fine when the
   item count genuinely needs the room — 20 comments don't compress into 20 lines. What's
   not fine is a second page of prose. If it spills, tighten in this order: cut the Ask
   column to the actual request, merge consecutive P items onto one row ("3, 5, 9 — see
   E-401 note 4"), collapse identical units in the equipment strip to one row with the
   tags listed, then drop Sources to a single line. Dropping the whole strip is the last
   lever, not the first — the numbers are usually why the brief is believed.
3. Render every round into the scratchpad as `brief-v1.pdf`, `brief-v2.pdf`, and so on.
   Nothing lands in the user's folders until Step 5 picks a winner.

## Step 5 — grade, iterate, ship the best round

No brief goes out ungraded. Hand the rendered PDF to a critic agent, which reads it
against the source package and scores it out of 10 using
[references/critic-rubric.md](references/critic-rubric.md).

```
Agent(subagent_type: "triage-critic", run_in_background: false,
      prompt: "Grade this triage brief. Brief: <pdf path>. Source package and comment
               log: <paths>. Return the score block only.")
```

Give the critic everything you worked from, not just the source PDF: the extracted text
file, the line numbers of the electrical data blocks, our schedule or panel schedule
(transcribe it if it only exists as a screenshot, and say so), and the path to the
Poppler binaries so it can re-extract and render pages itself. A critic that cannot
reach the source grades the brief against itself, which is worth nothing.

**In scan mode, say so in the prompt.** Without it the critic will look for a comment log
that does not exist and deduct for items it thinks are missing. Tell it the numbered
items are AHA's own comments to issue, and that the job is to judge whether each one is
real and defensible and whether an obvious one is absent, rather than to check numbering
against someone else's document. Name the date, and ask it to check the MCA derivation
and the feeder and OCPD conclusions specifically.

If `triage-critic` isn't a registered agent type, it was added after this session started.
Fall back to `general-purpose` with the same prompt plus: *"Read
`<skill>/references/critic-rubric.md` first and apply it exactly. You did not write this
brief and you owe it nothing."* Same rubric, same loop.

### The loop

Keep a ledger: every round is a version number, a score, and the findings that came back.
Nothing gets overwritten and no version is deleted until a winner is picked.

Each round, fix *only* what the critic named. Don't touch rows it didn't flag, and don't
restructure the brief to chase a score. Re-render as the next version, re-grade.

Stop when any of these is true:

- The score is 10, or the critic returns no findings
- Five grading passes are done
- Two consecutive rounds fail to beat the best score so far

**Reaching 8 is not a reason to stop.** 8 is the floor for shipping, not the target. If
the critic returns findings and there are passes left, run another round — the findings
are free information and the next version is usually better.

### Picking the winner

**Ship the highest-scoring version across all rounds, not the last one.** A fix pass can
make things worse; when it does, the earlier version wins and the later one is discarded.
Ties go to the earlier version, which has less churn in it.

Then, and only then:

1. Copy the winner to the reports folder, always, whatever project it came from.

   **Find the folder first.** Look for `reports-folder.txt` next to this `SKILL.md`. If it
   exists, its one line is the folder. Check that the folder still exists. If the file is
   missing, or the folder is gone, stop and ask the user:

   > Where should I save finished briefs? Paste the full folder path.

   Wait for the answer. Don't guess a path and don't default to the working directory.
   Create the folder if the user confirms it doesn't exist yet. Then write the path, as a
   single line, to `reports-folder.txt` next to this `SKILL.md` so you don't ask again.
   (It's gitignored. If the user says to change the folder, overwrite it.)

   Name the file so the folder reads at a glance, no opening required:

   ```
   <PROJECT> _ <TYPE> _ <NUMBER> - <Subject> _ <VERDICT>.pdf
   ```

   ```
   ACME _ SUB _ 260000-055-0 - Lighting inverter _ REVISE.pdf
   ACME _ RFI _ 228 - Ductbank routing _ OURS TO FIX.pdf
   ```

   Every field is mandatory and the order never changes. A name that varies by run is
   the thing this rule exists to stop. The separators are part of the format: space
   underscore space between project, type and number, a hyphen before the subject, and
   space underscore space before the verdict. Don't substitute hyphens for underscores
   or run them together.

   - **PROJECT** — short project name, the folder it came from (`ACME`). The reports
     folder holds every project, so without this you can't tell them apart.
   - **TYPE** — `SUB` or `RFI`, nothing else. Equipment scan mode is still `SUB`.
     Two fixed tokens is what makes the folder group itself.
   - **NUMBER** — the package number exactly as the source writes it
     (`260000-055-0`, `228`). Never reformat it. Project, type and number lead, so the
     folder sorts into package order.
   - **Subject** — 2 to 4 words, sentence case, what the package actually is
     (`Lighting inverter`, `OFCI MAUs`, `MV cable alternate`). Not a description of
     the brief. No trailing period.
   - **VERDICT** — one token from the table below, upper case. It goes last so it's the
     word the eye lands on at the end of every row.

   The response due date is **not** in the filename. It's on the face of the brief, in
   the header block, and it moves — a name that carries it goes stale the moment the
   date is extended.

   | TYPE | Verdict | When |
   |---|---|---|
   | SUB | `REVISE` | The package itself has to come back — rejected, or non-compliant on something the vendor must change |
   | SUB | `AS NOTED` | Comments to issue, vendor package stands. Still `AS NOTED` when **F** items send our own corrections out by SK or ASI |
   | SUB | `NO EXCEPTION` | Clean, nothing to issue |
   | RFI | `NEEDS DIRECTION` | Any **D** item — someone else decides before this closes |
   | RFI | `OURS TO FIX` | Any **F** item, no **D** |
   | RFI | `ANSWER` | All **P** and **A** — answer and close it |

   When more than one applies, **the most expensive action wins**: REVISE over AS NOTED
   over NO EXCEPTION, and NEEDS DIRECTION over OURS TO FIX over ANSWER. The verdict has
   to match the Call paragraph on the face of the brief. If it doesn't, one of the two
   is wrong and you fix it before shipping.

   Strip anything Windows won't take from the subject (`\ / : * ? " < > |`), collapse
   double spaces, and drop a trailing period. Keep the whole name under 120 characters;
   if it runs long, cut the subject, never the verdict or the number.
2. Leave the losing versions in the scratchpad. Don't clutter the reports folder with
   rounds nobody asked to see.

If the winner scored below 8, say so and name what's still wrong. That's the one case
where findings reach chat, because the user is now inheriting a known problem.

Fixing to the letter is the point. A critic finding is a defect with a named consequence,
not a suggestion to reword. If a finding looks wrong, say so in chat rather than making a
cosmetic change that clears it.

The critic runs silently. Its dialog, its reasoning, and its intermediate findings do not
go in chat.

## What does not go in the brief

The reader is an engineer who has seen a hundred of these.

- **Every row earns its place with a citation, a number, or a named decision-maker.**
  A row carrying none of the three is fluff. Cut it or fold it into another row.
- No explanation of what a submittal review is, what an RFI is, or how the process works.
- Don't quote the comment. State what it actually asks, in twelve words or fewer.
- No hedging. No "it appears," "consider," "may want to," "further review is recommended,"
  "consult a professional."
- No design inside the brief, and no recommendations nobody asked for.

## Reporting back in chat

Four things, and nothing else:

- The file path
- The one-line call
- `Scored <n>/10, best of <k> rounds.` One line. No findings, no critic transcript, no
  description of what got fixed along the way.
- Anything that actually blocked you, including a gap the source package doesn't cover

Don't restate the brief in chat. The whole point is that the PDF travels on its own. The
one exception is a loop that ends below 8 after five passes: name what's still wrong,
because the brief is going out with a known defect.

## Ground rules

- A submittal review confirms general conformance with design intent. It is not a
  dimensional, fabrication, or contractor-coordination check. That boundary is the basis
  for pushing back on an oversized comment.
- Never answer a bundled scope assertion by implication. Answer the question and decline
  the scope call explicitly, in writing.
- Don't design inside an RFI or submittal response. Route new design to a sketch, ASI, or
  bulletin.
- Note ball-in-court dates and vendor selection validity windows. A late response is a
  delay claim; a lapsed validity window moves numbers regardless of who's right.
- For listed equipment, the marked value governs. Conductor ampacity at or above MCA,
  overcurrent device at or below MOCP, and 110.3(B) is why. Re-derive the numbers anyway,
  not to replace the marking but because a gap between your figure and theirs names the
  component nobody accounted for.
- Never cite a code section you haven't confirmed in the edition that jurisdiction
  adopted. An unconfirmed article number is a liability, and the argument from the
  nameplate and the listing is usually stronger anyway.
- A scan finding on our own documents is ours. Write it plainly, in our own comment set,
  before the contractor finds it and prices it.

## Drafting the actual response letter

Separate job, only when asked for it. Structure and phrasing patterns are in
[references/response-letter-template.md](references/response-letter-template.md). Keep the
reviewer's numbering there too.
