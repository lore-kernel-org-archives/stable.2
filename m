Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794047049;
	b=fFwJ9QBaJ7DVYm2zxpUu3jmbZi3DPDyLtXnMJGduMTiU/xlQ9xoVdOmik8vD+WjKrkfm
	 5AoF1tuzhfCtMJfdc+ggByi8h07xS9x6MJjgQMbq5/mlCBXMcnrEZurjWVahBKqlqZEXs
	 I3nqbw1H03EkSh4BmitS/3/cmMcRuQzad+umpGfQgXn1aQKzZ/puTACdA+cRE4Ud2VQLM
	 bXrM4qsjD++h8tArJwzwM8SeYlO3GyUYcHtI+AfRlaTu3i+hlxoQ+BEGpgfH1N+iCmT0Y
	 uotxV7HQIl2Pf1HcU6p9o5OYVv6Ji3utW571a2m/S01RKMD2WENaWgObpIzuurfD0ww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794047049;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=pZZfG15eq4JyFpe1KBCskNbtKIXsooDW0xgPiYP7Bdk=;
	b=3f1V8Fn1MC7nO28IPkInjmUHxJBbDBuaOS+9o50k+GbXnMDovKlyuUB2i+6tKavEGlyS
	 Gwdv9pAeWdRbmL7eChqP5xHaocPtK5H0aNaTSvToPIyyFxk0U/NKG4k0YCYzr5WqWzCFV
	 drbzEgMec982o4kX71oP7Uu9tv4o8fmQ3V2na7LjaGfWyYmvr6tkScQ5NiHoOL+d0CGJb
	 Mf0ZQ/cgBywLDofvFczxIWLnMRsATrS4+RPGjGmr4512NhDUDsupNrIh6ym+4gSGLpUi9
	 lo6UkLQi3RwZPRJUjr8p7nK3ea3sNVLtSTQPDb/yqlenCnUxP1N10d9knftU4KuUmLw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z1wF6dPZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DCF7606A32E
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z1wF6dPZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B76401F0089F;
	Sat,  7 Nov 2026 10:24:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794047049;
	bh=pZZfG15eq4JyFpe1KBCskNbtKIXsooDW0xgPiYP7Bdk=;
	h=From:To:Cc:Subject:Date;
	b=Z1wF6dPZRzltcPk1+7w5/XuMSlklHblvRMxIJlrbfTQaKuDuXhvNJdpqFNcoiETOc
	 I9uBjfESxEBrz2MJHwhG7SQ3ZXM3+gSzaxF33r8HCGrYurtty014GPth7lUABQTfYZ
	 3O5reXKf30DQwFd7sVJhlzAo6d+1FSaMGW4jKqlRtIsMnOpKpl9MV9YBeZ43j0Pmdp
	 imp8iBeoc+qkKB/S/4GnOnfwZtYLYGcY+a9MQvRdy7bzqGTcAAdURPUvFfJL8Io6YJ
	 +ja+UzKBidnfkQiD1O6IDD/KZDNHgChEnZKBNbNl6o4mX98NJ5HqFHUyWGb0z/Enhb
	 d8/MBxI0ytG5Q==
From: Sasha Levin <sashal@kernel.org>
To: w_armin@gmx.de,
	github@firefishy.com,
	linux@roeck-us.net
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] hwmon: (acpi_power_meter) Fix 18.45 TW bug" failed to apply to 6.12-stable tree
Date: Sat,  7 Nov 2026 05:24:07 -0500
Message-ID: <20261107052407-failed-6.12-0b6eda22f9ab@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 0b6eda22f9ab67ddb2a872b0c3fc578ad9f4e27e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107052407-failed-6.12-0b6eda22f9ab@kernel.org' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 0b6eda22f9ab67ddb2a872b0c3fc578ad9f4e27e Mon Sep 17 00:00:00 2001
From: Armin Wolf <W_Armin@gmx.de>
Date: Wed, 7 Oct 2026 01:45:34 +0200
Subject: [PATCH] hwmon: (acpi_power_meter) Fix 18.45 TW bug

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
---
 drivers/hwmon/acpi_power_meter.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/acpi_power_meter.c b/drivers/hwmon/acpi_power_meter.c
index d8e8715094055..3891962f03db1 100644
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
@@ -30,7 +31,12 @@
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
@@ -452,7 +458,7 @@ static int power_meter_read(struct device *dev, enum hwmon_sensor_types type,
 		ret = update_meter(res);
 		if (ret)
 			return ret;
-		if (res->power == UNKNOWN_POWER)
+		if (res->power == UNKNOWN_POWER_32 || res->power == UNKNOWN_POWER_64)
 			return -ENODATA;
 		*val = res->power * 1000;
 		break;
-- 
2.53.0




