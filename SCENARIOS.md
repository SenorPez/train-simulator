The following scenario fix packages are available:

# **Peninsula Corridor: San Francisco - Gilroy Route Add-On**
**Package Name:** `PeninsulaGilroyScenarioFixes.zip`

**Installation:** See `INSTALLATION.md`.

> [!IMPORTANT]
> All scenarios have been **minimally tested**; they have been played through to 1000 points without issue. Scenarios are provided with no warranty and no support; the user of the modified scenario assumes all risk.
> All scenarios have been **minimally modified**; aside from updates listed in the solution no other changes have been made, including route errors, missing signage, or other issues.

## 01. [F40PHCC] First Train From Gilroy
**Problem:**  The timetable for the scenario is impossible. Even at the best possible legal speed, the early stops of the timetable are unachievable. While later stops can still be made, this makes it impossible to score 1000 points.

**Solution:** The timetable has been updated.

> [!NOTE]
> The scenario has a `STOP` signal aspect just prior to the Tamien stop. This signal is bugged and does not trigger a SPAD. (See below under **minimally modified**.)

## 05. [GP38] Hollister Local Part 2
**Problem:**  The timetable for the scenario is impossible. Even at the best possible legal speed, the early stops of the timetable are unachievable, which leads to a cascade effect of late stops and massively negative scores.

**Solution:** The timetable has been updated. AI traffic has been updated to account for the new timing of the player's consist.
