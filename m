Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794313553;
	b=3Uk3ArAixp7zCAEqnvFHY6EwQbonr4GxuHMtQ+GeU6MDon1TKiCV5d3dAwZTVfSYq8Ce
	 HZrpY3Iw8+Q0uCfgHM6Fb4nIJRO3odlQ1/+GUYPSAztr3XrLQLXy11Uq8Ycm934wXbLTn
	 Ui7bk/z/dLKVMo8cyu22PPkxaf2y7lHwHftSixIQOuW/dT/jkfvkUHqZtg4OB0G7grOme
	 Sd/xzp4BaASI+/DgAaQjngLEipOUUDzypXcl3e2TOQio2XtMaHQkSeMI0n47gl2sg812e
	 I3gAdBUSkvc6TbJV5Q6mc0U2uofOAWvghn0TOhh0O2KUWIAHhxul8dZsDfxPD9qdwLA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794313553;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=kdQOAjhlO0LRfaXoiB3O4Q8NqahxJff4uVkbJkmsp64=;
	b=fltLf7vV0FVM2qFI7iyhPrR/0PUh0XjbakAtSmr4MnZrEk//n1x0SRre8EK1NyGi5vJF
	 NDa405JPnFXJDep01nL3nu2by5BZNQeFQOT1eb4tJlLq8YUlQWJzpLL6+MhB+FwKGtZbm
	 qxtM9sqblsvx3ebP2Ao7mVUlpCv7OnMq8QUGnCPGeaEuVz60F7/R+X8euqfaEP0EbDFe2
	 3+DI72pfwYpGC+zrOcJ7BMhDDaRNexZdYL367Spgmh6iGx5FJfImD3Me/PbPr7N+Mpq3x
	 9288CUgBklJhjP+aKYf2ac/hLYMRKPK/i1qskFqo9b91syFiI6m0XqY3UnRQILr/TkQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Yaxtahpr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FA3A60A2627
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 12:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Yaxtahpr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50CE61F00903;
	Tue, 10 Nov 2026 12:25:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794313553;
	bh=kdQOAjhlO0LRfaXoiB3O4Q8NqahxJff4uVkbJkmsp64=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YaxtahprXFnyBaeq/e8wVkhcPHhkcq1UG11dckgz7vsPFqEcyII7M8vmjdiI4Wgwh
	 ME4Xs/L/awKQ0nt80fsot/npV8pvmxBNCxm+0TlJP0gV+3z1DzsyXhKxDJ6yXGsYj6
	 t2xpiKpZBqTwVeHr2fYsErPxE/eLP50/fU4O3qRu0qwcYmxcYFsnqOtuAnPT4lzN6P
	 Jk3CxR8AglpoPoE3EMAWkbxCsLHeYI5k51xoxBAWBQop74Fe380LG9U3rxzvhiM7r/
	 /5AOJz3DFZ2qFMIWERxOlzlGj9McH8WZ6jkED3HZMY6ruZ4zIx71k0IpY8atMhsx91
	 B2KWbvKNUSlgQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Robin Snyders <robin@snyders.xyz>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/2] power: supply: qcom_smbx: validate battery float voltage
Date: Tue, 10 Nov 2026 07:25:49 -0500
Message-ID: <20261110122522.1154709-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110122522.1154709-1-sashal@kernel.org>
References: <20261107051650-failed-6.12-a2d7dc538da2@kernel.org>
 <20261110122522.1154709-1-sashal@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Robin Snyders <robin@snyders.xyz>

[ Upstream commit a2d7dc538da2cb4a7426f0742197e762cb635f38 ]

power_supply_get_battery_info() leaves absent optional properties at
-EINVAL. The driver uses voltage_max_design_uv without checking it, so a
missing or out-of-range value can become an invalid float-voltage
selector.

Prefer the constant-charge voltage because it describes the charger's CV
target, then fall back to the battery design voltage. Both properties are
optional in the simple-battery binding, so preserve the hardware setting
when neither is present. Reject a supplied target outside the SMB2 range.

smb_init_hw() enables charging before battery data is parsed and before
the remaining fallible probe steps. Save the initial charging-enable bit
and install a managed rollback before initialization. Keep the rollback
active across battery-info, voltage, IRQ and wake-IRQ setup, then remove it
only after probe can no longer fail.

Fixes: 8648aeb5d7b7 ("power: supply: add Qualcomm PMI8998 SMB2 Charger driver")
Cc: stable@vger.kernel.org
Signed-off-by: Robin Snyders <robin@snyders.xyz>
Link: https://patch.msgid.link/20260812-qcom-smbx-fixes-v1-4-eb48246be599@snyders.xyz
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/power/supply/qcom_smbx.c | 61 ++++++++++++++++++++++++++++++--
 1 file changed, 58 insertions(+), 3 deletions(-)

diff --git a/drivers/power/supply/qcom_smbx.c b/drivers/power/supply/qcom_smbx.c
index c5ac09469650a..099d1385ea12d 100644
--- a/drivers/power/supply/qcom_smbx.c
+++ b/drivers/power/supply/qcom_smbx.c
@@ -350,6 +350,7 @@
 /* pmi8998 registers represent current in increments of 1/40th of an amp */
 #define CURRENT_SCALE_FACTOR				25000
 #define SMB2_FLOAT_VOLTAGE_MIN_UV			3487500
+#define SMB2_FLOAT_VOLTAGE_MAX_UV			4920000
 #define SMB2_FLOAT_VOLTAGE_STEP_UV			7500
 /* clang-format on */
 
