# NEC by equipment class

What to cite when an equipment submittal or an RFI turns on code. Organized by the
machine in front of you, because that is how the question arrives.

This file is a pointer list, not a substitute for opening the book. Confirm every
section in the adopted edition before it goes in writing.

---

## Citation discipline

Read this part before using any section number below.

**Confirm the adopted edition and the state amendments first.** The NEC is only law where
a jurisdiction adopts it, always on a lag, and usually amended. The spec's code
compliance section, the code sheet in the drawing set, or the AHJ tells you which. If
none of them do, that is a legitimate question to ask rather than a number to assume.

Amendment documents for AHA's offices, which are stable even as editions roll:

| State | Amendment vehicle |
|---|---|
| Massachusetts | 527 CMR 12.00, the Massachusetts Electrical Code |
| Georgia | State minimum standard codes, NEC with Georgia amendments |
| Pennsylvania | Uniform Construction Code, 34 Pa. Code Ch. 403 |
| Virginia | USBC, which incorporates the NEC by reference through the IBC |

Confirm the edition each one currently points at on every project. They move
independently and they do not move together.

**Prefer the durable argument to subsection archaeology.** For listed equipment, the
strongest citation is almost always the pair:

- **110.3(B)** — listed and labeled equipment shall be installed and used in accordance
  with instructions included in the listing or labeling
- the value marked on the equipment itself

That argument survives every edition change, it does not depend on a table you might be
reading from the wrong year, and it is very hard to argue with. Reach for a specific
subsection only when the marked value does not settle it.

**Watch the sections that moved.** Ampacity tables were reorganized in 2020 (what older
documents call Table 310.15(B)(16) is now Table 310.16, and the correction and adjustment
subsections renumbered with it). 210.8 has expanded in every recent cycle. Arc energy
reduction (240.67, 240.87) and emergency disconnects (230.85) have both changed scope
recently. If a comment quotes one of these from an old memory, check it before agreeing
or disagreeing.

**Never cite a section you have not confirmed.** A wrong article number in a submittal
response is worse than no article number. The critic caps the brief at 4 for one.

---

## Applies to nearly everything

| Section | What it gets you |
|---|---|
| 90.4 | The AHJ interprets and may waive. Ends "but the code says" arguments that have already been decided locally |
| 110.3(B) | Install per the listing. The backbone citation for any marked value |
| 110.9 | Interrupting rating adequate for the available fault current |
| 110.10 | Circuit impedance and component short-circuit withstand. The SCCR argument |
| 110.14(C) | Termination temperature rating governs conductor sizing. 60 C below 100 A unless the terminations are rated higher |
| 110.16 | Arc flash warning marking; service equipment labeling requirements for larger gear |
| 110.24 | Available fault current field marking at the service |
| 110.26(A) | Working space: depth per the condition table, 30 in width, 6.5 ft height |
| 110.26(C) | Entrance to working space, including the second-entrance requirement for large gear |
| 110.26(E) | Dedicated equipment space above and around |
| Article 100 | Definition of continuous load. The reason for every 125% factor downstream |
| 210.19, 215.2 | Branch and feeder conductor sizing, 125% of continuous load |
| 210.63 | Service receptacle required within 25 ft of HVAC and refrigeration equipment. Routinely missed at rooftop and outdoor units |
| 210.8(B) | GFCI in other than dwelling units. Scope has grown; check the adopted edition |
| 240.4 | Protection of conductors, including the small-conductor limits in 240.4(D) |
| 240.6(A) | Standard OCPD ratings. What "next size up" can actually be |
| 250.122 | Equipment grounding conductor sized from the OCPD, with the upsizing rule |
| 300.5 | Underground cover depths |
| 310.15, Table 310.16 | Ampacity, ambient correction, and adjustment for more than three current-carrying conductors |
| 408.4 | Circuit directory and source identification at panelboards |

---

## Packaged HVAC: RTUs, MAUs, chillers, condensing units, split systems

**Article 440** governs, and it is the one to know cold.

