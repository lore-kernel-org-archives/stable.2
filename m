Received: from mail-vs2-f12.google.com (mail-vs2-f12.google.com [74.125.227.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 580683C3BEE
	for <stable@vger.kernel.org>; Tue, 15 Sep 2026 04:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789446362; cv=none; b=gth3PD1o1kPjm+yE+cWH2dKJVk310Qjn5MCuJbG/xh15mBXu7ALhMwmMLsRGAcJbMxYsYu1h4EWP1g4khrKOKl9H4U2oKU6tqPNInQMSTsRo3zEpTlapfnYeoTc9Cq3r8RP89KM7jAyAppFBIZbWM+Kcv4QfBsNdGVL8K8SKmr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789446362; c=relaxed/simple;
	bh=goGTypsi29JZv923WshNeFTqi7KVaLuvDV7JqWYQbF0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MImn05tvU++6ibL7Ceo2S5l+EuxIqeBX3MerDqbp5IO+QW7z/LWKskkChyJUENt6b1ehRCykQbno8P/rzzPyMPwG+rWU173qem2JGD2PJ1acvY/emOtMSwSB2sQUlHtjl2jgV7cftPjrPJbCdtJ6COvdRXF/hdPO6baHnPao+G8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UZuuuQPA; arc=none smtp.client-ip=74.125.227.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UZuuuQPA"
Received: by mail-vs2-f12.google.com with SMTP id 71dfb90a1353d-5c67e5059faso725870e0c.0
        for <stable@vger.kernel.org>; Mon, 14 Sep 2026 21:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789446359; x=1790051159; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xgksxHZM5YdiC9WvlT9cN3WzyS9QqUuMDDleGgoWHKM=;
        b=UZuuuQPA6Qlo0gkEqBrOZn0itUkGeSpcCdDculk8DEHH9whyEc+HdMu3XKcK/T/hre
         4LRIOKa6XuWhbue/cKrE7engVZDUdpzuoiX3U59+lvuXOLn3CDXFQNfBuPSLcqxMi+2I
         sn1T6TAZyLU1SFWDJydgeTt3T8LnNQucSyBSfIMA5GyM0ZUwoNbP7MMDmhFUObJ7Msnw
         tV5XXzMSCLbL40Jumlw+zXTVeoS1MhP6EZyilfwz5E9rmqEQlxWqGyguxKC6p/1Y2DMc
         KRwfFHO7lP6KyJb6lxmwDom3BwKa6kd6KSVNww+H/JIDVs7YC2iDlCTS3b1N3eHoCF9Q
         rCLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789446359; x=1790051159;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xgksxHZM5YdiC9WvlT9cN3WzyS9QqUuMDDleGgoWHKM=;
        b=NKuPS2xXaTLqAD5cf/9/KxQXR8EaDlcPIoO9HpJfeti+LMhwvOVoP+JC/tlfA7rM2Z
         pa5ojTDK7zR67J3SmKzMR9Qu6pJJUFnh4G2YmM+OZ6thRAejmnp5nN/A3ni8S0sLlakW
         b8f9XkRWBa9qCftEh5MGQ5qTo/0Y3Pe568Gk0mRmR46av+Tt4jCWjzD6+0pr2ZMhot/N
         u6KKoTX1wq2eJFcKdRyQ/7jTsX97PyreyYqOKf6Go5XvPNlgyF2MhFjdic67JC9fadiW
         x60hsnPY7IZRXJapAC05/dtqE+s9WrEwXc46znY7RYn3TrSn0hdWXnHik/HQs3JJXRcT
         0Ymg==
X-Forwarded-Encrypted: i=1; AKwUvBxCU7uT7NXYbGi0+6fgr63/dGhQGmlHkW556BzIxSdD/D+5Q4wMDc1g2nhbb/+4CeVjjTuzp68=@vger.kernel.org
X-Gm-Message-State: AFuF++mYC0o5QqAC0mBIO3KBWmrFsIKdk7QOTNfYI3qV8NNTfG5uH6U4
	zfZ997OQlPtwXTrcnUQhSfr8exi4hQSQeGvJ+ILRUKFC8Fo+bHkWpFXkygv3TX2IwaTCSA==
X-Gm-Gg: AYBFou26EO6vCnFC+W5mOT2/yQrjIchcyenmOSXEAJdR1j9XNrKW7RV60s+xECePE6p
	GJv2tnXdlSoVgnxVSj4XPvlzLbTOtgTn3/xJcqOSsIWj7gp/DEFoM2a23bGVU8ogmRPuuLpzMi7
	gS6TuyRxBVUbYyOzKhkoJgXswIYNEhjMGmxX221qDhe5CKGwJtQImKbrAsd4reDNxSQWFtcqlBV
	VAqQhRYaXt9OPq+l0EMFUl12iPuFgpmqOEDRzkTb2H6VaqloXznFh55trbNId9gIJntNV/ikEwl
	WdNXiiFjEoF+mUhG8o6zA/UGTQPwAginOvikFViVkZGB/6oqXg0ysKg0Ma8sH1K3/hrh6sKZazD
	bENj2U1WiNJzUDpghtIhAeGnbHu7mmAxflhsXVSsdhy1K94xWNWvk2howVA2IIsSdOL3hQw1779
	OuMPuahwGg8I3o2vM45PLk5rBwNcLWX4/N3ute1HMeVZzskVqiIU04Q4BOTpd2yB/3
X-Received: by 2002:a05:6122:e266:b0:5bf:a179:b2be with SMTP id 71dfb90a1353d-5c9820e55eamr8036213e0c.7.1789446359087;
        Mon, 14 Sep 2026 21:25:59 -0700 (PDT)
Received: from beelink.. ([187.13.206.89])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5c8470e7ef4sm14528090e0c.9.2026.09.14.21.25.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 21:25:58 -0700 (PDT)
From: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: Ping Cheng <ping.cheng@wacom.com>,
	Jason Gerecke <jason.gerecke@wacom.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Aldo Ariel Panzardo <qwe.aldo@gmail.com>
Subject: [PATCH v2] HID: wacom: validate battery range before scaling
Date: Tue, 15 Sep 2026 01:25:46 -0300
Message-ID: <20260915042546.2454238-1-qwe.aldo@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260915041248.2432629-1-qwe.aldo@gmail.com>
References: <20260915041248.2432629-1-qwe.aldo@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Battery events divide by the difference between the logical maximum
and minimum without validating the range.  A malformed HID descriptor
with equal limits can therefore trigger a divide-by-zero exception.

Move percentage conversion to a helper that widens the arithmetic,
rejects non-positive ranges, and accounts for a nonzero logical
minimum.  Clamp the result to [0, 100] instead of rejecting
out-of-range values, so that real hardware whose ADC occasionally
reports slightly beyond its declared limits still registers its
battery and updates capacity normally.

Fixes: 37d160193834 ("HID: wacom: generic: Scale battery capacity measurements to percentages")
Cc: stable@vger.kernel.org
Signed-off-by: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
---

Changes in v2:
  - Clamp the computed percentage to [0, 100] instead of returning
    false, so that slightly out-of-range ADC values do not prevent
    battery registration (WACOM_QUIRK_BATTERY) or silently drop
    updates.  Reported by Sashiko AI review.

 drivers/hid/wacom_wac.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index da1f0ea85..XXXXXXX 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -7,6 +7,7 @@
 #include "wacom.h"
 #include <linux/input/mt.h>
 #include <linux/jiffies.h>
+#include <linux/math64.h>

 /* resolution for penabled devices */
 #define WACOM_PL_RES		20
@@ -1937,6 +1938,22 @@ static void wacom_wac_battery_usage_mapping(struct hid_device *hdev,
 	return;
 }

+static __s32 wacom_wac_battery_percentage(struct hid_field *field, __s32 value)
+{
+	s64 range = (s64)field->logical_maximum - field->logical_minimum;
+	s64 result;
+
+	if (range <= 0)
+		return 0;
+
+	result = div64_s64(((s64)value - field->logical_minimum) * 100,
+			   range);
+
+	return clamp_val(result, 0, 100);
+}
+
 static void wacom_wac_battery_event(struct hid_device *hdev, struct hid_field *field,
 		struct hid_usage *usage, __s32 value)
 {
@@ -1950,7 +1967,8 @@ static void wacom_wac_battery_event(struct hid_device *hdev, struct hid_field *f
 			wacom_wac->hid_data.bat_status = POWER_SUPPLY_STATUS_UNKNOWN;
 		}
 		else {
-			value = value * 100 / (field->logical_maximum - field->logical_minimum);
+			value = wacom_wac_battery_percentage(field, value);
 			wacom_wac->hid_data.battery_capacity = value;
 			wacom_wac->hid_data.bat_connected = 1;
 			wacom_wac->hid_data.bat_status = WACOM_POWER_SUPPLY_STATUS_AUTO;
@@ -1958,7 +1976,8 @@ static void wacom_wac_battery_event(struct hid_device *hdev, struct hid_field *f
 		wacom_wac->features.quirks |= WACOM_QUIRK_BATTERY;
 		break;
 	case WACOM_HID_WD_BATTERY_LEVEL:
-		value = value * 100 / (field->logical_maximum - field->logical_minimum);
+		value = wacom_wac_battery_percentage(field, value);
 		wacom_wac->hid_data.battery_capacity = value;
 		wacom_wac->hid_data.bat_connected = 1;
 		wacom_wac->hid_data.bat_status = WACOM_POWER_SUPPLY_STATUS_AUTO;
--
2.43.0
