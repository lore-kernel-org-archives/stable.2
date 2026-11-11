Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794362881;
	b=XrBfsyVE0JtSLPsnnBct41u3wJp2iaSf7lWwR8gXvWYmJKNGXMGRskc137EdCTq+YY8x
	 RDbCk3tJy11Fn2cqvCbscz/qonsArI/bFT3ADqt5JKRY001y+D42uWlpa8u9MKv8xzZ03
	 VRUd01g1ZMf89UGp6Kk2CudT7dYfmn1gq9Kxmcrw04OTN5VTOO2USidL1ps3dSuQvQOsq
	 tEermGnb5jnTxW8XsYc6vUEL1SKOELxwA/U7XoPPqy2nzlufgaadzr2H5hQeFZ4D8UsjE
	 PywBO65ZHtfUOPa08qIIP7xM6XIVnr/nYEd8hD8m80UK+o4yc+K/IkR7tmBmRh36iLg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794362881;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Xculw3XPJY9hSQC+iuPKzDmS/AV2gW3YuYS4MhdaX9I=;
	b=uwkvWjl4bmSUBhgsQBTFfGCB7V7Jz9wtL0eCkjdSA3At3kBdfvjCOcbIm8ZgQGC7Re7q
	 4mN22aloR7q5El1YNVFjksA9L9sx11Qzays7Va3csgGwIIeArwtxTsmkRVvl8Gy5r059O
	 4navp7cNY5iSPqHDzcxwMRVylgvW9RO8GftUAYD2gTz8s5RGML+sesGs+IMdPYTzPKb1r
	 xhwFepT8vTlJaEzu9sQ6ChdmyNiiASYSbqqJ2kb0o7qXXA0MiX1bY9+iaugV826X/pVF+
	 VfhW8Hp9ubahFLLiAHP29XNwt7o5m4zOQ8kVCJ9NW3ZL28EBk3XoxQM3/DbNtA1Xuhw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X6NiGJA5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25037606A31C
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 02:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X6NiGJA5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C5991F00A00;
	Wed, 11 Nov 2026 02:08:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794362881;
	bh=Xculw3XPJY9hSQC+iuPKzDmS/AV2gW3YuYS4MhdaX9I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=X6NiGJA5CXoSsswZ5mChjxq1Yb5REGlxbpRwe3Ifi0qtlON+zsa4GT1HwR059nTir
	 F2cas07GKdNhLWzwwGLD4TGq0t8M2e97oHGvbFCMtC42LxvXepPNr0mr1lklpYTaiS
	 4iJFCtDF/Je27yHOHuGGHFVjX0xi/HjxRWpUYGxBt0LjTE+jV51i9W9Qm9DS+34GMp
	 Pbads0vBadvYlkEtGehWPKd4PFk6fggoIVfnmeIDrw6QIE0VLM15b8BkAUnrraePwN
	 PuBETl55PZj0R2Bl2D2f76sLqJJikG4oQ3GFWo0ZlOt0ph85hOWCa7TVAdz8PFfeUO
	 A8VjS+NllZqcQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Armin Wolf <W_Armin@gmx.de>,
	Grant Slater <github@firefishy.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] hwmon: (acpi_power_meter) Fix 18.45 TW bug
Date: Tue, 10 Nov 2026 21:07:58 -0500
Message-ID: <20261111020720.565217-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107055120-failed-6.1-0b6eda22f9ab@kernel.org>
References: <20261107055120-failed-6.1-0b6eda22f9ab@kernel.org>
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
[ sashal: adapted the power check from power_meter_read() to show_power() using resource instead of res ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hwmon/acpi_power_meter.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/acpi_power_meter.c b/drivers/hwmon/acpi_power_meter.c
index 2147afb725581..30872b62d7639 100644
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

