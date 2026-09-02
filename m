Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9314D47DD71;
	Wed,  2 Sep 2026 19:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788376262; cv=none; b=JVQ6WRHAsUQMikerm+CQgUDqEDg/VHURkjewYkQXbGXJahO4h49YFkNDKbqSPRhFcVI9rVuzFR/Mf8MrCjIKVBiz8Ehu64cI0l+dyLLacg4rvhsNojet+g0HZGXsRletFX7H2IuUGQsodV56otWDGT+gGQi5n202IK2sThF3kJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788376262; c=relaxed/simple;
	bh=yE2f/jn8AI1W8fFPYHU7eXvgOtyZv3tRSrigXRHnhUc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=lKTRsXMHHJyrIWGOokkYdNgag/ZllqjSzt065+tDy+YZMe0aINtbtct9oUjSbkL7oqv1Ew/+DoDAcHph4KqBVL1Ub+//DkMWs7SqKYNHhTH8Z8j85IXvkBZOk//GLbPrnPU++bbORncjk7LumV3ov7MAgJcg7KTujJkriGt55qY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dEzZYzAx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dEzZYzAx"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 015EEC2BCF5;
	Wed,  2 Sep 2026 19:11:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1788376262;
	bh=yE2f/jn8AI1W8fFPYHU7eXvgOtyZv3tRSrigXRHnhUc=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=dEzZYzAxwXtDq+LkgqvfOUHNqGLXTYYnRiU0pWM4w0QSiB7VRmIHaMonT+WlvY+y3
	 nkvNqup/E5aZpEuRPFT6j7Mk2FBJzqXfXlGQ4YXdXIeWM+v7W+nRb9qefnd8y57vsf
	 TXq5WzlKx30hzo9b5RRzPrBdaMUZBAV8sHkeaRg+9mIyDkQ3ys2Jus8SnGW5jOVoRi
	 liq5rKTogP20weVYySptHgxeitH7GCFOYo+Gs4dvXY+dLyl8zc+ozT216Nvfr2nXti
	 H3BaeKKh/PDNo9VvtML2gxVD9Y5xBqE+RFmX6LJnB5E0BY7NRhKABK6ScLkGOTT/dv
	 aVQcdr2Qd58iA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAE83C61DD6;
	Wed,  2 Sep 2026 19:11:01 +0000 (UTC)
From: George Kokolakis via B4 Relay <devnull+george.kokolakis.ece.gmail.com@kernel.org>
Date: Wed, 02 Sep 2026 22:11:01 +0300
Subject: [PATCH RFC v3] ACPI: PM: Use EFI power off on Lenovo ThinkPad T14
 Gen 5
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260902-fix-thinkpad-t14-gen5-efi-poweroff-v3-1-84ce39bf43df@gmail.com>
X-B4-Tracking: v=1; b=H4sIAMR0mGoC/5XNzQ6CMBAE4FchPbuGlp+CJxMTH8Cr8VDKFjYKJ
 YUghvDuNj1x1OPMJN+sbERHOLJTtDKHM41kex+SQ8R0q/oGgWqfmYhFHpcxB0MLTC31z0HVMPE
 UGuwzQEMw2Dc6awwUslCJTmuVqYx5aHB+XsLJnd2uF/bwZUvjZN0nHM88TP98zBw4SCPzvNY8Q
 SzPTafoddS2C/ws9qT4iRSe1LKqRKlLXiRiT27b9gVpuNo9LAEAAA==
To: rafael@kernel.org
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 George Kokolakis <george.kokolakis.ece@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788376260; l=6706;
 i=george.kokolakis.ece@gmail.com; s=kernel-20260901;
 h=from:subject:message-id;
 bh=kwWjnFmxl215bmt+t2Jw6FgZ5QOa+GPRlvqda4v5/WQ=;
 b=IZYDRtSpAL/ypnyF134nu3DAshGGiTXMzux0gvqu4jcG4CHR+J2SvWuyGOEBrqTOXsSRpKc05
 A83Msjunf+iDxw2HzpDfja79JCdJMks/lVopwYh39AA5cj2JFLhZsAl
