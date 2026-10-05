# Electrical review checklist and arithmetic

Work this list against any package with electrical content. Most of these are checks
where the equipment tells you the answer and the only failure mode is not looking.

For the code article behind any of these, see [nec-by-equipment.md](nec-by-equipment.md),
keyed by equipment class. For pulling this data off a package that arrived with no
reviewer comments, see [equipment-scan.md](equipment-scan.md).

## Contents

1. Nameplate vs. our drawings
2. The accessory circuit trap
3. Overcurrent protection: MCA and MOCP
4. Fault current and SCCR
5. Terminations and physical coordination
6. Environment and ambient
7. Harmonics, VFDs, and power quality
8. Grounding and bonding
9. Emergency and standby power
10. The arithmetic

---

## 1. Nameplate vs. our drawings

Pull the equipment's electrical data table and set it beside our panel schedule,
one-line, and power plan. Check:

- **Voltage, phase, frequency.** Vendor drawings from global manufacturers often carry
  a generic title block listing several voltages (`3PH 380/440VAC 50/60Hz`) while the
  job-specific data sheet says the real one. Before treating that as a defect, look at
  the control transformer on the same sheet — a multi-tap primary (`380, 440, 460V`)
  usually means the machine is fine and the title block is boilerplate. That distinction
  is the difference between a written confirmation and a re-issued drawing set.
- **Connected load vs. what we scheduled.** If submitted kW or FLA exceeds what our
  panel schedule carries, feeder and breaker sizing may move.
- **Single point of connection vs. multiple.** Stated on the data table, usually as
  "Connection: SINGLE" or by listing circuits separately.

## 2. The accessory circuit trap

**This is the most commonly missed item in equipment submittals.** Large packaged
equipment ships with auxiliary loads that are not fed from the main power connection
and are almost always the buyer's or contractor's scope. Our drawings show one feeder;
the equipment needs three.

Search the package for these phrases — they are where the scope boundary is drawn:

> "by others" · "by buyer" · "buyer's scope" · "field wired" · "field supplied" ·
> "not by manufacturer" · "separate power source required" · "customer connection"

Then look on the P&ID or wiring diagram for tags like **SUPPLIED BY BUYER** next to a
component. The notes block on a P&ID is a high-yield place to read carefully.

Accessory loads that commonly need their own circuit:

- Pump kits and pump packages (often a genuine motor circuit, not a cord drop)
- Heater boxes, crankcase heaters, sump and oil heaters
- Heat trace and freeze protection
- Control panels and BMS interface panels
- Condensate pumps
- Convenience receptacles and service lighting at the unit
- UPS units serving magnetic bearing or control electronics

For each one found, the two questions to ask the vendor are: **what is the connected
load**, and **is this optional package actually in our order?** Optional accessories
show up in submittals whether or not they were purchased, often marked with an
asterisk convention explained in a footnote.

## 3. Overcurrent protection: MCA and MOCP

Two numbers, and they do opposite jobs. Confusing them is a recurring error.

- **MCA (minimum circuit ampacity)** is a *floor*. The conductor ampacity must be at
  least this. It already accounts for the 125% factor on the largest motor.
- **MOCP (maximum overcurrent protection)** is a *ceiling*. The overcurrent device must
  not exceed it. It exists so the device still allows starting inrush while protecting
  the equipment as listed.

```
conductor ampacity  >=  MCA
OCPD rating         <=  MOCP
```

The classic defect is a one-line showing a breaker **above** MOCP, usually because
someone rounded up to a familiar frame size. Listed equipment must be installed per
its listing, so exceeding the marked maximum is not a judgment call.

Practical fix: keep the larger **frame** if spare capacity is wanted and drop the
**trip** to the manufacturer's recommended breaker. A trip change usually does not
disturb a switchgear order the way a frame change would, which is worth saying
explicitly when the gear is already released.

Watch for packages containing **more than one selection** (a base design and an
alternate at different operating conditions). Their electrical tables will differ
slightly. Confirm which selection is being purchased before citing a number.

Cite NEC articles only when certain, and confirm the code edition adopted by the
jurisdiction before putting a section number in writing. Marked MOCP and the listing
requirement in Article 110 are the durable arguments; exact subsection numbering moves
between editions.

## 4. Fault current and SCCR

The equipment's **short circuit current rating** must be at least the available fault
current at its terminals. This is frequently absent from submittals and frequently
never checked.

- Find the SCCR on the nameplate data or the starter/panel data.
- Compare against the available fault current from the study, or the calculated value
  at that point.
