Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794329444;
	b=ExNqmbexxsaB9FeSwrmboOvRl7xZi0E/Z81XJCLmBUm14+b9pdbiIflSaslAbzYKT6iC
	 uOhE0XJP6Iu/nqc4BpdcxPLn9D3aAhUowVoGC2MDhifqTpMhuW4WRJgyzw2QaVaKrg5IV
	 p5I6N9nI0O8PkZBZZWHRCr3sWfhYv/bOynwibf2kWoLGUKJDVMjZo5tMH6Yh5GweEXVxf
	 r8cpKtldFc2smNOduhJDWfCcVrqMH90/H1Vom0UDoSKV3j/WhY2Vs6ysgEj1pSFUrjaL9
	 S7BdCRj9dRlA+hHf3bzhYEnV2K/Bz+1kO0JHfPs+uGyOemGjHbMVs0gTzygqwwMEHAg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794329444;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=ZWBQ6PMN/isuS4Cw3xyM7ROdfun5CoA0hXZHvUg1Lw0=;
	b=bVxS2yvK0vcKbBs+KS4pE27Ga8y613NaRxy5SM9ZhVPvknH/QsPwEvZ3YbA3j0V8ESlb
	 QJbbAaKcIHPAX+TH53v7WeLu+s57HDHv+IR4ybtKg6PAKS9b62bK/Of8FmkPVwQREcDfM
	 PvYPf2hFGgYPzlPDsEDh2DaxF9Oqw44C1/Ybhn9vlHt7cbndg5libLymxgWwShTa8otfN
	 /ZE77j3wF3iYsrhMn7fQFTXdCevyVjdxEbQkY6FDRkbE7GFOg/isDEYAAvEFGRUS9DXDD
	 jJdoLlR53rDurvC4qS9vUhxX/ddphgd+q/epuERpaEy0FH7x9zoktevc6v90sXxMo/A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GSsDxeIz;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC00D606A323;
	Tue, 10 Nov 2026 16:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GSsDxeIz
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794329443;
	b=S/PMtwjorcU1PZujT3PpyBu0brCfXwgF6P1PrAypHvFWIm5plrnp69mk9LQLuIqsSOQo
	 OHiDmaE7aXHWVH8xOrZCKp9wPxp4lxXbv5J3gHrMwF3kh86sc1cxyGGRRbQ1+V4FEaKY1
	 dA+KiDmcaTy4BbHJitoiS/l1uxD34oVYmu7ekxL1rv2qfPB8Q1LCSJnSQ/KVax6uA200W
	 tfNBAv1nCXv3cFRO2Ybd9blo8xzV0+BBJy6TRp6brdjbzeq9o4wswgp+CdJs54XFQDZ1C
	 RHgwfS8BHvrkrXc6rwJKNUekJtYiiDO8O1Aim4f4byFSlKH0X8O5sCH3tKVU9zn/g9A==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794329443;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=ZWBQ6PMN/isuS4Cw3xyM7ROdfun5CoA0hXZHvUg1Lw0=;
	b=KESV93vWaDKWvTWeSn9UJLrFsPCCszAXTqG8d1HV6dJywS2kICpV5St/rPZAh1JzJkes
	 Seoebfs3aY958sUGz9HFDEOFQ9bsDeb99bMosLbeyV5/agyfBGfoIqnWrFZEIdtQ8X0mN
	 Nh2PTLQFL1S5ePC5pENxu7jsAlN3jrxtWPvKG3Q0glBkICaBlgfy/vIrZjxhYnm/whnHz
	 3hXlcv0MkggGBE2fO3vMSpKN86480dR/Nwa73Rjaytb5clrDamgUB1JY8tDMLge1ixFzK
	 ApXNFTTTgEFF5KbQ2norsAM+7AyAYMkBPagpg2Wd230e6jTvijYBs6IYySFiMNbGhHQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id B2D4F1F0089F;
	Tue, 10 Nov 2026 16:50:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794329443;
	bh=ZWBQ6PMN/isuS4Cw3xyM7ROdfun5CoA0hXZHvUg1Lw0=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=GSsDxeIzjShpjR6acMgsPRoX3k71r/7mzwITmvhwc47fma0zpjXYcYR9JpnhYa0tG
	 GjrVPVljrCK3XL8cl+jCczS2XqWbv7vNL/AE/rcCkPRaU9/dYx1pbXG05kOh9s09vC
	 4EoAnnkqZ7x09g1Ozp9b+9g7tTEN+eIr+6mlGw4kXyth18GxqXUQqVQksyb4UjpbUM
	 rGZnrbhxfZ8uQEVXihYiAN1g8w7UtMxM+hWKVel6c8Qj++71aRmGCVkbnSID0lpTwk
	 /fLAShvB/0xIOIOYfI6KEknLD5Mzhj0Ew0e1UKRjWWEsT41WUJsFZvzzYLtL4A18Wd
	 /lqXGMFMJul4A==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 2CE9448BE0;
	Tue, 10 Nov 2026 16:50:42 +0000 (UTC)
