Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794604734;
	b=jY8NzPgyu8bEtctdB8HWsn+Zf9MJ8hy9/fQ0hqcfiuEBp3LWrUCPuPo44k3bs7Z9149m
	 cDSOftxvkD9w7SQNnMZBYEoXCj+6AZpPRALEUizdwMlGMkrWf8VtG8bfJEFwGPgV3b97C
	 0wSzAYrxLKOQpZN4SLOmn6aVxhRXsGX+6OoSVjjRXwWjcJP8ZxVNlSjQ60oZFhimxJO+n
	 LY/KErWR53BoOjVSQHi/rZBcvAOYiGpAfxMoYQXz48JFISYkzqXw0oELamy3J+yAeHNHx
	 EGky9hFsW5YOmRm7uUQtVypmJH+nNNiOeyVkT4M47pFL+DcBPif1grKEExBXIxvNOdg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794604734;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=pDybQjB8hyi6k7ZPRDtsv9lXCsKmSso9IQfevNO0Yy4=;
	b=gR6YYY9cW9/ZevUZKMYuHx1cN46cHTCdqaRt9w5j2itVg8PYDD6Aj9NARdDOvsFypcVm
	 I8s5OkcYyluVY0RAi/KlDMEWLCLVM5SVVHppqYkysveLPBM9JXS9/7XDqJmheE1jZioqB
	 bgPp32gSUSYSTU2Mvbdnpf6fuGIdxJlPDBOgAsHMrrgJpVFa7NFp/hAXZo5N/tRGT5b6+
	 Z9298qGza2APurT1KL2gGJl4fPGYNctcioCy7L6O/VAalFy9AWSGQwzIGg0CryzBZXnur
	 ZbGeUHNwJx1FLGkm/79mktHRkiEg1hvSL9vxWvFfm7EWncTrix8EwIbJDqJrvyEaoDw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QMzb+Xv6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63E6B606A331
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 21:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QMzb+Xv6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78DA51F000C4;
	Fri, 13 Nov 2026 21:18:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794604734;
	bh=pDybQjB8hyi6k7ZPRDtsv9lXCsKmSso9IQfevNO0Yy4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QMzb+Xv6R2Kl4bAulCdhdP7XoMb0/mvxwU7fqdDTV6XSRdWpmXBqVXpP3GIV0G67j
	 nBApZduA6U9CtQ1RXvjd0qJheuGirKrnJ6+WdWl1vl1NYlyOQPCwY8s/FLulISRBHr
	 DAnybBAHneDqcCspNXmINq/Kl/hh6q6rHrgmGMENH6F6yBscj5LLE5RtmHc5Ux5pcf
	 eSErQyeVDFZLd6NJ51QTtKqI+n8t4veURlKc4exgEMprtis56grSIFjODD6kXUiggN
	 qWuKTMmc53iRvHolRnMMZS7lNAnIU4tguSg2Im0a+YdTJXzLMhVV7Fem9R5s+jfR/q
	 W3D1jyjZ3aiFw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jiale Yao <yaojiale02@163.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] hwmon: (aquacomputer_d5next) reject short status reports
Date: Fri, 13 Nov 2026 16:18:52 -0500
Message-ID: <20261113211831.2668902-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109201613-failed-6.1-cf8f81babd2e@kernel.org>
References: <20261109201613-failed-6.1-cf8f81babd2e@kernel.org>
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

From: Jiale Yao <yaojiale02@163.com>

[ Upstream commit cf8f81babd2e96087dedbb74985bc1781c98f73d ]

The HID raw_event callback runs before HID core validates the received
report length. aqc_raw_event() reads device-specific status fields at fixed
offsets, including multi-byte values, without first ensuring that the
received buffer contains every field. A truncated report can therefore
cause out-of-bounds reads and update hwmon state with unrelated data.

The required length differs between supported devices and cannot be
derived from the HID report descriptor. Define the minimum length needed
by each asynchronous status format, select it while configuring the
device, and reject reports that do not contain the last field accessed by
that format. Keep the published length zero until probe configuration is
complete, which also excludes legacy devices whose status is retrieved
through feature reports.

