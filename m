Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794440189;
	b=EidNKY0dC8jrFoiijVRIol0itWfa12vMqYLECkuY7PPXnMTviC2SmmIpOTEZMoQtSz1U
	 7mttWh16/jb5Cs5uMPL+Ok4ECCcc20W7vAZXSH25wuo7Z2qAXjfRcxZi6xvcc4xa3FGkS
	 3mOAJV6XibArqOe2hWzHM6Up993qsMu0DOlAj/SOZuCJhM6DS5LB4YDY7XoBXYGXFz023
	 zwNf55ASokTf5FuXHOHbTECwAVzbN2KMfg3BMcffdoNGf6CJdt750l88ubRAxAiWNjC7X
	 qCqx1OM0wK8b1OLn25sAwMk7WKUXMKhXShLA7dkaoxQD5z3T92bI3PoVrg25oFgDsuA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794440189;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=gO1MVgjoFguecuzNEI7qcANHnCjMPECnOHHKwejXJeg=;
	b=nGCS9moIZkNugmqO5AxC0aZcDp63SFGoxVxOs6EVos/Fu7WDJjhFcSpOtIqO1rpxxj1G
	 U25ovvi9mnFo0xjcj9NpSAdDmBFe7WNqMfpCwtKDiHNnOTOWI9z2hIz8ukJLBgpNWMxoc
	 DZWUbFcKOFmm8Sc888tkD6Zk/zYHnEpshgNxcN9d7xvYxqTFSdqWsQt3V3YNcvPkh2pI1
	 gv/SKQO4U6BcFAFaLvHa3+chm2AZ5aWTTpWe2BYyU1tHQpQODpU0znE9DCbtXlBb1sD6Y
	 89vsmqTbcxAfWnauctlZfAZJSG9EDowtAahW3VVSddG9MQS002p1TDPmODv5ZTgvuiQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="TVpDvJB/";
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3D8F606A31C;
	Wed, 11 Nov 2026 23:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TVpDvJB/
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794440188;
	b=rHBs/kXoq7CNQ1Qrgg/cde/N1UxwdCMRYCbPCZSQYyHocy9+P60bLZ5t8rjHw9Jb5FRY
	 k8VUHY2V4mNNJ4adQ2roLOHs+ENk0yvJcztbdsjXtKcqWvaXar2Y+7vHfDIlexTeKrWv/
	 gfCi13UKM4bR1YnUHyEznV7phFI29+Ikj4dDeXeMjJRC6BFlmrPKUXIoFoR9X0ChKJ4Lr
	 jVDm9kAQ8AkX+8YNGaJtWj6l2klM6Q5u0MtGdkMyajrOgF4/kTkObBBoIUcPET0QiWWYS
	 5ZL2w8nWBA1fNx8FAopuQ9reeQi6LoAsB5fsDsM1s6Hwh5eADE4c0IEA0l738mqcnBQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794440188;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=gO1MVgjoFguecuzNEI7qcANHnCjMPECnOHHKwejXJeg=;
	b=D3bqVsCv23DDI8JVP2yP4LXiyG/SrLvWGlyDUT/m4u29Arh2dBwBxahpNzLkfvzIyugm
	 BXbkK42BvhVCbHcrCDvlNFm29Y5flsAe/IudKyFl4SM4VeooHU+vNe77JdYIvtpqJWPyK
	 DeO+TIJdt13uQgzJus8tR/P7ccQlRLTot8xfWMMtUT5eQ4+5TqK32G/v6srtMecS1Wx1i
	 OLOLl8DT2+ox/bT18X3DnoH/UAiWHgGd92xsNHixuCVp17Ov4hxyt4SJ/GCNbzDzlL93N
	 CKwdrbLdNpqebpw4jQnZMtP7yohOwy6L5B7WeT6A3j6ByJfnXts7F9J8gPMdmRTFoKg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id DE8EB1F00A05;
	Wed, 11 Nov 2026 23:36:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794440188;
	bh=gO1MVgjoFguecuzNEI7qcANHnCjMPECnOHHKwejXJeg=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=TVpDvJB/ytWYNMDmGFLiiJYioOoR90BEibKcMJjK1KLMdvPXL3yoiYLRWnanYiTJw
	 VMiFedjkN3LuxQELEewvhNYPkcUsRTmf8Mx6vOIunUCSrHpjJWzanrcmIvF+bULfJr
	 i+1zoltOkOdj5Z4dTxfwNvO8h2xBy0eS5yAJwfIJT3PXrrIHwa60vCuFjRDH/dIhZV
	 Y8ByDfKnhzlUzZ2U69WxEjccvBr3N+ot+UDhI/4YbCZIgW6DCxDJK8hm4H0svxXKsM
	 mdLDMRjtSm50Lezo1iDCu+35XYkImaisrH73zJIeWwuYAgvQ+JepB6Lwe9WUZ6m1eE
	 4voaGj56HQiKg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 3145B49156;
	Wed, 11 Nov 2026 23:36:27 +0000 (UTC)
