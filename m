Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794362352;
	b=tM2lDEe3l1YI0dT5Uj/Wx6Xg4cF1KsQHf2wyuk0Ie3RJxVc328/ZxiOuVjHzAcXM4Huj
	 ide8JNZ/MX9m7OAawfqIJcyfUNdt67AqSzDm9chFhln9n5VIcYDBaymIiz0TkAH3yjS5K
	 UldjRvc+ZYYiCM98E5xZhwS1g7EOwAxFFivUpQ61p52fX/Uq03MXV+dh1kguYlcDcWcYp
	 Pue02d+d/PG7x/XhjIcVbfl3ACr2VX/8X1Xo9geD5sF+/1JqzcIlkzHGlW5cYP281Ojjl
	 O31l57z9JLKBVxGBDbEgMqPaPq6kjHe8wAUdY3gQ0hKPpXAiac4O4/6/3J02S93uWlw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794362352;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=TGCBJBA9zjpwrd6ieVEjzGVov4zgswM71LXjfFZNl0Q=;
	b=b5a4TGF+GD8Er0tOqICBBZCy+ma/JrM0BZi4QF7J11W/6NrzULvy/6S0y0UmRw6vzJmr
	 o78RhXgNrwq74xP61MaG6VEDq+Ydj3NIQGBTKjI+rEAYfmQyqu1TxMETNeyo7O6xT4/2z
	 pSxpJyQb+cdWQi9v9ozN+qvNxO1xsH8Yzsd0RaDZcP+o4MX0qrQF7eUZCVoPf3VLE6QDy
	 heoTEOlrV1DgvIFc05z+G0Cz2IqnpDZjyPTGI0LFDjgqetc+YwLk00SVsD8KegU6MxBJ6
	 bOhXNG3ucCrleFq/L746PhyuLgV5gS65wrI4XmWoPTptC0YqY0TzgtXG685o3FixpjQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=A8PLLUJV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 170A7606A320
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 01:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=A8PLLUJV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B303C1F0093C;
	Wed, 11 Nov 2026 01:59:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794362351;
	bh=TGCBJBA9zjpwrd6ieVEjzGVov4zgswM71LXjfFZNl0Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=A8PLLUJV5hocwllSMUImOCL0AD6/hRi5sgQIzHaEnIt5NS8YVAK0kST02SOZPWx/h
	 vmJl1hTIxLu6D+ENYZn/AI0znlGrgdRI+Cby59kzM4wf5yHkjwkK52pCf52OjkjH1c
	 kmCEuQ5/chSC7+XULAnU8nJiGAMOA1YOL1YHxBoQSc2dA7crsKOqoEB6SZnBCQpTqn
	 MC/Kyd6n64uISjCGrxl5px9kDfvxq37OeLh8JAFKWREyfd703GL4FPWw2I53LRMyr6
	 FaJ1W+8fhKed27/Qi6aUJ8nI8uTTG9hkRM8H+DuHJLJ/s9bnp7UoEDgfaI8EUrWZ6d
	 G6RE6Ze+mPq6w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Armin Wolf <W_Armin@gmx.de>,
	Grant Slater <github@firefishy.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] hwmon: (acpi_power_meter) Fix 18.45 TW bug
Date: Tue, 10 Nov 2026 20:59:09 -0500
Message-ID: <20261111015534.442323-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107052407-failed-6.12-0b6eda22f9ab@kernel.org>
References: <20261107052407-failed-6.12-0b6eda22f9ab@kernel.org>
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
[ sashal: adapted the power_meter_read() change to show_power() using its existing resource variable ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hwmon/acpi_power_meter.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/acpi_power_meter.c b/drivers/hwmon/acpi_power_meter.c
index 6c8a9c863528e..eedcfc9d96c6c 100644
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

