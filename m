Received: from mail-qk2-f42.google.com (mail-qk2-f42.google.com [74.125.230.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CB424AF67D
	for <stable@vger.kernel.org>; Mon, 28 Sep 2026 11:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790595676; cv=none; b=BG/N1Ki/2aqBOB2KIaocPDto65x7MeGkXQz1G2CO+tmSSDcdTrTjaTFJQABAL6+YA6B6YmpGu4SorS57w5yaMMMqSZ4ip8yW0wQJepLhqOTEggUnZAWE0W8T9ZFzAmuPe5yHBFNC1UMsB0xn+h7v/fkZO52bSdLf1/zb0MdvfXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790595676; c=relaxed/simple;
	bh=tCyaVRK+OMgeWNDYxyRY3jzF8TBkGr6Wl3eti3U+l8E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tlNLwkjQ1z5wr7IqzXaOJLvlCTl+2XrCXY9eLNFTsQQPE7yPPGBnR4JS6spAUs0g5SwWBPsRBmE9cHGDgdptSU4zggaHWaH9np3nQXQHanz61oTbaqXCii+RP/3/TCYFvSBKDL0DW7CD1+X0gYXf8tguf3DZCOtXYSUGwXv7hZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lu+Plz7I; arc=none smtp.client-ip=74.125.230.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lu+Plz7I"
Received: by mail-qk2-f42.google.com with SMTP id d75a77b69052e-53320dc09f3so19919941cf.1
        for <stable@vger.kernel.org>; Mon, 28 Sep 2026 04:41:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790595673; x=1791200473; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eVdh45ZUj7FnpRC6Q2Foio9VZd4+GVrW1sEPilA+/sQ=;
        b=lu+Plz7Ia8w1lYqdNo6Zh+IaXwcRLpBHD8vQrkEPvX07OCBRDMzUPd6HH288OJefPY
         Ipi3RzcbfUmdz6l7vwVl+TKqfUf84oTBwAlnyYF1zzV6FA6oNb0M4Z1CMjmnA517iE8F
         efo31LHAugnH5uxaHzvzNbKeBuWqQYFa9EeV+Nejnc9QkuO9kP5BMypG1UyszOLQL6hG
         JoxJwDoUtpAYj+3ANxzdCpuI3QZCgqD4y6L7K1N2mafHgZMA4xVJDAmmv1w0CitqWJzM
         vULjattHt1xgcwT8wovPcceJ7dbiqOLuKbQ5EXixI0JfModY3RFPfxKiqYIbWL6GaCUV
         jzQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790595673; x=1791200473;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=eVdh45ZUj7FnpRC6Q2Foio9VZd4+GVrW1sEPilA+/sQ=;
        b=gfd+dC22mbmf5i6fFXPIH9NYpHVLhdrik9hbODw7TiN+lhLtsmqSnn4hn3hxFfeNQj
         0O+FJFoisuXKwmY0KhFBQQvLobeL1wfQTeqHB055hPlyhFP84J6VR6j4Gf/nvgWA93mv
         oy58OdzCUF5ISuHp3zhTqXixVHO2l3JItIKq5bwEO77UnPhQ7pNj0SXT6AoQwcuGIWx7
         i7NSGeRS+USJdsriwNdvi56O6qgMowlj9ivMMZLcfrlW0JfdjRVGTvcDIAX+ZmDNKIUN
         KLbbpZBXv8QYotrONGrsWQG9v9vp54MvYbNjfpFWTU9a7eNPAt3b1OAAtTD1qz5E3JrL
         /nGA==
X-Forwarded-Encrypted: i=1; AKwUvBxGJpiB8l0I3C+mVenD9pWP9f2WYkl12hQ64vWGEwYUayFsBFZBuFip1zls+5ZCeuvgstrsxuM=@vger.kernel.org
X-Gm-Message-State: AFuF++nra1AfygoJuftXI8jDrTcy3h27l8RpxhLaBqGkAHfobkK6IW8J
	sS1s41nQ9Qb3WMx0nN+h25ujKhn/P845jEG6NHOSzZI2qlDnGHko8F0e
X-Gm-Gg: AYBFou2LN7TX7yG+qe0rGNXrMalu7YFVt37aQXr7D/olxvSa4yvYzyTw3Wpkx+al6wD
	4D1McO867CUcraE94ms3ISiKVRlFcqJrrRIkSdCw3DR2TvQViyqMnTdeeeP0BWt1Y/XLEjfM8wk
	Nb2dwAHb+0obHkdpCoP3tV0CSDQktu/H6ZKAC1aU6AyCszIajjaYLQRDI5rHvkW2f5K+sjIW4cO
	qevB1WV2avl+pAZ5jiykrwLdxpl21MxhnW51IQ3Qls4+0EzQf6ihMRwgCdYel+zEPGCU+5rk8w4
	EisNzjz+TPSu9yFB2SDoDzRvaqXxI8nbOnDcHb7RpTT/xRFiiSZkBIInFTXCtvsDAr8oT7w5Lih
	qJ6wXT3M7ZlrHczwk0Agew2qJHUzuTGDm7TMzDfAJF9x1vA5m1tJibPy8/IEP6oWrf+q5Ibj7PT
	2TlbVUCswCd4fJTD1NketdzgQAH/sX/b4eqMZgRIVZiehhzydxULsnV7ustASOTN22yMQW2daJH
	KGgxK2+K6qGwdJACPynZk/DK0j25CUTzeW0pFEJfRkxWBSUGlRYZ+k=
X-Received: by 2002:a05:622a:1aa8:b0:530:dc10:4422 with SMTP id d75a77b69052e-5330b555c5fmr220930081cf.10.1790595672860;
        Mon, 28 Sep 2026 04:41:12 -0700 (PDT)
Received: from Z-System.tailddad04.ts.net (c-68-83-199-219.hsd1.mi.comcast.net. [68.83.199.219])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-53322132f3dsm60937351cf.8.2026.09.28.04.41.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 04:41:12 -0700 (PDT)
From: Zac Lanzon <lanzonza@gmail.com>
To: linux-hwmon@vger.kernel.org
Cc: Guenter Roeck <linux@roeck-us.net>,
	Aleksa Savic <savicaleksa83@gmail.com>,
	Edward Blair <edward.blair@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zac Lanzon <lanzonza@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 1/2] hwmon: (asus_rog_ryujin) Fix pump control source on the Ryujin III
Date: Mon, 28 Sep 2026 07:41:05 -0400
Message-ID: <7ca8fe6cd6b4125813613bd4187ff6cdda72e4b6.1790512964.git.lanzonza@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1790512964.git.lanzonza@gmail.com>
References: <cover.1790512964.git.lanzonza@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The RYUJIN III pump has a 4-pin cable for a motherboard fan header in
addition to USB. Byte 2 of the set cooler duty command selects the pump
control source: 0 hands the pump to its internal controller, which
follows the PWM of the header its 4-pin cable is plugged into, and 1
makes it follow the pump duty in byte 3. Byte 3 of the cooler duty
report returns the current source.

The driver fills byte 2 with duty_channel, which is 1 for the RYUJIN
III, and a pwm2 write re-sends the reported pump duty with the new fan
duty. So writing only the internal fan duty takes the pump away from
its internal controller.

Measured on a RYUJIN III 360 (firmware AURJ2-S750-0108) with the pump
cable on AIO_PUMP and the header PWM set through nct6775, after loading
the driver with the pump on its internal controller (pump rpm):

                                   header 50%   header 80%   source
  no write yet                        2160         3090         0
  pwm2 = 40%, before this patch       1740         1740         1
  pwm2 = 40%, with this patch         2130         3090         0

Send the reported source with pwm2 writes. The fan duty applies with
either source (40%: 1545 to 1590 rpm, 30%: 870 rpm). A pwm2 write sent
right after a pwm1 write that took the pump over, before the report
could show the change, left the pump on USB and applied its fan duty
(2 of 2 trials, and 7 of 7 with raw commands up to 0.9 s after).

pwm1 writes keep selecting source 1. The cooler reports the pump duty of
the last write, whichever source it selected, and 40% after power-on.
Byte 9 of the status report follows the duty the pump runs at. Measured
from power-on (PSU switched off) once per driver, with the header at
100%:

                                  before this patch   with this patch
                                  source duty  rpm    source duty  rpm
  no write yet                       0    100  3570      0    100  3570
  pwm2 = 40%                         1    100  3570      0    100  3570
  pwm1 = 40%, the reported duty      1    100  3570      1     40  1710
  pwm1 = 60%                         1     60  2430
  pwm1 = 40%                         1     40  1725

So a pwm1 write of the reported duty did not reach the pump, while
other duties applied in one write, also when taking the pump from its
internal controller (60%: 2460 rpm). When a pwm1 write requests the
reported duty, write a duty 1% away first (below at 100%), then the
requested one. Sent back to back, the two writes left the pump at the
requested duty in all 19 trials, 9 with raw commands and 10 through
this driver.

Tested on the RYUJIN III 360 only. The EXTREME, EVA and WHITE EDITION
use the same rog_ryujin_iii_info and send the same command, and Edward
Blair's analysis of the WHITE EDITION firmware shows the same pump
control source. The RYUJIN II, whose duty_channel is 0, is unchanged.

Fixes: cd258aca0dc4 ("hwmon: (asus_rog_ryujin) Add ROG Ryujin III support")
Closes: https://github.com/aleksamagicka/asus_rog_ryujin-hwmon/issues/12
Suggested-by: Edward Blair <edward.blair@gmail.com>
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Zac Lanzon <lanzonza@gmail.com>
---
 Documentation/hwmon/asus_rog_ryujin.rst |  6 +++
 drivers/hwmon/asus_rog_ryujin.c         | 54 ++++++++++++++++++++++++-
 2 files changed, 59 insertions(+), 1 deletion(-)

diff --git a/Documentation/hwmon/asus_rog_ryujin.rst b/Documentation/hwmon/asus_rog_ryujin.rst
index 3ebab230e8c..fe072e94d87 100644
--- a/Documentation/hwmon/asus_rog_ryujin.rst
+++ b/Documentation/hwmon/asus_rog_ryujin.rst
@@ -34,6 +34,12 @@ Usage notes
 As these are USB HIDs, the driver can be loaded automatically by the kernel and
 supports hot swapping.
 
+The pump of the RYUJIN III also has a 4-pin cable for a motherboard fan header.
+The cooler either hands the pump to its internal controller, which follows the
+PWM of the header its 4-pin cable is plugged into, or runs it at the pump duty
+set over USB. Writing pwm1 selects the duty set over USB. Writing pwm2 sets
+only the internal fan duty and leaves the pump control as it is.
+
 Sysfs entries
 -------------
 
diff --git a/drivers/hwmon/asus_rog_ryujin.c b/drivers/hwmon/asus_rog_ryujin.c
index 5ced69e94ea..ba188e86793 100644
--- a/drivers/hwmon/asus_rog_ryujin.c
+++ b/drivers/hwmon/asus_rog_ryujin.c
@@ -50,6 +50,7 @@ static const struct rog_ryujin_device_info rog_ryujin_iii_info = {
 #define MAX_REPORT_LENGTH	65
 
 /* Cooler duty report offsets */
+#define RYUJIN_PUMP_SOURCE		3
 #define RYUJIN_PUMP_DUTY		4
 #define RYUJIN_INTERNAL_FAN_DUTY	5
 
@@ -70,10 +71,15 @@ static const u8 get_cooler_duty_cmd[] = { RYUJIN_CMD_PREFIX, 0x9A };
 static const u8 get_controller_speed_cmd[] = { RYUJIN_CMD_PREFIX, 0xA0 };
 static const u8 get_controller_duty_cmd[] = { RYUJIN_CMD_PREFIX, 0xA1 };
 
+#define RYUJIN_SET_COOLER_CHANNEL_OFFSET	2
 #define RYUJIN_SET_COOLER_PUMP_DUTY_OFFSET	3
 #define RYUJIN_SET_COOLER_FAN_DUTY_OFFSET	4
 static const u8 set_cooler_duty_cmd[] = { RYUJIN_CMD_PREFIX, 0x1A, 0x00, 0x00, 0x00 };
 
+/* Pump control sources in the set cooler duty command and the cooler duty report */
+#define RYUJIN_SOURCE_HEADER	0
+#define RYUJIN_SOURCE_USB	1
+
 #define RYUJIN_SET_CONTROLLER_FAN_DUTY_OFFSET	4
 static const u8 set_controller_duty_cmd[] = { RYUJIN_CMD_PREFIX, 0x21, 0x00, 0x00, 0x00 };
 
@@ -117,6 +123,7 @@ struct rog_ryujin_data {
 	s32 temp_input[1];
 	u16 speed_input[6];	/* Pump, internal fan and four controller fan speeds in RPM */
 	u8 duty_input[3];	/* Pump, internal fan and controller fan duty in PWM */
+	u8 pump_source;		/* Pump control source from the cooler duty report */
 
 	u8 *buffer;
 	unsigned long updated;	/* jiffies */
@@ -306,6 +313,44 @@ static int rog_ryujin_read_string(struct device *dev, enum hwmon_sensor_types ty
 	return 0;
 }
 
+/*
+ * On devices with a non-zero duty_channel (the RYUJIN III), the channel byte of
+ * the set cooler duty command selects the pump control source.
+ * RYUJIN_SOURCE_HEADER hands the pump to its internal controller, which follows
+ * the PWM of the header its 4-pin cable is plugged into. RYUJIN_SOURCE_USB
+ * makes the pump follow the pump duty in the command. The cooler duty report
+ * returns the current source.
+ *
+ * A fan duty write sends the reported source back, so that it leaves the pump
+ * control source as it is. A pump duty write selects USB. The cooler does not
+ * pass on a pump duty equal to the one it reports, and after power-on it
+ * reports 40% while a pump handed over at that duty runs at full speed. So
+ * when a pump duty write asks for the reported duty, write a duty 1% away
+ * first.
+ */
+static int rog_ryujin_select_pump_source(struct rog_ryujin_data *priv, u8 *set_cmd,
+					 int channel)
+{
+	u8 duty = set_cmd[RYUJIN_SET_COOLER_PUMP_DUTY_OFFSET];
+	int ret;
+
+	if (channel == 1) {
+		set_cmd[RYUJIN_SET_COOLER_CHANNEL_OFFSET] = priv->pump_source;
+		return 0;
+	}
+
+	set_cmd[RYUJIN_SET_COOLER_CHANNEL_OFFSET] = RYUJIN_SOURCE_USB;
+
+	if (duty != rog_ryujin_pwm_to_percent(priv->duty_input[0]))
+		return 0;
+
+	set_cmd[RYUJIN_SET_COOLER_PUMP_DUTY_OFFSET] = duty < 100 ? duty + 1 : duty - 1;
+	ret = rog_ryujin_execute_cmd(priv, set_cmd, SET_CMD_LENGTH, &priv->cooler_duty_set);
+	set_cmd[RYUJIN_SET_COOLER_PUMP_DUTY_OFFSET] = duty;
+
+	return ret;
+}
+
 static int rog_ryujin_write_fixed_duty(struct rog_ryujin_data *priv, int channel, int val)
 {
 	u8 set_cmd[SET_CMD_LENGTH];
@@ -323,7 +368,7 @@ static int rog_ryujin_write_fixed_duty(struct rog_ryujin_data *priv, int channel
 			return ret;
 
 		memcpy(set_cmd, set_cooler_duty_cmd, SET_CMD_LENGTH);
-		set_cmd[2] = priv->info->duty_channel;
+		set_cmd[RYUJIN_SET_COOLER_CHANNEL_OFFSET] = priv->info->duty_channel;
 
 		/* Cooler duties are set as 0-100% */
 		val = rog_ryujin_pwm_to_percent(val);
@@ -340,6 +385,12 @@ static int rog_ryujin_write_fixed_duty(struct rog_ryujin_data *priv, int channel
 			set_cmd[RYUJIN_SET_COOLER_FAN_DUTY_OFFSET] = val;
 		}
 
+		if (priv->info->duty_channel) {
+			ret = rog_ryujin_select_pump_source(priv, set_cmd, channel);
+			if (ret < 0)
+				return ret;
+		}
+
 		return rog_ryujin_execute_cmd(priv, set_cmd, SET_CMD_LENGTH, &priv->cooler_duty_set);
 	} else {
 		/*
@@ -482,6 +533,7 @@ static int rog_ryujin_raw_event(struct hid_device *hdev, struct hid_report *repo
 			goto unlock;
 		}
 read_cooler_duty:
+		priv->pump_source = data[RYUJIN_PUMP_SOURCE];
 		priv->duty_input[0] = rog_ryujin_percent_to_pwm(data[RYUJIN_PUMP_DUTY]);
 		priv->duty_input[1] = rog_ryujin_percent_to_pwm(data[RYUJIN_INTERNAL_FAN_DUTY]);
 
-- 
2.53.0

