Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795133257;
	b=IDfl0WUYqnFxVxeA4ThZvhj1litXAH4SYaI9+OczEfaAMcaOg/i7RtM7y//yMfyhbRWf
	 R0ktFoKCBvqdGdPsHveP5PtUI9B7uPl15r3Mze81fYMcvngUQ9xmMWuh9EVJ2Pxu49ApV
	 LOOl1EnKYbpNCeXBrseih1/cob5R/Mo0fEs0y1ilP1d/FqmorMrp32Tql0ZBxBoMtA6lk
	 Uj1Eva1a2Px7EWMf18PlaoKpKXoiJXZn5J2K7XKSDgS/KX5eYWf2j6yvBwy5jnfR59eju
	 w54KmYQSWRBold44K5yOWAp7yGdqnZl0aod83b4gvYHLw/rjxhT0hvrRrtePjKPmLBA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795133257;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=yA0m58rWik3g8f7UVelIRblvrNa8BEocMNHHM2/4B1I=;
	b=0K875NVkbdDo0g4beAPQw92d0mNQiehWFLMdN59ZIMGwmnhFKmABPQFHcd01vpXq4wA3
	 bmmmUaodEVXmp6Nz+Rvakd4M7xJPmx6TBTjRcyG+lXvHuPI/YtBV42Se0KHgMt9vuqhVF
	 +gcPqRyqIrhREgUrWZKqIj0FZ/UlsXVOTo1oTsXLXYhPUghdUJSuJoBKsrNnyU+ca9sKp
	 lTVUHWTiP9vZ9RvAe17NEQLEKJEglslJA0DxLn4RdSDjUszY0sualQdiQO5rzznzHA0NN
	 wAX3Ax3LlhjkiS02SN8PbILLsu/G1IQvrBPCCf5QVrLC3JKF9FgksSZy1K2TfNxCEBg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=e+6c6co8;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E351E60A2602;
	Fri, 20 Nov 2026 00:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=e+6c6co8
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795133256;
	b=Q2DnX6FV6FVtjPeVMwIZlLc1lHJMYp203P/kyL9+CjDprgD6w92yYuX7M7dEwmElY2SH
	 4guaXSNtpdKXByblwDj7FSY+miNZmPHJ1o08oaHX6kHQoTQyAYSPDdBWShKYTRsfz6tbS
	 osY/ziYyyxKHmUEoAFCS24m5a+JLwyWLNQEd1cJdGsDOG6yBVe7sdNUkCDQUVpR+bAaRy
	 XdkNiAoTT1iWYT2cBfkq1eJfVWd3FY8vY2m3/wKxeLkzm8pqrP9oh+OHjKV9t5B7WpL3s
	 GSsyytS8sgkFgxskRxssFhG7AnE/bgK6S72dhTGtxr6AqmuJJokUBxSayUM3Iz7y+Zg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795133256;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=yA0m58rWik3g8f7UVelIRblvrNa8BEocMNHHM2/4B1I=;
	b=UyIJFjc8dcDWPdxy53onL1Yh/yrylFR6sZQpAqPBHgtP9JBHtYGj6lbCZciGvNb04aWf
	 kgRCSU6uOcxDScnR8DEE8rb3uipZFAwC7JS2pWzbwXgPDypvgr+7Nn6GyB15/eI8U8ZzW
	 8Hcw330OAmztuNOwga3+ZQh1pgFgIl9c0npm1cYOMSfvqRn0SID+lWuvX5Nf2JYu1JjKJ
	 PMzCDlb4Mn+zr8L/jSPUOFrj2Y/OL+hQE5sGHLntv7NpvEifjia04WgKsjZJT/6hWh8IR
	 hW5Ee26Um0lYP+oZUGRE/v/QF4JaWZlBwsj2MNQgns90Aj85E34XtKZ5zgtFe6W0llw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id E1ED71F000C4;
	Fri, 20 Nov 2026 00:07:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795133256;
	bh=yA0m58rWik3g8f7UVelIRblvrNa8BEocMNHHM2/4B1I=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=e+6c6co8kmNG3AH1u2sMiWzi70uceSK6F6xK14aunUKW98lZXhUf0EcoHfuFfcI2F
	 3boSupwg26k+MK+mDz/24gLL/y8c5fuItEp4vMhTaCzW2snh9cs4ejQyCO1mU135pO
	 UMRsQH+4yhCHnqpY3drV7xgbuU6jlKiPtDLNSex+MrjGzkSB72XP2Zwwm+akgFavlY
	 qQlJKuYkrtXo+Gm8s2TmVEuHHHAjjx+YEz7GRpbN2BGo7yeU2G/n3nFg0Z8kBvqiBK
	 2lLxU/OTwaH6pudG9Y19GMnA12aQgbt7MIGrQc0kBpUKfs3LXBX3l77vQNGqoGkPhO
	 t9cegpETdHxWA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 6F3FB424C7;
	Fri, 20 Nov 2026 00:07:35 +0000 (UTC)
From: Joseph Telaak via B4 Relay <devnull+joseph.telaak.dev@kernel.org>
Date: Thu, 19 Nov 2026 19:07:23 -0500
Subject: [PATCH v3 01/11] leds: rgb: ktd202x: Fix the flash period of short
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
Message-Id: <20261119-ktd202x-et6326-v3-1-98b836b1cddc@telaak.dev>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795133254; l=1641;
 i=joseph@telaak.dev; s=20261104; h=from:subject:message-id;
 bh=zfAMVaNdKcol9zMzD0rM6l30D7wHuzr1tcEVXAw473c=;
 b=3BQgXUcypJjlefjNYxm8V6ta1mw/nAx6OEIcHXXCunRFrfTiejklKfxqS7wNZbupPbBrqYF8n
 9GkZJkXs5TzAwXE5hn+oxswKooeYsI7QqglR8sAVfdnJY19OSoiyI2n
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


