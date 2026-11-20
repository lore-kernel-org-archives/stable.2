Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795133258;
	b=xHWsLGLMl8SWP6+MQLZvEL7bF4XTyvTA75AbvV+xy7FkMefeQ/wcFUdo7Lh9G00rfiYe
	 4bHzektj8dojREKofIuGT0WthocTOE6IiCp49SL/AVxMsBOxELczsFr1jab5a6FEHcdk8
	 RqIZjb+WqZIHuLZ8mARRU307wuotf81ut9RIk9+Tj7meCqvgDEaU/rPsBef8/utip0lnZ
	 FTQYau6EesFhpiiCNJkEfbQujkDm/3dquQrRQgXz01M9oXCe8fkAj1cYP90g5onIcZKeS
	 Vvg7Ex7gElBouCSPGrS+03FEvNgRfLeGQEHoXMZ4QylYSg3+iM9SGz0NOeNHdycEGAQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795133258;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=5v8xvvHg/zQOw7ubDKmkCpyQDBYHm31ESItRML/0yR8=;
	b=k7ujpuK1MdH4nvFQw13yFJfNN6oDan5X/cop6hgaVnhVvJuhbbRaQbS+fJSLXdKdxuh1
	 K/8F6gtDzuejOLxrO+X9kJ949oIpkmJfGR9zXqf2PfettyQXPAZeH/+zG3qS98Anu0NrI
	 umezNIey0YYf6m8eGgaHObPRBYAF5Bi75vM45xMZkRqdvxovVvr0SKPQMETZthlY/jUzA
	 FT/UKaMgBTkx4rctE6sk/MNu9ThisuwWCUtlcKjL1UvZy9cJMYP98GvLsfrvkEZGtIal/
	 0cgpN2bsUWAY/r1oawNv2tz4aAugYTCUKIUIm8b+KP2ir0bbEXb1Lk1LCefx7mdo07w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CMDg7yhW;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6331660A3814;
	Fri, 20 Nov 2026 00:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CMDg7yhW
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795133258;
	b=r2FYL55Lb84Juhh/msDNvbnEXyCCd9Fy/EIke8ckLFBG4lJ0Z+S5SMk01EVFnmjFlsL1
	 ijRD03GS1sYi1hHZeb6EVbDQM7UOs6CIGU2iXfC9FChLDmWGlKiwoWt5C9DvHxbr6Pnsb
	 I704wR72KNBlmUatEUp+qHcPYMgC7dcfZ2IyvptbaqxPOxIN8DudgdHOi7RQTci5OrBVf
	 E/xCxwSDjchha/SXUGvIPQW5AN+ygFICeXRPWIzXSBgnsJX948qM9I/TILGtH3SJrleUA
	 5IxZkctHIA/CD4xo7vvmn2KZUESMikL4LxDLV6IDx9cHnGi0kixiIGj5e56Joldhcuw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795133258;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=5v8xvvHg/zQOw7ubDKmkCpyQDBYHm31ESItRML/0yR8=;
	b=f6OHxfDQ0MBgu6os2Se+QgD1RXCJFjtcoV47nMPZi7a3k4JECD5v1iGJ3j979VYx0cz6
	 chwKE9YLq4fNhLW84VbVi3Eqd6jk4k/aCwZTOvIOPNqj4xV6fk5a7YL8GadivxyoCreav
	 xM+CJ/Fs1ZG/xXDfWoWoDe91KxBpd8dds7hcSms2+F57ezyFLx3xJFdh8e72LS8A/+I/l
	 YE6slEObXweIGJWXjgElHAKsdUsnPBmSflNYjOnA3cZognUKNgWDdUlqKKHLVl2XOYkUh
	 gctTPkXltJUYJXvkz3zYWW7Yv2xXO8G4n0fbjQdboDL6QuZUOqhDBCRnGtXPcfBs/lA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 187811F000C4;
	Fri, 20 Nov 2026 00:07:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795133258;
	bh=5v8xvvHg/zQOw7ubDKmkCpyQDBYHm31ESItRML/0yR8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=CMDg7yhWNLa0w7yfxIl6n63U9OVcYcLnDWGZWbn6wWIvOxXvHnyHUTD8c8pibTrJs
	 9tqpuimu8cRdR+xPPNTxhh+ltDPQF1fysLwbtOv7kLYPQWc5aYw24KT6ZUlSa0/S1G
	 duKEtJG1BgcHF0ZrF+LNA+ExbFs9e5kCEQSdCyG6lxAu4o2+grZIRh8guNHD9ijNpn
	 EHNO30LKg01q2w3pqyD/f9gwnLgim5v0wX/3CxjgkKsVbSAGga9zR7yD9ISHEdpSEn
	 TdlaEkF7DD1tnkndRbQQVXVQAbqPLmEeOHfPfGAOATL4+MSuPDVulf+/4oBvyNcK1X
	 a/kgkKrZSMDyA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id D8E5E424EE;
	Fri, 20 Nov 2026 00:07:35 +0000 (UTC)
From: Joseph Telaak via B4 Relay <devnull+joseph.telaak.dev@kernel.org>
Date: Thu, 19 Nov 2026 19:07:27 -0500
Subject: [PATCH v3 05/11] leds: rgb: ktd202x: Keep the unlit colors of a
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
Message-Id: <20261119-ktd202x-et6326-v3-5-98b836b1cddc@telaak.dev>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795133254; l=1614;
 i=joseph@telaak.dev; s=20261104; h=from:subject:message-id;
 bh=N0qjLyVSYeHCoIVzs3o90qtyZk6KHKqoW0ZHApWnTGE=;
 b=uJsMQ/n6ajRaxGbd7zm/7rUpM/ehN02TU8AxegrS22XOOrS9CPH1TX2cxKTdPXha2unWWxHbw
 ZAUHwZgHvhXBpOvd7qYZdlDHjPYTytHFYM+Dps4v3ZJjVcA2JQo/Woy
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
 drivers/leds/rgb/leds-ktd202x.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/leds/rgb/leds-ktd202x.c b/drivers/leds/rgb/leds-ktd202x.c
index bfc05f5f02d6..ac7ed7552fb2 100644
--- a/drivers/leds/rgb/leds-ktd202x.c
+++ b/drivers/leds/rgb/leds-ktd202x.c
@@ -285,6 +285,11 @@ static int ktd202x_blink_set(struct ktd202x_led *led, unsigned long *delay_on,
 		int channel = subleds[i].channel;
 
 		ctrl_mask |= KTD202X_CHANNEL_CTRL_MASK(channel);
+
+		/* A color with no brightness stays off */
+		if (!subleds[i].brightness)
+			continue;
+
 		ctrl_on |= KTD202X_CHANNEL_CTRL_ON(channel);
 		ctrl_pwm1 |= KTD202X_CHANNEL_CTRL_PWM1(channel);
 	}
@@ -360,6 +365,7 @@ static int ktd202x_blink_single_set(struct led_classdev *cdev,
 	if (!*delay_on)
 		return ktd202x_brightness_single_set(cdev, LED_OFF);
 
+	info.brightness = cdev->brightness;
 	info.channel = led->index;
 
 	return ktd202x_blink_set(led, delay_on, delay_off, &info, 1);

-- 
Git-155)