| Section | What it gets you |
|---|---|
| 440.4(B) | Multimotor and combination-load equipment must be marked with **MCA** and **maximum overcurrent protective device**. This is why the nameplate is the design basis |
| 440.6 | Use the rated-load current on the nameplate for sizing, not a table value |
| 440.12 | Disconnecting means rating, based on RLA and LRA |
| 440.14 | Disconnect within sight from and readily accessible from the equipment. Not behind the unit, not on the other side of the roof |
| 440.22 | Branch-circuit OCPD for a single motor-compressor: 175% of RLA, up to 225% if needed to start |
| 440.32, 440.33 | Conductor sizing for one and for several motor-compressors |
| 440.35 | For listed multimotor equipment, the **manufacturer's marked values govern**. Pair with 110.3(B) |

The two rules that decide most comments:

```
conductor ampacity  >=  MCA        (a floor)
OCPD rating         <=  MOCP       (a ceiling)
```

MCA already carries the 125% factor on the largest motor. MOCP exists so the device
tolerates starting inrush while still protecting the equipment as listed. Exceeding the
marked maximum is not a judgment call, and rounding up to a familiar frame size is the
usual way it happens. Keep the frame, drop the trip.

Also reachable from here: **424** if the unit carries electric heat, **430** for any
separately fed fan or pump motor, **210.63** for the service receptacle, and **110.26**
for working space in front of the electrical section.

## Motors, pumps, and fans

**Article 430.** The one that gets misapplied most often is 430.6.

| Section | What it gets you |
|---|---|
| 430.6(A)(1) | Size conductors and OCPD from the **Table 430.247 through 430.250 FLC**, not the nameplate FLA. Nameplate FLA is for overload protection only |
| 430.22 | Single motor branch conductors at 125% of FLC |
| 430.24 | Several motors: 125% of the largest plus the sum of the rest |
| 430.32 | Overload protection, sized from the **nameplate** FLA and service factor |
| 430.52, Table 430.52(C)(1) | Maximum branch short-circuit and ground-fault protection by device type. Inverse-time breaker generally 250% of FLC, with the next-standard-size allowance |
| 430.62 | Feeder OCPD: largest branch device plus the sum of the other FLCs |
| 430.102 | Disconnect in sight of the controller, and in sight of the motor or lockable |
| 430.110 | Disconnect ampere rating at least 115% of FLC |

## Variable frequency drives and power conversion equipment

Part X of Article 430, and the section people miss is 430.122.

| Section | What it gets you |
|---|---|
| 430.122 | Conductors supplying the drive are sized from **125% of the drive's rated input current**, not the motor FLC. Different number, and usually larger |
| 430.130 | Branch-circuit protection for a single power conversion unit |
| 430.126 | Motor overtemperature protection, because a drive at low speed defeats the motor's own cooling |
| 110.3(B) | Cable length limit between drive and motor, and whether a dV/dt or sine filter is required. Both are in the drive's listing instructions |

Harmonics are not an NEC question. IEEE 519 is the standard, it is measured at the point
of common coupling, and a drive-level TDD claim is not system compliance. Check whether
the stated performance assumes an integral filter, an active front end, or an external
line reactor that lands in our scope.

## Generators

| Section | What it gets you |
|---|---|
| 445.11 | Required nameplate marking |
| 445.12 | Overcurrent protection |
| 445.13(A) | Conductor ampacity at least **115%** of the nameplate current rating |
| 445.18 | Disconnecting means and shutdown, including remote emergency shutdown for larger outdoor installations. Check scope in the adopted edition |

Then the system article for how the generator is used: **700** emergency, **701** legally
required standby, **702** optional standby, **708** critical operations. They are not
interchangeable, and which one applies is a life safety code and AHJ determination, not
an electrical engineering preference.

For submittal review, starting kVA matters more than running kW. A VSD-started load has
a far gentler curve than across-the-line and can change generator sizing substantially.
Step loading, voltage and frequency dip tolerance, and whether control power rides
through the transfer are all submittal questions the package usually answers if you look.

Fuel storage, ventilation, and sound are not NEC. NFPA 110 governs the emergency power
supply system, and it is the citation for onsite fuel and testing.

## Transfer switches

