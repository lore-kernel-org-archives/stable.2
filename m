Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792586168;
	b=0xg7zAilcQxUi+E3oXYKtPP036uSHkReeoHEpFJ56uLpZvYBPAWCBBY48JSg84Fzjn63
	 00TNP2LSoPgGHk5nms1yjP8G2Zw1Fvm2QguR24gkhK+6yj/60UaCqaQhX0X9YUt8Qu0AG
	 0s7JFvnBhB9vgxRIXtPtDYVbVTCicj/M3kHB8DBf1IAPTlnAwjIKm+JhyH8PBfZ6IoHK8
	 7CLFzxXYMRyFOzOzoAZIC9c3HAFP95A/P78+FTStpuyaJMAVG/M7Pm4ro+Aw9lVl/TSxb
	 ec/645IRUxWnX+isKN8wRkzt0IS6IwETnN0XMdhcnIic+P7dpekvIVuyWNPS9MzhzLQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792586168;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=wCDHQuML4LdKAcWXdgBpdk6h8qnuPDjwnvmXCPSmpfM=;
	b=MBK0NTLeWMkA5KkaR6vN61sqE9re14tTDs+XB3vgwkjgrrtFB1MksAs2U7q6yOVy30uf
	 DMXzWS7X/BQD7fviWo7YUUMzimJ+/jVu1Im0qP6n/U5lNK9C62J8x1joAe2zRl25a+XJV
	 hSz11aQzKdYms1d30fX2WiZziTAkDq8BzVukEUu8QVUGURHjk0HeDeW6ulIloo/SN9+CW
	 1wz4n8tWZ1klwDWZieOfroeTI2u55jcf7g96M2k75M1PgpuIuL8uUfGkxEKkJ017+1ZX+
	 XtnwcR/TPoVX80VV+3EkkhSp1n6Ol6Cr/UVnX0sDjkDF/pySerXS9F9SZl8/Boc5mSQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="O/qi6uNq";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29F12606C00B;
	Wed, 21 Oct 2026 12:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=O/qi6uNq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B7FD1F000C4;
	Wed, 21 Oct 2026 12:36:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792586167;
	bh=wCDHQuML4LdKAcWXdgBpdk6h8qnuPDjwnvmXCPSmpfM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=O/qi6uNq2SzKR7bNL2IHx0StAuYQJVayudKIhDAwf89kn0gpirvnhicp9HsyKUKt0
	 C2MZEOZCdztflcLiuR2i+Rgx8ysvbTtceEPVefIrWPJ4cSz5U+Aa35POC/ZWNaJz5Y
	 1ijzHvnIZuD547pT6K1yQuulgj8UbcCGvgBDOoZWDtATKNteSI3I1CqqQ7QqfrMatu
	 G6ZD7yy8V6YY4GGtjS2D9vMlJcNxo+quOauD0o3ydENTd/av8VbqbJnOOSw1md2N0I
	 hpvKPoMru6zVkB4Qn3cAzJ8P8/QEP91spaCgfyoa/1SRTu/mXyxhZlMNdr/n8x/pQQ
	 Ic9VAiXm1utRw==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Pavel Machek <pavel@kernel.org>,
	Nikita Travkin <nikitos.tr@gmail.com>,
	linux-leds@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 18/21] leds: aw2013: Unlock chip mutex before registering LEDs
Date: Wed, 21 Oct 2026 12:32:27 +0000
Message-ID: <20261021123406.3163547-19-lee@kernel.org>
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

aw2013_probe() holds chip->mutex across aw2013_probe_dt(), which calls
devm_led_classdev_register_ext().  When a default trigger such as
"timer" is configured on an LED in the Device Tree, the LED core
synchronously activates the trigger during registration and invokes
aw2013_blink_set() on the same thread, which attempts to acquire
chip->mutex and deadlocks.

Reset the chip, disable the regulators, and release chip->mutex in
aw2013_probe() before calling aw2013_probe_dt(), and update
chip->num_leds before each LED is registered so trigger callbacks can
enable the chip cleanly during registration.

Fixes: 59ea3c9faf32 ("leds: add aw2013 driver")
Closes: https://sashiko.dev/#/bug/linux-5e2c9083-b95b-4aa4-aa0a-b0be8865ff12
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/leds/leds-aw2013.c | 54 ++++++++++++++++++++++----------------
 1 file changed, 32 insertions(+), 22 deletions(-)

diff --git a/drivers/leds/leds-aw2013.c b/drivers/leds/leds-aw2013.c
index dfeac8b2993f..c947cd068963 100644
--- a/drivers/leds/leds-aw2013.c
+++ b/drivers/leds/leds-aw2013.c
@@ -271,8 +271,6 @@ static int aw2013_probe_dt(struct aw2013 *chip)
 	if (!count || count > AW2013_MAX_LEDS)
 		return -EINVAL;
 
-	regmap_write(chip->regmap, AW2013_RSTR, AW2013_RSTR_RESET);
-
 	for_each_available_child_of_node_scoped(np, child) {
 		struct led_init_data init_data = {};
 		u32 source;
@@ -305,19 +303,29 @@ static int aw2013_probe_dt(struct aw2013 *chip)
 		led->cdev.brightness_set_blocking = aw2013_brightness_set;
 		led->cdev.blink_set = aw2013_blink_set;
 
+		mutex_lock(&chip->mutex);
+		chip->num_leds = ++i;
+		if (chip->enabled) {
+			ret = regmap_update_bits(chip->regmap,
+						 AW2013_LCFG(led->num),
+						 AW2013_LCFG_IMAX_MASK,
+						 led->imax);
+			if (ret) {
+				mutex_unlock(&chip->mutex);
+				return ret;
+			}
+		}
+		mutex_unlock(&chip->mutex);
+
 		ret = devm_led_classdev_register_ext(&chip->client->dev,
 						     &led->cdev, &init_data);
 		if (ret < 0)
 			return ret;
-
-		i++;
 	}
 
 	if (!count)
 		return -EINVAL;
 
-	chip->num_leds = i;
-
 	return 0;
 }
 
@@ -393,25 +401,27 @@ static int aw2013_probe(struct i2c_client *client)
 		goto error_reg;
 	}
 
+	ret = regmap_write(chip->regmap, AW2013_RSTR, AW2013_RSTR_RESET);
+	if (ret) {
+		dev_err(&client->dev, "Failed to reset chip: %d\n", ret);
+		goto error_reg;
+	}
+
+	ret = regulator_bulk_disable(ARRAY_SIZE(chip->regulators),
+				     chip->regulators);
+	if (ret) {
+		dev_err(&client->dev,
+			"Failed to disable regulators: %d\n", ret);
+		goto error;
+	}
+
+	mutex_unlock(&chip->mutex);
+
 	ret = devm_add_action(&client->dev, aw2013_chip_disable_action, chip);
 	if (ret)
-		goto error_reg;
+		return ret;
 
-	ret = aw2013_probe_dt(chip);
-	if (ret < 0)
-		goto error_reg;
-
-	ret = regulator_bulk_disable(ARRAY_SIZE(chip->regulators),
-				     chip->regulators);
-	if (ret) {
-		dev_err(&client->dev,
-			"Failed to disable regulators: %d\n", ret);
-		goto error;
-	}
-
-	mutex_unlock(&chip->mutex);
-
-	return 0;
+	return aw2013_probe_dt(chip);
 
 error_reg:
 	regulator_bulk_disable(ARRAY_SIZE(chip->regulators),
-- 
2.56.0.218.g1ec904b173-goog