Suggested-by: Guenter Roeck <linux@roeck-us.net>
Fixes: 0e35f63f7f4e ("hwmon: add driver for Aquacomputer D5 Next")
Fixes: 19692f17cd13 ("hwmon: (aquacomputer_d5next) Add support for Aquacomputer Aquastream XT")
Cc: stable@vger.kernel.org
Signed-off-by: Jiale Yao <yaojiale02@163.com>
Link: https://patch.msgid.link/20261021120408.48495-1-yaojiale02@163.com
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
[ sashal: adapted report-size configuration to the supported devices and existing AQC_TEMP_SENSOR_SIZE macro ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hwmon/aquacomputer_d5next.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/hwmon/aquacomputer_d5next.c b/drivers/hwmon/aquacomputer_d5next.c
index 8c7796d3fdd2d..f192919fa3643 100644
--- a/drivers/hwmon/aquacomputer_d5next.c
+++ b/drivers/hwmon/aquacomputer_d5next.c
@@ -84,6 +84,8 @@ static u8 secondary_ctrl_report[] = {
 #define D5NEXT_5V_VOLTAGE		0x39
 #define D5NEXT_12V_VOLTAGE		0x37
 #define D5NEXT_CTRL_REPORT_SIZE		0x329
+#define D5NEXT_MIN_STATUS_REPORT_SIZE	(D5NEXT_PUMP_OFFSET + AQC_FAN_SPEED_OFFSET + \
+					 sizeof(u16))
 static u8 d5next_sensor_fan_offsets[] = { D5NEXT_PUMP_OFFSET, D5NEXT_FAN_OFFSET };
 
 /* Pump and fan speed registers in D5 Next control report (from 0-100%) */
@@ -92,12 +94,16 @@ static u16 d5next_ctrl_fan_offsets[] = { 0x97, 0x42 };
 /* Register offsets for the Farbwerk RGB controller */
 #define FARBWERK_NUM_SENSORS		4
 #define FARBWERK_SENSOR_START		0x2f
+#define FARBWERK_MIN_STATUS_REPORT_SIZE	(FARBWERK_SENSOR_START + \
+					 FARBWERK_NUM_SENSORS * AQC_TEMP_SENSOR_SIZE)
 
 /* Register offsets for the Farbwerk 360 RGB controller */
 #define FARBWERK360_NUM_SENSORS			4
 #define FARBWERK360_SENSOR_START		0x32
 #define FARBWERK360_NUM_VIRTUAL_SENSORS		16
 #define FARBWERK360_VIRTUAL_SENSORS_START	0x3a
+#define FARBWERK360_MIN_STATUS_REPORT_SIZE	(FARBWERK360_VIRTUAL_SENSORS_START + \
+					 FARBWERK360_NUM_VIRTUAL_SENSORS * AQC_TEMP_SENSOR_SIZE)
 
 /* Register offsets for the Octo fan controller */
 #define OCTO_POWER_CYCLES		0x18
@@ -107,6 +113,7 @@ static u16 d5next_ctrl_fan_offsets[] = { 0x97, 0x42 };
 #define OCTO_NUM_VIRTUAL_SENSORS	16
 #define OCTO_VIRTUAL_SENSORS_START	0x45
 #define OCTO_CTRL_REPORT_SIZE		0x65F
+#define OCTO_MIN_STATUS_REPORT_SIZE	(0xD8 + AQC_FAN_SPEED_OFFSET + sizeof(u16))
 static u8 octo_sensor_fan_offsets[] = { 0x7D, 0x8A, 0x97, 0xA4, 0xB1, 0xBE, 0xCB, 0xD8 };
 
 /* Fan speed registers in Octo control report (from 0-100%) */
