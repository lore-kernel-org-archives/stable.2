Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795133257;
	b=IMlV4TwLBc0OU1G3cZd5C4/jlzpQAIE22WhP54mbMA1F/T4H3VlvzU3Z/VBvxqfLJCMB
	 wGFBsx6uPx6rlQ50c/+72w492YdkldWUWmHBrXRfpnISlBlC6NOFzmEexhsKB9GqvurNY
	 oWo6nNnDYRaJ0XEp4RVlLH+qky5FtNdidDQg1krmyE0a57x4SpPgTJzEnHUNNzgQtFNbl
	 3mA/nyYi4Bf8IqJFG+2JQSXaxhI0NH1CQ9PgJIxppCkKXXp+OmvNkB1FFq7DeXJdUZal7
	 d/3EtFjWqsYVD/fx33zBD91hyDfFDnlrk8jC2hcT0JmLm923dVTjGoiXeKbwodi4t2g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795133257;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=L9l4FZ5LL/w8As/C818xoov7mkgGSGnX0m7j2Tu08A8=;
	b=GihNG6tFMLq53bLcPnQGhufVdCfVNPoD30cDB79nPWAZGJurK5EFz3+pAtPQwzINxc1c
	 Yn7mQnnf9Gs8R8kQaP7/gfu6ynqYwUPcrJzJ4V7NiGbGS6jpyAJlvzum8Rnvs5/A3F2Lm
	 idM2xkzfJ0TcndYt5fUSoh2S/UsHkWMtYoZhZQ/mTLML0oprqqytyOyWRMlxA6o4ACd81
	 /Hrkl15aI3pACyky3XZm0RzpumGcxw5a6swYGLpJ4NMjP0z3wDMKiimMtiRFdxEnVVrtg
	 VHtXQq75e6vM23+GLINlT43PlL1jjLbew7OGVgVrWctQHOf/sWk3fgsxCk3m+Wzj06w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WhM3PsPV;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6344B60A2620;
	Fri, 20 Nov 2026 00:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WhM3PsPV
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795133257;
	b=duZQxZ6lkwYKjGgBp30dlhR4dmP9NIGQ3u00ik7WdtNdG06YKk6Gr+M1n82GGlv4ZNcm
	 3vi5mhDKrqnWwC1wHaxWlJWqZSjxxC9Xq9KU+l/iBbOrSmMIdNk/fpy5MMYciXUJI8aPR
	 b2+2WYX019Z0Val+OlRxtrglUJjUgaoPjQhWkckUGW6pMJjEYEhRuvJAE7fpgVPWA+YLt
	 8eG5nvQuJl3H227Em/g+JGKKJLTORVj1ooH+xXYUFsLTq/1Wep6lB6Lkti8g3ydkVLWAz
	 LfbA0eSfzJj4zpxXaAHU3D4GoEfEb/XJ+7lr+Kwqaewy0glmKhMiFf4XXSI/rVLhSFQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795133257;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=L9l4FZ5LL/w8As/C818xoov7mkgGSGnX0m7j2Tu08A8=;
	b=Dk4z0UkwPRR9ccxDH4KdL1Z81FtVcZG7Dv9N0sfw8DYXO6W2AEEBM2htcEti/HX7E1LR
	 hZs9pRmSni5A1ohFCGBCpcTc1DCJAhnKtEbXXE49y5Xzp5/WSauOJ8TqeXAt9o+H1U2LZ
	 R+NM+OxWsu+7r2fW8rSDPmPT4Vr4IBUQLCbTVfbS+51fXjHIXN5NpIN+lM73rxQTLcZtj
	 MubqnmpMmxEqSHkxd1bJUXbPbsx1H/SEyy6uY3b/mveWJlt6ply37mXymjo4wJVd8WRID
	 KECz66JBK+oNBcdZKfP2Bgcryw8Eu9BwhXAE9EtCvMw2hlqdVmiUrF0TO8Z1aj+YhQQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 3C73B1F000D0;
	Fri, 20 Nov 2026 00:07:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795133257;
	bh=L9l4FZ5LL/w8As/C818xoov7mkgGSGnX0m7j2Tu08A8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=WhM3PsPVscBFdaBQIcaZK+xDAFOnz54xytAnSa93Y+IwnwiVFP6hM+rmmHDczO0ow
	 p+2cRQp26KOvgow40JD50Z/P3FwMe8tcFy4iQtI3sBFJyyJLVMPCS6OjYVYdRKNAnc
	 btavZYWH/sSXHiBTWKpb4p7oX004JY7kAqijBYI7H4u8ISENI1m3W+3F6Kgr9bCCw3
	 YRROdEZgqToPSgVJHvNCz47jyWlbEewvzO9PIOvUPH+IYRo9xNJx+FGQJ7g2ypCRc8
	 L4qFKa92TXBdTScBhG9FuwAT8pe8fVEz++WGIfD1+HA1g/wfZzyk0SwO0ujvCLEr4Q
	 ksCPDMgMzYqOw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id BE7F9424E8;
	Fri, 20 Nov 2026 00:07:35 +0000 (UTC)
