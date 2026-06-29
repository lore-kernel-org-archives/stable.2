Received: from chaosmail.tech (chaosmail.tech [77.81.229.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CC573F8EA1;
	Mon, 29 Jun 2026 09:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.81.229.115
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782726557; cv=none; b=UVL6jK+uqhLCYi8e/PwPYQqfAHmvcRQzZpUJ/iWNF2zNpe5WD7I/mBkzqDO/5x8gAtHGjdRlpjVu8IMrdQcXeTNaLO0KSQaHc4+ymRlXQdylvkaaL0xG1P0+n0THwfMRljFDq84plDhVCLVMM9x74fBSGyuaAL4hZIBK40Vu5Nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782726557; c=relaxed/simple;
	bh=sqKFDbIEcCs2cvx/DTq3eUOzdy0v/552i0lfDimwwZE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=tY2eeOQDtfRIlyftvafegr04HD4VCogBRHACcU8TXtR6csa359i/jZ4znFoawQYeqmO0W1VU+UchsbnBFuhHtWwYZKp4IC5ts5+/R63jKxFq7Z+mYyIgTteB7kP7WTd7oE0gUevYIm8m9jOoEAzuf2uV1ESolz4JIjzk1tLXI+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=chaosmail.tech; spf=pass smtp.mailfrom=chaosmail.tech; dkim=pass (1024-bit key) header.d=chaosmail.tech header.i=@chaosmail.tech header.b=qMFhtldV; arc=none smtp.client-ip=77.81.229.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=chaosmail.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chaosmail.tech
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chaosmail.tech header.i=@chaosmail.tech header.b="qMFhtldV"
Received: by chaosmail.tech (Postfix) id 793011CB983;
	Mon, 29 Jun 2026 09:43:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chaosmail.tech;
	s=mail; t=1782726187;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=oBhbYYISpLrIPK4lF4gaoN3zx36fHWE0W6XAugBNCrk=;
	b=qMFhtldVvg7tSNSE+uKpg20xCQN+OrOt/FY8tRyLwSRcIuh3pvJHTMyr35XMx/rzIKy7vn
	VnmbcfvAik90s9Q0TfKF8jD1SHtyr1FLKfBQn9XQik6KnUNYQmYcTFcPh6oLI1P6zs9WYk
	rv8c+wNUhXDBPKpgYoDRlsXbrejECFM=
From: Sasha Finkelstein <k@chaosmail.tech>
Date: Mon, 29 Jun 2026 11:42:42 +0200
Subject: [PATCH v3] power: supply: macsmc: Support macOS 27 SMC firmware
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260629-gate-power-v3-1-8428ab93f389@chaosmail.tech>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/22OzQ7CIBAGX6XhLAbWBNST72E88LO0GG0bQNQ0f
 XehXjR6nOSb2Z1IxOAxkn0zkYDZRz/0BTarhphO9S1SbwsTYCCY4Jy2KiEdhzsGapyVIKxhVjp
 ShDGg848ldjy9Od70GU2qhbrofExDeC7XMq+7v+HMKadbJUACZ1th5KH8MsSr8pd1QtORWs/w6
 cOXD8W3KIXRO60luh9/nucXXyNCu/sAAAA=
X-Change-ID: 20260611-gate-power-cfd726dc0d7f
To: Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>, 
 Neal Gompa <neal@gompa.dev>, Sebastian Reichel <sre@kernel.org>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Joshua Peisach <jpeisach@ubuntu.com>, stable@vger.kernel.org, 
 Sasha Finkelstein <k@chaosmail.tech>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782726186; l=4571;
 i=k@chaosmail.tech; s=20241124; h=from:subject:message-id;
 bh=sqKFDbIEcCs2cvx/DTq3eUOzdy0v/552i0lfDimwwZE=;
 b=rAhW13ZQ4HEXnm44sK/vEYVcG2oDhiUbPESwy2G5RRIbCUbMuvLHz1NLGVk56y0zwnvS8yodm
 MhLGnNtNmmhC9QU2PDJ8upyBNA2Xar8vAA0vo3VggqD6cLw+NpmC4YF
X-Developer-Key: i=k@chaosmail.tech; a=ed25519;
 pk=aSkp1PdZ+eF4jpMO6oLvz/YfT5XkBUneWwyhQrOgmsU=

The SMC firmware included in macOS 27 changed the size of BCF0 key from
4 to 1 bytes. This key is used for indicating that battery state is
critically low.

Reviewed-by: Sven Peter <sven@kernel.org>
Reviewed-by: Joshua Peisach <jpeisach@ubuntu.com>
Reviewed-by: Janne Grunau <j@jannau.net>
Cc: stable@vger.kernel.org
Fixes: 0ebf821cf6c7 ("power: supply: Add macsmc-power driver for Apple Silicon")
Signed-off-by: Sasha Finkelstein <k@chaosmail.tech>
---
Changes in v3:
- Minor style fixes
- R-b tags and Cc stable
- Rebase on 7.2
- Link to v2: https://patch.msgid.link/20260612-gate-power-v2-1-de76cb9bb7ef@chaosmail.tech

Changes in v2:
- Addressing review feedback
- Link to v1: https://patch.msgid.link/20260611-gate-power-v1-1-8a62721086c7@chaosmail.tech
---
 drivers/power/supply/macsmc-power.c | 36 +++++++++++++++++++++++++++++++++---
 1 file changed, 33 insertions(+), 3 deletions(-)

diff --git a/drivers/power/supply/macsmc-power.c b/drivers/power/supply/macsmc-power.c
index ced07f71e0a8..a357e50f81f2 100644
--- a/drivers/power/supply/macsmc-power.c
+++ b/drivers/power/supply/macsmc-power.c
@@ -86,6 +86,7 @@ struct macsmc_power {
 	bool has_ch0i; /* Force discharge (Older firmware) */
 	bool has_ch0c; /* Inhibit charge (Older firmware) */
 	bool has_chte; /* Inhibit charge (Modern firmware) */
+	bool bcf0_1byte; /* Battery critical key is 1 byte (Modern firmware) */
 
 	u8 num_cells;
 	int nominal_voltage_mv;
@@ -273,6 +274,20 @@ static int macsmc_battery_get_date(const char *s, int *out)
 	return 0;
 }
 
+static int macsmc_battery_read_bcf0(struct macsmc_power *power, u32 *val)
+{
+	u8 tval = 0;
+	int ret;
+
+	if (power->bcf0_1byte) {
+		ret = apple_smc_read_u8(power->smc, SMC_KEY(BCF0), &tval);
+		*val = tval;
+		return ret;
+	}
+
+	return apple_smc_read_u32(power->smc, SMC_KEY(BCF0), val);
+}
+
 static int macsmc_battery_get_capacity_level(struct macsmc_power *power)
 {
 	bool flag;
@@ -280,7 +295,7 @@ static int macsmc_battery_get_capacity_level(struct macsmc_power *power)
 	int ret;
 
 	/* Check for emergency shutdown condition */
-	if (apple_smc_read_u32(power->smc, SMC_KEY(BCF0), &val) >= 0 && val)
+	if (macsmc_battery_read_bcf0(power, &val) >= 0 && val)
 		return POWER_SUPPLY_CAPACITY_LEVEL_CRITICAL;
 
 	/* Check AC status for whether we could boot in this state */
@@ -577,7 +592,7 @@ static void macsmc_power_critical_work(struct work_struct *wrk)
 	 * Check if SMC flagged the battery as empty.
 	 * We trigger a graceful shutdown to let the OS save data.
 	 */
-	if (apple_smc_read_u32(power->smc, SMC_KEY(BCF0), &bcf0) == 0 && bcf0 != 0) {
+	if (macsmc_battery_read_bcf0(power, &bcf0) == 0 && bcf0 != 0) {
 		power->orderly_shutdown_triggered = true;
 		dev_crit(power->dev, "Battery critical (empty flag set). Triggering orderly shutdown.\n");
 		orderly_poweroff(true);
@@ -616,6 +631,7 @@ static int macsmc_power_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct apple_smc *smc = dev_get_drvdata(pdev->dev.parent);
 	struct power_supply_config psy_cfg = {};
+	struct apple_smc_key_info info;
 	struct macsmc_power *power;
 	bool has_battery = false;
 	bool has_ac_adapter = false;
@@ -714,6 +730,20 @@ static int macsmc_power_probe(struct platform_device *pdev)
 		if (apple_smc_key_exists(smc, SMC_KEY(CH0I)))
 			power->has_ch0i = true;
 
+		ret = apple_smc_get_key_info(power->smc, SMC_KEY(BCF0), &info);
+		if (ret) {
+			dev_err(&pdev->dev, "Failed to determine BCF0 key size\n");
+			return ret;
+		}
+		if (info.size == 1)
+			power->bcf0_1byte = true;
+		else if (info.size == 4)
+			power->bcf0_1byte = false;
+		else {
+			dev_err(&pdev->dev, "Unexpected BCF0 key size %d\n", info.size);
+			return -EIO;
+		}
+
 		/* Reset "Optimised Battery Charging" flags to default state */
 		if (power->has_chte)
 			apple_smc_write_u32(smc, SMC_KEY(CHTE), 0);
@@ -766,7 +796,7 @@ static int macsmc_power_probe(struct platform_device *pdev)
 		power->nominal_voltage_mv = MACSMC_NOMINAL_CELL_VOLTAGE_MV * power->num_cells;
 
 		/* Enable critical shutdown notifications by reading status once */
-		apple_smc_read_u32(power->smc, SMC_KEY(BCF0), &val32);
+		macsmc_battery_read_bcf0(power, &val32);
 
 		psy_cfg.drv_data = power;
 		power->batt = devm_power_supply_register(dev, &power->batt_desc, &psy_cfg);

---
base-commit: dc59e4fea9d83f03bad6bddf3fa2e52491777482
change-id: 20260611-gate-power-cfd726dc0d7f

Best regards,
--  
Sasha Finkelstein <k@chaosmail.tech>