From: Moad Tarrih via B4 Relay <devnull+tarrihmoad.proton.me@kernel.org>
Date: Tue, 10 Nov 2026 16:50:27 +0000
Subject: [PATCH v3] platform/x86: asus-wmi: Ignore unusable kbd backlight
 WMI device on ROG Strix G814FP
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261110-asus-wmi-kbd-readback-v3-1-646adf2b8629@proton.me>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4WQyw6CMBBFf4V07Zg+gFRX/odxUdpBKpFiC6gh/
 LsFXOjCuDzJnXNvZiQBvcVA9slIPA42WNdEEJuE6Eo1ZwRrIhNOec4YlaBCH+B+tVAXBjwqUyh
 dAxc5TzOU3KAk8bb1WNrH4j2eVg59cUHdzbI5UdnQOf9cigc25/51DAwYFKWQZZ5SqgweWu861
 2yvSOaOgX9adr8sPFo0TWWpM2EkflmmdarHWx8/0b33T9MLzLTyFScBAAA=
X-Change-ID: 20261108-asus-wmi-kbd-readback-236245e82de8
To: Corentin Chary <corentin.chary@gmail.com>, 
 "Luke D. Jones" <luke@ljones.dev>, Denis Benato <denis.benato@linux.dev>, 
 Hans de Goede <hansg@kernel.org>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Antheas Kapenekakis <lkml@antheas.dev>, 
 Benjamin Tissoires <bentiss@kernel.org>
Cc: Sercan GOKMEN <gokmensercan@gmail.com>, 
 Burak Goncu <burakgon12@gmail.com>, Denis Benato <benato.denis96@gmail.com>, 
 platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Moad Tarrih <tarrihmoad@proton.me>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794329442; l=6707;
 i=tarrihmoad@proton.me; s=20261108; h=from:subject:message-id;
 bh=A3fueH7Mo+YXF19QBqh02BggMGzJGEqb1H2dxfXbUzs=;
 b=EgOWtgnOXN8ILC2KNlnypnxCwNuXPv14xQwsFYQDmH9bt1huHP1ulHAmbkshuahmbM/Gf6rQ9
 GOpVx0gxDJeCPUdFLb4+Xfp+J61edy6yMFpZhIkbDU0us2vymM2TVgj
X-Developer-Key: i=tarrihmoad@proton.me; a=ed25519;
 pk=wtwpmYxZldK7Qebavgtx7P5WmSQOiWjicK0506NOKLg=
X-Endpoint-Received: by B4 Relay for tarrihmoad@proton.me/20261108 with
 auth_id=1453
X-Original-From: Moad Tarrih <tarrihmoad@proton.me>
Reply-To: tarrihmoad@proton.me
Content-Transfer-Encoding: 7bit

From: Moad Tarrih <tarrihmoad@proton.me>

On the ASUS ROG Strix G18 G814FP, writing a level to the keyboard
backlight brightness in sysfs works, but reading it back always gives
0, and the read makes the Fn brightness keys misbehave.

The firmware reports the keyboard backlight WMI device as present but
doesn't implement it. DSTS(0x00050021) always returns 0x50000, which
is level 0 regardless of what the actual level is, and every
DEVS(0x00050021) write is rejected as an unsupported method. The
keyboard backlight is actually driven by hid-asus. asus-wmi saves the 0
as the current level on every read, and the brightness keys step from
the saved level. So after any read, for example by the desktop or by
systemd-backlight, the brightness-up key sets the keyboard to the
lowest level instead of one step higher.

Add a kbd_led_no_wmi quirk that makes asus-wmi treat the keyboard
backlight WMI device as absent, and set it for this board, matched on
the DMI board name. asus-wmi then keeps the LED registered for hid-asus
and no longer reads from or writes to the WMI device.

With its own quirk entry, the board no longer gets
wmi_backlight_set_devstate from the default quirk_asus_unknown. That
flag makes asus-wmi write DEVS(0x00050012, 2) at probe, but this
firmware rejects both DSTS and DEVS on 0x00050012 as unsupported
methods, so the write never did anything here.

As a side effect, the kbd_rgb_mode and kbd_rgb_mode_index attributes are
no longer created on this board, they never worked here since the firmware
rejects those writes as well.

This patch was written with the help of an AI coding assistant (Claude
Code, Claude Opus 5.5). I reviewed it and tested it on my affected laptop.

Fixes: fac55d29581f ("platform/x86: asus-wmi: Add support for multiple kbd led handlers")
Suggested-by: Antheas Kapenekakis <lkml@antheas.dev>
Suggested-by: Denis Benato <denis.benato@linux.dev>
Cc: stable@vger.kernel.org
Signed-off-by: Moad Tarrih <tarrihmoad@proton.me>
Reviewed-by: Antheas Kapenekakis <lkml@antheas.dev>
---
Tested on an ASUS ROG Strix G18 (board G814FP, BIOS G814FP.317,
keyboard 0b05:19b6) on 7.2.14, built as DKMS modules. The keyboard
backlight is still registered and driven by hid-asus, the attribute
reads back the level that was set, the brightness keys step from the
real level, and the level survives suspend/resume and reboots. v3
was retested the same way, and the screen backlight
(nvidia_wmi_ec_backlight) still works without
wmi_backlight_set_devstate.
Build-tested with W=1 against pdx86 for-next (c339f4010dea): no
warnings. checkpatch --strict is clean.

