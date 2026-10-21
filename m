Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792584279;
	b=LFON9x5ojHdNA5IbbEZdiEzs3plRz2n8sNMbfdHH8PN+cvhsxNl6mqCPOl5HdbswfWbs
	 PAcWW/ghd0sp2RMDvOFmItGrIpHLFlF1GfrKp9mfZmhCykAyZj8mXSO7CPuOOXd2vQLoi
	 2v3FZ/kvmNqmKE6h/9L485XnAHpaI5FJkmX/ncjV0xd9AltchroiRTCkfekFBtOBfj8MZ
	 R7dizofP+dopAxXlUOxU6wptPsAxiDMAd/AfkCJn6XJSzjfsnWmZjRM5iRwDCXClRR+LJ
	 b6qrfUPDNyEeVY6eLnq7OHZo0eVyylyCmvk4PvEfnngeLZqdx+2Ga2cl7t17nph1LwA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792584279;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=AwtIHnGzW3tKZfbYrcOGSQoJdi/ADFfIlP9FOFh7OYA=;
	b=eANwNxhkniDWlvCOLAdAN7kANPDZairebtBXx7cevppJ9lfKGd9xoeGX1fInpGiSMZJ9
	 efTWbRLX4DrGgSmwuECS5KvvXirk/bqS8kfmfaRaNIbqmzqN9NTWio86YNf9KNtfyr4De
	 OWy0yEc40ZukG1bFWwgIrcuLTq+p/gcColUwu7G1Vvwwl+eGY0mkXOrKu+dZmaAqj6/pV
	 76P8Yi6Corc8Jwqu7ODoPNVFHO7V6ot75pkmuOY5qsSJwhePt8UQq1RORXoOXnEePP6jw
	 KsbHf4qd5z9P+oJ+dMDFB0LeE7vTDIzTBBcIdGYEFKnjozQo9ff1vQEPiQttWg4EqUQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=BeNh1aud;
	arc=none smtp.remote-ip=117.135.210.4
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFCD6606A319;
	Wed, 21 Oct 2026 12:04:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DFCD6606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=BeNh1aud
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Aw
	tIHnGzW3tKZfbYrcOGSQoJdi/ADFfIlP9FOFh7OYA=; b=BeNh1aud3QJiybpaL8
	6BvRSQxrZ5uKr4tLK01heBjW6dx9K+jpbhFth6n7bfU2k3phCed9AMuzvFo7lTrH
	vi+AaGZfJKbzGUg/abXqUgyan+bX2aCxpPGtuZ0m/qALns5tL/81hI/e2NaRHJDc
	zvH7RhA4o8uJZnzzXH/P8s+qs=
Received: from pc.localdomain (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wD3n9U5qthqkt7RBQ--.900S2;
	Wed, 21 Oct 2026 20:04:10 +0800 (CST)
From: Jiale Yao <yaojiale02@163.com>
To: Aleksa Savic <savicaleksa83@gmail.com>,
	Jack Doan <me@jackdoan.com>,
	Guenter Roeck <linux@roeck-us.net>,
	linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH v2] hwmon: (aquacomputer_d5next) reject short status reports
Date: Wed, 21 Oct 2026 20:04:07 +0800
Message-Id: <20261021120408.48495-1-yaojiale02@163.com>
X-Mailer: git-send-email 2.34.1
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
X-CM-TRANSID:_____wD3n9U5qthqkt7RBQ--.900S2
X-Coremail-Antispam: 1Uf129KBjvJXoWfJr45Aw15Wr15ZrW7ArykAFb_yoWDAF4Up3
	4DAF9xtFWUKFWI939xJFs8uw4FyrZrKa1UXrnrGw40gF98W34UCFWIvayqvryrZrZ5trZ8
	K390qrWDAasxWF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jOJ5rUUUUU=
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbCzhqJw2rYqjoydwAA35

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
Cc: stable@vger.kernel.org
Signed-off-by: Jiale Yao <yaojiale02@163.com>
---
Changes in v2:
- Replace the HID descriptor length check with per-device minimum lengths
  derived from the final field accessed.
- Select each minimum length in the existing per-device probe branch.
- Keep the published length zero until probe configuration is complete and
  exclude legacy feature-report devices from the asynchronous parser.
