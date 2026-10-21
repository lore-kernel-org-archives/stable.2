Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792586110;
	b=LHTHxQEjZ94yoRBCdac55iDJumI5HjPr/GOrm8i4k212B/d/QyvaPJAbMIfAhOlJLk58
	 kv8yzs26OsxL3RiJcg+CD1A87O5nHSxNX/J3NP4WGOAAQ9F93IL80HVzqbYNitBcZp1Vo
	 ShOsQpGNOFathkBbUAqTqAcny2wX3H/pSjMIjI475y9FwvYPLrDFFq0Yggbfqh5XCnpVe
	 lizPUoELGz9tXwp56I1dLiPZezHaAKrk0kUJ2F4da/QFGKHiUicMQgD3vHFqJwt66n7kF
	 T+J0F5jtqZYtV8ZQUi5cQ0XvNtoLUXyS5AJdQmXaSD1Y26jeX/phGi8OksBX7/N9EZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792586110;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=gTmQ+NywCyX6K5cTzuNX4hq7MJpc15JMpySDjlaGZmQ=;
	b=hRyBasz7SlG0gp8OnPg35j8KofHCecMfGRKXRQHClPe7p93TsuHQGz6qJtcRHDjNBp2y
	 sJ+CIdtpCL2POFpiULbcUAU4Y4i7o47oVbRNSb7A09ViwHY5/W/bOcvDa8WnRfKE2al0U
	 TD3kObYUOi7rMBDGUrCnAHM5zPU7sK8lVrHQIprGEhzOn+GF43jjq0bjDPyWrJHSyFlJN
	 L0VNj4VxXvaYgv+KMwnbpMMqpXTude1cbK45g3Frp+yzUSnfGNtLOFTSMVZpZ/eWZIc6p
	 f8QoDlhRJTwfVstVzOEsPv/xpjRL4zECb6orc/U1IYsPLTTZ0m76Xhc4darMkHTE+rA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VDyudfpo;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EA0D60A2611;
	Wed, 21 Oct 2026 12:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VDyudfpo
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 091CC1F000C7;
	Wed, 21 Oct 2026 12:35:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792586110;
	bh=gTmQ+NywCyX6K5cTzuNX4hq7MJpc15JMpySDjlaGZmQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VDyudfpolIb9MCT+3PXQSKpnfF43apMqw5Yx0ykjTfdX8zjjgfTRUEzauXs1USPVN
	 frw01PXWy2VDRyz/hKt1BwYZipLtiUl3aKpM/x5zs6de57pbunfXi1s8eoTdfBCunX
	 foD2VI8LOPdRsNxHJKbwZx8pMA4CTPYfordybLNhh42IeL0yn1yD0+2XsyfZuj8E8T
	 unNTm0vmDWu9NIcPv9uJUWM07ibNJxxvxSb3iZcNX2rbtiXPAr6IfCIV2tfnpbiGWf
	 USGakY8kPi2XV4ToX19DtmKlZ6GifZtG6OzMa8RSGALawYFilKfnJzBy5HanYXgc/k
	 N3N1RMKwBzkgw==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Pavel Machek <pavel@kernel.org>,
	Luca Weiss <luca@lucaweiss.eu>,
	linux-leds@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 09/21] leds: sgm3140: Cancel powerdown work via devres after LED unregistration
Date: Wed, 21 Oct 2026 12:32:18 +0000
Message-ID: <20261021123406.3163547-10-lee@kernel.org>
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

Because devm_led_classdev_flash_register_ext() unregisters the flash LED
device via devres after sgm3140_remove() returns, cancelling
powerdown_work manually in sgm3140_remove() leaves a window where a
concurrent sysfs write to flash_strobe can re-arm powerdown_work before
the LED class device is unregistered and priv is freed.  A similar
window exists in sgm3140_probe() if v4l2_flash_init() fails after the
LED class device has been registered.

Initialise powerdown_work with devm_delayed_work_autocancel() before
calling devm_led_classdev_flash_register_ext() so that devres cancels
the work after unregistering the LED class device and before releasing
the regulator, GPIOs, and driver data.

Fixes: cef8ec8cbd21 ("leds: add sgm3140 driver")
Closes: https://sashiko.dev/#/bug/linux-81468d52-b80d-46b5-b1b4-29c35e9acb21
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/leds/flash/leds-sgm3140.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/leds/flash/leds-sgm3140.c b/drivers/leds/flash/leds-sgm3140.c
index 478573da1d61..4e21144900c9 100644
--- a/drivers/leds/flash/leds-sgm3140.c
+++ b/drivers/leds/flash/leds-sgm3140.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 // Copyright (C) 2020 Luca Weiss <luca@z3ntu.xyz>
 
+#include <linux/devm-helpers.h>
 #include <linux/gpio/consumer.h>
 #include <linux/led-class-flash.h>
 #include <linux/module.h>
@@ -237,7 +238,10 @@ static int sgm3140_probe(struct platform_device *pdev)
 	 */
 	priv->timeout = min(priv->max_timeout, FLASH_TIMEOUT_DEFAULT);
 
-	INIT_DELAYED_WORK(&priv->powerdown_work, sgm3140_powerdown_work);
+	ret = devm_delayed_work_autocancel(&pdev->dev, &priv->powerdown_work,
+					   sgm3140_powerdown_work);
+	if (ret)
+		goto err;
 
 	fled_cdev = &priv->fled_cdev;
 	led_cdev = &fled_cdev->led_cdev;
@@ -286,8 +290,6 @@ static void sgm3140_remove(struct platform_device *pdev)
 {
 	struct sgm3140 *priv = platform_get_drvdata(pdev);
 
-	cancel_delayed_work_sync(&priv->powerdown_work);
-
 	v4l2_flash_release(priv->v4l2_flash);
 }
 
-- 
2.56.0.218.g1ec904b173-goog

