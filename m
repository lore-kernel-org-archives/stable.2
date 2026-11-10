Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794314138;
	b=y9gawFCxHTsKciyBLjclMd4B3FBl8LscQmz/lQSWIxq0T8OBd6ReRy0gpuB2v5A6LJN2
	 JRwRSiHFjHMPFOt+bb27IB22Jzd93YQhAT8+aXIw5H9UyN7JEJqGxHAHUGAlUb9ZkN0v1
	 vZ19gU8CSHJQZQZVeazvtMIRbKfG/o/as50JOYZPGkFUCekuGUaDsMLtpHEK9NpS6jPxi
	 Cc+Z6PUWp5C//tEu0tVDEnBRLW8DVfxpmWXuh2OF15jBexbpFOz+gCkRDYBU3TxC/p/Bf
	 734Qp6UqfW39vq8wQCpDNukZb7ih9qD1BAAOXDeule09gtF/OrPE3/baXX8L0zlTSUQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794314138;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=rCkWHu6QuGmX7mGIMrRoJ4TwEAFbYDqFPAwlbYAdEvo=;
	b=UK2Zqu8HdonQSOZV5HUbsw3MwRCM6jacyz1azaba5xQ2vgLTjB/Q/Odt0AyLzZ0tDZgc
	 rVU9/AsuMMs4I/GBtP7greCZXImSIRG/olpRqOG0gt3mK+Mpv1mikX6sOii3SNmkryjj0
	 5tiiFtwxUpjWNyYLjZDJ+Wx0Y9HKFXW8iCMw1Y9qluppTum9YAjb2zTYscw0tPf/txeWl
	 yajitsXfjmpGdjebbZKauUvoXPjBKSnp7l+8miyGaESR/9kg76w3cCyUA2pQTGgq0DZwv
	 ywzq9akFDeGbeaLQYWrZb8LZ5QRREv0LvMZCywG6O5ljkXlRBI1k26HBFyGyDAJvpkQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LLFFoJK3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1F39606A321
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 12:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LLFFoJK3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B31F1F0089F;
	Tue, 10 Nov 2026 12:35:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794314137;
	bh=rCkWHu6QuGmX7mGIMrRoJ4TwEAFbYDqFPAwlbYAdEvo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LLFFoJK3proK14Ytm4N5sgDCpm61Ogwf4Ci6MiL9sZCWcHhf19aY/IXvvZsGlKzlv
	 jH1wNf3GC1YugP/cIDq0agvzxjZbBDzCSA+sl5ulb9YhwUal5+Jzzwp/xBRuvaLYWT
	 0oUa19SjoaiBqangNvJ6XiyTeozfmyk4E4POQxEYJmm70uzCQSASRERwFGI4YURN3w
	 DCrF026yOutRSo+qqu0WNHtiQnOPxeVlniGmyt2dwX2HxqdozkQOi2Yi6xSBeTgyrW
	 bFHn2XM+UgKUwurXkc2mZ8njs3PeV3U1Fg3YUqGqh4rl49OmBgwDJmBzQDk2NrKTsc
	 O+Su/kAKSF+hg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Robin Snyders <robin@snyders.xyz>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] power: supply: qcom_smbx: validate battery float voltage
Date: Tue, 10 Nov 2026 07:35:36 -0500
Message-ID: <20261110123514.1260705-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107052858-failed-6.6-a2d7dc538da2@kernel.org>
References: <20261107052858-failed-6.6-a2d7dc538da2@kernel.org>
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
[ sashal: adapted smb_ identifiers to the existing smb2_ naming convention ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/power/supply/qcom_pmi8998_charger.c | 61 ++++++++++++++++++++-
 1 file changed, 58 insertions(+), 3 deletions(-)

diff --git a/drivers/power/supply/qcom_pmi8998_charger.c b/drivers/power/supply/qcom_pmi8998_charger.c
index 2ad6b87eba762..3c91d5a0c8c94 100644
--- a/drivers/power/supply/qcom_pmi8998_charger.c
+++ b/drivers/power/supply/qcom_pmi8998_charger.c
@@ -350,6 +350,7 @@
 /* pmi8998 registers represent current in increments of 1/40th of an amp */
 #define CURRENT_SCALE_FACTOR				25000
 #define SMB2_FLOAT_VOLTAGE_MIN_UV			3487500
+#define SMB2_FLOAT_VOLTAGE_MAX_UV			4920000
 #define SMB2_FLOAT_VOLTAGE_STEP_UV			7500
 /* clang-format on */
 
@@ -377,6 +378,7 @@ struct smb2_register {
  * @base:		Base address for smb2 registers
  * @regmap:		Register map
  * @batt_info:		Battery data from DT
+ * @initial_charge_enable: Charging enable state before hardware setup
  * @status_change_work: Worker to handle plug/unplug events
  * @cable_irq:		USB plugin IRQ
  * @wakeup_enabled:	If the cable IRQ will cause a wakeup
@@ -390,6 +392,7 @@ struct smb2_chip {
 	unsigned int base;
 	struct regmap *regmap;
 	struct power_supply_battery_info *batt_info;
+	u8 initial_charge_enable;
 
 	struct delayed_work status_change_work;
 	int cable_irq;
@@ -909,6 +912,19 @@ static int smb2_init_hw(struct smb2_chip *chip)
 	return 0;
 }
 
+static void smb2_restore_charge_enable(void *data)
+{
+	struct smb2_chip *chip = data;
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
 static int smb2_init_irq(struct smb2_chip *chip, int *irq, const char *name,
 			 irqreturn_t (*handler)(int irq, void *data))
 {
@@ -937,6 +953,9 @@ static int smb2_probe(struct platform_device *pdev)
 	struct power_supply_config supply_config = {};
 	struct power_supply_desc *desc;
 	struct smb2_chip *chip;
+	unsigned int charge_enable;
+	unsigned int float_voltage_sel;
+	int float_voltage_uv;
 	int rc, irq;
 
 	chip = devm_kzalloc(&pdev->dev, sizeof(*chip), GFP_KERNEL);
@@ -967,6 +986,18 @@ static int smb2_probe(struct platform_device *pdev)
 				     "Couldn't get usbin_i IIO channel\n");
 	}
 
+	rc = regmap_read(chip->regmap, chip->base + CHARGING_ENABLE_CMD,
+			 &charge_enable);
+	if (rc < 0)
+		return dev_err_probe(chip->dev, rc,
+				     "Couldn't read charging state\n");
+
+	chip->initial_charge_enable = charge_enable & CHARGING_ENABLE_CMD_BIT;
+	rc = devm_add_action_or_reset(chip->dev, smb2_restore_charge_enable, chip);
+	if (rc)
+		return dev_err_probe(chip->dev, rc,
+				     "Couldn't register charging state rollback\n");
+
 	rc = smb2_init_hw(chip);
 	if (rc < 0)
 		return rc;
@@ -1001,13 +1032,35 @@ static int smb2_probe(struct platform_device *pdev)
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
 	rc = smb2_init_irq(chip, &irq, "bat-ov", smb2_handle_batt_overvoltage);
 	if (rc < 0)
 		return rc;
@@ -1029,6 +1082,8 @@ static int smb2_probe(struct platform_device *pdev)
 	if (rc < 0)
 		return dev_err_probe(chip->dev, rc, "Couldn't set wake irq\n");
 
+	devm_remove_action(chip->dev, smb2_restore_charge_enable, chip);
+
 	platform_set_drvdata(pdev, chip);
 
 	/* Initialise charger state */
-- 
2.53.0

