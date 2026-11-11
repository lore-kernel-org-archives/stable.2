Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794363334;
	b=NoP/s3TgrBaCn3nk8HfuOYuBXf724bp+1Ztbl945X35gISFK6YI0qSDIUDThs/l37crB
	 rCZZF1fHpBQKGCaGpb4dFDYTxr3H6WCxeqfMC1svi+LEeYqF4YH+7PGM7ymEdPqWbYwtn
	 ZFLUlXQUYZw+nbXJgyJOGy2xvOIkycCLoYhlzuOioSXxhth52T4nt1MI50lIlTOYK8MJ4
	 nh22Yjzlwm5MA+9m3Tx4Mp6GiXImyWHBCiqBIVGHUzGkutN8ityfwvzbJ0Fm9EMMS4fiS
	 8YDQYZ767WIyBDYOCkBKRIiec2JYmY0Kmt72GB9Yqcbhd9ZDh1UI5IvqRmWLecqyRqA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794363334;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=9Eg8Ks/p6+SJqpz0WhahT/90tFZdjbysLT4xT1R8uIg=;
	b=JFFATwPZBBaBSHa1G+/pofSN1T8OQwgls2Nas43uj4S8KxZkStdGq+PwX/qFmW9jiprw
	 fUCZ9RtuAuawThk7TuP/N696rmT46Mc2hQ8jXL/oBu4NgZz+mSGV+a0oM/WR1y1uV1u4W
	 64SB8J3XZXBgnqWuy3vbCXeZsxHfS+sUw4juPJlEUJe7+eAeFCrUEeiEE7DtFwFLnSqtT
	 SE5iqjG0Bwceh7x5lWxgA109sZdDWSkiN6Gt63h8IIMZP/acyzq6c8KgbIfuCi0d/fPoo
	 hsDq+5aNKOTzsykvLSCZfECSQMBOiSAgRVxpIcyRGYCBkls3WlhGy8YsJC4FuyrimsA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W5I0HHIg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA916606A326
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 02:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W5I0HHIg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D052D1F0089F;
	Wed, 11 Nov 2026 02:15:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794363334;
	bh=9Eg8Ks/p6+SJqpz0WhahT/90tFZdjbysLT4xT1R8uIg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=W5I0HHIg/43kp/ofL0Kn54FHzYB9qnvGVoEkZIcb1xesa+GeSh1vsELph0flTx2MN
	 te87Krs7vkAMJOuGsyUvSyALqhnFjtruBJ638/JlF+wgImx3gYSFdzD224mCz59QTz
	 etxb41gn4uB+qXbamvLpy8NPt+P1IridY+C7l7R4zQ16dOYh84Hl6xFPVKvuuWjLBx
	 ywvQoE53yXCPFLjU6SQJ+0C+4RbNJXRrV1p6q82P6PWBZB8cgJIVw9E2EXYkggKH+p
	 z0qbeOQau4pV+8BJ/Cv9Bf9MVPd4mHFuaEVJcr2TZlKdtfVGgUlrP/jiShOuVofSvZ
	 SLykoDmy4rNhQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Armin Wolf <W_Armin@gmx.de>,
	Grant Slater <github@firefishy.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] hwmon: (acpi_power_meter) Fix 18.45 TW bug
Date: Tue, 10 Nov 2026 21:15:32 -0500
Message-ID: <20261111021500.609375-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107062522-failed-5.10-0b6eda22f9ab@kernel.org>
References: <20261107062522-failed-5.10-0b6eda22f9ab@kernel.org>
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
[ sashal: adapted the power check to show_power() instead of power_meter_read() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hwmon/acpi_power_meter.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/acpi_power_meter.c b/drivers/hwmon/acpi_power_meter.c
index 5794d44538e9c..94d6c3cef0f7d 100644
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
@@ -32,7 +33,12 @@ ACPI_MODULE_NAME(ACPI_POWER_METER_NAME);
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
@@ -344,7 +350,7 @@ static ssize_t show_power(struct device *dev,
 	update_meter(resource);
 	mutex_unlock(&resource->lock);
 
-	if (resource->power == UNKNOWN_POWER)
+	if (resource->power == UNKNOWN_POWER_32 || resource->power == UNKNOWN_POWER_64)
 		return -ENODATA;
 
 	return sprintf(buf, "%llu\n", resource->power * 1000);
-- 
2.53.0

