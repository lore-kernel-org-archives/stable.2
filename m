Received: from smtp-bc0e.mail.infomaniak.ch (smtp-bc0e.mail.infomaniak.ch [45.157.188.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7D0B3EAC80
	for <stable@vger.kernel.org>; Wed, 22 Jul 2026 16:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784739267; cv=none; b=No3mU3AMoRJMrhpIbJFSm+VocBS7Tu44cNdVLmLWbwkZdaBfoKBhkrwiYY0TCSHs68oHtaGvHcXeuJu/x7qNVmQWVrRo5EopRfKDG8MdlJZTCOqHIQpL8drxKJOG1thnArun9gJGk2n2hB96yT/rm0SggLE7ptoedpub+Vkj8Gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784739267; c=relaxed/simple;
	bh=I6nbkqOu6mlCF15270Z2FS9/kWABpIDz+y2YfBplpOA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rHyQEbMGFBEOqFHruId0SQz8a8r5fJ4ku28Tw8iExB9n6gYVbHebIWvHJghY04WvNZBC/nYsyrjP4keNi8sRcyPA2DknhZPBHGX0buQ5nR8g5MIOCJZwf0QoX8fVJ87rRrxUIBU0c3ULBZHox9wyJfYrTb8oFenl/s91aGHY/bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.sh; spf=pass smtp.mailfrom=gibson.sh; dkim=pass (2048-bit key) header.d=gibson.sh header.i=@gibson.sh header.b=asnKwomE; arc=none smtp.client-ip=45.157.188.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.sh
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gibson.sh
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gibson.sh header.i=@gibson.sh header.b="asnKwomE"
Received: from smtp-4-0001.mail.infomaniak.ch (unknown [IPv6:2001:1600:7:10::a6c])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4h50hm1Rgqzprh
	for <stable@vger.kernel.org>; Wed, 22 Jul 2026 18:54:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gibson.sh;
	s=20260228; t=1784739256;
	bh=/mnNkwJHOhrAPip5E4Li3vjatahK4uy7cBwCPJUu5EE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=asnKwomEc86wy8p8ExK8Jq9hfzIUKn1jtGE3sBJ0p1VBvWHlz0fUmCElazfU9mfDM
	 kztOyMrM7Pyt1NQTgN+1YRQy7VE6uLwzm/EJsMIex7qA32pfzoYDjULrH15Dz4RY8p
	 uwyea7I3aSu8eOCGH3pl8k8kUcoLk1W1SEcYVZC7jnFgrGZTT+8Wdy9zetqI7oE9aq
	 7sGlOjZJ5mAi0X38nHTwaBRsy3ymiXYIyE6QvBRUi1IOjcvHfcuo5/n5ma3Z7pEJ/p
	 meQ9SkmiFYzNK+gknXNToEJisdsUsSWcd9g/IRkb6jk57Smjolt5t51tw650pPVC4H
	 y6mivKFBvp6MQ==
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4h50hl5NLQzt8x
	for <stable@vger.kernel.org>; Wed, 22 Jul 2026 18:54:15 +0200 (CEST)
Received: from unknown by spiderdemon.horst.lan (DragonFly Mail Agent v0.13);
	Wed, 22 Jul 2026 18:54:15 +0200
From: Daniel Gibson <daniel@gibson.sh>
To: stable@vger.kernel.org
Cc: Daniel Gibson <daniel@gibson.sh>,
	Hans de Goede <johannes.goede@oss.qualcomm.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 1/2] platform/x86/amd/pmc: Don't log during intermediate wakeups
Date: Wed, 22 Jul 2026 18:54:01 +0200
Message-ID: <20260722165402.3199573-2-daniel@gibson.sh>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260722165402.3199573-1-daniel@gibson.sh>
References: <20260722165402.3199573-1-daniel@gibson.sh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

commit 037f0b03c663a247366673a807834389107995b7 upstream.

The ECs in the IdeaPads that need the delay_suspend quirk send lots
of messages when charging, which not only causes intermediate wakeups
when suspended, but also prevents the device from reaching the deepest
suspend state.

Because of this amd_pmc_intermediate_wakeup_need_delay() returns false
during intermediate wakeups and amd_pmc_want_suspend_delay() is called.
So far it always logged its "Delaying suspend by 2.5s ..." messages
then, which spams dmesg. This commit makes sure that those messages are
only logged once per suspend.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=221383
Reviewed-by: Hans de Goede <johannes.goede@oss.qualcomm.com>
Signed-off-by: Daniel Gibson <daniel@gibson.sh>
Link: https://patch.msgid.link/20260611150426.3683372-5-daniel@gibson.sh
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/platform/x86/amd/pmc/pmc.c | 39 ++++++++++++++++++++++++------
 drivers/platform/x86/amd/pmc/pmc.h |  1 +
 2 files changed, 32 insertions(+), 8 deletions(-)

diff --git a/drivers/platform/x86/amd/pmc/pmc.c b/drivers/platform/x86/amd/pmc/pmc.c
index d5b543f74a22..b09512368877 100644
--- a/drivers/platform/x86/amd/pmc/pmc.c
+++ b/drivers/platform/x86/amd/pmc/pmc.c
@@ -811,6 +811,20 @@ static bool amd_pmc_intermediate_wakeup_need_delay(struct amd_pmc_dev *pdev)
 
 static bool amd_pmc_want_suspend_delay(struct amd_pmc_dev *pdev)
 {
+	/*
+	 * intermediate_wakeup implies that the machine didn't get to deepest sleep
+	 * state before - otherwise this function isn't called in amd_pmc_s2idle_check()
+	 * because amd_pmc_intermediate_wakeup_need_delay() returns true first.
+	 * On some IdeaPads that happens when charging, because the EC seems
+	 * to send lots of messages then that wake the machine.
+	 *
+	 * But even in that case, the sleep here is necessary (on those IdeaPads),
+	 * otherwise they wake up completely (resume) after a few seconds.
+	 * So this variable is only used to avoid spamming dmesg on each
+	 * intermediate wakeup.
+	 */
+	bool intermediate_wakeup = !pdev->is_first_check_after_suspend;
+
 	/*
 	 * Some Lenovo Laptops (like different IdeaPad 3 Slims) need some
 	 * me-time before sleeping or they get uncooperative after waking
@@ -829,17 +843,20 @@ static bool amd_pmc_want_suspend_delay(struct amd_pmc_dev *pdev)
 		 * disabled with disable_workarounds or delay_suspend=0
 		 */
 		if (delay_suspend == 1 || (delay_suspend == -1 && !disable_workarounds)) {
-			dev_info(pdev->dev, "Delaying suspend by 2.5s to avoid platform bug\n");
+			if (!intermediate_wakeup)
+				dev_info(pdev->dev, "Delaying suspend by 2.5s to avoid platform bug\n");
 			return true;
 		}
-		dev_info(pdev->dev, "Not delaying suspend because of module parameter, even though your device is assumed to need it!\n");
+		if (!intermediate_wakeup)
+			dev_info(pdev->dev, "Not delaying suspend because of module parameter, even though your device is assumed to need it!\n");
 	} else if (delay_suspend == 1) {
-		dev_info(pdev->dev, "Delaying suspend by 2.5s because delay_suspend=1. If this solves problems on your machine, please report this whole line to: platform-driver-x86@vger.kernel.org so it can be automatically detected as affected in the future. System Vendor: \"%s\" Product Name: \"%s\" Product Family: \"%s\" Board Vendor: \"%s\" Board Name: \"%s\"\n",
-			 dmi_get_system_info(DMI_SYS_VENDOR),
-			 dmi_get_system_info(DMI_PRODUCT_NAME),
-			 dmi_get_system_info(DMI_PRODUCT_FAMILY),
-			 dmi_get_system_info(DMI_BOARD_VENDOR),
-			 dmi_get_system_info(DMI_BOARD_NAME));
+		if (!intermediate_wakeup)
+			dev_info(pdev->dev, "Delaying suspend by 2.5s because delay_suspend=1. If this solves problems on your machine, please report this whole line to: platform-driver-x86@vger.kernel.org so it can be automatically detected as affected in the future. System Vendor: \"%s\" Product Name: \"%s\" Product Family: \"%s\" Board Vendor: \"%s\" Board Name: \"%s\"\n",
+				 dmi_get_system_info(DMI_SYS_VENDOR),
+				 dmi_get_system_info(DMI_PRODUCT_NAME),
+				 dmi_get_system_info(DMI_PRODUCT_FAMILY),
+				 dmi_get_system_info(DMI_BOARD_VENDOR),
+				 dmi_get_system_info(DMI_BOARD_NAME));
 		return true;
 	}
 	return false;
@@ -852,6 +869,9 @@ static void amd_pmc_s2idle_prepare(void)
 	u8 msg;
 	u32 arg = 1;
 
+	/* Reset this variable because this is a fresh suspend */
+	pdev->is_first_check_after_suspend = true;
+
 	/* Reset and Start SMU logging - to monitor the s0i3 stats */
 	amd_pmc_setup_smu_logging(pdev);
 
@@ -891,6 +911,9 @@ static void amd_pmc_s2idle_check(void)
 	rc = amd_pmc_write_stb(pdev, AMD_PMC_STB_S2IDLE_CHECK);
 	if (rc)
 		dev_err(pdev->dev, "error writing to STB: %d\n", rc);
+
+	/* remember that first check after suspend is done (until next prepare) */
+	pdev->is_first_check_after_suspend = false;
 }
 
 static int amd_pmc_dump_data(struct amd_pmc_dev *pdev)
diff --git a/drivers/platform/x86/amd/pmc/pmc.h b/drivers/platform/x86/amd/pmc/pmc.h
index 5e7b8d5dc5d6..bea65810de5a 100644
--- a/drivers/platform/x86/amd/pmc/pmc.h
+++ b/drivers/platform/x86/amd/pmc/pmc.h
@@ -37,6 +37,7 @@ struct amd_pmc_dev {
 	struct dentry *dbgfs_dir;
 	struct quirk_entry *quirks;
 	bool disable_8042_wakeup;
+	bool is_first_check_after_suspend;
 };
 
 void amd_pmc_process_restore_quirks(struct amd_pmc_dev *dev);
-- 
2.48.1

