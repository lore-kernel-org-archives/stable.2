Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794251065;
	b=t7hdX4RcAtuG2FedoeiYVb34v5sEuhwEA3669uTi+PxJ8qwWCDitrBBa9u6kljcuZarn
	 YKDgbkNVSxGsub1APrmOd8XCV3YXEGuAiKbr9i/bSPOo7aBcDb60K2emmzDZc/nZ4HQo7
	 XBNNo6KNnrUpXibSPO2xIj9emt2Z10XEdv/qpxsIJC0otVRZmbS34aF7lEXJu6zYJnHSS
	 p0vwL3z3wUIW7iSDaTwpKmVOjEZcHaH4Ps8TZWFnA0dmqibpP5equmQkopB+hqtokHjMW
	 EFCJ9nOT06f2v+dh6Dpi3HwYoS4RMdcmtQFjGuVDB511ObN2Iga3DYCLtvb/lmKoiAw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794251065;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=yA0m58rWik3g8f7UVelIRblvrNa8BEocMNHHM2/4B1I=;
	b=RD/JVQVBHSLq1uCZUcO70DPksQvQLPo1Yn/ZFn6poFNVj+dRwrPub1aNdq95Zx4wFoHe
	 D8+OE2oCoYbTzVmRUKGjuQZlTAigAt2/l1KMBj2KRoS5MZ0DTiShf8VcddQQODCVfuCT/
	 gG9FYbod6hGuuxSbVew9jbg131MLGxFMFcGEbZI5zDhkct+62+pBjo4+vtrHTTyj6nIUj
	 ws3K6dyxKVngiAVvXBLyhLTyIeuRTp9y55CakmPI2V1Zk9bnSpntfzbB/bOcHehL+4bBI
	 pSPbMXP9pldHZ1Si2ClHAWFwrsrxV0mqupJzJeGgxb5HsilL374VEKCsS0C17Ay1LmQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Eniiwcmz;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A01BB606A32A;
	Mon,  9 Nov 2026 19:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Eniiwcmz
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794251064;
	b=urKxTgMLdGme1AWpvqnusYyJCo93hjKlEr2KKvLE0/0aegw/AT4TjJeM6eSZC1MbN5ID
	 41CmsnfjgqKg7tNCu8yU4xl6GAKSjEf5aEon9p9ZTkTz/fyW8/uBKsnwRpoLAV1hkHIBD
	 MH91tOGozh0sAETW09AePyf/aTEPEQGxQIiROcZWL2cYLa1ADwtBknby8F/vrzHNWTsP0
	 3qKw1LHrsWZiPBr563pzqZkzE5GYoHGBixLw8j4CKLtZa0YKZmRBB2w8MTEDxm3FWt0s/
	 94SsparY7zwG2+veUnXoFHykJwd64kDV54aDoj2NwSPYQbkKGvcffj0WfZ7Q6CfEk+Q==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794251064;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=yA0m58rWik3g8f7UVelIRblvrNa8BEocMNHHM2/4B1I=;
	b=LgKqX3znlQsisN/ic3v20CBqnM0uGji60M2+nqH+RUjMFmir6dCYm66p42CZonmarj64
	 iyVuzm+Jlw75wpPOGCLPolXxAnRr8FM7rLNF6cnYCOr+U+AiAllnQIy5BUMcBLi6N0Eyp
	 epf6NYY1xQSzQd2UUax3B3PaUfn3ySK3D8w+E1TvjLdCoBmqjfhQUk/bt+24fQiGeXO0a
	 Qa+24ODxvgRnPqUaWZl672VGs2RslMDZ6foDwgvhoAqw0XAJfbqtT8QAG4v0iMn094PTV
	 5q9nWzjUPv/3V07b14HPzT+camwhoN96glyty+nMyFBFclMPxZTok7V3FrZZqGc+Y/g==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id B049E1F008A1;
	Mon,  9 Nov 2026 19:04:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794251064;
	bh=yA0m58rWik3g8f7UVelIRblvrNa8BEocMNHHM2/4B1I=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=EniiwcmzdYl5CGxAkJT3XB8AchkYb0BWL4SiizZ9Hx+ZGzTq8NB3emnaDcWAguPoI
	 aTT5CY7LKf5SDr2lHxGdi/VQYx9s8tRYBJ+Rm3cztqySW8EtEK+y8GWRaM2giNaO0v
	 x4BPz5Kj7/lGQSbGM1QoaRngV1/NAN9VhddXYYIFX5JZiMTJZ4Dz81//FZ9bn/R8y5
	 gkJa737IZEBIlHGXHIaeU1yZtc3FA63F1KmoisW4qQO0MqSYx2krpr/+idPtfN7hPg
	 qAWtUQf8k/UpJ2bXcFEosR7OBtkj3/gMBg4IBfN/nmdZ/md8e08EPNC/o8T2b3l9F9
	 gJBZBWJLRFCgQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 22F83485C9;
	Mon,  9 Nov 2026 19:04:23 +0000 (UTC)