- Drop the inaccurate hid-asus comparison from the commit message.

 drivers/hwmon/aquacomputer_d5next.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/hwmon/aquacomputer_d5next.c b/drivers/hwmon/aquacomputer_d5next.c
index 1ca70e726298..341cce4347e2 100644
--- a/drivers/hwmon/aquacomputer_d5next.c
+++ b/drivers/hwmon/aquacomputer_d5next.c
@@ -132,6 +132,7 @@ static u8 aquaero_secondary_ctrl_report[] = {
 #define AQUAERO_FAN_CURRENT_OFFSET		0x06
 #define AQUAERO_FAN_POWER_OFFSET		0x08
 #define AQUAERO_FAN_SPEED_OFFSET		0x00
+#define AQUAERO_MIN_STATUS_REPORT_SIZE		(0x18B + AQUAERO_FAN_POWER_OFFSET + sizeof(u16))
 static u16 aquaero_sensor_fan_offsets[] = { 0x167, 0x173, 0x17f, 0x18B };
 
 /* Control report offsets for the Aquaero fan controllers */
@@ -155,6 +156,8 @@ static u16 aquaero_ctrl_fan_offsets[] = { 0x20c, 0x220, 0x234, 0x248 };
 #define D5NEXT_5V_VOLTAGE		0x39
 #define D5NEXT_12V_VOLTAGE		0x37
 #define D5NEXT_VIRTUAL_SENSORS_START	0x3f
+#define D5NEXT_MIN_STATUS_REPORT_SIZE	(D5NEXT_PUMP_OFFSET + AQC_FAN_SPEED_OFFSET + \
+					 sizeof(u16))
 static u16 d5next_sensor_fan_offsets[] = { D5NEXT_PUMP_OFFSET, D5NEXT_FAN_OFFSET };
 
 /* Control report offsets for the D5 Next pump */
@@ -179,11 +182,14 @@ static u16 d5next_ctrl_fan_offsets[] = { 0x97, 0x42 };	/* Pump and fan speed (fr
 #define AQUASTREAMULT_FAN_CURRENT_OFFSET	0x00
 #define AQUASTREAMULT_FAN_POWER_OFFSET		0x04
 #define AQUASTREAMULT_FAN_SPEED_OFFSET		0x06
+#define AQUASTREAMULT_MIN_STATUS_REPORT_SIZE	(AQUASTREAMULT_PRESSURE_OFFSET + sizeof(u16))
 static u16 aquastreamult_sensor_fan_offsets[] = { AQUASTREAMULT_FAN_OFFSET };
 
 /* Spec and sensor report offset for the Farbwerk RGB controller */
 #define FARBWERK_NUM_SENSORS		4
 #define FARBWERK_SENSOR_START		0x2f
+#define FARBWERK_MIN_STATUS_REPORT_SIZE	(FARBWERK_SENSOR_START + \
+					 FARBWERK_NUM_SENSORS * AQC_SENSOR_SIZE)
 
 /* Specs of the Farbwerk 360 RGB controller */
 #define FARBWERK360_NUM_SENSORS			4
@@ -193,6 +199,8 @@ static u16 aquastreamult_sensor_fan_offsets[] = { AQUASTREAMULT_FAN_OFFSET };
 /* Sensor report offsets for the Farbwerk 360 */
 #define FARBWERK360_SENSOR_START		0x32
 #define FARBWERK360_VIRTUAL_SENSORS_START	0x3a
+#define FARBWERK360_MIN_STATUS_REPORT_SIZE	(FARBWERK360_VIRTUAL_SENSORS_START + \
+					 FARBWERK360_NUM_VIRTUAL_SENSORS * AQC_SENSOR_SIZE)
 
 /* Control report offsets for the Farbwerk 360 */
 #define FARBWERK360_TEMP_CTRL_OFFSET		0x8
@@ -209,6 +217,7 @@ static u16 aquastreamult_sensor_fan_offsets[] = { AQUASTREAMULT_FAN_OFFSET };
 #define OCTO_SENSOR_START		0x3D
 #define OCTO_VIRTUAL_SENSORS_START	0x45
 #define OCTO_FLOW_SENSOR_OFFSET		0x7B
