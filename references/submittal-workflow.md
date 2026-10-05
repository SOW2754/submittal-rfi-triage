# Submittal-specific workflow

## What a submittal review is and is not

The review confirms **general conformance with the design concept** and general
compliance with the information in the contract documents. It is not a check of
dimensions, quantities, fabrication means, or the contractor's coordination — those
stay with the contractor, and every review stamp says so.

This boundary is the strongest and most professional basis for pushing back on an
oversized comment. A request that asks the engineer to verify installation detail, or
asks the vendor to document internal fabrication, is asking the submittal process to
do a job it was never meant to do. Saying that plainly is more effective than arguing
about effort.

## Status stamps

Typical legend, though projects vary:

| Code | Meaning |
|---|---|
| 1 | No exceptions taken |
| 2 | Refer to submittal review comments |
| 3 | Submit specified item |
| 4 | Rejected |
| 5 | Resubmit |
| 6 | Do not resubmit |

Read the combination. **(2,6)** means comments were issued and the item is released
without another cycle — the submittal is closed. **(2,5)** means it comes back.

When new comments arrive on a submittal already stamped with a no-resubmittal status,
that is a reopened closed item. It is worth naming in the response, without heat:
state the original stamp and date, state what the new comments would cost, and let
the GC and owner decide whether to spend it. Absorbing that silently means it happens
again on the next package.

## Reading a vendor package

The information is rarely where you expect. Places worth going directly:

- **The notes block.** Numbered notes under a data table or on a drawing routinely
  contain the scope boundary ("power supply of the pump kit is the buyer's scope"),
  the meaning of symbol conventions, and the validity date. Read every note.
- **Asterisks, parentheses, and superscripts.** These almost always have a footnote
  defining them, often one page away. A value in `( )*` frequently means "with the
  optional accessory package installed," which changes weights, currents, and pressure
  drops throughout the package.
- **Multiple selections.** Packages often contain a base design and one or more
  alternates at different operating conditions, each with its own multi-page report and
  its own page numbering (`1/3`, `2/3`). Their electrical and performance data differ.
  Determine which is being purchased before quoting a number, and if the package does
  not say, that is a legitimate comment.
- **Standard-condition ratings.** Efficiency tables published under a rating standard
  (AHRI and equivalents) are required to be at that standard's conditions, not the
  job's. A comment complaining that the part-load table is "at the wrong temperatures"
  is often looking at the certified rating table while the site-condition table sits
  a page later. Check before agreeing.
- **Color on drawings.** Legends often distinguish systems by line color. A reviewer
  working from a black-and-white print will report the color coding as missing. Re-issue
  the sheet in color rather than debating it.
- **Foreign-origin drawings.** Bilingual title blocks and generic voltage listings
  usually indicate a standard factory drawing rather than a job-specific one. Judge the
  job-specific data sheets as authoritative and treat the standard drawing's title block
  as boilerplate to be corrected at record drawings.

## The validity clock

Vendor selections and quotes carry a **period of validity**. After it lapses, the
manufacturer may re-run the selection on updated software and the numbers can move.
It is a commercial term, not a shelf life on the equipment, and once an order is
placed against a selection it is largely moot.

But it is a schedule fact worth stating: when the validity date is weeks away and the
comment set implies multiple round trips, the response window and the validity window
are in conflict. That framing moves a GC in a way that a technical argument does not.

## Long-lead equipment

For switchgear, generators, chillers, transformers, and UPS systems, the milestone
that matters is **release for manufacture**, not final approval. Comments that do not
affect what gets built should never gate release. Sorting comments by that question —
*does this change what the factory builds?* — is often the cleanest way to explain the
tracks to a GC:

- Changes what the factory builds → must resolve before release
- Changes only documentation → resolve in parallel, deliver with O&M
- Changes our drawings → does not touch the vendor at all

## Resubmittal hygiene

When a resubmittal is genuinely required, ask for it in a form that makes the next
review fast:

- The original comments and the contractor's point-by-point responses included
- Changes clouded or otherwise marked
- Only the affected sheets, when a full re-issue is not needed

A resubmittal that arrives without the prior comments attached costs the reviewer the
entire verification pass a second time.