| Section | What it gets you |
|---|---|
| 700.5, 701.5, 702.5 | Transfer equipment requirements by system class. Must be listed for emergency use where 700 applies |
| 700.10(B) | Emergency wiring kept independent of all other wiring. Drives separate raceways and separate sections, and it is a real coordination cost |
| 702.7 | Signage at the service and at the transfer equipment |
| 708.24 | Transfer equipment for critical operations power systems |

## Transformers

| Section | What it gets you |
|---|---|
| 450.3(B), Table 450.3(B) | Overcurrent protection for transformers 1000 V and less. Primary-only or primary-and-secondary, with the notes that let you round up |
| 240.21(C) | **Secondary conductor taps.** The most commonly missed transformer item, and the one that shows up in the field |
| 450.9 | Ventilation, and clearance to walls per the markings on the transformer |
| 450.13 | Accessibility, including the conditions for installing above a suspended ceiling |
| 450.21 | Indoor dry-type over 112.5 kVA: fire-rated room, or a higher insulation class with the specified clearances |
| 450.22 | Outdoor dry-type in a weatherproof enclosure |
| 250.30 | Grounding and bonding of the separately derived system on the secondary |

K-factor and harmonic derating are not code requirements. They are design decisions, and
a submittal that silently substitutes a standard transformer where a K-rated one was
specified is a spec comment, not a code comment.

## Switchgear, switchboards, and panelboards

| Section | What it gets you |
|---|---|
| 408.36 | Panelboard overcurrent protection |
| 408.3(F) | Field marking where multiple sources supply the equipment |
| 110.24 | Available fault current marking, and the update requirement when the system changes |
| 110.26(C) | Second entrance to the working space for large gear |
| 230.95 | Ground-fault protection of equipment on solidly grounded wye services over 150 V to ground and 1000 A or more |
| 240.67, 240.87 | Arc energy reduction for fuses and for circuit breakers at and above 1200 A. Scope has changed recently; confirm the edition |
| 700.32, 701.32, 708.54 | Selective coordination where the system class requires it |

SCCR is the check that gets skipped. The equipment rating must be at least the available
fault current at its terminals, series ratings only apply where the combination is tested
and listed together, and a 5 kA control panel fed from a large service is a real problem.

## UPS, batteries, and energy storage

| Section | What it gets you |
|---|---|
| 480.7 | Disconnecting means for stationary standby batteries |
| 480.10 | Battery locations: ventilation, spaces about, live parts, working space |
| Article 706 | Energy storage systems, for lithium and other ESS installations |
| 700.12(B) | Storage battery as an emergency system source, including capacity and duration |
| 645.10 | Disconnecting means in an information technology equipment room |

NFPA 855 governs ESS siting, separation, and fire protection, and it is usually the
binding document long before the NEC is. For UPS inside equipment enclosures, the
ambient limit is the thing to check: small rack units are commonly rated to about 40 C
and battery life falls sharply above 25 C, which outdoor enclosures in a hot climate
exceed routinely.

## Fire pumps

**Article 695**, and it deliberately inverts the normal rules. Reliability beats
protection here, which is why so many of its requirements look wrong at first glance.

| Section | What it gets you |
|---|---|
| 695.3 | Acceptable power sources and when a second source is required |
| 695.4 | Continuity of power. Direct connection, or a supervised connection whose OCPD is sized to **carry locked-rotor current indefinitely** |
| 695.5 | Transformer sized at 125% of the fire pump and jockey pump loads plus accessories |
| 695.6(B) | Supply conductors at 125% of the fire pump, jockey pump, and accessory loads |
| 695.6(D) | No overload protection in the fire pump circuit |
| 695.7 | Voltage drop: not more than 15% at the controller during starting, not more than 5% running |
| 695.10 | Listed for fire pump service |

NFPA 20 is the companion, and on a fire pump submittal it usually decides more than the
NEC does.

## Elevators

| Section | What it gets you |
|---|---|
| 620.51 | Disconnecting means, lockable in the open position, in sight of the controller |
| 620.62 | **Selective coordination** where more than one driving machine disconnect is supplied by a single feeder. A frequent and expensive miss |
| 620.22 | Separate branch circuits for car lighting and for machine room lighting and receptacles |
| 620.16 | Short-circuit current rating of the controller |
| 620.23, 620.24 | Machine room and pit lighting and receptacles |
| 110.26 | Working space in the machine room, which elevator vendors size for their own equipment and not for ours |

