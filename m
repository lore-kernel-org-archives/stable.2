Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793585583;
	b=KssHU03/isxi0DmHQYJLaimQrYPNm8YddWXo56XgUSrNlCrO9VcT+Nheip5a2f+Nxnvv
	 OSWGyCVh+CixDYK3G+ep6ECZ9jZPBU+Ai3c5lWSXAuvfdBoyksgLdPMXp8I4tFtxRIy6t
	 qBemiXrYbr3RCfii75cgHyxVNk8hvlc69s3URApAgruYp0qC1CuPdmgzu4GWVZupxOX/4
	 hrVxiV/q/Qa9e18hOoBZtdwd5sJFoZQYp/rI4UxuQE8IQsIxMv0KjLwKTYkiPxAQ/zPbe
	 LaBJY0SQqOBKB1jYWXpmqpfB5RGGLCWXMVXLNeVwGXwuMBwJy2hqpjydDE37n1GuAAQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793585583;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=e7faZ4zHoj+LWmeEHc89fWpnoDlQ1eH9taJo6V1MAGE=;
	b=ntQhVSLv4LmzWFi3xShrUmq21/cx2uSg9FTq5SvHopFX0+VZF6f95x6NiKUofD7VQUpk
	 SSF0areBVtDuwoNsGh4RWqTHJ5O7+HtwPIx+Io60VAwVaX2YBO1kJiA7snRN9bgKC1H7d
	 Zira3JJPows1j/Vqzai8CrhZPbXaa7zWTOK0kVqYz1e3V61+HYuscyFiveEqmJPxYB9e5
	 vtAThFgnDBf18Htl1THOUGL6F1EHL+8OcRWFNF4qdQie7iIE9jIt8dNyI0yvtvF7Inxlo
	 ILlI483j9jPPKUwwHl8lbYpfVZ/37ocQqcT2/dD9Kwn0XSaoBO5KBshI828U3kLFTRA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=I9G91mHk;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBA4B606A32C;
	Mon,  2 Nov 2026 02:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=I9G91mHk
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793585582;
	b=VQRzFtNPUljv1YzEqK9TyUgyG/1VY8qW/lraXOtjF8KkW7SAv6sOjC3e2v7nej6GI2Zq
	 5HZRtQqBO1W2Ulygc20ws98rjgaeOfoT9lqN4KqrAX53SuaLk7kjaHSVlv2ZyrzZU6BrR
	 a1dJXwsujeHiDhZnl/pmLxJFQKttxcyChMOPt7L0KiPxW2FIF7xZDDo6E9PD424Ue+bFQ
	 Zzd/5XNX1LOqx+0AiCbik+LfPhq3Ze6KK9AjmMkmcG2gt8cTya6GQXU92YO0KnimkRyJ9
	 3AmLj7TWIIbBg9r5el90ex/UpeCV/uWinyWAhfB+9rGmkpAy0+qUHWhAKL6cX6D2gfA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793585582;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=e7faZ4zHoj+LWmeEHc89fWpnoDlQ1eH9taJo6V1MAGE=;
	b=E6KSYKJzzx2a3xNF8C0C/INfSpYg7oxnE+dtJKMLRx2eEUp2touUEdvBnZKjmOLRFsO5
	 lPJWl8/lWi//1ltLnyuP+Bzw4nmvOxwx3gOLG7bh0tnb4xFLfNifja0rviEE5edcum7jP
	 Ut2Kb7Ofgqzi4rmZGA8dI7hUCrKK4edpoWjmWNwWi0/9zbMI/uJ6gYpPZ1xvJHjq1fE3c
	 0UwhAwrlHsE2fNZlqNu9EDU+VDby0jttO/0uVrr5bkv3Zot1LmxOXvYyswm4bqgoVq76I
	 sf+AODKXiVB9sSSvK2FsJ3QMwfBZ52xk+3idrTV+SdKo5+PSDFf7JFfwrs9gA7KoV1Q==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 8097E1F00A28;
	Mon,  2 Nov 2026 02:13:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793585582;
	bh=e7faZ4zHoj+LWmeEHc89fWpnoDlQ1eH9taJo6V1MAGE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=I9G91mHkf8klDoG6oW9AL/ocsuk6HnhuuM0sjwIZOm82agbfDgbbixpfw+zpeiGRi
	 rJSzWScBeiE7MZeaXQ+UpGIGMN7Zf/O7YdXkSsLd1WZ/onMSl3s726S3eAAQcUuP/Q
	 f4WIpGiovpuv3QYZfroABW8mp/tSh/T3VwZDTKxEvGFMc6xo1fhoZHZkFU9zGXOcBa
	 SYjc2p1p3Iej5w0lRlC1y2ANaKQ/km5p7emAO3KDxd4inJGZHh+C5ArqWwHy3PGV4E
	 TQg4ggQ6A68DHtQY8fEbGxLEkyj2Emegd34L5v3JiGaONO2IL4rJzCiRIEnXjQfuas
	 4mpuYPlXed6lQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id F0CC54631A;
	Mon,  2 Nov 2026 02:13:00 +0000 (UTC)
