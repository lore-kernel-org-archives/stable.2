Received: from smtp-42ac.mail.infomaniak.ch (smtp-42ac.mail.infomaniak.ch [84.16.66.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB76F3FB7C1
	for <stable@vger.kernel.org>; Tue,  9 Jun 2026 10:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781002700; cv=none; b=ZD2tZh4QunasyV7d+JJq3TOftjgKtAMdZzhyS97+DPwp3V2XuwY1+m/gWMyGgc6J3P/vXvYtWkzQoLMPYCtO/MAJirfKSBoTk81BHzGxpiplmLIB4OY6XnnZ5xEmisxB+VSITbFCDHQPuy34TTms81YHmDBs6NTFbPhRJhUMCMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781002700; c=relaxed/simple;
	bh=iGddSxVjTpbO2KPSSlbyY19cjevIobd5WV0Ztj2oN78=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i/19fC1547X0Oz1m165qfFnIvRVAeGu3k3T5sgF9mGCjCExpbx7O29nluksqHWIqct1RIejWhPnWFvIxT0oqllre5o56cePGk6vCLXGU2QLe+0wvyWJtlLdn1HvblxHn5v+SoYenqmHZ+nTX02L26awmDBzPfM+VC/+fZRMtSEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.sh; spf=pass smtp.mailfrom=gibson.sh; dkim=pass (2048-bit key) header.d=gibson.sh header.i=@gibson.sh header.b=Qv834IIU; arc=none smtp.client-ip=84.16.66.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.sh
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gibson.sh
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gibson.sh header.i=@gibson.sh header.b="Qv834IIU"
Received: from smtp-4-0001.mail.infomaniak.ch (unknown [IPv6:2001:1600:7:10::a6c])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4gZQqr2FndzWS2
	for <stable@vger.kernel.org>; Tue,  9 Jun 2026 12:58:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gibson.sh;
	s=20260228; t=1781002696;
	bh=zNRJcAtKCFEEQWPfOc+E80/0CEgSRYKf5Wc0gPgVvTY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Qv834IIUAtA7mkKXfDNe0VhbW3dTUOfqTzA5zlhpnWzkEn4aPpfw4DVB99ldx+RkE
	 +1A+Is1AT97h1rYVlhUAoZEaDgNpRcSAq6TrIwy7H7ddwe3QuSosjWdMQd3WRuHzl1
	 AqeFx7mdahLvxT8Sr6XSOHE4TRo+ZJF1PNkJxkqLI+fBpeaMb9LIA6kdioHJqNYXyc
	 xQi8uNPeP3x1tiU59+irPsMYaL/s+/cpeo1Lxtqzc2AX73CAlm/vOwYzrj7ecC1PiX
	 ypAS1x0KhQc779GAtev5a4hKSBlII7LvEEk98Qn1CdqzZaznrwXOn1ri3t96dCvAd0
	 nIUMRDgpRuhNw==
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4gZQqq5BQ9z7qQ
	for <stable@vger.kernel.org>; Tue,  9 Jun 2026 12:58:15 +0200 (CEST)
Received: from unknown by spiderdemon.horst.lan (DragonFly Mail Agent v0.13);
	Tue, 09 Jun 2026 12:58:15 +0200
From: Daniel Gibson <daniel@gibson.sh>
To: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
	Hans de Goede <hansg@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mario Limonciello <superm1@kernel.org>
Cc: Daniel Gibson <daniel@gibson.sh>,
	Sindre Henriksen <sindrehenriksen93@gmail.com>,
	Hans de Goede <johannes.goede@oss.qualcomm.com>,
	stable@vger.kernel.org
Subject: [PATCH v5 2/4] platform/x86/amd/pmc: Delay suspend for some Lenovo Laptops
Date: Tue,  9 Jun 2026 12:57:54 +0200
Message-ID: <20260609105756.2813669-3-daniel@gibson.sh>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260609105756.2813669-1-daniel@gibson.sh>
References: <20260609105756.2813669-1-daniel@gibson.sh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

Some IdeaPad Slim 3 devices and similar with AMD CPUs have a
nonfunctional keyboard and lid switch after s2idle.

It helps to delay suspend by 2.5 seconds so the EC has some time
to do whatever it needs to get done before suspend - unfortunately
at least on my 16ABR8 waking it with a timer (wakealarm) still
triggers the issue, but at least normal resume via keypress or
lid works fine. On the 14ARP10 wakealarm has been reported to also
work fine with this patch.

This issue has been reported for many different devices, this patch
has been tested with the Zen3-based IdeaPad Slim 3 16ABR8 (82XR)
and the Zen3+-based IdeaPad Slim 3 14ARP10 (83K6) and IdeaPad Slim 3
15ARP10 (83MM).

Reported-by: Sindre Henriksen <sindrehenriksen93@gmail.com>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=221383
Tested-by: Sindre Henriksen <sindrehenriksen93@gmail.com>
Suggested-by: Mario Limonciello (AMD) <superm1@kernel.org>
Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Reviewed-by: Hans de Goede <johannes.goede@oss.qualcomm.com>
Signed-off-by: Daniel Gibson <daniel@gibson.sh>
Cc: stable@vger.kernel.org
---
 drivers/platform/x86/amd/pmc/pmc-quirks.c | 39 +++++++++++++++++++++++
 drivers/platform/x86/amd/pmc/pmc.c        | 24 +++++++++++++-
 drivers/platform/x86/amd/pmc/pmc.h        |  1 +
 3 files changed, 63 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/x86/amd/pmc/pmc-quirks.c b/drivers/platform/x86/amd/pmc/pmc-quirks.c
index 24506e342943..74ddf1d8289a 100644
--- a/drivers/platform/x86/amd/pmc/pmc-quirks.c
+++ b/drivers/platform/x86/amd/pmc/pmc-quirks.c
@@ -18,6 +18,7 @@
 struct quirk_entry {
 	u32 s2idle_bug_mmio;
 	bool spurious_8042;
+	bool need_suspend_delay;
 };
 
 static struct quirk_entry quirk_s2idle_bug = {
@@ -33,6 +34,10 @@ static struct quirk_entry quirk_s2idle_spurious_8042 = {
 	.spurious_8042 = true,
 };
 
+static struct quirk_entry quirk_s2idle_need_suspend_delay = {
+	.need_suspend_delay = true,
+};
+
 static const struct dmi_system_id fwbug_list[] = {
 	{
 		.ident = "L14 Gen2 AMD",
@@ -203,6 +208,35 @@ static const struct dmi_system_id fwbug_list[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "82XQ"),
 		}
 	},
+	/* https://bugzilla.kernel.org/show_bug.cgi?id=221383 */
+	{
+		.ident = "Zen3-based IdeaPad Slim and similar",
+		.driver_data = &quirk_s2idle_need_suspend_delay,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
+			/*
+			 * Note: there are also some Zen2-based 82X* devices that
+			 * need different quirks, they're already handled above
+			 */
+			DMI_MATCH(DMI_PRODUCT_NAME, "82X"),
+		}
+	},
+	{
+		.ident = "Zen3+-based IdeaPad Slim and similar",
+		.driver_data = &quirk_s2idle_need_suspend_delay,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "83K"),
+		}
+	},
+	{
+		.ident = "IdeaPad Slim 3 15ARP10 (83MM)",
+		.driver_data = &quirk_s2idle_need_suspend_delay,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "83MM"),
+		}
+	},
 	/* https://bugzilla.kernel.org/show_bug.cgi?id=221273 */
 	{
 		.ident = "Thinkpad L14 Gen3",
@@ -356,6 +390,11 @@ void amd_pmc_process_restore_quirks(struct amd_pmc_dev *dev)
 		amd_pmc_skip_nvme_smi_handler(dev->quirks->s2idle_bug_mmio);
 }
 
