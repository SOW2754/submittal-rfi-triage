# Triage brief critic rubric

Applied by the `triage-critic` agent. This file is the single source of truth for the
score, so the rubric can be tuned here without touching the agent definition.

## Stance

You did not write the brief and you owe it nothing. Your reader is the engineer who has
to defend this document if the project ends up in a claim file.

**Read the source package yourself.** Never verify a claim against the brief's own
restatement of it. Every check below runs against the source document, not against the
brief's internal consistency.

## Scoring

Start at 10 and deduct. A raw "rate this 1-10" drifts between runs; the deduction table
does not. Report the arithmetic.

### Caps

These override the deduction total. If more than one applies, take the lowest.

| Condition | Cap |
|---|---|
| A cited sheet, detail, spec section, page, or code article does not exist, or does not support the claim made on it | 4 |
| A calculation is wrong, or a value is misread from the nameplate, schedule, or data sheet | 4 |
| An item from the reviewer's log is missing, or has been renumbered, or two comments were merged into one row | 5 |
| An NEC article is cited for the wrong equipment class, or a subsection is quoted that the adopted edition does not contain or numbers differently | 4 |
| A value in the equipment strip does not match the package: MCA, MOCP, voltage, SCCR, a unit tag, or the value attributed to our schedule | 4 |
| A comment asserts non-compliance where the equipment is in fact compliant, or asserts the vendor's marked MCA is wrong without naming the component that explains the gap | 4 |
| A scope assertion is answered by implication, or responsibility is absorbed that is not ours | 5 |
| A D-track item is filed as P or A, so a cost or scope call reads as an engineering answer | 5 |
| New design is performed inside the brief rather than routed to a sketch, ASI, or bulletin | 5 |
| A means-and-methods or installation decision that belongs to the contractor is taken | 5 |

### Deductions from 10

| Defect | Each | Max |
|---|---|---|
| Row cannot be acted on without opening the source package | −1 | −3 |
| Row carries no citation, no number, and no named decision-maker | −1 | −3 |
| A real risk the source supports is not surfaced: response due date, ball-in-court status, vendor selection validity window, item cluster on one sheet or detail, release-for-manufacture gating | −1 | −3 |
| Track misassignment in the safe direction (P or A filed as D) | −0.5 | −1.5 |
| Hedging language, process explanation, a definition, or the comment quoted back instead of its actual ask | −0.5 | −2 |
| Number stated without its basis or its comparison | −0.5 | −1.5 |
| Runs past one page without the item count justifying the room | −1 | −1 |
| A cell in the equipment strip is blank where the package is silent, instead of reading *not stated* | −0.5 | −1.5 |
| A comment the source clearly supports is absent: OCPD above marked MOCP, feeder sized to a load the submittal contradicts, electric heat kW mismatch, an accessory or by-others load with no circuit on our drawings, SCCR absent or below the available fault current, an unresolved multi-selection package | −1 | −3 |
| A finding is issued that would not survive a meeting with the manufacturer's rep, or that reaches past general conformance into dimensions, fabrication, or contractor coordination | −1 | −2 |

### Scan mode

When the prompt says AHA is the reviewer and there is no comment log, the numbered items
are comments AHA is about to issue. Two changes:

- The missing-or-renumbered-item cap does not apply. There is no prior numbering to
  preserve, so do not deduct for numbering.
- Judge each item on whether it is real, defensible, and worth issuing, and judge the set
  on whether an obvious comment is missing. The absent-comment deduction above is the
  main instrument, and in this mode it is the one that matters most.

Floor at 1. Round half up to a whole number.

An 8 means: no caps triggered, no dangerous mis-tracks, and nothing worse than minor
density or phrasing problems. Do not award an 8 to be agreeable. Do not withhold one to
look rigorous.

## Findings

Every finding names the row number and states the consequence in concrete terms. When the
defect is outside the item table, anchor it to the section instead: `the call`,
`numbers run`, `before you answer`, `sources`, `header`.

- Usable: "Row 7 answers the feeder question without declining the upsize direction. As
  written it is a document showing the engineer directed the work, which is the change
  order."
- Useless, do not write: "Row 7 could be firmer." "Consider clarifying the citation."
  "The tone could be improved."

If you cannot state what goes wrong as a result of the defect, it is not a finding. Drop
it. An invented finding to justify a lower score is a worse failure than missing one.

Findings must be fixable from the source package. Do not ask for information the source
does not contain; if the gap is genuinely in the source, note it as a gap and do not
deduct for it.

## Output

Return exactly this, nothing else. No preamble, no summary of what you read.

```
SCORE: <n>/10
MATH: 10 <each deduction or cap, with the row it came from>
FINDINGS:
- row <n>: <defect> -> <consequence>
- row <n>: <defect> -> <consequence>
VERDICT: SHIP | FIX
```

`SHIP` at 8 or above, `FIX` below. If there are no findings, write `FINDINGS: none`.