## Data centers and IT equipment rooms

| Section | What it gets you |
|---|---|
| 645.4 | **The gate.** Article 645 applies only if every listed condition is met: the disconnecting means of 645.10, a dedicated HVAC system, listed ITE, a separate room with fire-rated separation, and no other occupancy |
| 645.5 | Supply circuits and interconnecting cable requirements, including the under-floor allowances that are the reason to invoke 645 at all |
| 645.10 | Disconnecting means for electronic equipment and HVAC, with the exemption path for critical operations data systems |
| 645.14 | Separately derived systems and grounding |
| Article 708 | Critical operations power systems, where the facility is designated |

The decision to be explicit about: if 645.4 cannot be fully satisfied, Article 645 does
not apply, the installation is designed to Chapter 3, and the 645.10 disconnect is not
required. Teams argue about the EPO for months without settling that question first.

## Electric heat and duct heaters

| Section | What it gets you |
|---|---|
| 424.3(B) | Branch-circuit conductors and OCPD at **125%** of the total heating load. Fixed electric heat is a continuous load by rule, no judgment involved |
| 424.22(B) | Subdivision of load, with the per-subdivided-circuit ampere limit |
| 424.19 | Disconnecting means, within sight or capable of being locked open |
| 424.65 | Disconnect for a duct heater controller, accessible and within sight of the controller |

## EV supply equipment

| Section | What it gets you |
|---|---|
| 625.40 | Dedicated branch circuit per EVSE |
| 625.41 | Rating: EVSE load is continuous, so 125% |
| 625.42 | Load calculation, including the energy management allowance |
| 625.43 | Disconnecting means for larger units |
| 625.54 | GFCI for receptacle-supplied EVSE |
| Article 750 | Energy management systems, where load is being managed rather than added |

## Solar and interconnection

| Section | What it gets you |
|---|---|
| 705.12 | Load-side interconnection, including the busbar sizing rules. This section has been reorganized recently; confirm the edition before citing a subsection |
| 705.11 | Supply-side connections |
| 690.12 | Rapid shutdown |
| 690.13 | PV system disconnecting means |

## Appliances and commercial kitchen equipment

| Section | What it gets you |
|---|---|
| 422.10 | Branch-circuit sizing for a single appliance and for multiple |
| 422.11 | Overcurrent protection, including the manufacturer's marked maximum |
| 422.16 | Where flexible cord is permitted, and the conditions on it |
| 422.30 through 422.33 | Disconnecting means, including cord-and-plug as the disconnect |
| 210.8(B) | GFCI for kitchen equipment and receptacles. Scope has expanded; check the edition |

Nameplate values on kitchen equipment are frequently the connected load with every option
installed, and the actual order is smaller. Ask before resizing a feeder around one.

## Health care

| Section | What it gets you |
|---|---|
| 517.13 | Redundant grounding in patient care spaces |
| 517.18, 517.19 | Receptacle counts and requirements by patient care space category |
| 517.30 | Essential electrical system, and the branch structure |
| 517.31 | Coordination requirement for the essential electrical system |
| 517.160 | Isolated power systems |

NFPA 99 sets the risk category that drives most of the above, and it is the document to
read first.

## Hazardous locations

| Section | What it gets you |
|---|---|
| 500.5, 500.7 | Classification, and the permitted protection techniques |
| 501.10 | Wiring methods by division |
| 501.15 | Sealing, which is the requirement that actually gets violated in the field |

Classification is a documented determination by the owner or a qualified person, not
something to assume from the presence of fuel or batteries.

## Control, fire alarm, and communications

| Section | What it gets you |
|---|---|
| 725.121 | Class 2 and Class 3 power sources |
| 725.136 | Separation of Class 2 conductors from power conductors |
| 725.144 | Ampacity of conductors carrying power and data, which is the PoE bundling limit |
| 760.41, 760.121 | Fire alarm power supply requirements, non-power-limited and power-limited |
| 770, 800, 805, 840 | Optical fiber and communications circuits, including bonding and listing |
| 300.22(C) | Wiring methods in plenum spaces |
