Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 666EE434E40;
	Tue, 11 Aug 2026 23:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786491013; cv=none; b=iP3MeKyLg0pNBYtL9HnMH+mmH6yE/5sNfyvQoazAHP+avtpGixwF2Up7QFNAh76xuAFRwHZmWkAT6hz4f29g5giQ1icOfS7UebL2sZzwAyHc1cMFceeN6+V7x2FVYGmOTgQrs7ZzJ/sk7RMkPOE5BTDOPQ01lg4HqZq2PUk0NOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786491013; c=relaxed/simple;
	bh=KEUxM4u9mL2sqsdQtdngh6AEzOIeJhjeAAa1iyA6wok=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=t2vAlA2vMyhTqAUQ6Uqf32qOKTSzzNffZzVwVWbbSz1CrzTUcyGyL6Px4jVYn7Rfniw6xSuhTSG57sDewj3QFlGiQhIaZadJsR+ILLOiIWVA9kXP99ewbRuOVRhEhslGrZhdi9wbMOSEpx5kbMOOsWQ9yLKP7IRvQf7Z8kY1mG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pqBocubv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pqBocubv"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 35D85C2BCFD;
	Tue, 11 Aug 2026 23:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1786491013;
	bh=KEUxM4u9mL2sqsdQtdngh6AEzOIeJhjeAAa1iyA6wok=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=pqBocubveInBfxLXubPL0gYP9ZhepzPY+wSEdSzXMrk02HYW8OX/WAiVXiwujucpl
	 iGYBYW0C6l2ok+LhBOOMtu/0avaloqRStGpvpg7eNuY6uKmbC9Xc8nkmhHfZOKYYC+
	 iJGe0Axe5EJIzL0GuwI//aABhjQnm8ZUOcf2VudPMDXBWPxwO8J37ouNcUjjNnoI7g
	 MxU7QiTpoArJ3ozY14kkKn9ej/E/LfLxmuzJdvJ5OHuQTdwoiZXTdBdaU+WcLSprV0
	 7tiojVIfmHTORV/5eyPo1q17h6KxCaSJ3YMmxA9PeCezp6Lx59AyTdQMhvdQ7nZbml
	 ZP68ayqem6cfA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25C18C5CFDB;
	Tue, 11 Aug 2026 23:30:13 +0000 (UTC)
From: Robin Snyders via B4 Relay <devnull+robin.snyders.xyz@kernel.org>
Date: Wed, 12 Aug 2026 01:30:01 +0200
Subject: [PATCH 4/5] power: supply: qcom_smbx: validate battery float
 voltage
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260812-qcom-smbx-fixes-v1-4-eb48246be599@snyders.xyz>
References: <20260812-qcom-smbx-fixes-v1-0-eb48246be599@snyders.xyz>
In-Reply-To: <20260812-qcom-smbx-fixes-v1-0-eb48246be599@snyders.xyz>
To: Casey Connolly <casey.connolly@linaro.org>, 
 Sebastian Reichel <sre@kernel.org>
Cc: Robin Snyders <robin@snyders.xyz>, linux-arm-msm@vger.kernel.org, 
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Sebastian Reichel <sebastian.reichel@collabora.com>, stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786491008; l=5766;
 i=robin@snyders.xyz; s=default; h=from:subject:message-id;
 bh=GzUPMoVhsoygcgB/E6QggNyBQTzq9stOZL0prTQsNcM=;
 b=VPERR54hNV31IgFZsn84X9Hv9aKk1yFHlVBw2hbGyFRc1I7gYcahhELe4ZOEIZH1yn3DPVP5S
 cM64N1FgZ+oBqs0nxsnXHfcyWEF/dQVIdU+44eF1fE4yBhQ/NUzxrO0
X-Developer-Key: i=robin@snyders.xyz; a=ed25519;
 pk=Mdk5dNn+Tkcy7BWexDxBLR/s1BNz8WdqDPnr3qtYBIU=
X-Endpoint-Received: by B4 Relay for robin@snyders.xyz/default with
 auth_id=938
X-Original-From: Robin Snyders <robin@snyders.xyz>
Reply-To: robin@snyders.xyz

From: Robin Snyders <robin@snyders.xyz>

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
---
 drivers/power/supply/qcom_smbx.c | 61 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 58 insertions(+), 3 deletions(-)

diff --git a/drivers/power/supply/qcom_smbx.c b/drivers/power/supply/qcom_smbx.c
index e236b95c0ebf3..55ffe9857e494 100644
--- a/drivers/power/supply/qcom_smbx.c
+++ b/drivers/power/supply/qcom_smbx.c
@@ -353,6 +353,7 @@
 /* pmi8998 registers represent current in increments of 1/40th of an amp */
 #define CURRENT_SCALE_FACTOR				25000
 #define SMB2_FLOAT_VOLTAGE_MIN_UV			3487500
+#define SMB2_FLOAT_VOLTAGE_MAX_UV			4920000
 #define SMB2_FLOAT_VOLTAGE_STEP_UV			7500
 /* clang-format on */
 
@@ -380,6 +381,7 @@ struct smb_init_register {
  * @base:		Base address for smb registers
  * @regmap:		Register map
  * @batt_info:		Battery data from DT
+ * @initial_charge_enable: Charging enable state before hardware setup
  * @status_change_work: Worker to handle plug/unplug events
  * @cable_irq:		USB plugin IRQ
  * @wakeup_enabled:	If the cable IRQ will cause a wakeup
@@ -393,6 +395,7 @@ struct smb_chip {
 	unsigned int base;
 	struct regmap *regmap;
 	struct power_supply_battery_info *batt_info;
+	u8 initial_charge_enable;
 
 	struct delayed_work status_change_work;
 	int cable_irq;
@@ -905,6 +908,19 @@ static int smb_init_hw(struct smb_chip *chip)
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
@@ -1025,6 +1078,8 @@ static int smb_probe(struct platform_device *pdev)
 	if (rc < 0)
 		return dev_err_probe(chip->dev, rc, "Couldn't set wake irq\n");
 
+	devm_remove_action(chip->dev, smb_restore_charge_enable, chip);
+
 	platform_set_drvdata(pdev, chip);
 
 	/* Initialise charger state */

-- 
2.54.0


