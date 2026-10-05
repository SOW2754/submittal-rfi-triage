# Equipment scan

For the submittal that arrives with **no reviewer comment log**, because AHA is the
reviewer. There is nothing to triage. The scan produces the comments.

The deliverable is unchanged: one page, same tracks, same template. What changes is
where the items come from. Each row is a comment AHA is about to issue, numbered by the
brief, and each one has to be defensible on its own because nobody else wrote it first.

A scan also runs *inside* a normal triage when the package has equipment in it. There it
is a background step — it feeds the Numbers block and catches the comment the reviewer
missed, but the reviewer's numbering still governs the item table.

---

## 1. Inventory before you read anything

Extract the text first (`scripts/pdf-to-text.ps1`), then find out how many machines are
actually in the package. This is the step people skip, and it is why the wrong number
gets quoted.

```
grep -n -iE 'unit tag|rtu tag|equipment tag|model number' source.txt
grep -n -iE 'electrical data|electrical requirements|power supply|nameplate' source.txt
```

Write down, per unit: **tag, model, page range, line number of its electrical block.**
Keep that map. You will come back to it for every number you cite.

Three traps live here:

- **Repeated tags.** A package for three identical units repeats the same data block
  three times with different tags. Confirm they are actually identical before treating
  one as representative — electric heat and options often differ unit to unit.
- **Multiple selections.** A base design and an alternate at different conditions, each
  with its own page numbering (1/3, 2/3) and its own electrical table. Determine which
  is purchased before quoting. If the package does not say, that is comment number one.
- **Tag translation.** The vendor's tag (DH101MAU1-1) and our schedule's tag (MAU-1-1)
  are often not the same string. Map them explicitly and put the mapping on the brief if
  it is not obvious. A reviewer who cannot match a row to a unit stops reading.

## 2. Pull the field schema, per unit

Take everything on this list that the package states. Mark anything absent as **not
stated** rather than leaving it blank — an absent SCCR is itself a finding.

**Supply**
- Voltage / phase / frequency, and whether it came from the job-specific data sheet or a
  generic title block
- Single point of connection or multiple. Stated as `Connection: SINGLE`, or implied by
  separate circuits listed
- MCA (minimum circuit ampacity)
- MOCP / MOP / MFS, and its *type*: "max fuse", "max HACR breaker", "max inverse time
  breaker". A fuse-only marking means a breaker is not a like-for-like substitution
- SCCR, at the unit and at any factory control panel

**Loads that build the MCA**
- Compressors: quantity, RLA each, LRA each
- Fan motors: quantity, HP, FLA each, supply and exhaust separately
- Electric heat: kW, stages, and the amps drawn
- Gas train, igniter, controls transformer
- Anything with its own FLA line

**Accessories and scope**
- Every load marked *by others, by buyer, field wired, field supplied, separate power
  source, customer connection*
- Convenience receptacle and unit service lighting, and whether GFCI is factory-provided
- Control panel, BMS gateway, VFD, condensate or pump kit, heat trace
- The option list, and which options are actually on the order

**Physical**
- Factory or field disconnect; fused or non-fused; its ampere rating
- Lug quantity, wire range, and termination temperature rating
- Conduit entry location and available entry area
- Enclosure / NEMA rating, and the operating ambient range for the unit *and* for the
  control electronics inside it
- Service clearances, against NEC working space

## 3. Read the nameplate image when the text is thin

`pdftotext -layout` drops values out of graphical nameplate blocks, and OCR-less scans
give nothing. Render and look:

```
pdftoppm -png -r 300 -f <page> -l <page> -x <X> -y <Y> -W <W> -H <H> source.pdf out
```

**Never put a value on the brief that you have not seen directly**, in the text
extraction or in the image. The critic checks these against the source and one misread
caps the score at 4.

## 4. Derive the numbers, then compare to the marked ones

For listed multimotor and combination-load equipment, the **marked values govern**. NEC
440.4(B) requires the marking; 110.3(B) requires installing per it. That is the whole
argument, and it does not depend on your arithmetic:

