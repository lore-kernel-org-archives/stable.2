Received: from chaosmail.tech (chaosmail.tech [77.81.229.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC50C1F3BAC;
	Sat, 11 Jul 2026 22:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.81.229.115
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783810220; cv=none; b=JgYyjrTnnWaFwRUaHkPR0NfBn/0kO/wFdQ5B3OvsU3ZzR3NYNqKocAd25bGlU8njdJFSjqI281bpiA7q5fvzwqdNfKlgXC+y/itKLtQs1MiAi7nm3Mx5+IgvK/FuBQ87clSUweT9S2SJS5nATZqSFKU84PgqQ7SPKNNWX/2nNXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783810220; c=relaxed/simple;
	bh=9hEttOjxUo4x8VZA0u6Zh8it9IZ1e1B/QRSppPFee94=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=LxYlKvy0nfiMrNkOhBhNOavO/Cb16gSlzq2Yrhni2WN1+9OXsCJmEIn0ZC8UHsGUVDwYPgSxitiKtbjb4FKFAlBBMOK8B3H97TxCixMvgFkDO2Yy7NCMVPLPd5CAh7qPN4rsXxf4+9RwCgKZ0dQbJLIbF2oK3LkJrQg2W0wwyzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=chaosmail.tech; spf=pass smtp.mailfrom=chaosmail.tech; dkim=pass (1024-bit key) header.d=chaosmail.tech header.i=@chaosmail.tech header.b=T3xlR045; arc=none smtp.client-ip=77.81.229.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=chaosmail.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chaosmail.tech
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chaosmail.tech header.i=@chaosmail.tech header.b="T3xlR045"
Received: by chaosmail.tech (Postfix) id 2256B1C8673;
	Sat, 11 Jul 2026 22:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chaosmail.tech;
	s=mail; t=1783810207;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=BqTPpzuvZrixISR9QYSmrDSTNk2cgTef1nAy5K2DnE4=;
	b=T3xlR0454W0UcaNa9HsYGVt63N1K7Vvfn2XsjjAWPW9fTA2Bz4vtxrWWCPBArqroirWByc
	w6PDEYFcp4SMFyebriPEtY7G7y7NHwSqmIOWB/onHKNjWjcMVA/39mAbIBlCmID5QTZlbX
	bC72qJ9MPc1pMJlmXyGANLEZeyMinaw=
From: Sasha Finkelstein <k@chaosmail.tech>
Date: Sun, 12 Jul 2026 00:48:56 +0200
Subject: [PATCH v4] power: supply: macsmc: Support macOS 27 SMC firmware
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260712-gate-power-v4-1-aa59c6583247@chaosmail.tech>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/23OOw7CMBAE0Ksg1xjFG+QPFfdAFP6sEyMgyA4BF
 OXu2KEBkXKkfTM7koQxYCK71UgiDiGF7prDdr0ittXXBmlwOROogFecMdroHumte2Ck1jsB3Nn
 KCU8yuEX04TmXHY6fnO7mhLYvDeWiDanv4mteG1i5WyweGGVUag4CWCW5Ffv8S5cuOpw3PdqWl
 PYBvj38eMjeoeDWKGME+kVff3lQP74u+1uQ2qja11L9+Wma3teBhBI7AQAA
X-Change-ID: 20260611-gate-power-cfd726dc0d7f
To: Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>, 
 Neal Gompa <neal@gompa.dev>, Sebastian Reichel <sre@kernel.org>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Joshua Peisach <jpeisach@ubuntu.com>, stable@vger.kernel.org, 
 Sasha Finkelstein <k@chaosmail.tech>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783810207; l=6328;
 i=k@chaosmail.tech; s=20241124; h=from:subject:message-id;
 bh=9hEttOjxUo4x8VZA0u6Zh8it9IZ1e1B/QRSppPFee94=;
 b=7RHM7NDNYULbELZ142reJuoDQRRO402Ewn+zyEZnHcC7TyyVJz9M7AfU8S7PqkuPAeVuvmB+s
 n9R19EQxBTyC/6f4EFmEQIRIqTJkdvjL0/9ivANdcprnByU9Kcme7hx
X-Developer-Key: i=k@chaosmail.tech; a=ed25519;
 pk=aSkp1PdZ+eF4jpMO6oLvz/YfT5XkBUneWwyhQrOgmsU=

The SMC firmware included in macOS 27 changed the size of BCF0 key from
4 to 1 bytes. This key is used for indicating that battery state is
critically low. In addition, B0RM key has changed endianness.

Reviewed-by: Sven Peter <sven@kernel.org>
Reviewed-by: Joshua Peisach <jpeisach@ubuntu.com>
Reviewed-by: Janne Grunau <j@jannau.net>
Cc: stable@vger.kernel.org
Fixes: 0ebf821cf6c7 ("power: supply: Add macsmc-power driver for Apple Silicon")
Signed-off-by: Sasha Finkelstein <k@chaosmail.tech>
---
Changes in v4:
- Also fix B0RM endianness
- Link to v3: https://patch.msgid.link/20260629-gate-power-v3-1-8428ab93f389@chaosmail.tech

Changes in v3:
- Minor style fixes
- R-b tags and Cc stable
- Rebase on 7.2
- Link to v2: https://patch.msgid.link/20260612-gate-power-v2-1-de76cb9bb7ef@chaosmail.tech

Changes in v2:
- Addressing review feedback
- Link to v1: https://patch.msgid.link/20260611-gate-power-v1-1-8a62721086c7@chaosmail.tech
---
 drivers/power/supply/macsmc-power.c | 52 +++++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 45 insertions(+), 7 deletions(-)

diff --git a/drivers/power/supply/macsmc-power.c b/drivers/power/supply/macsmc-power.c
index ced07f71e0a8..ef735f86394e 100644
--- a/drivers/power/supply/macsmc-power.c
+++ b/drivers/power/supply/macsmc-power.c
@@ -86,6 +86,11 @@ struct macsmc_power {
 	bool has_ch0i; /* Force discharge (Older firmware) */
 	bool has_ch0c; /* Inhibit charge (Older firmware) */
 	bool has_chte; /* Inhibit charge (Modern firmware) */
+	/*
+	 * Battery critical key is 1 byte and charge key is little endian
+	 * (Modern firmware)
+	 */
+	bool fw_ge_27;
 
 	u8 num_cells;
 	int nominal_voltage_mv;
@@ -273,6 +278,20 @@ static int macsmc_battery_get_date(const char *s, int *out)
 	return 0;
 }
 
+static int macsmc_battery_read_bcf0(struct macsmc_power *power, u32 *val)
+{
+	u8 tval = 0;
+	int ret;
+
+	if (power->fw_ge_27) {
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
@@ -280,7 +299,7 @@ static int macsmc_battery_get_capacity_level(struct macsmc_power *power)
 	int ret;
 
 	/* Check for emergency shutdown condition */
-	if (apple_smc_read_u32(power->smc, SMC_KEY(BCF0), &val) >= 0 && val)
+	if (macsmc_battery_read_bcf0(power, &val) >= 0 && val)
 		return POWER_SUPPLY_CAPACITY_LEVEL_CRITICAL;
 
 	/* Check AC status for whether we could boot in this state */
@@ -303,6 +322,12 @@ static int macsmc_battery_get_capacity_level(struct macsmc_power *power)
 		return POWER_SUPPLY_CAPACITY_LEVEL_NORMAL;
 }
 
+static s16 macsmc_swap_b0rm(struct macsmc_power *power, s16 b0rm)
+{
+	/* B0RM was Big Endian, likely pass through from TI gas gauge */
+	return power->fw_ge_27 ? b0rm : (s16)swab16(b0rm);
+}
+
 static int macsmc_battery_get_property(struct power_supply *psy,
 				       enum power_supply_property psp,
 				       union power_supply_propval *val)
@@ -397,8 +422,7 @@ static int macsmc_battery_get_property(struct power_supply *psy,
 		break;
 	case POWER_SUPPLY_PROP_CHARGE_NOW:
 		ret = apple_smc_read_u16(power->smc, SMC_KEY(B0RM), &vu16);
-		/* B0RM is Big Endian, likely pass through from TI gas gauge */
-		val->intval = (s16)swab16(vu16) * 1000;
+		val->intval = macsmc_swap_b0rm(power, vu16) * 1000;
 		break;
 	case POWER_SUPPLY_PROP_ENERGY_FULL_DESIGN:
 		ret = apple_smc_read_u16(power->smc, SMC_KEY(B0DC), &vu16);
@@ -410,8 +434,7 @@ static int macsmc_battery_get_property(struct power_supply *psy,
 		break;
 	case POWER_SUPPLY_PROP_ENERGY_NOW:
 		ret = apple_smc_read_u16(power->smc, SMC_KEY(B0RM), &vu16);
-		/* B0RM is Big Endian, likely pass through from TI gas gauge */
-		val->intval = (s16)swab16(vu16) * power->nominal_voltage_mv;
+		val->intval = macsmc_swap_b0rm(power, vu16) * power->nominal_voltage_mv;
 		break;
 	case POWER_SUPPLY_PROP_TEMP:
 		ret = apple_smc_read_u16(power->smc, SMC_KEY(B0AT), &vu16);
@@ -577,7 +600,7 @@ static void macsmc_power_critical_work(struct work_struct *wrk)
 	 * Check if SMC flagged the battery as empty.
 	 * We trigger a graceful shutdown to let the OS save data.
 	 */
-	if (apple_smc_read_u32(power->smc, SMC_KEY(BCF0), &bcf0) == 0 && bcf0 != 0) {
+	if (macsmc_battery_read_bcf0(power, &bcf0) == 0 && bcf0 != 0) {
 		power->orderly_shutdown_triggered = true;
 		dev_crit(power->dev, "Battery critical (empty flag set). Triggering orderly shutdown.\n");
 		orderly_poweroff(true);
@@ -616,6 +639,7 @@ static int macsmc_power_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct apple_smc *smc = dev_get_drvdata(pdev->dev.parent);
 	struct power_supply_config psy_cfg = {};
+	struct apple_smc_key_info info;
 	struct macsmc_power *power;
 	bool has_battery = false;
 	bool has_ac_adapter = false;
@@ -714,6 +738,20 @@ static int macsmc_power_probe(struct platform_device *pdev)
 		if (apple_smc_key_exists(smc, SMC_KEY(CH0I)))
 			power->has_ch0i = true;
 
+		ret = apple_smc_get_key_info(power->smc, SMC_KEY(BCF0), &info);
+		if (ret) {
+			dev_err(&pdev->dev, "Failed to determine BCF0 key size\n");
+			return ret;
+		}
+		if (info.size == 1)
+			power->fw_ge_27 = true;
+		else if (info.size == 4)
+			power->fw_ge_27 = false;
+		else {
+			dev_err(&pdev->dev, "Unexpected BCF0 key size %d\n", info.size);
+			return -EIO;
+		}
+
 		/* Reset "Optimised Battery Charging" flags to default state */
 		if (power->has_chte)
 			apple_smc_write_u32(smc, SMC_KEY(CHTE), 0);
@@ -766,7 +804,7 @@ static int macsmc_power_probe(struct platform_device *pdev)
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

