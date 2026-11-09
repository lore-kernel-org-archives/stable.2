Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794251066;
	b=czKIn7sH5xstY2sEPFC6nlmqzOaNagWbihitST9/4akL/KoffnMDxa6LANHRQm+BlzOs
	 H5p96CT1oTgjEypv/ZE01ynJWNpdZ61OcnsYMTyj6Re9iQN8WJAOF1erwpk8DJUTOZd/I
	 VGE+u8PHcV79q0odq8rqq707cDZMclRIlK/oJjjmOBRdETQTFNkjBMOJNYjLyset7mWSa
	 5iStprSU0vPdyOlNmA1jRZY2OJumoAMy1r8yaCh/2YCJcuPG9aqSWzHcRYvinqEJsEekH
	 djWgp3DAvw2XBLgNWUGKMnEwW/aXGhGBCYeXFcW0rS3lgojr4T0MQ4aDTWLuC8ZmIpQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794251066;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=qHVHVdBhvVACkfhgtNiYDlSjRrCBN0WlkapDhYne718=;
	b=335Ha/UTSmIARHlkdKgwMoD+oPGxnV27yV2lt17v1q8rkZxLYbWH1V2R4mVc6e5MaKq5
	 3+vRE5P7eM0NNG6zCxPhc7ChZsLPgk5ltc9pqZEuajI6DDHYSzXgkA0/bsPAO18W0M/wK
	 1IfgO2fnB2LVilGDOjqesR27MFHsuymK5dJsDyhz3z8VYnNRW7V0mBC6CrI7YwNx304h5
	 DZdtcQ//B5nhQvIQ6HdaTZwmApYJHmMjwkUduTDncX65KDFnnbkHFoL8NzT7UfgYqIdFE
	 nC9b9nynxzLCl2afCI0mMnPWHiqF6JClSlChC5sJ+HruL1DUl9PHK634n/BLXUpE2wQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ABlZM4ya;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFE3860A2612;
	Mon,  9 Nov 2026 19:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ABlZM4ya
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794251065;
	b=Zo6ptvvYXkTxoSMs7osPCbH//9JpssbhhFXoMYjOyk7yHtjQc6A0BFptDBanpl8ZCqCu
	 +x1tIPF/Afqf2b66KAII0jAi/f2hhq2D3vxq2shHK+Re1khHm02wm+AhC9TLTgyM1rp9O
	 9uR1m7HDU/OQEPp9Gl/s/jMfr59fqoBYHwTlQBOS/m4uQdh/92cacWn7w8fDyz0JbSLkx
	 ShXHVH+u2T804dveG6XfKEkxryWwU7fxNdGUSZ1qGmjeKoq2nVInHSeFElk6kDdwcDfq7
	 njrqEb/kTqVAs0F5schIB+0pel+qSXeDcIdaj8FZWfxll1U+xRHlI3DbHtzCilRn2Gw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794251065;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=qHVHVdBhvVACkfhgtNiYDlSjRrCBN0WlkapDhYne718=;
	b=OU5/dXz8ExvftIv3Z+whWwxnpx2Sxjr6LwiSLqgCegeDTgukIVjyIJ8VrMwXkNt3xFpd
	 /HT/3Bpd5UjDVmf/632ptp6X74kHMF1rh8kdRzq6FUUkMmrX18aACLN318mNiLcYxobLm
	 p7T/lSmOoWO+Btu9t4izCgaE38UEvhhYxt9EuAGVyO2fbIk/UAoMUj3P9O1IV4HssCQAh
	 JC5oH47U61slVXAtkXhyFm9BVxiubS7BsmhAw2uNTb05rtbY+Bz4H7gH0NoZbNmw51tUL
	 IJ9Na1VJNl0GnOic7xGIbqIJGJ5KgJqIbmu5o6ed/VWILAvk3/DPpB1wQV5avhbFVcA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id CF40C1F008BF;
	Mon,  9 Nov 2026 19:04:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794251065;
	bh=qHVHVdBhvVACkfhgtNiYDlSjRrCBN0WlkapDhYne718=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=ABlZM4yaeWNjSC05DVmR54BjoNAXRLk8ZJxROlHbz0XWRzlOJN4Ru44LDA7/yj+IL
	 CraScJsvuJhdkoObAmlH9QBcfJ1IfT4ZGb5xjvtkvRJ+Mfr2VpXQgvbkNXKryFVHWL
	 H1bQCOQgkYCqAnSyLRtlBiB+T4Z/4myML5fWv8mb/8t0ZhZoO5tiPqr1QeCteXsU8e
	 8z8yo1apdCDRT7Fen3pLBkhGwBtA9/CKnxmcMDWBupa+9RUHVGCh9iYC4SGBEXfH9+
	 UTqmYA9BGt7XHrLfoVzdWbE7vUdsotAAovdeW7AJS5ulEc/QYRS61egklt8q4T6rJ6
	 OyqufSU4rlWBQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 6D571485F2;
	Mon,  9 Nov 2026 19:04:23 +0000 (UTC)
