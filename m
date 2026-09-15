Received: from mail-vs2-f42.google.com (mail-vs2-f42.google.com [74.125.227.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5C1F258CE5
	for <stable@vger.kernel.org>; Tue, 15 Sep 2026 04:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789445581; cv=none; b=YL+hKYcuHmv4Tq1B1QEmLtExcfX2lG9TaYvwppf+rzh6ExLfwwrIvQXSQWyJTQL+LUirBn4JoXF0i62W1ipm0zm1nIaCFIaxiz3HbCbZeWL3GeV5fJz9bsOU+oA/WOS/2JnRQwRjvzIIroygzPQdUy0It2lgPF1nJGegel9ApAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789445581; c=relaxed/simple;
	bh=loIPSrIcsCq4I57+VmLSgBbXGoXXojb4HxS7NRgVz8g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dUxnxfIUFo2QBw3KajI/LpolrMH7m36SN0yXGKnqHJf4mVEWXg9Rbubhc59KmNRlXdm6j0oqYqZwH8nehIwIpIp2idvvQsrp3sQApnc5/RlzxJmfHE3IP8Fj2UtaFLSfymlIaiUQUtAi05Z78DwCeO0FhvfHZvsu447rEPv/46E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=STHYAuwU; arc=none smtp.client-ip=74.125.227.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="STHYAuwU"
Received: by mail-vs2-f42.google.com with SMTP id 71dfb90a1353d-5c963a787c9so993808e0c.2
        for <stable@vger.kernel.org>; Mon, 14 Sep 2026 21:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789445578; x=1790050378; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=IjLBesoU4POHMf+R0ywOnRIASBPE1EpsLahpSC+o4kk=;
        b=STHYAuwUevdugWyet+MvnKb6qryaoqEE+H2F2YzU3OJvXig65C60DBXuvwMAtHf1ET
         cIv3LHa/VqrdR28ys545SPZqAHtX2OsFefU6bZt+sZX4wrfXz7jmiLDhyRAGm8s2eWmE
         xW13WAUluenAeXdXwYdxlc8CT4Y+2JpF10b+KvAsjyxZroqnferKSbgHwo4Cb4Slr6hU
         dhunei+vLjklOMUlylTYuKUVieJqaKTpu2q0A8T40MVSS9FNFoW9tU/JwpDOVWLj3n8w
         wNjmJ4rzn4dagu8swOTwS39RcOKOGgxqZTZhIosbz+ZCVllMDwfujWNcFZ4MeEd4BBvf
         eTQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789445578; x=1790050378;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IjLBesoU4POHMf+R0ywOnRIASBPE1EpsLahpSC+o4kk=;
        b=Yxsh5GV3A7Hdoc4iyiG4S27hDn2fmP9lIVEFtIYFtmEuvmrzDrNA3ahrrrcmjASvb+
         HSAnv9Y6i6KHYczdzzyGW5KbMm9/2dnYGaj1/hDeF5e27peEJMkh9kV06D/y+joeQQvC
         vpoQ0fEq/BBPGgmYii2jVjY8GhZU0XiKLfogXoyOQZSyrn5pqYQo88BZJxEbvM9dQStt
         xbVijMyOnbHy+hlNTI/FtPWW9TEluhxKOuZdvrbgMxEWRVwU0EPSHCvrdsfT9f2LZedB
         5vt0FfYsQ4uyDVs4gP6ls7oSbQjr1BEwm//81tW4teUVisN2r4T+ymCArmHaynjd/4hc
         zibg==
X-Forwarded-Encrypted: i=1; AKwUvBzHI11JWT7itr2Okv9FxCSvPkST4xqeG0oyhsV7TetfQge3yZNMkwz4gz+JMwraJP1iX9hXeZ4=@vger.kernel.org
X-Gm-Message-State: AFuF++nFfjoGv4fnsLTbvVlMpBN4HuFQfzPzliSx9zb+QVRwUZCM3UJ3
	tZgJMTQU9mGkjP81b9I0MmzAXZSbcdapRsdlOLhZ1/XCuUlrvd/UAvNa
X-Gm-Gg: AYBFou1n4QXyEsgp5oNp/jVo2Jf6dCxLoUqt9TvKhfe70+k1MVqssGPC3tDdONkT4yA
	/ZfxxCAazdWMK5cFzJQtRpH2Vge6chFI0xhCvy9qpjmo2JN0CLtaVF5dKLlPmmqai/kNobZlzY3
	ln+AqgDi/PT+TzmdZWAtC7hs0R0IJFMZqNGMs9aMfZgnBkT32W2UXRvUN4HxM/N/we8z8Lzh0Km
	5zNG/0+mqtkQ0lZ3CRlx4XogULrljh0VxyQecZvLWrn0QbwrAyoR8pS/21Sxop0AOJbXy1jifW4
	/QRXLC3XD8hIvDpGKYqDdmCLwfoABo7YAEUl2tSZ89Bwi3tNySREPCclGe3gkTorxAOeTag90Bg
	pBPr94PlfdQY2tDdSqqiwHeudgLli2a1dmn+tN7aVqwmGXzb0Dzxzj3VQjbtry7lVFMKA0w0ZDF
	YJb69y9I4WoQl+2dnfoyPX/JJUwdXderlxkJf+Lqp+gJy2SH6lP/gBd249O59QSwzf
X-Received: by 2002:a05:6122:4f91:b0:5c6:58df:5826 with SMTP id 71dfb90a1353d-5c981d5fca1mr7577057e0c.5.1789445578612;
        Mon, 14 Sep 2026 21:12:58 -0700 (PDT)
Received: from beelink.. ([187.13.206.89])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5c847100f4asm14219340e0c.11.2026.09.14.21.12.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 21:12:58 -0700 (PDT)
From: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: Ping Cheng <ping.cheng@wacom.com>,
	Jason Gerecke <jason.gerecke@wacom.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Aldo Ariel Panzardo <qwe.aldo@gmail.com>
Subject: [PATCH] HID: wacom: validate battery range before scaling
Date: Tue, 15 Sep 2026 01:12:48 -0300
Message-ID: <20260915041248.2432629-1-qwe.aldo@gmail.com>
X-Mailer: git-send-email 2.43.0
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
rejects non-positive ranges and out-of-range results, and accounts for
a nonzero logical minimum.

Fixes: 37d160193834 ("HID: wacom: generic: Scale battery capacity measurements to percentages")
Cc: stable@vger.kernel.org
Signed-off-by: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
---
 drivers/hid/wacom_wac.c | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index da1f0ea85..b93aac8e3 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -7,6 +7,7 @@
 #include "wacom.h"
 #include <linux/input/mt.h>
 #include <linux/jiffies.h>
+#include <linux/math64.h>
 
 /* resolution for penabled devices */
 #define WACOM_PL_RES		20
@@ -1937,6 +1938,24 @@ static void wacom_wac_battery_usage_mapping(struct hid_device *hdev,
 	return;
 }
 
+static bool wacom_wac_battery_percentage(struct hid_field *field, __s32 value,
+					 __s32 *percentage)
+{
+	s64 range = (s64)field->logical_maximum - field->logical_minimum;
+	s64 result;
+
+	if (range <= 0)
+		return false;
+
+	result = div64_s64(((s64)value - field->logical_minimum) * 100,
+			   range);
+	if (result < 0 || result > 100)
+		return false;
+
+	*percentage = result;
+	return true;
+}
+
 static void wacom_wac_battery_event(struct hid_device *hdev, struct hid_field *field,
 		struct hid_usage *usage, __s32 value)
 {
@@ -1950,7 +1969,8 @@ static void wacom_wac_battery_event(struct hid_device *hdev, struct hid_field *f
 			wacom_wac->hid_data.bat_status = POWER_SUPPLY_STATUS_UNKNOWN;
 		}
 		else {
-			value = value * 100 / (field->logical_maximum - field->logical_minimum);
+			if (!wacom_wac_battery_percentage(field, value, &value))
+				return;
 			wacom_wac->hid_data.battery_capacity = value;
 			wacom_wac->hid_data.bat_connected = 1;
 			wacom_wac->hid_data.bat_status = WACOM_POWER_SUPPLY_STATUS_AUTO;
@@ -1958,7 +1978,8 @@ static void wacom_wac_battery_event(struct hid_device *hdev, struct hid_field *f
 		wacom_wac->features.quirks |= WACOM_QUIRK_BATTERY;
 		break;
 	case WACOM_HID_WD_BATTERY_LEVEL:
-		value = value * 100 / (field->logical_maximum - field->logical_minimum);
+		if (!wacom_wac_battery_percentage(field, value, &value))
+			return;
 		wacom_wac->hid_data.battery_capacity = value;
 		wacom_wac->hid_data.bat_connected = 1;
 		wacom_wac->hid_data.bat_status = WACOM_POWER_SUPPLY_STATUS_AUTO;
-- 
2.43.0

