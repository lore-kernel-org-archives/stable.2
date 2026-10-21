Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792586060;
	b=XcCKliOgDIoHxnxYY9bMFtMzdXIh2tC8apock0k65kAhw4hq8ASNNMZUUBo4PBi/UYgp
	 W+A+xvkVOhNWxfDrQu7n3i2KsWGnL3MWK4wQMmBsh+10S1l4BTX4w5kwhhXAAzbF470ZF
	 eMth0dh3Eve9ndtP2dVlu/LN7CfSV/9DvyUnOluAu7sIGS2h20vFBFAJi+z38pI6GtyPe
	 yV5Rha/ksl52fZfVfm+6iK1GOjN2anK/e00xiobalqPwU+GQe02DZSORFc5n7uf+ZDyrH
	 HnvCP/XeCEwynTLz0ilc8xeiknGsNaC4M7njNQVvVvvI4IC17MBXgyZPZhmtzNFlMMg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792586060;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=wenmE0YAn8+JyMp89qN8fVPurYYawYryf969l+sg++o=;
	b=njLGCpflKG274ubEpDDoknASv4hXoU/OhYiqKinG2tZ+PVTXf2dTB7LB9GYsH7SCHduF
	 QpHSf9A26H1fQXvsHgjlUSOr0XgqVRX+JpNwZZMZmzOWmjQidoLBfC0SFUl5Vupd1JwQy
	 gudJ9yK1+LUFcvdl9btttp4s/Vb9maY13HmBpFT6BEEC/ZEtvnQlV+icsIBDdxEUwuVPB
	 QbcZkSyOMX6RztslPus086FPJh7R4svcrRPt5nUWJoNq48+wAN/TxbwMo4qzBj5K8cRrI
	 VuD+VGBfBgyc8DC4b4WkZ+d2p1d7rtCTvdHXbvL4xPXe0NV2Gblwb00qklB+Qk9+lEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Qt1vMh/a";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3336A606A322;
	Wed, 21 Oct 2026 12:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Qt1vMh/a
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CE5E1F000C5;
	Wed, 21 Oct 2026 12:34:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792586059;
	bh=wenmE0YAn8+JyMp89qN8fVPurYYawYryf969l+sg++o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Qt1vMh/aQcHSD2Tg6vJ8MIRMuZ5seJTBWwJF62bQZhz8sNU9eBtLto5xKBBnj2zgC
	 FMTDTkdCEu6/CNCwfMRoSUNnDyhOELHxfvW3u+MiGz+GfumsqYgzA1q1qDRKg3zt64
	 d2JjsKZeQeVqdTW2FkukSSiI1mWB+loSQwFM+1f0WWI7GdjsdQKRdJEwXfZyuwSaVC
	 +bMm2s3Qircf/zFCgfpmlZ5W9OnIU8hekvsutEBTu4bmI290m8Yz7TBOWXqq8rLhKO
	 f3uEhssJBK3gIyZixTbpmkKPSOvQ4bp6JxHHDG6MyNflWOcazOEi74XWow9JDuCBW3
	 ljYFI7izPuCYQ==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Pavel Machek <pavel@kernel.org>,
	Dan Murphy <dmurphy@ti.com>,
	Jacek Anaszewski <jacek.anaszewski@gmail.com>,
	linux-leds@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 01/21] leds: lm3532: Propagate error from devm_regulator_get()
Date: Wed, 21 Oct 2026 12:32:10 +0000
Message-ID: <20261021123406.3163547-2-lee@kernel.org>
X-Mailer: git-send-email 2.56.0.218.g1ec904b173-goog
In-Reply-To: <20261021123406.3163547-1-lee@kernel.org>
References: <20261021123406.3163547-1-lee@kernel.org>
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

lm3532_parse_node() catches errors from devm_regulator_get() and sets
priv->regulator to NULL.  Because devm_regulator_get() already returns a
dummy regulator when the supply is omitted in Device Tree, an error
pointer is only returned on a genuine failure such as -EPROBE_DEFER.

Masking that error as NULL both breaks probe deferral when a supply is
specified and causes a NULL pointer dereference in regulator_enable()
and regulator_disable() when the LED brightness is later modified via
lm3532_led_enable() or lm3532_led_disable().

Propagate the error code from devm_regulator_get() instead.

Fixes: bc1b8492c764 ("leds: lm3532: Introduce the lm3532 LED driver")
Closes: https://sashiko.dev/#/bug/linux-8836989c-356e-4601-ac4c-6db97861cb00
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/leds/leds-lm3532.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/leds/leds-lm3532.c b/drivers/leds/leds-lm3532.c
index b51496910b08..7f849a166a92 100644
--- a/drivers/leds/leds-lm3532.c
+++ b/drivers/leds/leds-lm3532.c
@@ -570,7 +570,7 @@ static int lm3532_parse_node(struct lm3532_data *priv)
 
 	priv->regulator = devm_regulator_get(&priv->client->dev, "vin");
 	if (IS_ERR(priv->regulator))
-		priv->regulator = NULL;
+		return PTR_ERR(priv->regulator);
 
 	ret = device_property_read_u32(&priv->client->dev, "ramp-up-us",
 				       &ramp_time);
-- 
2.56.0.218.g1ec904b173-goog