X-Developer-Key: i=george.kokolakis.ece@gmail.com; a=ed25519;
 pk=vZ27t8agUnF5GcuvLoIUzClMG59D0bvQE7GXXdwXJ9I=
X-Endpoint-Received: by B4 Relay for
 george.kokolakis.ece@gmail.com/kernel-20260901 with auth_id=995
X-Original-From: George Kokolakis <george.kokolakis.ece@gmail.com>
Reply-To: george.kokolakis.ece@gmail.com

From: George Kokolakis <george.kokolakis.ece@gmail.com>

A Lenovo ThinkPad T14 Gen 5 (type 21ML) powers back on immediately
after an orderly ACPI S5 shutdown. This was reproduced with BIOS
N47ET29W 1.18 and Ubuntu kernel 7.0.0-30-generic.

A standalone UEFI application invoking ResetSystem(EfiResetShutdown)
before Linux even loads leaves the same machine powered off reliably.
An out-of-tree DMI-scoped module doing the same substitution inside
Linux (registering an EFI-based SYS_OFF_MODE_POWER_OFF handler while
skipping ACPI's normal power-off-prepare stage, as v1 of this patch
also did) succeeded on its first two real shutdown tests, then
intermittently failed on two later ones.

Root cause of the intermittent failure: acpi_power_off_prepare() does
two things, acpi_sleep_prepare(S5) (_PTS/_GTS firmware notification)
and acpi_disable_all_gpes() (disarms every wake GPE armed by drivers
at runtime -- Wi-Fi, Thunderbolt, PCIe root ports, etc). v1 of this
patch skipped registering that handler entirely on acpi_no_s5
platforms, along with the broken final S5 entry, so those GPEs stayed
armed right up to the EFI ResetSystem call. The standalone pre-Linux
test never had this problem because Linux's ACPI subsystem, and
therefore those GPEs, never initialized in the first place.

Fix: keep registering acpi_power_off_prepare() unconditionally, and
only make the final SYS_OFF_MODE_POWER_OFF registration conditional
on !acpi_no_s5. This preserves normal firmware notification and GPE
disarming on affected hardware and only substitutes the last, broken
step. An out-of-tree module built this way has now passed two
consecutive real shutdown tests with no failures, disabling the Intel
Wi-Fi ACPI wake source (CNVW) is confirmed unrelated, and CNVW itself
is separately confirmed to only declare S4 wake support in its own
_PRW, i.e. it was never expected to wake this machine from S5 at all.

Still sending as RFC rather than a confirmed fix: two consecutive
passes is better evidence than v1's single success, but not yet
enough to claim reliability on this class of hardware. Posting the
corrected approach and reasoning for review while more real-world
testing continues.

Link: https://bugs.launchpad.net/bugs/2162837
Cc: stable@vger.kernel.org
Signed-off-by: George Kokolakis <george.kokolakis.ece@gmail.com>
---
Changes in v3:
- Identified why v1/v2's approach was intermittent: it skipped
  registering acpi_power_off_prepare() entirely on acpi_no_s5
  platforms, which also skips acpi_disable_all_gpes() and the _PTS/
  _GTS firmware notification, leaving every driver-armed wake GPE
  (Wi-Fi, Thunderbolt, PCIe root ports) enabled through shutdown.
- Fix: register acpi_power_off_prepare() unconditionally; only the
  final SYS_OFF_MODE_POWER_OFF registration is still conditional on
  !acpi_no_s5. Normal firmware notification and GPE disarming now
  run on affected hardware; only the broken final S5 entry changes.
- An out-of-tree module built this way has passed two consecutive
  real shutdown tests with no failures (vs. one success then two
  failures for the previous approach).
- Confirmed the earlier Wi-Fi (CNVW) wake source is unrelated: it
  only declares S4 wake support in its own _PRW, so it was never
  wake-capable from S5 in the first place.
- Still RFC: two consecutive passes is better evidence than v1's
  single success, but not enough yet to call this reliable.
