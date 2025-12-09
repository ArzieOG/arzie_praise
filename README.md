📌 arzie_praise — Player Praise System (QBOX + ox_lib)

arzie_praise is a lightweight, user-friendly praise submission system for FiveM servers using QBOX, ox_lib, and oxmysql.
It allows players to submit positive feedback (“praise”) about other players/characters through a clean UI menu and logs all submissions to a Discord webhook for staff review.

A 24-hour cooldown per character ensures players can only submit one praise per day. (Can be changed)
An optional flag allows players to mark whether staff may share their praise publicly (this does not hide anything from the webhook is simply if you wanted to make it public).

🖼️ Preview


<img width="184" height="115" alt="image" src="https://github.com/user-attachments/assets/09ebe063-8ac7-4d45-9089-6215283dc2f3" />
<img width="547" height="585" alt="image" src="https://github.com/user-attachments/assets/9e668ddf-7c5a-4416-a123-6cd387951d57" />
<img width="508" height="567" alt="image" src="https://github.com/user-attachments/assets/7bfe8e7f-4352-490e-b43b-697e67bf7fca" />
<img width="416" height="65" alt="image" src="https://github.com/user-attachments/assets/aa6deca2-e57d-41ca-8376-627d0cd12064" />
<img width="392" height="90" alt="image" src="https://github.com/user-attachments/assets/07f49760-8df2-4905-a2dd-374129986e4c" />
<img width="351" height="398" alt="arzpr" src="https://github.com/user-attachments/assets/aa4befe2-c085-41c0-9033-bdcef59f878a" />

✨ Features

/praiseplayer command opens an ox_lib input dialog

Players fill out:

Your Name

Who You’re Praising

Comments / Reason

Public Sharing Permission (Yes/No)

Fully customizable Discord webhook embed

Per-character cooldown (SQL)

Cooldowns persist between restarts

Clean, optimized, standalone resource


🛠 Dependencies

ox_lib

oxmysql

QBOX / qbx_core

📦 Installation

Drag the arzie_praise folder into your server resources

Add this line to server.cfg:

ensure arzie_praise


Import the SQL file:

praise_cooldowns.sql


Edit server.lua and set your webhook:

local webhook = "YOUR_WEBHOOK_HERE"


Done — the system is live.

🖥️ Usage

Players type:

/praiseplayer


A menu opens with the fields:

Your Name

Player Praised

Comments

OK to be Public? (Yes/No)

When submitted:

The praise is logged to Discord

The sender gets a 24-hour cooldown

Cooldown is tied to the character’s citizenid

📡 Webhook Output Example

From: John Doe

Praising: Sarah Thompson

Comments: Helped me with a mission, super friendly!

CitizenID: QBC12345

In-game Name: Doe

Public Sharing OK?: Yes
