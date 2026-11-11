Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794362651;
	b=xtm98UFoNZhaH+KNL5AzbTrUMtk/VdC8ng104GrT9lYgFXw5STw166cIdnXdWt/xeYbf
	 +qhN3i/GB1m4XUqsXOx5C9jW7fLA15te0284uYutYFifQFwb0/W7vqAFAbiUQZ/icZgBJ
	 S2VR6zrycHOVs8lsh2k7HWpGV6ViN5hBV0RBZD5MIFiAAjfA7bfXzZp+3U24JbtgdqQAt
	 VKyR/Ux7wO5Ev+UH7hUU6l29oMTKa6IeIGfHVolIPu1Dgiq2jNxTbMPAo1YYRITgaXgoh
	 37M8j5TGHxcM/oEsSMTq+zcD4x46xJ0fb3XwZOwhEHIMq14oB/SUT60cPWE8yizkiNA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794362651;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=oOR6pv3hSaUwwtcIy4ooAFAyWOKEyjKFNFsw30A6fiQ=;
	b=vBbB5Qc2N4ZwOVWqv3ap334NqK+NRho2cIFFBThRYo8q6j9QGwACb5yWgHFZIiZe7xSH
	 X4lUSPq3H4owDnH2TmuAq6lREwEF4FUnx1qv0r4SCZZd7SAbW41bURIrBXfypohnQZwua
	 iRRI+0PUcwEe5CE58rQgOxgyGN37GD7vTFoAExYxCK0814tuh0ZemQUomfGKExjQ6V7zw
	 DlEzGWzLoxfKC8X+wCQKtCEqaUnYLKkeiRWdWItgqJQGRLNLV23A8WTqSdc/uOiADqy2J
	 c66am/Pjp8rI7RBFmFa2AUUpWxXhEqMxz+OVtc1+otPTLHHzjJtffXYvo/BP2d6gr+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NhsGLl2Y;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B748F606A320
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 02:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NhsGLl2Y
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A841E1F0089F;
	Wed, 11 Nov 2026 02:04:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794362651;
	bh=oOR6pv3hSaUwwtcIy4ooAFAyWOKEyjKFNFsw30A6fiQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NhsGLl2Y1Q6mhFQxcKZH+pVk569hRCN0lNSAVkrJfPxgjwR+BWeDgPMONb4yhRKz5
	 DC4gt6gqWGkhOhc1evfo/M2LcqznZ9FAUcfDzGibtOIXGcjVCUXOaIfRFlw3keSaZn
	 UycFiMWxf3VPcLEZhWbSeuXr7crDXggTrzdURs1v5iVwXOJiijiqTSQirtsajcbARl
	 816IsrddCIRtIcoIxXFY5eG4sw4gq/nWU7nMCK/mQ1gD54O8ec6tvI8/ndz9gRgFVb
	 YNAVmeO1go229VaDzDMeGUlgME0MOLoEvA4MK//jGmEHjxX2TeXnkNlL5reay7+1Kj
	 EGFb8nUQ8e9XA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Armin Wolf <W_Armin@gmx.de>,
	Grant Slater <github@firefishy.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] hwmon: (acpi_power_meter) Fix 18.45 TW bug
Date: Tue, 10 Nov 2026 21:04:09 -0500
Message-ID: <20261111020349.542990-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107053646-failed-6.6-0b6eda22f9ab@kernel.org>
References: <20261107053646-failed-6.6-0b6eda22f9ab@kernel.org>
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
index b772c076a5aed..1743467e65db9 100644
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