@@ -377,6 +378,7 @@ struct smb_init_register {
  * @base:		Base address for smb registers
  * @regmap:		Register map
  * @batt_info:		Battery data from DT
+ * @initial_charge_enable: Charging enable state before hardware setup
  * @status_change_work: Worker to handle plug/unplug events
  * @cable_irq:		USB plugin IRQ
  * @wakeup_enabled:	If the cable IRQ will cause a wakeup
@@ -390,6 +392,7 @@ struct smb_chip {
 	unsigned int base;
 	struct regmap *regmap;
 	struct power_supply_battery_info *batt_info;
+	u8 initial_charge_enable;
 
 	struct delayed_work status_change_work;
 	int cable_irq;
@@ -904,6 +907,19 @@ static int smb_init_hw(struct smb_chip *chip)
 	return 0;
 }
 
+static void smb_restore_charge_enable(void *data)
+{
+	struct smb_chip *chip = data;
+	int rc;
+
+	rc = regmap_update_bits(chip->regmap,
+				chip->base + CHARGING_ENABLE_CMD,
+				CHARGING_ENABLE_CMD_BIT,
+				chip->initial_charge_enable);
+	if (rc < 0)
+		dev_err(chip->dev, "Couldn't restore charging state: %d\n", rc);
+}
+
 static int smb_init_irq(struct smb_chip *chip, int *irq, const char *name,
 			 irqreturn_t (*handler)(int irq, void *data))
 {
@@ -931,6 +947,9 @@ static int smb_probe(struct platform_device *pdev)
 	struct power_supply_config supply_config = {};
 	struct power_supply_desc *desc;
 	struct smb_chip *chip;
+	unsigned int charge_enable;
+	unsigned int float_voltage_sel;
+	int float_voltage_uv;
 	int rc, irq;
 
 	chip = devm_kzalloc(&pdev->dev, sizeof(*chip), GFP_KERNEL);
@@ -961,6 +980,18 @@ static int smb_probe(struct platform_device *pdev)
 				     "Couldn't get usbin_i IIO channel\n");
 	}
 
+	rc = regmap_read(chip->regmap, chip->base + CHARGING_ENABLE_CMD,
+			 &charge_enable);
+	if (rc < 0)
+		return dev_err_probe(chip->dev, rc,
+				     "Couldn't read charging state\n");
+
+	chip->initial_charge_enable = charge_enable & CHARGING_ENABLE_CMD_BIT;
+	rc = devm_add_action_or_reset(chip->dev, smb_restore_charge_enable, chip);
+	if (rc)
+		return dev_err_probe(chip->dev, rc,
+				     "Couldn't register charging state rollback\n");
+
 	rc = smb_init_hw(chip);
 	if (rc < 0)
 		return rc;
@@ -995,13 +1026,35 @@ static int smb_probe(struct platform_device *pdev)
 		return dev_err_probe(chip->dev, rc,
 				     "Failed to init status change work\n");
 
-	rc = (chip->batt_info->voltage_max_design_uv -
-	      SMB2_FLOAT_VOLTAGE_MIN_UV) / SMB2_FLOAT_VOLTAGE_STEP_UV;
+	if (power_supply_battery_info_has_prop(chip->batt_info,
+					       POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE_MAX)) {
+		float_voltage_uv =
+			chip->batt_info->constant_charge_voltage_max_uv;
+	} else if (power_supply_battery_info_has_prop(chip->batt_info,
+					      POWER_SUPPLY_PROP_VOLTAGE_MAX_DESIGN)) {
+		float_voltage_uv = chip->batt_info->voltage_max_design_uv;
+	} else {
+		dev_warn(chip->dev, "No battery float voltage; preserving hardware setting\n");
+		goto skip_float_voltage;
+	}
+
+	if (float_voltage_uv < SMB2_FLOAT_VOLTAGE_MIN_UV ||
+	    float_voltage_uv > SMB2_FLOAT_VOLTAGE_MAX_UV)
+		return dev_err_probe(chip->dev, -EINVAL,
+				     "float voltage %d uV outside %d-%d uV\n",
+				     float_voltage_uv,
+				     SMB2_FLOAT_VOLTAGE_MIN_UV,
+				     SMB2_FLOAT_VOLTAGE_MAX_UV);
+
+	float_voltage_sel =
+		(float_voltage_uv - SMB2_FLOAT_VOLTAGE_MIN_UV) /
+		SMB2_FLOAT_VOLTAGE_STEP_UV;
 	rc = regmap_update_bits(chip->regmap, chip->base + FLOAT_VOLTAGE_CFG,
-				FLOAT_VOLTAGE_SETTING_MASK, rc);
+				FLOAT_VOLTAGE_SETTING_MASK, float_voltage_sel);
 	if (rc < 0)
 		return dev_err_probe(chip->dev, rc, "Couldn't set vbat max\n");
 
+skip_float_voltage:
 	rc = smb_init_irq(chip, &irq, "bat-ov", smb_handle_batt_overvoltage);
 	if (rc < 0)
 		return rc;
@@ -1023,6 +1076,8 @@ static int smb_probe(struct platform_device *pdev)
 	if (rc < 0)
 		return dev_err_probe(chip->dev, rc, "Couldn't set wake irq\n");
 
+	devm_remove_action(chip->dev, smb_restore_charge_enable, chip);
+
 	platform_set_drvdata(pdev, chip);
 
 	/* Initialise charger state */
-- 
2.53.0

