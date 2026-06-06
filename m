Received: from smtp-190b.mail.infomaniak.ch (smtp-190b.mail.infomaniak.ch [185.125.25.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D8FA2BD11
	for <stable@vger.kernel.org>; Sat,  6 Jun 2026 04:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780721286; cv=none; b=rx+1q6jgCaSEn57dpzAE+JBFoRzcwt054+8FqnrOFO0hr/4ob8QOo5flcpqkPYGYqH0Q7mc/Pa0/Epg4ZirjhwMVKZVM+RYanCEqpZW/AcA6YKbqHz6bhUuSUzassgZ2Mi/xmfSldKf5E/Usqr5nZUg9VxhasS2DHdrJEw96Z94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780721286; c=relaxed/simple;
	bh=Najpki1ZcHOMyLm6nlLJYDdfo+4pegQmAATFZ1fPdJA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cJe+bzboqPZP5z8lZFAezAxxjsWJ59hm49jcWf7oxqcRO3S8ectanSXRiDBADo7puq1A73Ob+J+wdN5s7llL9PxHaup86uTQAj/4seYHdafgbBTgDxalsNjN2QvRdtpplb9MyY0UuBLENuWyLck+rxv+gNL5f4SVZ2UvYsuggMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.sh; spf=pass smtp.mailfrom=gibson.sh; dkim=pass (2048-bit key) header.d=gibson.sh header.i=@gibson.sh header.b=JKCxGiU0; arc=none smtp.client-ip=185.125.25.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.sh
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gibson.sh
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gibson.sh header.i=@gibson.sh header.b="JKCxGiU0"
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch [10.7.10.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4gXQm21S8Lz353
	for <stable@vger.kernel.org>; Sat,  6 Jun 2026 06:48:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gibson.sh;
	s=20260228; t=1780721282;
	bh=4JgcUrF1sbZczkpfNhX8xMy73Iep2kkb6jW8W1MiLyM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JKCxGiU0N6YcnIIe8NOTvLKSAA6CikMhXCfnh3fDLtQT+GrMsBvzB95JGs4N9seHd
	 cOncvZcb3WxOXAYvOzd8y4/pHEosuP5B5T2iEjMgXaFnvxPt1wavnZK5liWHyM9CED
	 SvRjRgcsYH6i7+5+4bFgOTGtfxgEUDsDtVwBFBp36Jd5S9R1WjCkOazOKrJO7/DjWc
	 yHwF6gBnoMuCdmXEZ+lLGxQGK8nUZRiyl4UHSt11yIKl86vMLFOiXtola2VAhXjmfl
	 9g9OL4Us3PuctTdYy+6xGuVWaJBcEzAIgn+GrLXQPer4QKVpjoKN92LOczD0fm8Sc1
	 ZQejknObqHx7g==
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4gXQm15GTSzyb
	for <stable@vger.kernel.org>; Sat,  6 Jun 2026 06:48:01 +0200 (CEST)
Received: from unknown by spiderdemon.horst.lan (DragonFly Mail Agent v0.13);
	Sat, 06 Jun 2026 06:48:00 +0200
From: Daniel Gibson <daniel@gibson.sh>
To: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
	Hans de Goede <hansg@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mario Limonciello <superm1@kernel.org>
Cc: Daniel Gibson <daniel@gibson.sh>,
	stable@vger.kernel.org
Subject: [PATCH v4 3/3] platform/x86/amd/pmc: Don't log during intermediate wakeups
Date: Sat,  6 Jun 2026 06:47:58 +0200
Message-ID: <20260606044758.2213401-4-daniel@gibson.sh>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260606044758.2213401-1-daniel@gibson.sh>
References: <20260606044758.2213401-1-daniel@gibson.sh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

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
Signed-off-by: Daniel Gibson <daniel@gibson.sh>
Cc: stable@vger.kernel.org
---
 drivers/platform/x86/amd/pmc/pmc.c | 39 ++++++++++++++++++++++++------
 drivers/platform/x86/amd/pmc/pmc.h |  1 +
 2 files changed, 32 insertions(+), 8 deletions(-)

diff --git a/drivers/platform/x86/amd/pmc/pmc.c b/drivers/platform/x86/amd/pmc/pmc.c
index 2d3d180c15d2..7d772ccd17a6 100644
--- a/drivers/platform/x86/amd/pmc/pmc.c
+++ b/drivers/platform/x86/amd/pmc/pmc.c
@@ -619,6 +619,20 @@ static bool amd_pmc_intermediate_wakeup_need_delay(struct amd_pmc_dev *pdev)
 
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
@@ -637,17 +651,20 @@ static bool amd_pmc_want_suspend_delay(struct amd_pmc_dev *pdev)
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
@@ -660,6 +677,9 @@ static void amd_pmc_s2idle_prepare(void)
 	u8 msg;
 	u32 arg = 1;
 
+	/* Reset this variable because this is a fresh suspend */
+	pdev->is_first_check_after_suspend = true;
+
 	/* Reset and Start SMU logging - to monitor the s0i3 stats */
 	amd_pmc_setup_smu_logging(pdev);
 
@@ -699,6 +719,9 @@ static void amd_pmc_s2idle_check(void)
 	rc = amd_stb_write(pdev, AMD_PMC_STB_S2IDLE_CHECK);
 	if (rc)
 		dev_err(pdev->dev, "error writing to STB: %d\n", rc);
+
+	/* remember that first check after suspend is done (until next prepare) */
+	pdev->is_first_check_after_suspend = false;
 }
 
 static int amd_pmc_dump_data(struct amd_pmc_dev *pdev)
diff --git a/drivers/platform/x86/amd/pmc/pmc.h b/drivers/platform/x86/amd/pmc/pmc.h
index f5257e47b8c4..8aa7073ed09f 100644
--- a/drivers/platform/x86/amd/pmc/pmc.h
+++ b/drivers/platform/x86/amd/pmc/pmc.h
@@ -114,6 +114,7 @@ struct amd_pmc_dev {
 	struct dentry *dbgfs_dir;
 	struct quirk_entry *quirks;
 	bool disable_8042_wakeup;
+	bool is_first_check_after_suspend;
 	struct amd_mp2_dev *mp2;
 	struct stb_arg stb_arg;
 };
-- 
2.48.1