From: Joseph Telaak via B4 Relay <devnull+joseph.telaak.dev@kernel.org>
Date: Thu, 19 Nov 2026 19:07:26 -0500
Subject: [PATCH v3 04/11] leds: rgb: ktd202x: Fix a division by zero with
 long blinks
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261119-ktd202x-et6326-v3-4-98b836b1cddc@telaak.dev>
References: <20261119-ktd202x-et6326-v3-0-98b836b1cddc@telaak.dev>
In-Reply-To: <20261119-ktd202x-et6326-v3-0-98b836b1cddc@telaak.dev>
To: Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>, 
 Griffin Kroah-Hartman <griffin@kroah.com>, Kees Cook <kees@kernel.org>, 
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 =?utf-8?q?Andr=C3=A9_Apitzsch?= <git@apitzsch.eu>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>
Cc: linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-hardening@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-doc@vger.kernel.org, stable@vger.kernel.org, 
 Joseph Telaak <joseph@telaak.dev>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795133254; l=2532;
 i=joseph@telaak.dev; s=20261104; h=from:subject:message-id;
 bh=ZwqI7v4DG55lRFAiYaRoYyNEA1kQO3JMlNgT3S5y4mM=;
 b=aaQu7aGpvdbUbM81gqST6Zt3voZbe3FFw/DAPdKyMXWgDKmE16Nv4rYLy5iLtxK1nwT63hqg+
 uos1glpgUeeDYwjXRgFTNQBQUR0raXyMwAH+BKFGsgIJjcNmNBdr8R3
X-Developer-Key: i=joseph@telaak.dev; a=ed25519;
 pk=oQI+UfddlZ0wK2ac4WKOGNjUl1ZEN8j9ZVFSqEDoNP0=
X-Endpoint-Received: by B4 Relay for joseph@telaak.dev/20261104 with
 auth_id=1404
X-Original-From: Joseph Telaak <joseph@telaak.dev>
Reply-To: joseph@telaak.dev
Content-Transfer-Encoding: 7bit

From: Joseph Telaak <joseph@telaak.dev>

blink_set() works out the on time as delay_on * 256 / (delay_on +
delay_off) in unsigned long, with delays straight from the timer
trigger's sysfs files:

- when the two delays add up to exactly 2^32 on 32 bit, or 2^64 on
  64 bit, the sum wraps to 0 and the kernel divides by zero, for
  example with "echo 2147483648" into both delay_on and delay_off.
  That oopses on x86 and gives an arbitrary result on MIPS and arm64.
- on 32 bit the product already overflows once delay_on is above about
  4.6 hours, and a sum that wraps sets the wrong period, so long blinks
  get an arbitrary duty cycle

Saturate the sum, and compute the on time with mul_u64_u64_div_u64().

Fixes: 0ebdb7210943 ("leds: Add ktd202x driver")
Cc: stable@vger.kernel.org
Signed-off-by: Joseph Telaak <joseph@telaak.dev>
---
 drivers/leds/rgb/leds-ktd202x.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/leds/rgb/leds-ktd202x.c b/drivers/leds/rgb/leds-ktd202x.c
index 362d231eddcc..bfc05f5f02d6 100644
--- a/drivers/leds/rgb/leds-ktd202x.c
+++ b/drivers/leds/rgb/leds-ktd202x.c
@@ -9,10 +9,12 @@
 
 #include <linux/i2c.h>
 #include <linux/led-class-multicolor.h>
+#include <linux/math64.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
+#include <linux/overflow.h>
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
 
@@ -297,7 +299,8 @@ static int ktd202x_blink_set(struct ktd202x_led *led, unsigned long *delay_on,
 	/* Convert into values the HW will understand. */
 
 	/* Integer representation of time of flash period */
-	delay_total_ms = *delay_on + *delay_off;
+	if (check_add_overflow(*delay_on, *delay_off, &delay_total_ms))
+		delay_total_ms = ULONG_MAX;
 	if (delay_total_ms < KTD202X_FLASH_PERIOD_MIN_MS)
 		num_steps = 0;
 	else
@@ -309,8 +312,8 @@ static int ktd202x_blink_set(struct ktd202x_led *led, unsigned long *delay_on,
 	 * Integer representation of percentage of LED ON time. A value of 0
 	 * keeps the LED dark, so use the shortest on time instead.
 	 */
-	on = (*delay_on * KTD202X_FLASH_ON_MAX) / (*delay_on + *delay_off);
-	on = max(on, KTD202X_FLASH_ON_MIN);
+	on = mul_u64_u64_div_u64(*delay_on, KTD202X_FLASH_ON_MAX, delay_total_ms);
+	on = clamp(on, KTD202X_FLASH_ON_MIN, KTD202X_FLASH_ON_MAX - 1);
 
 	/* Actually used delay_{on,off} values */
 	delay_total_ms = num_steps * KTD202X_FLASH_PERIOD_STEP_MS + KTD202X_FLASH_PERIOD_MIN_MS;

-- 
Git-155)