```
conductor ampacity  >=  MCA
OCPD rating         <=  MOCP
```

You still re-derive, for one reason: **a gap between your number and theirs names a
component.** That is how you find the accessory that is not on our drawings.

```
MCA = 1.25 x (largest motor RLA or FLA) + sum of all other loads
```

Work it against the component table on the same page. If your figure and the marked
figure disagree by more than rounding, the difference is almost always electric heat,
an option package, or a load the table lists but the total omits. Find which one.

**Do not issue a comment saying the vendor's MCA is wrong unless you can name the
component that explains the gap.** Absent that, your derivation is the thing that is
wrong, and the comment is one you lose in front of the manufacturer.

Everything else worth running is in
[electrical-checklist.md](electrical-checklist.md) section 10.

## 5. Build the comparison

Two columns of truth: what was submitted, and what our documents carry. Set them side by
side per unit, on the face of the brief when it fits.

| Submitted | Our schedule / one-line / panel schedule | Delta | Consequence |
|---|---|---|---|

The consequence column is the one that matters. `MCA 76 A vs. 400 AF/400 AT scheduled`
is a fact. *"OCPD is five times the marked maximum, so the installation cannot comply
with the listing and the feeder is sized for a load that does not exist"* is a comment.

## 6. What the scan usually finds

Ordered by how often each turns out to be real. Work the list top down; the first four
account for most of what ships.

1. **OCPD above marked MOCP.** Usually a frame size someone rounded up to, or a schedule
   written before the selection came back. Keep the frame, drop the trip, and say so —
   a trip change does not disturb released gear the way a frame change does.
2. **Feeder and breaker sized to the design load, not the submitted MCA.** Runs in both
   directions. Undersized is a defect we own. Grossly oversized is still a defect,
   because conductor protection and the equipment listing both key off the marked values.
3. **Electric heat kW does not match the schedule.** Changes MCA, feeder, and often the
   panel's connected load.
4. **Accessory loads with no circuit on our drawings.** The single most missed item in
   equipment submittals. Section 2 of [electrical-checklist.md](electrical-checklist.md)
   has the phrase list and the usual suspects.
5. **Voltage or phase mismatch** that turns out to be a generic multi-voltage title block
   on a factory-standard drawing. Check the control transformer taps before calling it a
   defect. Boilerplate gets a written confirmation, not a re-issued drawing set.
6. **SCCR not stated, or stated below the available fault current** at those terminals.
   Cheap to ask for, expensive to discover in the field.
7. **Disconnect scope unstated.** Factory-mounted or ours, fused or not, and whether its
   rating works with the MOCP.
8. **Options shown that are not on the order**, or purchased options missing from the
   submittal. The asterisk-and-footnote convention is how the package tells you, usually
   a page away from the table.
9. **Multiple points of connection** where our drawings show one feeder.
10. **Working space and termination reality.** Lug wire range against our parallel sets,
    conduit entry against our routing, NEC 110.26 clearance against the vendor's own
    service dimensions.

Then check the applicable articles in [nec-by-equipment.md](nec-by-equipment.md) for the
equipment class in hand, and cite only what you have confirmed in the adopted edition.

## 7. Filtering to what ships

A scan generates more candidates than a submittal review should carry. Cut on two tests:

- **Does it change what gets built, what gets bought, or what we draw?** If not, it is a
  record-drawing note, not a review comment.
- **Would you defend it in a meeting with the manufacturer's rep?** A comment you would
  walk back costs more credibility than the one you did not write.

A submittal review confirms general conformance with design intent. It is not a
dimensional check, a fabrication check, or the contractor's coordination. Comments that
reach past that line get declined when other people write them, and should not be
written by us either.

Cluster before you finalize: if several findings trace to one cause — one stale schedule
row, one option package — say that in a single line. One cause stated plainly closes
more than five symptoms listed separately.