From: Joseph Telaak via B4 Relay <devnull+joseph.telaak.dev@kernel.org>
Date: Sun, 01 Nov 2026 21:12:28 -0500
Subject: [PATCH 04/10] leds: rgb: ktd202x: Fix a division by zero with long
 blinks
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
Message-Id: <20261101-ktd202x-et6326-v1-4-eb51eddad08c@telaak.dev>
References: <20261101-ktd202x-et6326-v1-0-eb51eddad08c@telaak.dev>
In-Reply-To: <20261101-ktd202x-et6326-v1-0-eb51eddad08c@telaak.dev>
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
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793585580; l=2525;
 i=joseph@telaak.dev; s=20261102; h=from:subject:message-id;
 bh=9khUpnVIznb+BmjNA8t95846XXlyL+YUn/unSSiwMvA=;
 b=+v/pi1hd59t8tQZRnI+2mCmQeAbFBuA4fP+f05pYeOYX35rBONWO9BfO+TzygzG61YjMRx5qw
 2+r+z3S4ynQDpkf7kxMOjNTDAuCkGCN3BieP/OhjzVP0Wbyj4QrhG7R
X-Developer-Key: i=joseph@telaak.dev; a=ed25519;
 pk=OmwSusdK4grZpiuZVfCZAvYyqz9FBkNemsV1EnHyVr4=
X-Endpoint-Received: by B4 Relay for joseph@telaak.dev/20261102 with
 auth_id=1382
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
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Joseph Telaak <joseph@telaak.dev>
---
 drivers/leds/rgb/leds-ktd202x.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/leds/rgb/leds-ktd202x.c b/drivers/leds/rgb/leds-ktd202x.c
index 8c890ea5a..feea33b7e 100644
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
 
@@ -296,7 +298,8 @@ static int ktd202x_blink_set(struct ktd202x_led *led, unsigned long *delay_on,
 	/* Convert into values the HW will understand. */
 
 	/* Integer representation of time of flash period */
-	delay_total_ms = *delay_on + *delay_off;
+	if (check_add_overflow(*delay_on, *delay_off, &delay_total_ms))
+		delay_total_ms = ULONG_MAX;
 	if (delay_total_ms < KTD202X_FLASH_PERIOD_MIN_MS)
 		num_steps = 0;
 	else
@@ -308,8 +311,8 @@ static int ktd202x_blink_set(struct ktd202x_led *led, unsigned long *delay_on,
 	 * Integer representation of percentage of LED ON time. A value of 0
 	 * keeps the LED dark, so use the shortest on time instead.
 	 */
-	on = (*delay_on * KTD202X_FLASH_ON_MAX) / (*delay_on + *delay_off);
-	on = max(on, 1);
+	on = mul_u64_u64_div_u64(*delay_on, KTD202X_FLASH_ON_MAX, delay_total_ms);
+	on = clamp(on, 1, KTD202X_FLASH_ON_MAX - 1);
 
 	/* Actually used delay_{on,off} values */
 	delay_total_ms = num_steps * KTD202X_FLASH_PERIOD_STEP_MS + KTD202X_FLASH_PERIOD_MIN_MS;

-- 
Git-155)


