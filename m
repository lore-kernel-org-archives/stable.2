Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794363096;
	b=yy2BdA5UPBYqD+UP9XQcM29UjbRXKDn5J5qW0oAD/dK6A9n9x77kmFBQk/SGYnq0h7Li
	 Z60weruwty7syu2aKPVcX0dAqRsUzmou4BgZDhVsKjpbv+bvZQ3cFx4ZGv0tIElPhg+um
	 loPgw2Z6fG8lrM84koGEdPatOiyQ+vGZVpMRBasDdC3Q0/Sb0JAxUDYdp+4gPcINxoiwo
	 8BqU5Ul4UtNe6V/zhIjTUvu7rEaSIkGd3KusjO+6kaRTIfdgxU8kxaww3VOh12xGT8Gnu
	 D2U55KmTTr2S++dqyTHuZMzV2/O4UynzTlVnIyISndR5+5fDSJ4OmJ9OlS8hFg4M2Tw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794363096;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=wjXgaQfss6+W9H2TgmngKVjySiAYC9wO1OgdTX+jKeE=;
	b=QOFVxkW90DP/067hns57Gd62CNENe4b+LcUaUiZKyXkv/7HmsWqDq7U1P6PYa9OtzMD2
	 Atn5AZtU2kwL36HVtS3mYrlWBNPRgNM7M+AjQSQyJXX5bb1i9bTMLJ+G3nHyBmMUXF45a
	 oli9tl4Fdh4nlJKEH578Xi43LSmQxumKb440yg3DT9NomAGlmP0vEWBp1w2Gs1ZKWTX+j
	 SxZodjxYkGlovyWj3fnRXVd5aPN54O6L055ccrsTZOlJJt/1UP1ivR9O79ghyPnEfy8eT
	 TsqjMXOXKUzIYy/bvRHC8crk1Un5CbNuyZnn7e8fculdwufa4pSgMPm9879HfZQGodA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WGF6kCQK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CAFB606A31C
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 02:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WGF6kCQK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 970CD1F0089F;
	Wed, 11 Nov 2026 02:11:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794363096;
	bh=wjXgaQfss6+W9H2TgmngKVjySiAYC9wO1OgdTX+jKeE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WGF6kCQKOnx1RCDsP133+NCeoa1RgKP+t3QWOhaQPna6f1J1OqJk3atO3rL2SrQi3
	 ip2Dd7kGllm8aHnRCR3j5jdanBfCVeUr3i8W4RRmdT1vitEPAQKSrsAnlDNSV9aCkV
	 rUFwXE+CRCM1TgSY+9wSw7wyUCv6Yw97MToo7Bl2CjrH4Y5pHdznO298Nhps/1Vrax
	 GIKruZMLNr69kB6Z5m4P5ANSXL1GUiPBao3arM/44XYiPDfl2Ov6HAI5cIlDJqvOG9
	 QEfoT9BEr1wH1m9riEHgPZ4rsSwJfIcP2VpjNVeDawSQmwWL/KbHyQ7tOO06HeLYwe
	 A33k1W801ATjw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Armin Wolf <W_Armin@gmx.de>,
	Grant Slater <github@firefishy.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] hwmon: (acpi_power_meter) Fix 18.45 TW bug
Date: Tue, 10 Nov 2026 21:11:34 -0500
Message-ID: <20261111021114.582623-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107060830-failed-5.15-0b6eda22f9ab@kernel.org>
References: <20261107060830-failed-5.15-0b6eda22f9ab@kernel.org>
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

From: Armin Wolf <W_Armin@gmx.de>

[ Upstream commit 0b6eda22f9ab67ddb2a872b0c3fc578ad9f4e27e ]

The ACPI specification says:

"If an error occurs while obtaining the meter reading or if the value
is not available then an Integer with all bits set is returned"

This integer can also be 64-bit wide on ACPI 2.0 and later systems,
so we have to check for that too.

Compile-tested only.

Reported-by: Grant Slater <github@firefishy.com>
Closes: https://github.com/lm-sensors/lm-sensors/issues/460
Fixes: 1fefca6c57fb ("hwmon: (acpi_power_meter) Fix 4.29 MW bug")
Cc: stable@vger.kernel.org
Signed-off-by: Armin Wolf <W_Armin@gmx.de>
Link: https://patch.msgid.link/20261006234618.10943-1-W_Armin@gmx.de
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
[ sashal: adapted the unknown-power check from power_meter_read() to show_power() using resource->power instead of res->power ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hwmon/acpi_power_meter.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/acpi_power_meter.c b/drivers/hwmon/acpi_power_meter.c
index 1336f77106177..874de8b82adc0 100644
--- a/drivers/hwmon/acpi_power_meter.c
+++ b/drivers/hwmon/acpi_power_meter.c
@@ -10,6 +10,7 @@
 #include <linux/hwmon.h>
 #include <linux/hwmon-sysfs.h>
 #include <linux/jiffies.h>
+#include <linux/limits.h>
 #include <linux/mutex.h>
 #include <linux/dmi.h>
 #include <linux/slab.h>
@@ -31,7 +32,12 @@
 #define POWER_METER_CAN_NOTIFY	(1 << 3)
 #define POWER_METER_IS_BATTERY	(1 << 8)
 #define UNKNOWN_HYSTERESIS	0xFFFFFFFF
-#define UNKNOWN_POWER		0xFFFFFFFF
+/*
+ * ACPI integers can either be 32-bit or 64-bit wide, so
+ * we have to check for both values.
+ */
+#define UNKNOWN_POWER_32	U32_MAX
+#define UNKNOWN_POWER_64	U64_MAX
 
 #define METER_NOTIFY_CONFIG	0x80
 #define METER_NOTIFY_TRIP	0x81
@@ -349,7 +355,7 @@ static ssize_t show_power(struct device *dev,
 	update_meter(resource);
 	mutex_unlock(&resource->lock);
 
-	if (resource->power == UNKNOWN_POWER)
+	if (resource->power == UNKNOWN_POWER_32 || resource->power == UNKNOWN_POWER_64)
 		return -ENODATA;
 
 	return sprintf(buf, "%llu\n", resource->power * 1000);
-- 
2.53.0

