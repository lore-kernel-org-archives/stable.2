Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=79.135.106.30
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795717930;
	b=WtC9rVyE7xLT7Et1Ug2BMAb2KC2gC5ch64T/PWL/8oE3PVK35lVl+0pqoVp1HVuDWuaI
	 8EygkTnOc8tdryo36F1yENP9wrYusKqYaIVOjiHOjwXBaeW+VeYKpo3yRFlhUkyNybLxQ
	 XpYGeEb+W6gek2Mc3MZhQHUMdj7cQfbDyLWxn3l53wD93EjkzIAvaCtj0j4B90OwZ8lbP
	 k4rgb8w3x+Ina4pAHi9j7gxWTzdLCI3i4+lpqqBZHYNt6TYN3xXSkFDG2cAR9lpDxA5iS
	 /T6T0df2K+l2gABQRpy1K9kRXmRXb/Q2fktLMuVwVqjMaK59EYgV5vM34sh+GTmtF1w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795717930;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 Feedback-ID:X-Pm-Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=yrhLXFXeWJTnVM3UNeomvZ38ATGqp5KmdTXH8KsKQrE=;
	b=dr1hCfl52jzkXsii2Kq7s2VpXi8rAp032f1ygsdd8oHyAaxobuWl9lVnOjWy6Mil6RHM
	 IIulnMitU59sIlQKUW2ASL8RHMudkDJAdM+coPfX7rqUZilO/SXSJeDgySeYu+9tdOaWI
	 Hmjf156XuT7hVrKKw146rcmtl0b/WVzOXRmEJT6EZhpbZ9IK4uM+dPePlzdmwwW/tt6yC
	 1w8xmImHkTMBBZPTHCh43aWcT+Tgr+at/I27vp2AvM1DqSVZpCc+eK9rFjqhs7hKIKx7N
	 LWpDi4KH6x3bRmT24WgBFTbsodrCVKMvgokw+7ET6uVpklOFl33+i7qsrtnMnd7c2xQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=protonmail.com;
	spf=pass smtp.mailfrom=protonmail.com;
	dkim=pass header.d=protonmail.com header.i=@protonmail.com header.a=rsa-sha256 header.s=protonmail3 header.b=AWPfEb3m;
	arc=none smtp.remote-ip=79.135.106.30
Received: from mail-10630.protonmail.ch (mail-10630.protonmail.ch [79.135.106.30])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 284D8606A321
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 18:32:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 284D8606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=protonmail.com header.i=@protonmail.com header.a=rsa-sha256 header.s=protonmail3 header.b=AWPfEb3m
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1795717923; x=1795977123;
	bh=yrhLXFXeWJTnVM3UNeomvZ38ATGqp5KmdTXH8KsKQrE=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=AWPfEb3m/uZSPhRCrE1TYE5eGBpOY20ul5FQQeqIRXnEOJxTZ238uvi0HUYjpRMb+
	 Xm4Ah6F/qg7cGKj/ZCIZa23OXv6H8f3ZEnpi3zX5PzwuhES6qQqZkd/iof3QoAeAFz
	 92WNDZt1KnDl9HMqy974XKi1vEgUP5RkiPyPv9k5Un0ZuiznzeuOwANHqsBaVYbMXf
	 Crx6s2ZAyvC+mnZp5sdjqV6zGWDtxIR7CtLODz++cqV6NFgrbKb2jr0rnBjWnCQcmF
	 GSCaafwKJPF8M4n1htwfeHeoYvLuQsro0QtYOBvhayeSnXOWphQ2UgNstxZO92+Zod
	 7Zrug7CGl3VoA==
