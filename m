Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794829700;
	b=xXUxXFp6WXUsALwRO5qTqdiBwmDGv7qFkVSHLD6xbh89ITgLxdBhHLr7IfEnl84frZqR
	 /on5TAfeA/D1mFIhoxED4Aaq+1Ktny1HPwZmwJzixbRPyggB4xvidW76agDU6t0kua6sQ
	 WEffj9BFQIRV7/Xf6BPiPZYWfbJQsaIRTsZGIRDRI3vEZkFlGxhCZn83pEzl7bOnZL9U8
	 +jM4QoSyqZL9We64RdvbT3W23QZf4W0aiV2QLMI6YBMi1qc2hz8R5B9e+ZhQxOEA85TaH
	 SFRSMmbBBEBb8LVNBVM/lAlnOV+JFEgf2i+4bV5jtY0g2BLd+a8auKq+iWxqjDRLVFA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794829700;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=jtELbdJR4zGF+dqbQswzGUFJCLtGbxQUtZG2xjdVLiM=;
	b=MMOeSG2otj019dd6VKxGF+XNtPTX72+h5nNG76kk3+TzKL7VmE79ZjNgi4m5czeGQOia
	 o0jDPrmIPAFIwiroWZ9tFugZ63mXF3ks18PLXCAQ2nI3C1W+mFot6LkPTzssLrTRsgVJJ
	 3nKd1FjZ2YZn8CwJ5h2HyRkhXJi2F6f6M8iPyGJJ502gFNIUDzBWyFSZ5X897uFGSuw1u
	 M7Sdm/WUEO+Jd2jJOc3lpQK0CX6KiZqHqgt4KkB45C4KBdyHNimlHXgk4eGZ3riSM01qP
	 TRO/PCgpDVRlvZ7QhlnDyJsebKLYU8oM+ClAcW6laDIQEB4LRLcpbbm/8sJCtGVZfvA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="PyLTBj/T";
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1DAE606A323;
	Mon, 16 Nov 2026 11:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PyLTBj/T
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794829699;
	b=GG7VZp+VIGWnzcCLVU+je10HIGVoTl98bnB182nqqAbr2k2AdvOh42ELt7WU0paKTGRp
	 WVq6zMeQlD8PsOmz5LvwYqT4KSxj8ncr69Bn1Lswm424HoSUt8rURcMbLwpkaz7S+/eEI
	 OvT/fSk5H9muIcSJEVjLzf1pr0rXWqrY5BtzCmo+kuhRHTLubyj1oae96wQDAejziURr2
	 3cL93oaymEY69D7eSR2GVFBhBqVPy6+DbflAGmZFKFZRrpI8eRKX787tTS5/009uV3rm+
	 ba6vaPX3RN6cqMXhSXaZPLWByOb/3kFWJo69tYipYqUso3TRT6WMs5KkgqxC8ImWoeg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794829699;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=jtELbdJR4zGF+dqbQswzGUFJCLtGbxQUtZG2xjdVLiM=;
	b=nZnFZz8H/PyCZqVnGyXJC64dQf6voWkaBCgD/bWHKR7skKyJD1WZdMBqZBoCpdxb2cME
	 Q7FZtVh/wParKLoEbd0VNBYcvXiIGIAkG4wfCzO/xSk8ftcb6rGb+mE26+xNkRGiMFNui
	 BRVhodVdhQQNsrAlQV6V3Ie//fNvKI6uEfD8lGxhEhx3oRsTc00N1MUXEbE8gCAo3GCh1
	 YqE8SReb1PK7KILrH+xZNFFT6coAFM80QfKeuZWgfO/oX8DWHKKyCwhRLHtf3yvGlfBBX
	 RMLP4BfUg5W+rELdCYOF6jsCL9vvB8tWae13QRPZO2d/2lj0CrG5Fv7Vk8Oxn+y6W7g==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 27F891F000C4;
	Mon, 16 Nov 2026 11:48:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794829699;
	bh=jtELbdJR4zGF+dqbQswzGUFJCLtGbxQUtZG2xjdVLiM=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=PyLTBj/TkfGtMPO7kk0uDTpPQ8FTRWmQ9X7WYQzniLtx8enLz0boAVt/9Hj3xkhRR
	 KRBVNbHTlGWqO6qgmIEW9KOfVuB9L01mAcFn3mRMSJRRRGJNaRR/kofYJ+RSWVa+iv
	 kjeSo9kycpZtjB6D8JKqTxFN76fcD3YpwH/ms1uBIdvVaq1SwU3uzAfX7IHQ8Ns4xy
	 Kozy50FgwtFMTSg3f1104gLZnCy22/9+pLgot/gOTWWUxTd1bKul9El6HYMuITN6mT
	 xJq9P5qRzAcmBz5yrxfCtYs37Eq7SyQFDxvxMQ6rueJ43u1LQYKGGFeLCm0CA1eEs4
	 Dd4M+R3QV9yeQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 8054C4A444;
	Mon, 16 Nov 2026 11:48:18 +0000 (UTC)