From: Joseph Telaak via B4 Relay <devnull+joseph.telaak.dev@kernel.org>
Date: Mon, 09 Nov 2026 14:03:37 -0500
Subject: [PATCH v2 01/11] leds: rgb: ktd202x: Fix the flash period of short
 blinks on 32 bit
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
Message-Id: <20261109-ktd202x-et6326-v2-1-56e97c226658@telaak.dev>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794251062; l=1641;
 i=joseph@telaak.dev; s=20261104; h=from:subject:message-id;
 bh=zfAMVaNdKcol9zMzD0rM6l30D7wHuzr1tcEVXAw473c=;
 b=N3ePYzao1Oy33AVtVloS1eSN5HorlfEqfYiwGCpK/9UfQ0WgR4y0zGA0KLJxov5unsBUOIlcU
 l8/79Di/Ld/Ar/xPNNor+Zu9A7mdqx+FY/UXchSqPkI02eTUPu8PxqM
X-Developer-Key: i=joseph@telaak.dev; a=ed25519;
 pk=oQI+UfddlZ0wK2ac4WKOGNjUl1ZEN8j9ZVFSqEDoNP0=
X-Endpoint-Received: by B4 Relay for joseph@telaak.dev/20261104 with
 auth_id=1404
X-Original-From: Joseph Telaak <joseph@telaak.dev>
Reply-To: joseph@telaak.dev
Content-Transfer-Encoding: 7bit

From: Joseph Telaak <joseph@telaak.dev>

When delay_on + delay_off is below 256 ms, the unsigned subtraction of
KTD202X_FLASH_PERIOD_MIN_MS wraps. On 64 bit the result truncates to -1
or -2 and gets clamped to the shortest period, but on 32 bit it
truncates to 33554431 or 33554430 and gets clamped to the longest one,
so asking for a fast blink gives a blink every 16 seconds.

Compare before subtracting.

Fixes: 0ebdb7210943 ("leds: Add ktd202x driver")
Cc: stable@vger.kernel.org
Signed-off-by: Joseph Telaak <joseph@telaak.dev>
---
 drivers/leds/rgb/leds-ktd202x.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/leds/rgb/leds-ktd202x.c b/drivers/leds/rgb/leds-ktd202x.c
index 143020945e23..539cf425cdb7 100644
--- a/drivers/leds/rgb/leds-ktd202x.c
+++ b/drivers/leds/rgb/leds-ktd202x.c
@@ -296,9 +296,13 @@ static int ktd202x_blink_set(struct ktd202x_led *led, unsigned long *delay_on,
 	/* Convert into values the HW will understand. */
 
 	/* Integer representation of time of flash period */
-	num_steps = (*delay_on + *delay_off - KTD202X_FLASH_PERIOD_MIN_MS) /
-		    KTD202X_FLASH_PERIOD_STEP_MS;
-	num_steps = clamp(num_steps, 0, KTD202X_FLASH_PERIOD_MAX_STEPS);
+	delay_total_ms = *delay_on + *delay_off;
+	if (delay_total_ms < KTD202X_FLASH_PERIOD_MIN_MS)
+		num_steps = 0;
+	else
+		num_steps = min_t(unsigned long, KTD202X_FLASH_PERIOD_MAX_STEPS,
+				  (delay_total_ms - KTD202X_FLASH_PERIOD_MIN_MS) /
+				  KTD202X_FLASH_PERIOD_STEP_MS);
 
 	/* Integer representation of percentage of LED ON time */
 	on = (*delay_on * KTD202X_FLASH_ON_MAX) / (*delay_on + *delay_off);

-- 
Git-155)