From: Joseph Telaak via B4 Relay <devnull+joseph.telaak.dev@kernel.org>
Date: Mon, 09 Nov 2026 14:03:41 -0500
Subject: [PATCH v2 05/11] leds: rgb: ktd202x: Keep the unlit colors of a
 blinking LED off
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
Message-Id: <20261109-ktd202x-et6326-v2-5-56e97c226658@telaak.dev>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794251062; l=1610;
 i=joseph@telaak.dev; s=20261104; h=from:subject:message-id;
 bh=nXXhn11l+uuavgmJzzQ3n82zfpI6KSghh/2iqqmNfXQ=;
 b=Llboo1xxSNU9uZEpfPmWt2eG0Ga2Nu3GmXYd7b0/15NN8tVeaqf4/G+RHKOTi6x6mZl34mxwq
 xiuJneJlifqB3lQl604n88ArUJsNM+MREsB6V4a5NNqI6UjUTbhylyV
X-Developer-Key: i=joseph@telaak.dev; a=ed25519;
 pk=oQI+UfddlZ0wK2ac4WKOGNjUl1ZEN8j9ZVFSqEDoNP0=
X-Endpoint-Received: by B4 Relay for joseph@telaak.dev/20261104 with
 auth_id=1404
X-Original-From: Joseph Telaak <joseph@telaak.dev>
Reply-To: joseph@telaak.dev
Content-Transfer-Encoding: 7bit

From: Joseph Telaak <joseph@telaak.dev>

blink_set() switches every channel of a multicolor LED to the flash
timer, or to always on when delay_off is 0, including the colors whose
brightness is 0. Their current register still holds the last brightness
they had, or the 10 mA default, so for example a red blink set with a
multi_intensity of "255 0 0" also blinks green and blue.

Leave the channels of the colors with no brightness off, as
brightness_set() does. A single color LED now passes its brightness too.

Fixes: 0ebdb7210943 ("leds: Add ktd202x driver")
Cc: stable@vger.kernel.org
Signed-off-by: Joseph Telaak <joseph@telaak.dev>
---
 drivers/leds/rgb/leds-ktd202x.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/leds/rgb/leds-ktd202x.c b/drivers/leds/rgb/leds-ktd202x.c
index feea33b7e885..042de16c28bc 100644
--- a/drivers/leds/rgb/leds-ktd202x.c
+++ b/drivers/leds/rgb/leds-ktd202x.c
@@ -284,6 +284,10 @@ static int ktd202x_blink_set(struct ktd202x_led *led, unsigned long *delay_on,
 		int channel = subleds[i].channel;
 
 		ctrl_mask |= KTD202X_CHANNEL_CTRL_MASK(channel);
+		/* A color with no brightness stays off */
+		if (!subleds[i].brightness)
+			continue;
+
 		ctrl_on |= KTD202X_CHANNEL_CTRL_ON(channel);
 		ctrl_pwm1 |= KTD202X_CHANNEL_CTRL_PWM1(channel);
 	}
@@ -359,6 +363,7 @@ static int ktd202x_blink_single_set(struct led_classdev *cdev,
 	if (!*delay_on)
 		return ktd202x_brightness_single_set(cdev, LED_OFF);
 
+	info.brightness = cdev->brightness;
 	info.channel = led->index;
 
 	return ktd202x_blink_set(led, delay_on, delay_off, &info, 1);

-- 
Git-155)