- Link to v2: https://lore.kernel.org/r/20260902-fix-thinkpad-t14-gen5-efi-poweroff-v2-1-c7bb29c91832@gmail.com

Changes in v2:
- Additional real-world shutdown attempts on the same hardware showed
  the EFI power-off path does not reliably prevent the reboot-on-
  poweroff behavior: it succeeded on the first two independent tests
  but failed on two subsequent ones with the same handlers active.
- Disabling the Intel Wi-Fi ACPI wake source (CNVW) for one boot did
  not change the outcome, ruling it out as the variable.
- Re-posting as RFC with this data rather than letting v1's single
  success stand unqualified; asking whether EC-side conditions (AC/
  dock/Thunderbolt wake arming) are known to matter here.
- Link to v1: https://lore.kernel.org/r/20260901-fix-thinkpad-t14-gen5-efi-poweroff-v1-1-7f766dc13ee9@gmail.com
---
 drivers/acpi/sleep.c | 32 ++++++++++++++++++++++++++++----
 1 file changed, 28 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
index 132a9df984..f581b434b9 100644
--- a/drivers/acpi/sleep.c
+++ b/drivers/acpi/sleep.c
@@ -27,7 +27,7 @@
 #include "sleep.h"
 
 /*
- * Some HW-full platforms do not have _S5, so they may need
+ * Some HW-full platforms do not have a usable _S5, so they may need
  * to leverage efi power off for a shutdown.
  */
 bool acpi_no_s5;
@@ -173,6 +173,12 @@ static int __init init_default_s3(const struct dmi_system_id *d)
 	return 0;
 }
 
+static int __init init_no_s5(const struct dmi_system_id *d)
+{
+	acpi_no_s5 = true;
+	return 0;
+}
+
 static const struct dmi_system_id acpisleep_dmi_table[] __initconst = {
 	{
 	.callback = init_old_suspend_ordering,
@@ -407,6 +413,14 @@ static const struct dmi_system_id acpisleep_dmi_table[] __initconst = {
 		DMI_MATCH(DMI_PRODUCT_NAME, "20GGA00L00"),
 		},
 	},
+	{
+	.callback = init_no_s5,
+	.ident = "Lenovo ThinkPad T14 Gen 5 (21ML)",
+	.matches = {
+		DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+		DMI_MATCH(DMI_PRODUCT_NAME, "21ML"),
+		},
+	},
 	{},
 };
 
@@ -1117,13 +1131,23 @@ int __init acpi_sleep_init(void)
 	if (acpi_sleep_state_supported(ACPI_STATE_S5)) {
 		sleep_states[ACPI_STATE_S5] = 1;
 
+		/*
+		 * Always run the normal S5 preparation (_PTS/_GTS firmware
+		 * notification and disarming every wake GPE) even when the
+		 * final ACPI S5 entry itself is quirked out below. Skipping
+		 * this step entirely on acpi_no_s5 platforms left wake GPEs
+		 * armed through shutdown, which is a plausible source of the
+		 * reboot behavior the quirk is meant to fix in the first
+		 * place.
+		 */
 		register_sys_off_handler(SYS_OFF_MODE_POWER_OFF_PREPARE,
 					 SYS_OFF_PRIO_FIRMWARE,
 					 acpi_power_off_prepare, NULL);
 
-		register_sys_off_handler(SYS_OFF_MODE_POWER_OFF,
-					 SYS_OFF_PRIO_FIRMWARE,
-					 acpi_power_off, NULL);
+		if (!acpi_no_s5)
+			register_sys_off_handler(SYS_OFF_MODE_POWER_OFF,
+						 SYS_OFF_PRIO_FIRMWARE,
+						 acpi_power_off, NULL);
 
 		/*
 		 * Windows uses S5 for reboot, so some BIOSes depend on it to

---
base-commit: 786262be6048deab760f68c8acc2c85607165894
change-id: 20260901-fix-thinkpad-t14-gen5-efi-poweroff-878a3c4da5a5

Best regards,
-- 
George Kokolakis <george.kokolakis.ece@gmail.com>