Date: Thu, 26 Nov 2026 18:31:58 +0000
To: moritz.froehlich@student.uni-tuebingen.de
From: Max Brandtner <maximilian.immanuel.brandtner@protonmail.com>
Cc: Max Brandtner <maximilian.immanuel.brandtner@protonmail.com>, stable@vger.kernel.org
Subject: [PATCH] platform/x86: thinkpad_acpi: Restore KEY_PROG4 for TrackPoint doubletap
Message-ID: <20261126183149.3123386-1-maximilian.immanuel.brandtner@protonmail.com>
Feedback-ID: 42508046:user:proton
X-Pm-Message-ID: 9505e75b8bf006775160e59e0c19a318f6f26e0b
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Commit 6227cc32fa01 ("platform/x86: thinkpad_acpi: Add sysfs control
for TrackPoint double-tap") replaced the tpacpi_input_send_key() call
for TP_HKEY_EV_TRACK_DOUBLETAP (0x8036) in hotkey_notify_8xxx() with
code that only clears send_acpi_ev when doubletap is disabled. With
doubletap enabled, which is the default, a doubletap is therefore no
longer reported on the "ThinkPad Extra Buttons" input device; it only
produces an ACPI netlink event. The KEY_PROG4 entry for 0x8036 in
keymap_lenovo[] is left unused.

Up to v7.0 a doubletap was reported as KEY_PROG4, as added by
commit a9b0b1ee59a7 ("platform/x86: thinkpad_acpi: Support for
trackpoint doubletap"). The doubletap_enable documentation in
Documentation/admin-guide/laptops/thinkpad-acpi.rst still says that a
doubletap "triggers a special function key event". Since v7.1,
userspace that binds KEY_PROG4 no longer sees doubletaps. On machines
where commit 9a98ebe630cf ("input: trackpoint - Enable doubletap by
default on capable devices") now enables doubletap in the TrackPoint
firmware, the events reach the driver but are never reported as a key.

Call tpacpi_input_send_key() again when doubletap is enabled. Since
0x8036 lies outside the legacy hotkey scancode ranges, that function
also clears send_acpi_ev, which restores the pre-v7.1 behaviour of
reporting the event through evdev only. When doubletap is disabled the
event is still dropped entirely, as documented for doubletap_enable=3D0.

The problem was found, and this patch drafted, with an AI coding
assistant (Claude Opus 5.5 in Claude Code) while reviewing the
TrackPoint doubletap code.

Fixes: 6227cc32fa01 ("platform/x86: thinkpad_acpi: Add sysfs control for Tr=
ackPoint double-tap")
Cc: stable@vger.kernel.org
---
Not tested on hardware with a doubletap-capable TrackPoint.

Build-tested on x86_64 (defconfig + THINKPAD_ACPI=3Dm) with gcc 16.2.1
at W=3D1; no new warnings.

The event path was exercised in a userspace harness that compiles
hotkey_notify(), hotkey_notify_8xxx(), tpacpi_input_send_key() and
keymap_lenovo[] verbatim from the driver against stubs and feeds it
HKEY 0x8036:

                  doubletap_enable=3D1   doubletap_enable=3D0
  v7.0            KEY_PROG4            netlink 0x8036
  without patch   netlink 0x8036       nothing
  with patch      KEY_PROG4            nothing

In the v4 review of the series, Hans suggested keeping the
tpacpi_input_send_key() call and only inverting its condition [1];
v5 dropped the call instead.

[1] https://lore.kernel.org/all/6ebeb4e7-e446-45aa-a0bb-fc96d1431580@kernel=
.org/

 Doubletap on ThinkPads: allowlist question and the E14 Gen 8

  1. Is it an allowlist? Not per model. The kernel uses a prefix allowlist =
plus
  a short denylist, keyed on the PS/2 TrackPoint's ACPI PNP ID
  (/sys/bus/serio/devices/serio1/firmware_id):

  - Any ID starting PNP: LEN03 counts as doubletap-capable unless it's on t=
he
    7-entry denylist.
  - There is no DMI or model table.
  - The thinkpad_acpi side isn't gated at all. Even your T480s has
    doubletap_enable in sysfs.

  2. Is the E14 Gen 8 supported? The hardware has doubletap: Lenovo's spec =
sheet
  (PSREF) for both the AMD and Intel versions says "TrackPoint pointing dev=
ice,
  double-tap to open the TrackPoint Quick Menu". Whether the kernel turns i=
t on
  depends on that machine's PNP ID and TrackPoint vendor, and I haven't bee=
n
  able to confirm either yet. Even when the kernel does turn it on, a doubl=
etap
  on 7.1+ doesn't produce a key event (bug 2 below).

  How the check works

  Merged in v7.1. The v8 series is the lore link you gave.
  - Capability check: trackpoint_is_dt_capable()
    (drivers/input/mouse/trackpoint.c:413) requires the LEN03 prefix and re=
jects
    LEN0304, LEN0306, LEN0317 and LEN031A=E2=80=93LEN031D (:399). If the ID=
 passes,
    trackpoint_detect() writes 0x58 =3D 0xFF (:514).
  - Why a prefix: on pre-2015 TrackPoints, register 0x58 controlled drag
    hysteresis, so the prefix keeps old machines out.
  - Why trust the denylist: Hans de Goede asked how anyone knows it's compl=
ete.
    Vishnu (Lenovo) answered that Lenovo's internal docs list these as the =
only
    IDs without doubletap, and that "all future trackpoints will support th=
e
    double-tap feature".
  - Before 7.1: newer ThinkPads ship with doubletap switched off in the
    TrackPoint itself, and nothing on Linux switched it on.

  Two bugs in the merged code (still present in v7.4-rc4)

  1. Four of the seven denylist entries never match. pnp_add_id() lowercase=
s the
     hex digits (drivers/pnp/driver.c:325), so the real string is PNP: LEN0=
31a
     PNP0f13. The code's own comment example (LEN030d) is lowercase too. Th=
e
     entries LEN031A=E2=80=93D are uppercase and compared with case-sensiti=
ve strncmp()
     (trackpoint.c:430), so only 0304, 0306 and 0317 are actually excluded.=
 A
     userspace copy of the function confirmed this. Ilpo pointed out the ca=
se
     mismatch in the v1 review in June 2025, and Vishnu said he'd fix it, b=
ut it
     was never changed.
  2. Doubletap no longer sends KEY_PROG4 (a regression in 7.1). Since
     6227cc32fa01, hotkey_notify_8xxx() (thinkpad_acpi.c:3854) no longer ca=
lls
     tpacpi_input_send_key(). A doubletap now produces only an ACPI netlink
     event (hotkey code 0x8036), which acpid/acpi_listen can see but deskto=
p
     shortcuts can't.
     - The KEY_PROG4 keymap entry (:3291) is now unused, and the docs still=
 say
       a doubletap "triggers a special function key event".
     - Net effect: on TrackPoints that ship with doubletap off, no kernel
       version gives you a key event out of the box. Up to 7.0 the kernel n=
ever
       switches it on; from 7.1 it switches it on but sends no key event.
     - I found no fix for either bug on patchwork.

  What still decides the E14 Gen 8

  From your lore list, the one relevant current thread is the Nov 2=
=E2=80=9313 "variant
  id 7" =E2=86=92 "JYT_NDT" thread. Vishnu's other recent threads (fan quir=
ks, USB-C
  security, folio keyboards) don't touch doubletap. It works if all three o=
f
  these hold:
  - The ID passes the check. The 2024 generation does: LEN0321 on the T14 G=
en 5
    AMD and P14s Gen=C2=A05. In March, Mark Pearson said Lenovo wanted this=
 ready
    "for the Linux preloads for the 2026 platforms", and the E14 Gen 8 is o=
ne of
    those, so a passing LEN03xx ID is likely. It isn't confirmed.
  - The TrackPoint sits directly on the PS/2 port, not behind the touchpad.=
 A
    TrackPoint connected through the touchpad never gets a firmware_id.
  - The kernel recognises the TrackPoint vendor. 2026 models can ship a JYT=
/NDT
    TrackPoint (variant 0x07). Without ce8010f11f3e (v7.4-rc3, tagged for s=
table
    but not yet in 7.3.6 or 7.2.15), it shows up as "PS/2 Generic Mouse" an=
d
    doubletap is never switched on.

  The only public E14 Gen 8 data I found is a linux-hardware.org probe of a
  machine type 21Y6 unit running Fedora 44. The site is returning "429 Too =
Many
  Requests", so I've left a slow retry running in the background and will r=
eport
  the actual ID when it comes back. If you have the machine, this settles i=
t:
  cat /sys/bus/serio/devices/serio1/firmware_id   # want PNP: LEN03xx, not=
=20
  0304/0306/0317
  sudo dmesg | grep -i trackpoint                 # want "TPPS/2 =E2=80=
=A6 TrackPoint",=20
  not "PS/2 Generic Mouse"
  acpi_listen                                     # then double-tap: expect=
=20
  "ibm/hotkey =E2=80=A6 00008036"

  One caveat I haven't tested: doubletap is only switched on when the Track=
Point
  is first detected, not when it reconnects after resume. If the TrackPoint
  loses that setting over suspend, doubletap stays off until it's detected
  again.

  Should I draft patches for the two bugs (fix the denylist case, and resto=
re
  tpacpi_input_send_key() when doubletap is enabled)?

  Sources:
  - v8 series
    (https://lore.kernel.org/all/20260311143144.482145-1-vishnuocv@gmail.co=
m/) =C2=B7

  One caveat I haven't tested: doubletap is only switched on when the Track=
Point
  is first detected, not when it reconnects after resume. If the TrackPoint
  loses that setting over suspend, doubletap stays off until it's detected
  again.

  Should I draft patches for the two bugs (fix the denylist case, and resto=
re
  tpacpi_input_send_key() when doubletap is enabled)?

I've written the patch for the second bug. It still needs your Signed-off-b=
y before you send it. It's
  at:

  /home/max/Documents/git/linux/0001-platform-x86-thinkpad_acpi-Restore-KEY=
_PROG4-for-Tra.patch

  The kernel's .gitignore ignores *.patch, so your checkout stays clean, an=
d your branch (esp-tcp-inplace)
  wasn't touched. I built it in a separate scratch copy, based on the platf=
orm/x86 tree's fixes branch.

  The fix (hotkey_notify_8xxx(), 3 lines added, 1 removed):
  -               if (!tp_features.trackpoint_doubletap_enable)
  +               if (tp_features.trackpoint_doubletap_enable)
  +                       tpacpi_input_send_key(hkey, send_acpi_ev);
  +               else
                          *send_acpi_ev =3D false;

  When doubletap is enabled it sends KEY_PROG4 again, with no ACPI netlink =
event, exactly as up to v7.0.
  When it's disabled, the event is still dropped completely, which is what =
the docs promise for
  doubletap_enable=3D0. The tags are Fixes: 6227cc32fa01 and Cc: stable@vge=
r.kernel.org.

  Tested:
  - Reproducer: a userspace harness compiles the driver's real event-handli=
ng code against stubs and feeds
    it a doubletap event (0x8036):

  |               | doubletap_enable=3D1 | doubletap_enable=3D0 |
  |---------------|--------------------|--------------------|
  | v7.0          | KEY_PROG4          | netlink event      |
  | without patch | netlink event only | nothing            |
  | with patch    | KEY_PROG4          | nothing            |

  - Build: gcc 16.2.1 and clang, both at W=3D1, with no new warnings.
  - checkpatch.pl --strict: the only error is the missing Signed-off-by; wi=
th one added it reports 0
    errors, 0 warnings, 0 checks.
  - Applies cleanly to the platform/x86 fixes and for-next branches, mainli=
ne (v7.4-rc4+), 7.3.y and
    7.2.y.

  Not tested: real hardware. Your T480s has no doubletap TrackPoint, and I =
didn't attempt a VM with faked
  ThinkPad ACPI tables. The patch notes below the --- line say so.

  What you need to do or decide:
  1. Add your sign-off. The kernel's rules for AI tools (coding-assistants.=
rst) forbid me from adding it.
     Put Signed-off-by: Max Brandtner <maximilian.immanuel.brandtner@proton=
mail.com> after the Cc: stable
     line.
  2. AI disclosure paragraph. The changelog says the bug was found and the =
patch drafted with Claude Opus
     5.5 in Claude Code, because generated-content.rst requires that. Rewor=
d it if you like, but keep the
     disclosure. I left out a Co-Authored-By: trailer because checkpatch re=
jects it as non-standard.
  3. Netlink event. Since 7.1, a doubletap sends only the netlink event. Re=
storing v7.0 behaviour drops it
     again, because the driver deliberately doesn't send netlink events for=
 these hotkeys. If you'd
     rather keep both, pass NULL instead of send_acpi_ev.
  4. Stable tag. Cc: stable is optional, but this is a regression in releas=
ed kernels (7.1 to 7.3).

  It's an ordinary public bug under the kernel threat model, not a security=
 issue. To send it (I haven't
  sent anything):
  git send-email --to=3Dilpo.jarvinen@linux.intel.com --to=3Dhansg@kernel.o=
rg \
    --cc=3Dhmh@hmh.eng.br --cc=3Dmpearson-lenovo@squebb.ca --cc=3Dderekjohn=
.clark@gmail.com \
    --cc=3Di@rong.moe --cc=3Dvishnuocv@gmail.com --cc=3Dplatform-driver-x86=
@vger.kernel.org \
    --cc=3Dibm-acpi-devel@lists.sourceforge.net --cc=3Dlinux-kernel@vger.ke=
rnel.org \
    0001-platform-x86-thinkpad_acpi-Restore-KEY_PROG4-for-Tra.patch
  These are the people and lists get_maintainer.pl lists for the patch; git=
 send-email will also Cc
  stable@ automatically from the tag.

  The harness is in /tmp/claude-1000/-home-max/f46fb157-4a04-44c6-94f2-832b=
1aa46e4d/scratchpad/repro/,
  which gets cleared on reboot. I can copy it somewhere permanent if review=
ers might ask for it. The
  background retry for the E14 Gen 8 hardware probe is still running, and I=
'll report its PNP ID when it
  finishes.

compiling a custom linux kernel:
git clone https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.gi=
t
cd linux
sudo pacman -S gcc make binutils bc bison flex perl python tar xz git cpio =
openssl efibootmgr rust libelf pahole zstd zlib linux-headers ncurses
make menuconfig
make -j$(nproc)
sudo make install

 drivers/platform/x86/lenovo/thinkpad_acpi.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/x86/lenovo/thinkpad_acpi.c b/drivers/platform=
/x86/lenovo/thinkpad_acpi.c
index 4f81855ad721..923031ff1cfc 100644
--- a/drivers/platform/x86/lenovo/thinkpad_acpi.c
+++ b/drivers/platform/x86/lenovo/thinkpad_acpi.c
@@ -3913,7 +3913,9 @@ static bool hotkey_notify_8xxx(const u32 hkey, bool *=
send_acpi_ev)
 =09switch (hkey) {
 =09case TP_HKEY_EV_TRACK_DOUBLETAP:
 =09=09/* Only send event if doubletap is enabled */
-=09=09if (!tp_features.trackpoint_doubletap_enable)
+=09=09if (tp_features.trackpoint_doubletap_enable)
+=09=09=09tpacpi_input_send_key(hkey, send_acpi_ev);
+=09=09else
 =09=09=09*send_acpi_ev =3D false;
 =09=09return true;
 =09default:

base-commit: d4000e7b99e06e92f21a3c92098a0476d316e9d6
--=20
2.56.1