From: Moad Tarrih via B4 Relay <devnull+tarrihmoad.proton.me@kernel.org>
Date: Wed, 11 Nov 2026 23:36:26 +0000
Subject: [PATCH v4] platform/x86: asus-wmi: Ignore unusable kbd backlight
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
Message-Id: <20261111-asus-wmi-kbd-readback-v4-1-79df1567476d@proton.me>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4XQTQ7CIBAF4KsY1mJgQIKuvIdxwc+gaGwrtFVje
 nepumhijMuXzHwvMw+SMUXMZD17kIR9zLGuSpDzGXEHU+2RRl8yAQaKc6apyV2m13OkJ+tpQuO
 tcScKQoFcogaPmpTdJmGIt5e73b1z7uwRXTti48Qh5rZO91dxz8e5fx09p5zaIHRQkjHjcdOku
 q2rxRnJ2NHDVFn9UqAojkkd3FJ4jV+KmCic/VJEUZRUxgewWsFqqgzvgxNeuvLP9vOFYXgCZ4/
 i6G0BAAA=
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794440189; l=5327;
 i=tarrihmoad@proton.me; s=20261108; h=from:subject:message-id;
 bh=2DuMrNPPbmG4EK58GjRCWYX3JTlzq8zk3x5L5iXO+R4=;
 b=DbfGtdQqmZnbH4vi8ozqbeJ1yzktm11TKJN/TvPIGdcGufMdLcRthxvFIiwFN4hfWw5zlLrk5
 kLi6/0+BDieD2VqhRZ2b+G9sGC2eVtj5ajvv4kwbykYP/MDb7KTdTX4
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

The firmware reports the keyboard backlight WMI device as present
without implementing it, and the backlight is actually driven by
hid-asus. DSTS(0x00050021) always returns 0x50000, which is level 0
regardless of what the actual level is, and every DEVS(0x00050021)
write is rejected as an unsupported method.

Add a kbd_led_no_wmi quirk that makes asus-wmi treat the keyboard
backlight WMI device as absent, and set it for this board, matched on
the DMI board name. asus-wmi then keeps the LED registered for hid-asus
and no longer reads from or writes to the WMI device.

As a side effect, the kbd_rgb_mode and kbd_rgb_mode_index attributes are
no longer created on this board, they never worked here since the firmware
rejects those writes as well.

Fixes: fac55d29581f ("platform/x86: asus-wmi: Add support for multiple kbd led handlers")
Suggested-by: Antheas Kapenekakis <lkml@antheas.dev>
Suggested-by: Denis Benato <denis.benato@linux.dev>
Cc: stable@vger.kernel.org
Signed-off-by: Moad Tarrih <tarrihmoad@proton.me>
Reviewed-by: Antheas Kapenekakis <lkml@antheas.dev>
---
Tested on an ASUS ROG Strix G18 (board G814FP, BIOS G814FP.317) on
7.2.14: the brightness attribute reads back the level that was set, the
Fn keys step from it, and this survives suspend and reboot. W=1 and
checkpatch --strict are clean. v4 only changes the commit message.

Sercan GOKMEN's B9406CAA patch also adds a field to struct quirk_entry
and a DMI entry, so whichever lands second may need a trivial rebase.

AI assistance: Claude Code (Claude Opus 5.5) was used to trace the
asus-wmi code, write the patch and draft the commit message. I reviewed
it and tested it on the hardware.
---
Changes in v4:
- Trim the commit message and move the AI assistance note below the
  --- line (Ilpo).
- Link to v3: https://patch.msgid.link/20261110-asus-wmi-kbd-readback-v3-1-646adf2b8629@proton.me

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