From: Moad Tarrih via B4 Relay <devnull+tarrihmoad.proton.me@kernel.org>
Date: Mon, 16 Nov 2026 11:48:12 +0000
Subject: [PATCH v5] platform/x86: asus-wmi: Ignore unusable kbd backlight
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
Message-Id: <20261116-asus-wmi-kbd-readback-v5-1-f2f170836bf4@proton.me>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4XRTW7CMBAF4Ksgr+vKf3EcVtyj6sL2jIuLSMBOA
 gjl7jjQRdQq6vJJM9+TZu4kY4qYyXZzJwnHmGPXllC9bYjf2/YLaYSSiWBCc84MtXnI9HKM9OC
 AJrTgrD9QIbVQFRoBaEjZPSUM8fp0Pz5fOQ/uG30/Y/PEPua+S7dn8cjnuf86Rk45dUGaoBVjF
 nB3Sl3fte9HJHPHKJZKs6aIonimTPCVBIN/FLlQOFtTZFG00haCcEaL5reilgpfU1RR6gYCr3S
 tag1LZXqdLeF5KF/pf245TQ9XfvwtswEAAA==
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794829702; l=5701;
 i=tarrihmoad@proton.me; s=20261108; h=from:subject:message-id;
 bh=3nGZnubAyvz6LHpt+pJHAhYjFwDOuh3QCXEfuWLUP48=;
 b=TU1qjWk4F4/ItjYisO1i5iKWQwNqMsFCBU33o2CipCt7EFQTzX3TF1s4ZnbuTV+qfUGpoquAk
 Pdgiiz66DvuCLf8dqI+/S/46EIXMXLrofXVU5cVd80YzilnaxiLhpyY
X-Developer-Key: i=tarrihmoad@proton.me; a=ed25519;
 pk=wtwpmYxZldK7Qebavgtx7P5WmSQOiWjicK0506NOKLg=
X-Endpoint-Received: by B4 Relay for tarrihmoad@proton.me/20261108 with
 auth_id=1453
X-Original-From: Moad Tarrih <tarrihmoad@proton.me>
Reply-To: tarrihmoad@proton.me
Content-Transfer-Encoding: 7bit

From: Moad Tarrih <tarrihmoad@proton.me>

On the ASUS ROG Strix G18 G814FP, writing a level to the keyboard
backlight brightness in sysfs changes the LED brightness, but reading
it back always gives 0, and the read makes the Fn brightness keys
misbehave.

The firmware reports the keyboard backlight WMI device as present
without implementing it, and the backlight is actually driven by
hid-asus. DSTS(0x00050021) always returns 0x50000, which is level 0
with the presence bit set, regardless of the actual level, and every
DEVS(0x00050021) write is rejected as an unsupported method.

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
Reviewed-by: Denis Benato <denis.benato@linux.dev>
---
Tested on an ASUS ROG Strix G18 (board G814FP, BIOS G814FP.317) on
7.2.14: the brightness attribute reads back the level that was set, the
Fn keys step from it, and this survives suspend and reboot. W=1 and
checkpatch --strict are clean. v5 only changes the commit message.

Sercan GOKMEN's B9406CAA patch also adds a field to struct quirk_entry
and a DMI entry, so whichever lands second may need a trivial rebase.

AI assistance: Claude Code (Claude Opus 5.5) was used to trace the
asus-wmi code, write the patch and draft the commit message. I reviewed
it and tested it on the hardware.
---
Changes in v5:
- Say that the sysfs write changes the LED brightness, and that
  DSTS(0x00050021) returns level 0 with the presence bit set (Denis).
- Add Denis's Reviewed-by.
- Link to v4: https://patch.msgid.link/20261111-asus-wmi-kbd-readback-v4-1-79df1567476d@proton.me

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