+bool amd_pmc_quirk_need_suspend_delay(struct amd_pmc_dev *dev)
+{
+	return dev->quirks && dev->quirks->need_suspend_delay;
+}
+
 void amd_pmc_quirks_init(struct amd_pmc_dev *dev)
 {
 	const struct dmi_system_id *dmi_id;
diff --git a/drivers/platform/x86/amd/pmc/pmc.c b/drivers/platform/x86/amd/pmc/pmc.c
index 2b9e5730170a..6bafd8661d68 100644
--- a/drivers/platform/x86/amd/pmc/pmc.c
+++ b/drivers/platform/x86/amd/pmc/pmc.c
@@ -611,6 +611,27 @@ static bool amd_pmc_intermediate_wakeup_need_delay(struct amd_pmc_dev *pdev)
 	return get_metrics_table(pdev, &table) == 0 && table.s0i3_last_entry_status;
 }
 
+static bool amd_pmc_want_suspend_delay(struct amd_pmc_dev *pdev)
+{
+	/*
+	 * Some Lenovo Laptops (like different IdeaPad 3 Slims) need some
+	 * me-time before sleeping or they get uncooperative after waking
+	 * up and don't send events for keyboard and lid switch anymore.
+	 *
+	 * Unfortunately this doesn't entirely fix the problem: It can still
+	 * happen when resuming with a timer (wakealarm), but at least the
+	 * more common usecases (wakeup by opening lid or pressing a key)
+	 * work fine with this workaround.
+	 *
+	 * See https://bugzilla.kernel.org/show_bug.cgi?id=221383
+	 */
+	if (!disable_workarounds && amd_pmc_quirk_need_suspend_delay(pdev)) {
+		dev_info(pdev->dev, "Delaying suspend by 2.5s to avoid platform bug\n");
+		return true;
+	}
+	return false;
+}
+
 static void amd_pmc_s2idle_prepare(void)
 {
 	struct amd_pmc_dev *pdev = &pmc;
@@ -647,7 +668,8 @@ static void amd_pmc_s2idle_check(void)
 	struct amd_pmc_dev *pdev = &pmc;
 	int rc;
 
-	if (amd_pmc_intermediate_wakeup_need_delay(pdev))
+	if (amd_pmc_intermediate_wakeup_need_delay(pdev) ||
+	    amd_pmc_want_suspend_delay(pdev))
 		msleep(2500);
 
 	/* Dump the IdleMask before we add to the STB */
diff --git a/drivers/platform/x86/amd/pmc/pmc.h b/drivers/platform/x86/amd/pmc/pmc.h
index fe3f53eb5955..f5257e47b8c4 100644
--- a/drivers/platform/x86/amd/pmc/pmc.h
+++ b/drivers/platform/x86/amd/pmc/pmc.h
@@ -147,6 +147,7 @@ enum amd_pmc_def {
 };
 
 void amd_pmc_process_restore_quirks(struct amd_pmc_dev *dev);
+bool amd_pmc_quirk_need_suspend_delay(struct amd_pmc_dev *dev);
 void amd_pmc_quirks_init(struct amd_pmc_dev *dev);
 void amd_mp2_stb_init(struct amd_pmc_dev *dev);
 void amd_mp2_stb_deinit(struct amd_pmc_dev *dev);
-- 
2.48.1