+#define OCTO_MIN_STATUS_REPORT_SIZE	(0xD8 + AQC_FAN_SPEED_OFFSET + sizeof(u16))
 static u16 octo_sensor_fan_offsets[] = { 0x7D, 0x8A, 0x97, 0xA4, 0xB1, 0xBE, 0xCB, 0xD8 };
 
 /* Control report offsets for the Octo */
@@ -229,6 +238,7 @@ static u16 octo_ctrl_fan_offsets[] = { 0x5B, 0xB0, 0x105, 0x15A, 0x1AF, 0x204, 0
 #define QUADRO_SENSOR_START		0x34
 #define QUADRO_VIRTUAL_SENSORS_START	0x3c
 #define QUADRO_FLOW_SENSOR_OFFSET	0x6e
+#define QUADRO_MIN_STATUS_REPORT_SIZE	(0x97 + AQC_FAN_SPEED_OFFSET + sizeof(u16))
 static u16 quadro_sensor_fan_offsets[] = { 0x70, 0x7D, 0x8A, 0x97 };
 
 /* Control report offsets for the Quadro */
@@ -248,6 +258,7 @@ static u16 quadro_ctrl_fan_offsets[] = { 0x37, 0x8c, 0xe1, 0x136 }; /* Fan speed
 #define HIGHFLOWNEXT_CONDUCTIVITY	95
 #define HIGHFLOWNEXT_5V_VOLTAGE		97
 #define HIGHFLOWNEXT_5V_VOLTAGE_USB	99
+#define HIGHFLOWNEXT_MIN_STATUS_REPORT_SIZE	(HIGHFLOWNEXT_5V_VOLTAGE_USB + sizeof(u16))
 
 /* Specs of the Leakshield */
 #define LEAKSHIELD_NUM_SENSORS		2
@@ -263,6 +274,7 @@ static u16 quadro_ctrl_fan_offsets[] = { 0x37, 0x8c, 0xe1, 0x136 }; /* Fan speed
 #define LEAKSHIELD_FLOW_IN		111
 #define LEAKSHIELD_RESERVOIR_VOLUME	313
 #define LEAKSHIELD_RESERVOIR_FILLED	311
+#define LEAKSHIELD_MIN_STATUS_REPORT_SIZE	(LEAKSHIELD_RESERVOIR_VOLUME + sizeof(u16))
 
 /* Specs of the Aquastream XT pump */
 #define AQUASTREAMXT_SERIAL_START		0x3a
@@ -554,6 +566,7 @@ struct aqc_data {
 	const char *name;
 
 	int status_report_id;	/* Used for legacy devices, report is stored in buffer */
+	u16 min_report_size;
 	int ctrl_report_id;
 	int secondary_ctrl_report_id;
 	int secondary_ctrl_report_size;
@@ -1333,6 +1346,8 @@ static int aqc_raw_event(struct hid_device *hdev, struct hid_report *report, u8
 		return 0;
 
 	priv = hid_get_drvdata(hdev);
+	if (!priv->min_report_size || size < priv->min_report_size)
+		return 0;
 
 	/* Info provided with every report */
 	priv->serial_number[0] = get_unaligned_be16(data + priv->serial_number_start_offset);
@@ -1518,6 +1533,7 @@ static void aqc_debugfs_init(struct aqc_data *priv)
 static int aqc_probe(struct hid_device *hdev, const struct hid_device_id *id)
 {
 	struct aqc_data *priv;
+	u16 min_report_size = 0;
 	int ret;
 
 	priv = devm_kzalloc(&hdev->dev, sizeof(*priv), GFP_KERNEL);
@@ -1585,6 +1601,7 @@ static int aqc_probe(struct hid_device *hdev, const struct hid_device_id *id)
 		priv->power_label = label_fan_power;
 		priv->voltage_label = label_fan_voltage;
 		priv->current_label = label_fan_current;
+		min_report_size = AQUAERO_MIN_STATUS_REPORT_SIZE;
 		break;
 	case USB_PRODUCT_ID_D5NEXT:
 		priv->kind = d5next;
@@ -1610,6 +1627,7 @@ static int aqc_probe(struct hid_device *hdev, const struct hid_device_id *id)
 		priv->power_label = label_d5next_power;
 		priv->voltage_label = label_d5next_voltages;
 		priv->current_label = label_d5next_current;
+		min_report_size = D5NEXT_MIN_STATUS_REPORT_SIZE;
 		break;
 	case USB_PRODUCT_ID_FARBWERK:
 		priv->kind = farbwerk;
@@ -1620,6 +1638,7 @@ static int aqc_probe(struct hid_device *hdev, const struct hid_device_id *id)
 		priv->temp_sensor_start_offset = FARBWERK_SENSOR_START;
 
 		priv->temp_label = label_temp_sensors;
+		min_report_size = FARBWERK_MIN_STATUS_REPORT_SIZE;
 		break;
 	case USB_PRODUCT_ID_FARBWERK360:
 		priv->kind = farbwerk360;
@@ -1636,6 +1655,7 @@ static int aqc_probe(struct hid_device *hdev, const struct hid_device_id *id)
 
 		priv->temp_label = label_temp_sensors;
 		priv->virtual_temp_label = label_virtual_temp_sensors;
+		min_report_size = FARBWERK360_MIN_STATUS_REPORT_SIZE;
 		break;
 	case USB_PRODUCT_ID_OCTO:
 		priv->kind = octo;
@@ -1665,6 +1685,7 @@ static int aqc_probe(struct hid_device *hdev, const struct hid_device_id *id)
 		priv->power_label = label_fan_power;
 		priv->voltage_label = label_fan_voltage;
 		priv->current_label = label_fan_current;
+		min_report_size = OCTO_MIN_STATUS_REPORT_SIZE;
 		break;
 	case USB_PRODUCT_ID_QUADRO:
 		priv->kind = quadro;
@@ -1694,6 +1715,7 @@ static int aqc_probe(struct hid_device *hdev, const struct hid_device_id *id)
 		priv->power_label = label_fan_power;
 		priv->voltage_label = label_fan_voltage;
 		priv->current_label = label_fan_current;
+		min_report_size = QUADRO_MIN_STATUS_REPORT_SIZE;
 		break;
 	case USB_PRODUCT_ID_HIGHFLOWNEXT:
 		priv->kind = highflownext;
@@ -1711,6 +1733,7 @@ static int aqc_probe(struct hid_device *hdev, const struct hid_device_id *id)
 		priv->speed_label = label_highflownext_fan_speed;
 		priv->power_label = label_highflownext_power;
 		priv->voltage_label = label_highflownext_voltage;
+		min_report_size = HIGHFLOWNEXT_MIN_STATUS_REPORT_SIZE;
 		break;
 	case USB_PRODUCT_ID_LEAKSHIELD:
 		/*
@@ -1730,6 +1753,7 @@ static int aqc_probe(struct hid_device *hdev, const struct hid_device_id *id)
 
 		priv->temp_label = label_leakshield_temp_sensors;
 		priv->speed_label = label_leakshield_fan_speed;
+		min_report_size = LEAKSHIELD_MIN_STATUS_REPORT_SIZE;
 		break;
 	case USB_PRODUCT_ID_AQUASTREAMXT:
 		priv->kind = aquastreamxt;
@@ -1760,6 +1784,7 @@ static int aqc_probe(struct hid_device *hdev, const struct hid_device_id *id)
 		priv->power_label = label_aquastreamult_power;
 		priv->voltage_label = label_aquastreamult_voltages;
 		priv->current_label = label_aquastreamult_current;
+		min_report_size = AQUASTREAMULT_MIN_STATUS_REPORT_SIZE;
 		break;
 	case USB_PRODUCT_ID_POWERADJUST3:
 		priv->kind = poweradjust3;
@@ -1833,6 +1858,8 @@ static int aqc_probe(struct hid_device *hdev, const struct hid_device_id *id)
 		break;
 	}
 
+	priv->min_report_size = min_report_size;
+
 	if (priv->buffer_size != 0) {
 		priv->checksum_start = 0x01;
 		priv->checksum_length = priv->buffer_size - 3;

base-commit: a804c5742bff224d4cb4d25dd383554d598be32b
-- 
2.34.1

