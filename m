Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794251066;
	b=5hUJ4o8JGjVY4NYwt0w31jUnY9Cmgc35qrOldRfhYTaSzEbzK6jvX/slAKYlAN0Ab/Gs
	 Ca/jjtS7MFamicp05QfAAYSB7BMK3zWgP6pa8FWyYhQlRutCtpMMnX3BF8qhVaFAjiZNH
	 7RSgEE6VZwEWerTL6SVmUekrsKi7d72OIVF9u2A90N33f2s50VrkubgA3L37alKeFVKQF
	 OR4URBaxSfpVYVoQSd7UlFjSgXaXXc1bVeWHnpGOJrfjxDSsZ8XguNMORXa1RWt3i6iAL
	 zXb2I7zF4E0GHCjQsv4dZIoaXW3BVBiUyFoNcehZDADgyw0pWWvUekLsWcBUAUbYIfQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794251066;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=49taFnAvJKb1RIMPamI90VyoncoDiyY+nPIAJJZ8N+s=;
	b=t+2xjlHDTAKE2PpfwHSw3FQLnYP0HPZ70bBlO6UW8KtBDVLOb5QxApvy5fW/NDsSMrUN
	 4I/cgQKtxHJxdRwb0inxvYzqnBzJ5fMWkZYrE218cs42oF2sxiW9PzX7RxNPa4v2Ob0OD
	 bqJSUIULF5YVOhm8KEVDuhUgCjj5jXSjfIvu7UVWrDRNKwTaSQN0bnKoJwzIsaHsmnxuu
	 Qk8wqzNWmH2K2XSdDTPZuRXjPheKjDvQFwe5Y+3IjWgkECfM9ID3IS7uuyOLc7K72ygiK
	 urpzd1r5whAwleqCHH/QW1eGBj8nw8kdWEAPMU2FI6gatPERc2DK5HTJj6LtUXr9Akg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ms4gVD8P;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 447ED606A334;
	Mon,  9 Nov 2026 19:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ms4gVD8P
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794251064;
	b=JtMKcsFmDyfmzHNOqeBLX8y78ao+St6qDkTDY+XDZYRno3LR6/1m8euwguR7KyD3Cvc6
	 Mq5JbTY/bL9gScJsjCglzSrZ5RLzbUHpnFpN75zJosdFPL5HSTncuStSfaYNWJuH/5v7F
	 QNLjGAS2lhIRU/bo0pY8uONt8iGrv6yjVo9fFeb6p4LBZawbFRad/IhwMo9lie2GTlUex
	 VM3aVtTf/0+hk0LHftLzA8rLqaqX8vkumJGLs3MyNdM59dCiS9Ft0kVBW5Q6Wa/mRgQt/
	 IjGgKJ5DgwBvAqIb3DLtazIKitYhx4W3vkFf2AmCBuI5B9ncsxRTEP81h89VREM3DOg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794251064;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=49taFnAvJKb1RIMPamI90VyoncoDiyY+nPIAJJZ8N+s=;
	b=29/Gx5L4GPJAc4zu0SoJKYbXypf+iQrLWLmHmWf6aV93/uB5AU6TfK6cmV+Zj9JiRmRc
	 XrUMLGSjXUZVc538xlit03k8R/sDrEQuz34qW/c0h4kCDlsUtpfNH/LJaN3MvFSIgmKcg
	 7k0bzJUVT7mXyV1YPWMetTyS81CicQ/58wjt0keIa/8Gbycz639e11VOa0QIakyIaUuM0
	 FwMkEamHQmHlVhXLend+71PNV80v+TLeo0nlnm/s3BaflAx0UHxNC28IHsXCY1Oo1ktUU
	 +ydJc9EOKhVe576I4UbrFXY//FCWQtr/gE4t5TREmbVzyQlLLQvtF3vUvwOvlCRncXw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id D6F381F008A4;
	Mon,  9 Nov 2026 19:04:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794251064;
	bh=49taFnAvJKb1RIMPamI90VyoncoDiyY+nPIAJJZ8N+s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=ms4gVD8PyI8JoNdCdrdtYX0hJXjV5i5Xim+JjJPzNy0v9Gp3QK3b+olrdvJ2j7mLU
	 b+bwyMGPEWhsn1wQFhdhtXW/ZjOm1573Pv3TRgFgy8aMj0zz9RLGyo08htmQ4lGYP0
	 Ei1AGpcmx7CDWBd38QHIwhovQfsZT9XA2v+TUvXfKNRQYbKWkd/ZVsQVoFj0IFzBRp
	 CluFMUnSPCO+74i83QEHTtEsM+5FqpFXCjau2rBoRP9nWgWJ7PbeFMXh5K+K5eN5iZ
	 +rbpvC2DehJbqtrP271mRSFjQmJBOBQKPXvSBxs/EufpqaBO6fSMjStWcnP0Q22Pw+
	 b65JOH715yCzw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 5A0B3485EE;
	Mon,  9 Nov 2026 19:04:23 +0000 (UTC)
From: Joseph Telaak via B4 Relay <devnull+joseph.telaak.dev@kernel.org>
Date: Mon, 09 Nov 2026 14:03:40 -0500
Subject: [PATCH v2 04/11] leds: rgb: ktd202x: Fix a division by zero with
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
Message-Id: <20261109-ktd202x-et6326-v2-4-56e97c226658@telaak.dev>
References: <20261109-ktd202x-et6326-v2-0-56e97c226658@telaak.dev>
In-Reply-To: <20261109-ktd202x-et6326-v2-0-56e97c226658@telaak.dev>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794251062; l=2494;
 i=joseph@telaak.dev; s=20261104; h=from:subject:message-id;
 bh=7z9O3spgFaG/KPiRDFqlglhrq5SskileVglyCLyPmHI=;
 b=PSkHXAqlRN1p/zhRbsVHGWpSmXPInhNbyja/3AhCzWdTMSidWfocndbj7e1NVaDUdMZSlLrjj
 F4Eo9uAcoW2Bfdtc0L8GHr9Zvt4we5GyOo2+53NPumXmthGtlrR6tvd
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
index 8c890ea5a754..feea33b7e885 100644
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