- A 5 kA default SCCR on a control panel fed from a large service is a real problem
  and a legitimate comment to raise.
- Series ratings only apply where the combination is tested and listed together.

If SCCR is not stated, ask for it. This is a cheap ask with a high consequence.

## 5. Terminations and physical coordination

What we need in order to draw the connection, and what usually is not submitted:

- Lug location and quantity, and whether lugs are furnished or field-provided
- Lug wire range (does it accept our conductor size and number of parallel sets?)
- Conduit entry: top or bottom, which side, and available entry area
- Working space in front of the equipment, NEC Article 110 clearances, against the
  vendor's own service clearance dimensions
- Whether disconnecting means is factory-mounted or by us

Asking for "elevation views of all panels" is usually oversized. Asking for a
**termination detail** gets the same information out of a drawing the vendor already
has.

## 6. Environment and ambient

Electronics inside equipment enclosures have narrower temperature limits than the
equipment itself, and this gets missed on outdoor installations in hot climates.

- **UPS units and batteries** inside control panels. Small rack UPS units are commonly
  rated to about 40°C (104°F), and battery service life falls sharply above 25°C.
  Outdoor equipment in a hot climate can exceed that inside an unventilated enclosure.
- VFDs, PLCs, and drives: check derating curves against ambient and altitude.
- Ask about the **internal panel ambient**, not just the outdoor design ambient. Whether
  the enclosure is ventilated or conditioned is the question that actually answers it.
- Altitude derating on drives and transformers above roughly 3300 ft.

Enclosure rating (NEMA / IP) should match the installed location. Note that IP and
NEMA do not map exactly; IP54 is not equivalent to NEMA 3R for all purposes.

## 7. Harmonics, VFDs, and power quality

- Confirm whether the stated harmonic performance (`TDD < 5%`) is achieved with an
  integral filter, an active front end, or assumes an external line reactor we owe.
- IEEE 519 compliance is measured at the point of common coupling, not at the drive
  terminals. A drive-level TDD claim is not the same as system compliance.
- Check whether a K-rated or drive-isolation transformer is assumed upstream.
- Cable length limits between drive and motor, and whether a dV/dt or sine filter is
  needed, are common submittal omissions.

## 8. Grounding and bonding

- Equipment grounding conductor sizing per NEC Table 250.122, sized to the OCPD.
- Any manufacturer-specific grounding requirement (some drives and mag-bearing
  machines specify a dedicated ground or a specific impedance).
- Bonding of separately derived systems within the equipment.
- Whether the vendor expects a signal reference ground separate from the safety ground.

## 9. Emergency and standby power

If the equipment is on generator or UPS:

- **Starting kVA and inrush**, not just running load. VSD-started equipment has a much
  gentler curve than across-the-line, which can change generator sizing substantially.
- Step-loading sequence and whether the equipment tolerates the generator's voltage
  and frequency dip.
- Restart behavior and time to full capacity after a transfer. Some packages document
  a restart test; find it and read the conditions it was run at.
- Whether control power rides through the transfer or the unit faults out.

## 10. The arithmetic

Run these rather than asserting. A number in the response ends an argument that an
adjective prolongs.

**Three-phase current from power**

```
A = kW x 1000 / (V x 1.732 x PF)
A = kVA x 1000 / (V x 1.732)
```

**Motor current** — use the NEC Table 430.250 value for conductor and OCPD sizing, not
the nameplate FLA. Nameplate FLA is for overload protection.

**Chilled water flow and delta T** (the cross-discipline check that catches selection
conflicts)

```
GPM = tons x 24 / deltaT_F
deltaT_F = tons x 24 / GPM
```

Compare the result against the evaporator's published **minimum flow**. A required
delta T that drives flow below the minimum is not achievable with that machine, and
the ceiling is:

```
max deltaT_F at full load = tons x 24 / min_flow_GPM
```

This is a mechanical conclusion, so hand it to the mechanical EOR as a flag with the
numbers shown, rather than issuing it as a determination.

**Airflow and heat**

```
BTU/hr (sensible, air) = 1.08 x CFM x deltaT_F
kW of heat             = BTU/hr / 3412
```

**Voltage drop, three-phase**

```
VD = 1.732 x K x I x L / cmil        K ~ 12.9 copper, ~21.2 aluminum
```

**Transformer full-load current**

```
A = kVA x 1000 / (V x 1.732)
```

**Sanity check on any stated efficiency**

```
kW/ton = 12 / EER          EER = 12 / (kW/ton)
```

When a published table gives both, confirm they agree. A mismatch means the table was
edited by hand or the conditions differ from what the header claims.