@@ -121,6 +128,7 @@ static u16 octo_ctrl_fan_offsets[] = { 0x5B, 0xB0, 0x105, 0x15A, 0x1AF, 0x204, 0
 #define QUADRO_VIRTUAL_SENSORS_START	0x3c
 #define QUADRO_CTRL_REPORT_SIZE		0x3c1
 #define QUADRO_FLOW_SENSOR_OFFSET	0x6e
+#define QUADRO_MIN_STATUS_REPORT_SIZE	(0x97 + AQC_FAN_SPEED_OFFSET + sizeof(u16))
 static u8 quadro_sensor_fan_offsets[] = { 0x70, 0x7D, 0x8A, 0x97 };
 
 /* Fan speed registers in Quadro control report (from 0-100%) */
@@ -135,6 +143,7 @@ static u16 quadro_ctrl_fan_offsets[] = { 0x37, 0x8c, 0xe1, 0x136 };
 #define HIGHFLOWNEXT_CONDUCTIVITY	95
 #define HIGHFLOWNEXT_5V_VOLTAGE		97
 #define HIGHFLOWNEXT_5V_VOLTAGE_USB	99
+#define HIGHFLOWNEXT_MIN_STATUS_REPORT_SIZE	(HIGHFLOWNEXT_5V_VOLTAGE_USB + sizeof(u16))
 
 /* Labels for D5 Next */
 static const char *const label_d5next_temp[] = {
@@ -273,6 +282,7 @@ struct aqc_data {
 	enum kinds kind;
 	const char *name;
 
+	u16 min_report_size;
 	ktime_t last_ctrl_report_op;
 	int ctrl_report_delay;	/* Delay between two ctrl report operations, in ms */
 
@@ -710,6 +720,8 @@ static int aqc_raw_event(struct hid_device *hdev, struct hid_report *report, u8
 		return 0;
 
 	priv = hid_get_drvdata(hdev);
+	if (!priv->min_report_size || size < priv->min_report_size)
+		return 0;
 
 	/* Info provided with every report */
 	priv->serial_number[0] = get_unaligned_be16(data + SERIAL_FIRST_PART);
@@ -848,6 +860,7 @@ static void aqc_debugfs_init(struct aqc_data *priv)
 static int aqc_probe(struct hid_device *hdev, const struct hid_device_id *id)
 {
 	struct aqc_data *priv;
+	u16 min_report_size = 0;
 	int ret;
 
 	priv = devm_kzalloc(&hdev->dev, sizeof(*priv), GFP_KERNEL);
@@ -892,6 +905,7 @@ static int aqc_probe(struct hid_device *hdev, const struct hid_device_id *id)
 		priv->power_label = label_d5next_power;
 		priv->voltage_label = label_d5next_voltages;
 		priv->current_label = label_d5next_current;
+		min_report_size = D5NEXT_MIN_STATUS_REPORT_SIZE;
 		break;
 	case USB_PRODUCT_ID_FARBWERK:
 		priv->kind = farbwerk;
@@ -900,6 +914,7 @@ static int aqc_probe(struct hid_device *hdev, const struct hid_device_id *id)
 		priv->num_temp_sensors = FARBWERK_NUM_SENSORS;
 		priv->temp_sensor_start_offset = FARBWERK_SENSOR_START;
 		priv->temp_label = label_temp_sensors;
+		min_report_size = FARBWERK_MIN_STATUS_REPORT_SIZE;
 		break;
 	case USB_PRODUCT_ID_FARBWERK360:
 		priv->kind = farbwerk360;
@@ -912,6 +927,7 @@ static int aqc_probe(struct hid_device *hdev, const struct hid_device_id *id)
 
 		priv->temp_label = label_temp_sensors;
 		priv->virtual_temp_label = label_virtual_temp_sensors;
+		min_report_size = FARBWERK360_MIN_STATUS_REPORT_SIZE;
 		break;
 	case USB_PRODUCT_ID_OCTO:
 		priv->kind = octo;
@@ -933,6 +949,7 @@ static int aqc_probe(struct hid_device *hdev, const struct hid_device_id *id)
 		priv->power_label = label_fan_power;
 		priv->voltage_label = label_fan_voltage;
 		priv->current_label = label_fan_current;
+		min_report_size = OCTO_MIN_STATUS_REPORT_SIZE;
 		break;
 	case USB_PRODUCT_ID_QUADRO:
 		priv->kind = quadro;
@@ -955,6 +972,7 @@ static int aqc_probe(struct hid_device *hdev, const struct hid_device_id *id)
 		priv->power_label = label_fan_power;
 		priv->voltage_label = label_fan_voltage;
 		priv->current_label = label_fan_current;
+		min_report_size = QUADRO_MIN_STATUS_REPORT_SIZE;
 		break;
 	case USB_PRODUCT_ID_HIGHFLOWNEXT:
 		priv->kind = highflownext;
@@ -968,11 +986,14 @@ static int aqc_probe(struct hid_device *hdev, const struct hid_device_id *id)
 		priv->speed_label = label_highflownext_fan_speed;
 		priv->power_label = label_highflownext_power;
 		priv->voltage_label = label_highflownext_voltage;
+		min_report_size = HIGHFLOWNEXT_MIN_STATUS_REPORT_SIZE;
 		break;
 	default:
 		break;
 	}
 
+	priv->min_report_size = min_report_size;
+
 	if (priv->buffer_size != 0) {
 		priv->checksum_start = 0x01;
 		priv->checksum_length = priv->buffer_size - 3;
-- 
2.53.0