The kbd_rgb_mode and kbd_rgb_mode_index attributes are no longer
created on this board. They never worked here: writes to kbd_rgb_mode
are rejected by the firmware with -ENODEV, like the brightness writes.

To answer Denis's questions on v1, the bug this patch fixes happens on
the latest BIOS for this board as of writing, which is version 317.
I only have the G814FP, so I don't know if other 2025 G814 models
are affected, the quirk only matches G814FP.

This no longer depends on Sercan GOKMEN's kbd_led_no_readback patch.
Both patches add a field to struct quirk_entry and a DMI entry, so
whichever lands second may need a trivial rebase.

AI assistance: Claude Code was used to trace the keyboard backlight
code in asus-wmi, run the debugfs DSTS/DEVS probes, write the patch and
draft this message. Testing and final review were done by me on the
hardware.
---
Changes in v3:
- Drop the comment on kbd_led_no_wmi (Antheas).
- Don't set wmi_backlight_set_devstate for this board: the firmware
  rejects both DSTS and DEVS on 0x00050012, so the write did nothing
  (Antheas).
- Add Antheas's Reviewed-by.
- Link to v2: https://patch.msgid.link/20261109-asus-wmi-kbd-readback-v2-1-c048fc53d8ee@proton.me

Changes in v2:
- Add a quirk that makes asus-wmi skip the keyboard backlight WMI
  device on this board instead of detecting rejected writes at
  runtime (Antheas), so no more WMI writes that are known to fail
  are issued (Denis).
- Link to v1: https://patch.msgid.link/20261108-asus-wmi-kbd-readback-v1-1-bf38f6400ade@proton.me
---
 drivers/platform/x86/asus-nb-wmi.c | 13 +++++++++++++
 drivers/platform/x86/asus-wmi.c    |  3 ++-
 drivers/platform/x86/asus-wmi.h    |  1 +
 3 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/x86/asus-nb-wmi.c b/drivers/platform/x86/asus-nb-wmi.c
index 3b0f3346dc60..9b2a4b829885 100644
--- a/drivers/platform/x86/asus-nb-wmi.c
+++ b/drivers/platform/x86/asus-nb-wmi.c
@@ -93,6 +93,10 @@ static struct quirk_entry quirk_asus_unknown = {
 	.wmi_backlight_set_devstate = true,
 };
 
+static struct quirk_entry quirk_asus_g814fp = {
+	.kbd_led_no_wmi = true,
+};
+
 static struct quirk_entry quirk_asus_q500a = {
 	.filter_i8042_e1_extended_codes = true,
 	.wmi_backlight_set_devstate = true,
@@ -167,6 +171,15 @@ static int dmi_matched(const struct dmi_system_id *dmi)
 }
 
 static const struct dmi_system_id asus_quirks[] = {
+	{
+		.callback = dmi_matched,
+		.ident = "ASUS ROG Strix G18 G814FP",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
+			DMI_MATCH(DMI_BOARD_NAME, "G814FP"),
+		},
+		.driver_data = &quirk_asus_g814fp,
+	},
 	{
 		.callback = dmi_matched,
 		.ident = "ASUSTeK COMPUTER INC. Q500A",
diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index b33ebdb21aa2..51fea21ff247 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -2165,7 +2165,8 @@ static int asus_wmi_led_init(struct asus_wmi *asus)
 	asus->kbd_led.brightness_set_blocking = kbd_led_set;
 	asus->kbd_led.brightness_get = kbd_led_get;
 	asus->kbd_led.max_brightness = ASUS_EV_MAX_BRIGHTNESS;
-	asus->kbd_led_avail = !kbd_led_read(asus, &led_val, NULL);
+	asus->kbd_led_avail = !asus->driver->quirks->kbd_led_no_wmi &&
+			      !kbd_led_read(asus, &led_val, NULL);
 	INIT_WORK(&asus->kbd_led_work, kbd_led_update_all);
 
 	if (asus->kbd_led_avail) {
diff --git a/drivers/platform/x86/asus-wmi.h b/drivers/platform/x86/asus-wmi.h
index b45f81b38a47..e53c6b3fc619 100644
--- a/drivers/platform/x86/asus-wmi.h
+++ b/drivers/platform/x86/asus-wmi.h
@@ -41,6 +41,7 @@ struct quirk_entry {
 	bool wmi_force_als_set;
 	bool wmi_ignore_fan;
 	bool filter_i8042_e1_extended_codes;
+	bool kbd_led_no_wmi;
 	int key_wlan_event;
 	enum asus_wmi_tablet_switch_mode tablet_switch_mode;
 	int wapf;

---
base-commit: c339f4010dea8b0d754f84ace70cd1b089878ef8
change-id: 20261108-asus-wmi-kbd-readback-236245e82de8

Best regards,
--  
Moad Tarrih <tarrihmoad@proton.me>


