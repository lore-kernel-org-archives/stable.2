Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792586187;
	b=HP7SNgdlc5p2r1ujD+PR7WgUhH1Myx9O5QTIu5LEQWxf/FqObfns4b1v9VLyTFG6I1q3
	 etai/PGHtrwa/QYHxjTpPkNNngmRmYm1lTFJ37mY18XIIWXX3CfjeJuho1PwvXXB/8ySY
	 QUIGBrTpbQdA+HkWRWN+ZNFTqYRarxyig5Qbn29k2QRs1Ap4xTmtXmb9WPsgu+or2HEfC
	 9sLcLGUYslKvQLx7ATmFW4lUEWHOlZ0L+JX5wM/E8kgGsOA0NV+9R7KxEi6goNkf3MNBp
	 XnAHs+Zt1J1h+zFMtHKB1DijUKpNFngOFX2uF6BxX3kJEf8+H5gMr9qHCufHgZYIg9Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792586187;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=/ysTjV0GBjSJYji7PBboh+pSwqOHhnA/0a5rIMsM+RU=;
	b=PeCktDRGysGviLvYhGnkRizjQcztRX78RyPyEYMe82zrbqF8IlTXkAnWM0xbYI7s6tRf
	 W+0pC2aYHjPsnDnwXFg06S9mEprsMkFZKvK964QY5hAwE76UT4DDo89fsOtfRbd1T5vAK
	 QyJ99KkzuxVMkO08U4uHvEtXMNR482yKEs1F5iIxKvGkCWTbHRM6Udm6zVod81VpOsRZX
	 wj9gipQlvIGBU9Zehh5Ez4sot6rP7r/OTluAvhBQV10RJvAvRz4Scvw4BSZ9kiGKbLrub
	 eEnWQUMILmCilDl4mGfAziloWArZ3kMHUtZVy979pG8CdXP75Rw4Wm1hBBthinUJ9Tg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U7PIVoKP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 239C360A2630;
	Wed, 21 Oct 2026 12:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U7PIVoKP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CDA31F000C4;
	Wed, 21 Oct 2026 12:36:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792586187;
	bh=/ysTjV0GBjSJYji7PBboh+pSwqOHhnA/0a5rIMsM+RU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=U7PIVoKPDlOqueJeSNwK1DxvSrkNaXhI18pqzPszsYFm1CcSmeXJDnSu976muqiGY
	 uOuGRrLpHKaZpp+nVWGY+JHnH9T5li3zpjnryIP3LsMJPa2zPEfIqIPM+UzZX5bzlU
	 NruXaO1NnHHqi+w5W1e1zzLeWEcd4ZilVjMiAM++gm1WDwfnzazGBMfdRyuBUqZKRG
	 dRvbmBmYaNG59k5xYSWLk85TmgZeB42hDZz4LVClStZ22CBE3UOklcm8iF6q06zOXE
	 nFXShF8mI/FYcoltDAf8Ys18GrOoBYUjIaHd9CmZjNQjYocTJt9kjg8m8Erzo8lHi5
	 38A9WTsfPvf5w==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Pavel Machek <pavel@kernel.org>,
	Dan Murphy <dmurphy@ti.com>,
	Jacek Anaszewski <jacek.anaszewski@gmail.com>,
	linux-leds@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 21/21] leds: lm3692x: Use devm_mutex_init() to avoid premature mutex destruction
Date: Wed, 21 Oct 2026 12:32:30 +0000
Message-ID: <20261021123406.3163547-22-lee@kernel.org>
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

lm3692x_probe() registers the LED class device using
devm_led_classdev_register_ext(), so the LED is unregistered during
devres release after lm3692x_remove() returns.  Calling mutex_destroy()
in lm3692x_remove() destroys led->lock while the LED sysfs interface is
still active and before devres unregistration turns off the LED via
lm3692x_brightness_set().

Initialise led->lock with devm_mutex_init() before registering the LED
class device and drop mutex_destroy() from lm3692x_remove() so the mutex
outlives the LED device.

Fixes: 9699cb6bbef2 ("leds: lm3692x: Introduce LM3692x dual string driver")
Closes: https://sashiko.dev/#/bug/linux-012e3698-2af6-4390-88c9-d8989d2dc2a6
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/leds/leds-lm3692x.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/leds/leds-lm3692x.c b/drivers/leds/leds-lm3692x.c
index 9c58d54c5783..ec53f9d25654 100644
--- a/drivers/leds/leds-lm3692x.c
+++ b/drivers/leds/leds-lm3692x.c
@@ -470,7 +470,10 @@ static int lm3692x_probe(struct i2c_client *client)
 	if (!led)
 		return -ENOMEM;
 
-	mutex_init(&led->lock);
+	ret = devm_mutex_init(&client->dev, &led->lock);
+	if (ret)
+		return ret;
+
 	led->client = client;
 	led->led_dev.brightness_set_blocking = lm3692x_brightness_set;
 	led->model_id = id->driver_data;
@@ -500,7 +503,6 @@ static void lm3692x_remove(struct i2c_client *client)
 	struct lm3692x_led *led = i2c_get_clientdata(client);
 
 	lm3692x_leds_disable(led);
-	mutex_destroy(&led->lock);
 }
 
 static const struct i2c_device_id lm3692x_id[] = {
-- 
2.56.0.218.g1ec904b173-goog

